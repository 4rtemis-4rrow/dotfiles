from plugins.ranger_udisk_menu.mounter import mount
from ranger.api.commands import Command
from ranger.core.loader import CommandLoader
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import padding
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
import os
import subprocess

class avfs(Command):
    avfs_root = os.path.join(os.environ["HOME"], ".avfs")
    avfs_suffix = "#"

    def execute(self):
        if os.path.isdir(self.avfs_root):
            archive_directory = "".join([
                self.avfs_root,
                self.fm.thisfile.path,
                self.avfs_suffix,
            ])
            name = os.path.basename(self.fm.thisfile.path)
            if os.path.isdir(archive_directory):
                self.fm.tab_open(name, archive_directory)
            else:
                self.fm.notify(
                    "This file cannot be handled by avfs.", bad=True)
        else:
            self.fm.notify(
                "Install `avfs' and run `mountavfs' first.", bad=True)

class encrypt(Command):
    """
    :encrypt <password>

    Encrypts the selected files or directories using AES-256.
    """

    def execute(self):
        password = self.arg(1).encode()
        salt = os.urandom(16)

        key = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=salt,
            iterations=100000,
            backend=default_backend()
        ).derive(password)

        def encrypt_file(file_path):
            with open(file_path, 'rb') as f:
                data = f.read()

            padder = padding.PKCS7(algorithms.AES.block_size).padder()
            padded_data = padder.update(data) + padder.finalize()

            cipher = Cipher(algorithms.AES(key), modes.CFB(salt), backend=default_backend())
            encryptor = cipher.encryptor()
            encrypted_data = encryptor.update(padded_data) + encryptor.finalize()

            encrypted_file_path = file_path + ".enc"
            with open(encrypted_file_path, 'wb') as f:
                f.write(salt + encrypted_data)

            os.remove(file_path)  # Remove the original file

        def process_directory(dir_path):
            for root, dirs, files in os.walk(dir_path):
                for file in files:
                    file_path = os.path.join(root, file)
                    encrypt_file(file_path)

        for file in self.fm.thistab.get_selection():
            if os.path.isdir(file.path):
                process_directory(file.path)
            else:
                encrypt_file(file.path)

            self.fm.notify(f"Encrypted {file.path}")

class decrypt(Command):
    """
    :decrypt <password>

    Decrypts the selected files or directories using AES-256.
    """

    def execute(self):
        password = self.arg(1).encode()

        def decrypt_file(file_path):
            with open(file_path, 'rb') as f:
                data = f.read()

            salt = data[:16]
            encrypted_data = data[16:]

            key = PBKDF2HMAC(
                algorithm=hashes.SHA256(),
                length=32,
                salt=salt,
                iterations=100000,
                backend=default_backend()
            ).derive(password)

            cipher = Cipher(algorithms.AES(key), modes.CFB(salt), backend=default_backend())
            decryptor = cipher.decryptor()
            padded_data = decryptor.update(encrypted_data) + decryptor.finalize()

            unpadder = padding.PKCS7(algorithms.AES.block_size).unpadder()
            data = unpadder.update(padded_data) + unpadder.finalize()

            decrypted_file_path = file_path.replace(".enc", "")
            with open(decrypted_file_path, 'wb') as f:
                f.write(data)

            os.remove(file_path)  # Remove the encrypted file

        def process_directory(dir_path):
            for root, dirs, files in os.walk(dir_path):
                for file in files:
                    file_path = os.path.join(root, file)
                    if file_path.endswith(".enc"):
                        decrypt_file(file_path)

        for file in self.fm.thistab.get_selection():
            if os.path.isdir(file.path):
                process_directory(file.path)
            else:
                if file.path.endswith(".enc"):
                    decrypt_file(file.path)
                else:
                    self.fm.notify(f"File {file.path} is not encrypted!", bad=True)

            self.fm.notify(f"Decrypted {file.path}")

class shred(Command):
    """
    :shred <times>

    Securely deletes the selected files by overwriting them <times> times with random data from /dev/urandom.
    """

    def execute(self):
        times = int(self.arg(1)) if self.arg(1) else 3  # Default to 3 passes

        def shred_file(file_path):
            with open(file_path, 'r+b') as f:
                length = os.path.getsize(file_path)
                for _ in range(times):
                    f.seek(0)
                    # Overwrite with random data from /dev/urandom
                    f.write(os.urandom(length))
                    
            os.remove(file_path)  # Remove the file after shredding

        for file in self.fm.thistab.get_selection():
            shred_file(file.path)
            self.fm.notify(f"Shredded {file.path}")

class copyfile(Command):
    def execute(self):
        # Get the path of the selected file
        file_path = self.fm.thisfile.path

        # Check if the file exists and is readable
        if not self.fm.thisfile.is_file:
            self.fm.notify("Selected item is not a file", bad=True)
            return

        try:
            # Read the contents of the file
            with open(file_path, 'r') as file:
                file_contents = file.read()
            
            # Copy the contents to clipboard using wl-copy
            subprocess.run(['wl-copy'], input=file_contents.encode(), check=True)
            self.fm.notify("File contents copied to clipboard")
        except Exception as e:
            self.fm.notify(f"Failed to copy file contents: {e}", bad=True)


class extract(Command):
    def execute(self):
        """ extract selected files to current directory."""
        cwd = self.fm.thisdir
        marked_files = tuple(cwd.get_selection())

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        one_file = marked_files[0]
        cwd = self.fm.thisdir
        original_path = cwd.path
        au_flags = ['-x', cwd.path]
        au_flags += self.line.split()[1:]
        au_flags += ['-e']

        self.fm.copy_buffer.clear()
        self.fm.cut_buffer = False
        if len(marked_files) == 1:
            descr = "extracting: " + os.path.basename(one_file.path)
        else:
            descr = "extracting files from: " + os.path.basename(
                one_file.dirname)
        obj = CommandLoader(args=['aunpack'] + au_flags
                            + [f.path for f in marked_files], descr=descr,
                            read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

class compress(Command):
    def execute(self):
        """ Compress marked files to current directory """
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        parts = self.line.split()
        au_flags = parts[1:]

        descr = "compressing files in: " + os.path.basename(parts[1])
        obj = CommandLoader(args=['apack'] + au_flags + \
                [os.path.relpath(f.path, cwd.path) for f in marked_files], descr=descr, read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        """ Complete with current folder name """

        extension = ['.zip', '.tar.gz', '.rar', '.7z']
        return ['compress ' + os.path.basename(self.fm.thisdir.path) + ext for ext in extension]

