From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 18:31:45 +0000
Subject: [CRIU][PATCH v3 10/15] s390:criu: Add support for s390 consoles
Message-Id: <20170630183150.76021-11-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On s390 we have special console drivers with minors 64 and 65.
Add support for them in criu code and in zdtm testsuite.

Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 criu/tty.c            | 11 +++++++++++
 test/zdtm/static/vt.c |  8 +++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/criu/tty.c b/criu/tty.c
index baef7f5..f674f25 100644
--- a/criu/tty.c
+++ b/criu/tty.c
@@ -300,6 +300,17 @@ struct tty_driver *get_tty_driver(dev_t rdev, dev_t dev)
 			 * of kernel).
 			 */
 			return &vt_driver;
+#ifdef __s390x__
+		/*
+		 * On s390 we have the following consoles:
+		 * - tty3215    : ttyS0   , minor = 64, linemode console
+		 * - sclp_line  : ttyS0   , minor = 64, linemode console
+		 * - sclp_vt220 : ttysclp0, minor = 65, vt220 console
+		 * See also "drivers/s390/char"
+		 */
+		else if (minor == 64 || minor == 65)
+			return &vt_driver;
+#endif
 		/* Other minors points to UART serial ports */
 		break;
 	case USB_SERIAL_MAJOR:
diff --git a/test/zdtm/static/vt.c b/test/zdtm/static/vt.c
index 0db0f2c..0d843c4 100644
--- a/test/zdtm/static/vt.c
+++ b/test/zdtm/static/vt.c
@@ -15,6 +15,12 @@ const char *test_author	= "Ruslan Kuprieiev <kupruser@gmail.com>";
 char *filename;
 TEST_OPTION(filename, string, "file name", 1);
 
+#ifdef __s390x__
+#define MINOR	64 /* ttyS0 */
+#else
+#define MINOR	5
+#endif
+
 int main(int argc, char **argv)
 {
 	struct stat st1, st2;
@@ -22,7 +28,7 @@ int main(int argc, char **argv)
 
 	test_init(argc, argv);
 
-	if (mknod(filename, S_IFCHR | S_IRUSR | S_IWUSR, makedev(4, 5))) {
+	if (mknod(filename, S_IFCHR | S_IRUSR | S_IWUSR, makedev(4, MINOR))) {
 		pr_perror("Can't create virtual terminal %s", filename);
 		return 1;
 	}
-- 
2.7.4
