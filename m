Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/9] fs: remove various compat readv/writev helpers
Date: Fri, 18 Sep 2020 14:45:29 +0200
Message-Id: <20200918124533.3487701-6-hch@lst.de>
In-Reply-To: <20200918124533.3487701-1-hch@lst.de>
References: <20200918124533.3487701-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Now that import_iovec handles compat iovecs as well, all the duplicated
code in the compat readv/writev helpers is not needed.  Remove them
and switch the compat syscall handlers to use the native helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 179 ++++++++----------------------------------------
 1 file changed, 30 insertions(+), 149 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 2f961c653ce561..9eb63c53da78f2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1211,226 +1211,107 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 	return do_pwritev(fd, vec, vlen, pos, flags);
 }
 
+/*
+ * Various compat syscalls.  Note that they all pretend to take a native
+ * iovec - import_iovec will properly treat those as compat_iovecs based on
+ * in_compat_syscall().
+ */
 #ifdef CONFIG_COMPAT
-static size_t compat_readv(struct file *file,
-			   const struct compat_iovec __user *vec,
-			   unsigned long vlen, loff_t *pos, rwf_t flags)
-{
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
-	struct iov_iter iter;
-	ssize_t ret;
-
-	ret = import_iovec(READ, (const struct iovec __user *)vec, vlen,
-			   UIO_FASTIOV, &iov, &iter);
-	if (ret >= 0) {
-		ret = do_iter_read(file, &iter, pos, flags);
-		kfree(iov);
-	}
-	if (ret > 0)
-		add_rchar(current, ret);
-	inc_syscr(current);
-	return ret;
-}
-
-static size_t do_compat_readv(compat_ulong_t fd,
-				 const struct compat_iovec __user *vec,
-				 compat_ulong_t vlen, rwf_t flags)
-{
-	struct fd f = fdget_pos(fd);
-	ssize_t ret;
-	loff_t pos;
-
-	if (!f.file)
-		return -EBADF;
-	pos = f.file->f_pos;
-	ret = compat_readv(f.file, vec, vlen, &pos, flags);
-	if (ret >= 0)
-		f.file->f_pos = pos;
-	fdput_pos(f);
-	return ret;
-
-}
-
 COMPAT_SYSCALL_DEFINE3(readv, compat_ulong_t, fd,
-		const struct compat_iovec __user *,vec,
+		const struct iovec __user *, vec,
 		compat_ulong_t, vlen)
 {
-	return do_compat_readv(fd, vec, vlen, 0);
-}
-
-static long do_compat_preadv64(unsigned long fd,
-				  const struct compat_iovec __user *vec,
-				  unsigned long vlen, loff_t pos, rwf_t flags)
-{
-	struct fd f;
-	ssize_t ret;
-
-	if (pos < 0)
-		return -EINVAL;
-	f = fdget(fd);
-	if (!f.file)
-		return -EBADF;
-	ret = -ESPIPE;
-	if (f.file->f_mode & FMODE_PREAD)
-		ret = compat_readv(f.file, vec, vlen, &pos, flags);
-	fdput(f);
-	return ret;
+	return do_readv(fd, vec, vlen, 0);
 }
 
 #ifdef __ARCH_WANT_COMPAT_SYS_PREADV64
 COMPAT_SYSCALL_DEFINE4(preadv64, unsigned long, fd,
-		const struct compat_iovec __user *,vec,
+		const struct iovec __user *, vec,
 		unsigned long, vlen, loff_t, pos)
 {
-	return do_compat_preadv64(fd, vec, vlen, pos, 0);
+	return do_preadv(fd, vec, vlen, pos, 0);
 }
 #endif
 
 COMPAT_SYSCALL_DEFINE5(preadv, compat_ulong_t, fd,
-		const struct compat_iovec __user *,vec,
+		const struct iovec __user *, vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high)
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
 
-	return do_compat_preadv64(fd, vec, vlen, pos, 0);
+	return do_preadv(fd, vec, vlen, pos, 0);
 }
 
 #ifdef __ARCH_WANT_COMPAT_SYS_PREADV64V2
 COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
-		const struct compat_iovec __user *,vec,
+		const struct iovec __user *, vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
 	if (pos == -1)
-		return do_compat_readv(fd, vec, vlen, flags);
-
-	return do_compat_preadv64(fd, vec, vlen, pos, flags);
+		return do_readv(fd, vec, vlen, flags);
+	return do_preadv(fd, vec, vlen, pos, flags);
 }
 #endif
 
 COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
-		const struct compat_iovec __user *,vec,
+		const struct iovec __user *, vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high,
 		rwf_t, flags)
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
 
 	if (pos == -1)
-		return do_compat_readv(fd, vec, vlen, flags);
-
-	return do_compat_preadv64(fd, vec, vlen, pos, flags);
-}
-
-static size_t compat_writev(struct file *file,
-			    const struct compat_iovec __user *vec,
-			    unsigned long vlen, loff_t *pos, rwf_t flags)
-{
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
-	struct iov_iter iter;
-	ssize_t ret;
-
-	ret = import_iovec(WRITE, (const struct iovec __user *)vec, vlen,
-			   UIO_FASTIOV, &iov, &iter);
-	if (ret >= 0) {
-		file_start_write(file);
-		ret = do_iter_write(file, &iter, pos, flags);
-		file_end_write(file);
-		kfree(iov);
-	}
-	if (ret > 0)
-		add_wchar(current, ret);
-	inc_syscw(current);
-	return ret;
-}
-
-static size_t do_compat_writev(compat_ulong_t fd,
-				  const struct compat_iovec __user* vec,
-				  compat_ulong_t vlen, rwf_t flags)
-{
-	struct fd f = fdget_pos(fd);
-	ssize_t ret;
-	loff_t pos;
-
-	if (!f.file)
-		return -EBADF;
-	pos = f.file->f_pos;
-	ret = compat_writev(f.file, vec, vlen, &pos, flags);
-	if (ret >= 0)
-		f.file->f_pos = pos;
-	fdput_pos(f);
-	return ret;
+		return do_readv(fd, vec, vlen, flags);
+	return do_preadv(fd, vec, vlen, pos, flags);
 }
 
 COMPAT_SYSCALL_DEFINE3(writev, compat_ulong_t, fd,
-		const struct compat_iovec __user *, vec,
+		const struct iovec __user *, vec,
 		compat_ulong_t, vlen)
 {
-	return do_compat_writev(fd, vec, vlen, 0);
-}
-
-static long do_compat_pwritev64(unsigned long fd,
-				   const struct compat_iovec __user *vec,
-				   unsigned long vlen, loff_t pos, rwf_t flags)
-{
-	struct fd f;
-	ssize_t ret;
-
-	if (pos < 0)
-		return -EINVAL;
-	f = fdget(fd);
-	if (!f.file)
-		return -EBADF;
-	ret = -ESPIPE;
-	if (f.file->f_mode & FMODE_PWRITE)
-		ret = compat_writev(f.file, vec, vlen, &pos, flags);
-	fdput(f);
-	return ret;
+	return do_writev(fd, vec, vlen, 0);
 }
 
 #ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64
 COMPAT_SYSCALL_DEFINE4(pwritev64, unsigned long, fd,
-		const struct compat_iovec __user *,vec,
+		const struct iovec __user *, vec,
 		unsigned long, vlen, loff_t, pos)
 {
-	return do_compat_pwritev64(fd, vec, vlen, pos, 0);
+	return do_pwritev(fd, vec, vlen, pos, 0);
 }
 #endif
 
 COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
-		const struct compat_iovec __user *,vec,
+		const struct iovec __user *,vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high)
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
 
-	return do_compat_pwritev64(fd, vec, vlen, pos, 0);
+	return do_pwritev(fd, vec, vlen, pos, 0);
 }
 
 #ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
 COMPAT_SYSCALL_DEFINE5(pwritev64v2, unsigned long, fd,
-		const struct compat_iovec __user *,vec,
+		const struct iovec __user *, vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
 	if (pos == -1)
-		return do_compat_writev(fd, vec, vlen, flags);
-
-	return do_compat_pwritev64(fd, vec, vlen, pos, flags);
+		return do_writev(fd, vec, vlen, flags);
+	return do_pwritev(fd, vec, vlen, pos, flags);
 }
 #endif
 
 COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
-		const struct compat_iovec __user *,vec,
+		const struct iovec __user *,vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high, rwf_t, flags)
 {
 	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
 
 	if (pos == -1)
-		return do_compat_writev(fd, vec, vlen, flags);
-
-	return do_compat_pwritev64(fd, vec, vlen, pos, flags);
+		return do_writev(fd, vec, vlen, flags);
+	return do_pwritev(fd, vec, vlen, pos, flags);
 }
-
-#endif
+#endif /* CONFIG_COMPAT */
 
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		  	   size_t count, loff_t max)
-- 
2.28.0
