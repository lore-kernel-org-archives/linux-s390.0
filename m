Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] s390/vmur: fix build warning
Date: Tue, 22 Dec 2015 12:23:51 +0530
Message-Id: <1450767231-21039-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

The helper no_seek_end_llseek() was added but now newpos is not required
and as a result we are getting build warning of unused variable.

Fixes: fb1d259e480c ("new helpers: no_seek_end_llseek{,_size}()")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/s390/char/vmur.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index a532e54..6c30e93a 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -782,8 +782,6 @@ static int ur_release(struct inode *inode, struct file *file)
 
 static loff_t ur_llseek(struct file *file, loff_t offset, int whence)
 {
-	loff_t newpos;
-
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY)
 		return -ESPIPE; /* seek allowed only for reader */
 	if (offset % PAGE_SIZE)
-- 
1.9.1
