Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 07/23] use register_chrdev_ids in drivers/s390/
Date: Thu, 19 May 2011 15:33:10 -0600
Message-Id: <1305840792-25877-8-git-send-email-jim.cromie@gmail.com>
In-Reply-To: <1305840792-25877-1-git-send-email-jim.cromie@gmail.com>
References: <1305840792-25877-1-git-send-email-jim.cromie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, Jim Cromie <jim.cromie@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

cc: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-s390@vger.kernel.org
cc: linux390@de.ibm.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/s390/char/tape_char.c |    2 +-
 drivers/s390/char/vmlogrdr.c  |    2 +-
 drivers/s390/char/vmur.c      |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
index 87cd0ab..e321435 100644
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -494,7 +494,7 @@ tapechar_init (void)
 {
 	dev_t	dev;
 
-	if (alloc_chrdev_region(&dev, 0, 256, "tape") != 0)
+	if (register_chrdev_ids(&dev, 256, "tape") != 0)
 		return -1;
 
 	tapechar_major = MAJOR(dev);
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index c837d74..15eeab7 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -866,7 +866,7 @@ static int __init vmlogrdr_init(void)
 
         recording_class_AB = vmlogrdr_get_recording_class_AB();
 
-	rc = alloc_chrdev_region(&dev, 0, MAXMINOR, "vmlogrdr");
+	rc = register_chrdev_ids(&dev, MAXMINOR, "vmlogrdr");
 	if (rc)
 		return rc;
 	vmlogrdr_major = MAJOR(dev);
diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index f6b00c3..e752c84 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -1037,9 +1037,9 @@ static int __init ur_init(void)
 	if (rc)
 		goto fail_class_destroy;
 
-	rc = alloc_chrdev_region(&dev, 0, NUM_MINORS, "vmur");
+	rc = register_chrdev_ids(&dev, NUM_MINORS, "vmur");
 	if (rc) {
-		pr_err("Kernel function alloc_chrdev_region failed with "
+		pr_err("register_chrdev_ids() failed with "
 		       "error code %d\n", rc);
 		goto fail_unregister_driver;
 	}
-- 
1.7.4.4
