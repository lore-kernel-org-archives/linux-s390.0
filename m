Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 Aug 2017 21:59:31 +0800 (CST)
From: sohu0106 <sohu0106@126.com>
Subject: drivers/s390/char/keyboard.c kernel stack infoleak
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <116f735.aa23.15da864e94a.Coremail.sohu0106@126.com>
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


The stack object "kbdiacr" has a total size of 4 bytes. Its last 1 bytes are padding bytes after "result" which are not initialized and leaked to userland via "copy_to_user".


diff --git a/keyboard.c b/keyboard.c
index ba0e4f9..76a6d35 100644
--- a/keyboard.c
+++ b/keyboard.c
@@ -480,6 +480,8 @@ int kbd_ioctl(struct kbd_data *kbd, unsigned int cmd, unsigned long arg)
                struct kbdiacr diacr;
                int i;
 
+               memset( &diacr, 0, sizeof(struct kbdiacr) );
+
                if (put_user(kbd->accent_table_size, &a->kb_cnt))
                        return -EFAULT;
                for (i = 0; i < kbd->accent_table_size; i++) {
