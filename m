From: Sachin Sant <sachinp@in.ibm.com>
Subject: [-next PATCH] Add param ops struct for hvc_iucv driver.
Date: Tue, 17 Nov 2009 18:51:03 +0530
Message-ID: <20091117132103.18413.53658.sendpatchset@localhost.localdomain>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Sachin Sant <sachinp@in.ibm.com>, schwidefsky@de.ibm.com, rusty@rustcorp.com.au, linux-next@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Today's next 20091117 build failed on s390 with

drivers/char/hvc_iucv.c:1331: error: 'param_ops_vmidfilter' undeclared here (not in a function)
make[2]: *** [drivers/char/hvc_iucv.o] Error 1

Most probably caused by commit 684a6d340b8a5767db4670031b0f39455346018a
(param:param_ops) which introduced a param_ops structure.

The following compile tested patch adds a param_ops structure for hvc_iucv.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/drivers/char/hvc_iucv.c b/drivers/char/hvc_iucv.c
--- a/drivers/char/hvc_iucv.c	2009-11-13 06:16:07.000000000 +0530
+++ b/drivers/char/hvc_iucv.c	2009-11-17 18:34:30.000000000 +0530
@@ -1146,7 +1146,7 @@ out_err:
  * Note: If it is called early in the boot process, @val is stored and
  *	 parsed later in hvc_iucv_init().
  */
-static int param_set_vmidfilter(const char *val, struct kernel_param *kp)
+static int param_set_vmidfilter(const char *val, const struct kernel_param *kp)
 {
 	int rc;
 
@@ -1173,7 +1173,7 @@ static int param_set_vmidfilter(const ch
  * The function stores the filter as a comma-separated list of z/VM user IDs
  * in @buffer. Typically, sysfs routines call this function for attr show.
  */
-static int param_get_vmidfilter(char *buffer, struct kernel_param *kp)
+static int param_get_vmidfilter(char *buffer, const struct kernel_param *kp)
 {
 	int rc;
 	size_t index, len;
@@ -1200,6 +1200,11 @@ static int param_get_vmidfilter(char *bu
 
 #define param_check_vmidfilter(name, p) __param_check(name, p, void)
 
+static struct kernel_param_ops param_ops_vmidfilter = {
+        .set = param_set_vmidfilter,
+        .get = param_get_vmidfilter,
+};
+
 /**
  * hvc_iucv_init() - z/VM IUCV HVC device driver initialization
  */
