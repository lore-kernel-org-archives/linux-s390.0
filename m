Return-Path: <linux-kernel-owner+w=401wt.eu-S966339AbXDGUaz@vger.kernel.org>
Date: Sun, 8 Apr 2007 00:31:21 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] iucv: fix compilation on s390-up
Message-ID: <20070407203120.GA11326@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

  CC [M]  net/iucv/iucv.o
net/iucv/iucv.c: In function 'iucv_init':
net/iucv/iucv.c:1556: error: 'iucv_cpu_notifier' undeclared (first use in this function)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 net/iucv/iucv.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -519,7 +519,6 @@ static void iucv_disable(void)
 	kfree(iucv_path_table);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int __cpuinit iucv_cpu_notify(struct notifier_block *self,
 				     unsigned long action, void *hcpu)
 {
@@ -565,7 +564,6 @@ static int __cpuinit iucv_cpu_notify(struct notifier_block *self,
 static struct notifier_block iucv_cpu_notifier = {
 	.notifier_call = iucv_cpu_notify,
 };
-#endif
 
 /**
  * iucv_sever_pathid
