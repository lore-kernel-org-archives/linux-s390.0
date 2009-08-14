Return-Path: <linux-kernel-owner+w=401wt.eu-S1756127AbZHNLaQ@vger.kernel.org>
Message-Id: <20090814112620.312076191@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 33/34] zcrypt: Use spin_lock_bh in suspend callback
Content-Disposition: inline; filename=132-zcrypt-locking-callback.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Felix Beck <felix.beck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

Fix lock dependency warning.

inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
bash/1442 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&ap_dev->lock){+.?...}, at: [<000003e001280404>] __ap_poll_device+0x40/0x3e8 [ap]
{IN-SOFTIRQ-W} state was registered at:
  [<000000000017f094>] __lock_acquire+0xb78/0x182c
  [<000000000017fe8e>] lock_acquire+0x146/0x178
  [<0000000000549cf2>] _spin_lock+0x5a/0x98
  [<000003e001280404>] __ap_poll_device+0x40/0x3e8 [ap]
  [<000003e001280afe>] ap_poll_all+0xaa/0x1a4 [ap]
  [<000000000014fa82>] tasklet_action+0xfe/0x1f4
  [<0000000000150a56>] __do_softirq+0x116/0x284
  [<0000000000111058>] do_softirq+0xe4/0xe8
  [<00000000001504ba>] irq_exit+0xba/0xd8
  [<00000000003dd04a>] do_IRQ+0x176/0x1fc
  [<000000000011823c>] io_return+0x0/0x8
  [<0000004bfbfd2c0e>] 0x4bfbfd2c0e

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -648,7 +648,9 @@ static int ap_bus_suspend(struct device 
 	/* Poll on the device until all requests are finished. */
 	do {
 		flags = 0;
+		spin_lock_bh(&ap_dev->lock);
 		__ap_poll_device(ap_dev, &flags);
+		spin_unlock_bh(&ap_dev->lock);
 	} while ((flags & 1) || (flags & 2));
 
 	ap_device_remove(dev);
@@ -1407,14 +1409,12 @@ static void ap_reset(struct ap_device *a
 
 static int __ap_poll_device(struct ap_device *ap_dev, unsigned long *flags)
 {
-	spin_lock(&ap_dev->lock);
 	if (!ap_dev->unregistered) {
 		if (ap_poll_queue(ap_dev, flags))
 			ap_dev->unregistered = 1;
 		if (ap_dev->reset == AP_RESET_DO)
 			ap_reset(ap_dev);
 	}
-	spin_unlock(&ap_dev->lock);
 	return 0;
 }
 
@@ -1441,7 +1441,9 @@ static void ap_poll_all(unsigned long du
 		flags = 0;
 		spin_lock(&ap_device_list_lock);
 		list_for_each_entry(ap_dev, &ap_device_list, list) {
+			spin_lock(&ap_dev->lock);
 			__ap_poll_device(ap_dev, &flags);
+			spin_unlock(&ap_dev->lock);
 		}
 		spin_unlock(&ap_device_list_lock);
 	} while (flags & 1);
@@ -1487,7 +1489,9 @@ static int ap_poll_thread(void *data)
 		flags = 0;
 		spin_lock_bh(&ap_device_list_lock);
 		list_for_each_entry(ap_dev, &ap_device_list, list) {
+			spin_lock(&ap_dev->lock);
 			__ap_poll_device(ap_dev, &flags);
+			spin_unlock(&ap_dev->lock);
 		}
 		spin_unlock_bh(&ap_device_list_lock);
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
