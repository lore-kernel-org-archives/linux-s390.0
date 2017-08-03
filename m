Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 Aug 2017 21:57:38 +0800 (CST)
From: sohu0106 <sohu0106@126.com>
Subject: drivers/s390/char/keyboard.c NULL pointer reference
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Message-ID: <3b10f99f.aa01.15da8632dec.Coremail.sohu0106@126.com>
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



Local users able to send the NULL arg argument to kbd_ioctl(), which could cause kernel crash




diff --git a/keyboard.c 
b/keyboard.c
index ba0e4f9..3ec16b1 100644
--- a/keyboard.c
+++ b/keyboard.c
@@ -456,6 +456,8 @@ int kbd_ioctl(struct kbd_data *kbd, unsigned int cmd, unsigned long arg)
        int perm;
 
        argp = (void __user *)arg;
+       if( !argp )
+               return -EFAULT;
 
        /*
         * To have permissions to do most of the vt ioctls, we either have


https://bugzilla.kernel.org/show_bug.cgi?id=196575
