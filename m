From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 070/109] fs: add ksys_write() helper; remove in-kernel calls to sys_write()
Date: Thu, 29 Mar 2018 13:23:47 +0200
Message-ID: <20180329112426.23043-71-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Using this helper allows us to avoid the in-kernel calls to the sys_write()
syscall. The ksys_ prefix denotes that this function is meant as a drop-in
replacement for the syscall. In particular, it uses the same calling
convention as sys_write().

In the near future, the do_mounts / initramfs callers of ksys_write()
should be converted to use filp_open() and vfs_write() instead.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/s390/kernel/compat_linux.c | 2 +-
 fs/read_write.c                 | 9 +++++++--
 include/linux/syscalls.h        | 1 +
 init/do_mounts_rd.c             | 4 ++--
 init/initramfs.c                | 2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 79b7a3438d54..5a9cfde5fc28 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -468,7 +468,7 @@ COMPAT_SYSCALL_DEFINE3(s390_write, unsigned int, fd, const char __user *, buf, c
 	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
 
-	return sys_write(fd, buf, count);
+	return ksys_write(fd, buf, count);
 }
 
 /*
diff --git a/fs/read_write.c b/fs/read_write.c
index f8547b82dfb3..8e8f0b4f52e2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -578,8 +578,7 @@ SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
 	return ret;
 }
 
-SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
-		size_t, count)
+ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
 {
 	struct fd f = fdget_pos(fd);
 	ssize_t ret = -EBADF;
@@ -595,6 +594,12 @@ SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
 	return ret;
 }
 
+SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
+		size_t, count)
+{
+	return ksys_write(fd, buf, count);
+}
+
 SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
 			size_t, count, loff_t, pos)
 {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 920a0db1871d..80524faa9664 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -951,5 +951,6 @@ int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
 int ksys_umount(char __user *name, int flags);
 int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
+ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 
 #endif
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 99e0b649fc0e..2d365c398ccc 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -270,7 +270,7 @@ int __init rd_load_image(char *from)
 			printk("Loading disk #%d... ", disk);
 		}
 		sys_read(in_fd, buf, BLOCK_SIZE);
-		sys_write(out_fd, buf, BLOCK_SIZE);
+		ksys_write(out_fd, buf, BLOCK_SIZE);
 #if !defined(CONFIG_S390)
 		if (!(i % 16)) {
 			pr_cont("%c\b", rotator[rotate & 0x3]);
@@ -317,7 +317,7 @@ static long __init compr_fill(void *buf, unsigned long len)
 
 static long __init compr_flush(void *window, unsigned long outcnt)
 {
-	long written = sys_write(crd_outfd, window, outcnt);
+	long written = ksys_write(crd_outfd, window, outcnt);
 	if (written != outcnt) {
 		if (decompress_error == 0)
 			printk(KERN_ERR
diff --git a/init/initramfs.c b/init/initramfs.c
index 7e99a0038942..6f972df15bf2 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -27,7 +27,7 @@ static ssize_t __init xwrite(int fd, const char *p, size_t count)
 
 	/* sys_write only can write MAX_RW_COUNT aka 2G-4K bytes at most */
 	while (count) {
-		ssize_t rv = sys_write(fd, p, count);
+		ssize_t rv = ksys_write(fd, p, count);
 
 		if (rv < 0) {
 			if (rv == -EINTR || rv == -EAGAIN)
-- 
2.16.3
