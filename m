Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [TRIVIAL PATCH next 01/15] s390: Convert vmalloc/memset to vzalloc
Date: Sat, 28 May 2011 10:36:21 -0700
Message-Id: <f40dc6eefbb2cd401aa47970ffe786c6f198ba47.1306603968.git.joe@perches.com>
In-Reply-To: <cover.1306603968.git.joe@perches.com>
References: <cover.1306603968.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Kosina <trivial@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/s390/hypfs/hypfs_diag.c |    3 +--
 drivers/s390/cio/blacklist.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 6023c6d..74c8f5e 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -562,10 +562,9 @@ static int dbfs_d204_create(void **data, void **data_free_ptr, size_t *size)
 	void *base;
 
 	buf_size = PAGE_SIZE * (diag204_buf_pages + 1) + sizeof(d204->hdr);
-	base = vmalloc(buf_size);
+	base = vzalloc(buf_size);
 	if (!base)
 		return -ENOMEM;
-	memset(base, 0, buf_size);
 	d204 = page_align_ptr(base + sizeof(d204->hdr)) - sizeof(d204->hdr);
 	rc = diag204_do_store(d204->buf, diag204_buf_pages);
 	if (rc) {
diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index 76058a5..08c6603 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -335,10 +335,9 @@ cio_ignore_write(struct file *file, const char __user *user_buf,
 		return -EINVAL;
 	if (user_len > 65536)
 		user_len = 65536;
-	buf = vmalloc (user_len + 1); /* maybe better use the stack? */
+	buf = vzalloc(user_len + 1); /* maybe better use the stack? */
 	if (buf == NULL)
 		return -ENOMEM;
-	memset(buf, 0, user_len + 1);
 
 	if (strncpy_from_user (buf, user_buf, user_len) < 0) {
 		rc = -EFAULT;
-- 
1.7.5.rc3.dirty
