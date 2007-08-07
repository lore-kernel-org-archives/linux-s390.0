Return-Path: <linux-kernel-owner+w=401wt.eu-S932284AbXHGLRt@vger.kernel.org>
Message-Id: <20070807111846.147082751@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/18] vmur: use DECLARE_COMPLETION_ONSTACK to keep lockdep happy
Content-Disposition: inline; filename=006-vmur-lockdep.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
000000000ff9fb08 000000000ff9fb18 0000000000000002 0000000000000000
000000000ff9fbb8 000000000ff9fb30 000000000ff9fb30 0000000000104198
0000000000000000 0000000000000002 0000000000000000 0000000000000000
000000000ff9fb18 000000000000000c 000000000ff9fb18 000000000ff9fb88
0000000000448db0 0000000000104198 000000000ff9fb18 000000000ff9fb68
Call Trace:
([<00000000001040ea>] show_trace+0x12e/0x170)
 [<00000000001041f2>] show_stack+0xc6/0xf8
 [<0000000000104252>] dump_stack+0x2e/0x3c
 [<0000000000155f9c>] __lock_acquire+0x460/0x1048
 [<0000000000156c16>] lock_acquire+0x92/0xb8
 [<000000000043f406>] _spin_lock_irqsave+0x62/0x80
 [<0000000000121382>] complete+0x32/0x78
 [<000000001082b468>] ur_int_handler+0xc8/0xec [vmur]
 [<0000000000313216>] ccw_device_call_handler+0xae/0xd4
 [<0000000000310da4>] ccw_device_irq+0x5c/0x130
 [<0000000000312c84>] io_subchannel_irq+0x8c/0x118
 [<000000000030a88c>] do_IRQ+0x16c/0x194
 [<0000000000111a62>] io_no_vtime+0x16/0x1c
 [<0000000080001394>] 0x80001394

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmur.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -202,7 +202,7 @@ static int do_ur_io(struct urdev *urd, s
 {
 	int rc;
 	struct ccw_device *cdev = urd->cdev;
-	DECLARE_COMPLETION(event);
+	DECLARE_COMPLETION_ONSTACK(event);
 
 	TRACE("do_ur_io: cpa=%p\n", cpa);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
