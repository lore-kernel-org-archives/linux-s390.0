Return-Path: <linux-kernel-owner+w=401wt.eu-S1755690AbZHNL0h@vger.kernel.org>
Message-Id: <20090814112620.543808713@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 34/34] kernel: Set preferred s390 console based on conmode
Content-Disposition: inline; filename=133-preferred-console.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Provide a new function to set the default preferred console for s390.
The preferred console depends on the conmode parameter that is used
to switch between 3270 and 3215 terminal/console mode.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -154,6 +154,20 @@ static int __init condev_setup(char *str
 
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
@@ -168,6 +182,7 @@ static int __init conmode_setup(char *st
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

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
