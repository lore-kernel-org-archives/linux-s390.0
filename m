From: Dan Carpenter <error27@gmail.com>
Date: Tue, 01 Mar 2011 15:22:50 +0000
Subject: [patch] [S390] keyboard: integer underflow bug
Message-Id: <20110301152250.GR18043@bicker>
To: linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The "ct" variable should be an unsigned int.  Both struct kbdiacrs
->kb_cnt and struct kbd_data ->accent_table_size are unsigned ints.

Making it signed causes a problem in KBDIACRUC because the user could
set the signed bit and cause a buffer overflow.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index d667334..8065881 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -458,7 +458,8 @@ do_kdgkb_ioctl(struct kbd_data *kbd, struct kbsentry __user *u_kbs,
 int kbd_ioctl(struct kbd_data *kbd, unsigned int cmd, unsigned long arg)
 {
 	void __user *argp;
-	int ct, perm;
+	unsigned int ct;
+	int perm;
 
 	argp = (void __user *)arg;
 
