# WSL Disk Optimization

It seems that windows allocates some space to the disk image of wsl. Even after clearing deleting the files, the disk space remains occupied as it has been allocated to the disk image. You need to compactify the disk image.
This script helps you to compact the disks of all your wsl distributions.

## Usage
Open an admin powershell and run
```powershell
powershell -noexit -ExecutionPolicy Bypass -File .\OptimizeWSLdisk.ps1
```

## Tests

- [x] Win 11 Pro 10.0.22631 Build 22631
- [ ] Win 10
