Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Muhammad Falak R Wani <falakreyaz@gmail.com>
Subject: [PATCH v2] ks390/keyboard: use memdup_user_nul().
Date: Fri, 20 May 2016 18:51:20 +0530
Message-Id: <1463750488-12565-1-git-send-email-falakreyaz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Jan Kara <jack@suse.cz>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Use memdup_user_nul to duplicate a memory region from user-space
to kernel-space and terminate with a NULL, instead of open coding
using kmalloc + copy_from_user and explicitly NULL terminating.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/s390/char/keyboard.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index ef04a9f..f82a7dc 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -438,18 +438,13 @@ do_kdgkb_ioctl(struct kbd_data *kbd, struct kbsentry __user *u_kbs,
 			return -EFAULT;
 		if (len > sizeof(u_kbs->kb_string))
 			return -EINVAL;
-		p = kmalloc(len, GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-		if (copy_from_user(p, u_kbs->kb_string, len)) {
-			kfree(p);
-			return -EFAULT;
-		}
+		p = memdup_user_nul(u_kbs->kb_string, len);
+		if (IS_ERR(p))
+			return PTR_ERR(p);
 		/*
 		 * Make sure the string is terminated by 0. User could have
 		 * modified it between us running strnlen_user() and copying it.
 		 */
-		p[len - 1] = 0;
 		kfree(kbd->func_table[kb_func]);
 		kbd->func_table[kb_func] = p;
 		break;
-- 
1.9.1
