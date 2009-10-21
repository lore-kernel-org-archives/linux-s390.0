Return-Path: <linux-kernel-owner+w=401wt.eu-S1753293AbZJUNJ5@vger.kernel.org>
Date: Wed, 21 Oct 2009 15:09:23 +0200 (CEST)
From: John Kacur <jkacur@redhat.com>
Subject: Re: Subject: [PATCH] crypto: s390: Remove BKL in zcrypt_open
In-Reply-To: <alpine.LFD.2.00.0910190046540.3405@localhost.localdomain>
Message-ID: <alpine.LFD.2.00.0910211505320.3526@localhost.localdomain>
References: <alpine.LFD.2.00.0910190046540.3405@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arndbergmann@googlemail.com>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Felix Beck <felix.beck@de.ibm.com>, Ralph Wuerthner <ralph.wuerthner@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


I took a deeper look at this after all of the great information form folks 
like Arnd and Thomas about what to be careful of. I think this patch is 
safe to do. I have respun it and explicitly set llseek to nollseek.

It is still RFC, or pending an ack by the S390 zcrypt folks who can 
actually test it.

Thanks

From 6d3fad58dbeae2e37aeb093197c25a57018ab8fd Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Mon, 19 Oct 2009 00:44:03 +0200
Subject: [PATCH] crypto: s390: Remove BKL in zcrypt_open

Remove the BKL in zcrypt_open and explicitly set llseek = nollseek.

- zcrypt_read, zcrypt_write, just return -EPERM
- zcrypt_open only has an atomic_inc which doesn't need to be locked.
- The bkl in the zcrypt_open function could conceivably be serializing the misc_register() in zcrypt_api_init(). However, the rest of the code is protected by the zcrypt_rng_mutex and the ioctl is already an unlocked_ioctl kind.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 drivers/s390/crypto/zcrypt_api.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 65b6a96..22c9b0a 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -34,7 +34,6 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/compat.h>
-#include <linux/smp_lock.h>
 #include <asm/atomic.h>
 #include <asm/uaccess.h>
 #include <linux/hw_random.h>
@@ -299,9 +298,7 @@ static ssize_t zcrypt_write(struct file *filp, const char __user *buf,
  */
 static int zcrypt_open(struct inode *inode, struct file *filp)
 {
-	lock_kernel();
 	atomic_inc(&zcrypt_open_count);
-	unlock_kernel();
 	return 0;
 }
 
@@ -888,6 +885,7 @@ static long zcrypt_compat_ioctl(struct file *filp, unsigned int cmd,
  */
 static const struct file_operations zcrypt_fops = {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.read		= zcrypt_read,
 	.write		= zcrypt_write,
 	.unlocked_ioctl	= zcrypt_unlocked_ioctl,
-- 
1.6.0.6
