Return-Path: <linux-kernel-owner+w=401wt.eu-S933987AbZHWThc@vger.kernel.org>
Date: Sun, 23 Aug 2009 21:37:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for v2.6.31-rc7
Message-ID: <20090823213714.11757b14@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Hendrik Brueckner (1):
      [S390] set preferred console based on conmode

Julia Lawall (1):
      [S390] drivers/s390: put NULL test before dereference

Sebastian Ott (1):
      [S390] cio: fix double free after failed device initialization

 arch/s390/kernel/setup.c  |   25 ++++++++++++++++++-------
 drivers/s390/block/dasd.c |    2 +-
 drivers/s390/cio/device.c |    4 +---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 9717717..cbb897b 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -154,6 +154,20 @@ static int __init condev_setup(char *str)
 
 __setup("condev=", condev_setup);
 
+static void __init set_preferred_console(void)
+{
+	if (MACHINE_IS_KVM) {
+		add_preferred_console("hvc", 0, NULL);
+		s390_virtio_console_init();
+		return;
+	}
+
+	if (CONSOLE_IS_3215 || CONSOLE_IS_SCLP)
+		add_preferred_console("ttyS", 0, NULL);
+	if (CONSOLE_IS_3270)
+		add_preferred_console("tty3270", 0, NULL);
+}
+
 static int __init conmode_setup(char *str)
 {
 #if defined(CONFIG_SCLP_CONSOLE) || defined(CONFIG_SCLP_VT220_CONSOLE)
@@ -168,6 +182,7 @@ static int __init conmode_setup(char *str)
 	if (strncmp(str, "3270", 5) == 0)
 		SET_CONSOLE_3270;
 #endif
+	set_preferred_console();
         return 1;
 }
 
@@ -780,9 +795,6 @@ static void __init setup_hwcaps(void)
 void __init
 setup_arch(char **cmdline_p)
 {
-	/* set up preferred console */
-	add_preferred_console("ttyS", 0, NULL);
-
         /*
          * print what head.S has found out about the machine
          */
@@ -802,11 +814,9 @@ setup_arch(char **cmdline_p)
 	if (MACHINE_IS_VM)
 		pr_info("Linux is running as a z/VM "
 			"guest operating system in 64-bit mode\n");
-	else if (MACHINE_IS_KVM) {
+	else if (MACHINE_IS_KVM)
 		pr_info("Linux is running under KVM in 64-bit mode\n");
-		add_preferred_console("hvc", 0, NULL);
-		s390_virtio_console_init();
-	} else
+	else
 		pr_info("Linux is running natively in 64-bit mode\n");
 #endif /* CONFIG_64BIT */
 
@@ -851,6 +861,7 @@ setup_arch(char **cmdline_p)
 
         /* Setup default console */
 	conmode_default();
+	set_preferred_console();
 
 	/* Setup zfcpdump support */
 	setup_zfcpdump(console_devno);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 7498366..3f62dd5 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2135,9 +2135,9 @@ static int dasd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	struct dasd_device *base;
 
 	block = bdev->bd_disk->private_data;
-	base = block->base;
 	if (!block)
 		return -ENODEV;
+	base = block->base;
 
 	if (!base->discipline ||
 	    !base->discipline->fill_geometry)
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 3c57c1a..d593bc7 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -772,10 +772,8 @@ static struct ccw_device * io_subchannel_create_ccwdev(struct subchannel *sch)
 	cdev = io_subchannel_allocate_dev(sch);
 	if (!IS_ERR(cdev)) {
 		ret = io_subchannel_initialize_dev(sch, cdev);
-		if (ret) {
-			kfree(cdev);
+		if (ret)
 			cdev = ERR_PTR(ret);
-		}
 	}
 	return cdev;
 }
