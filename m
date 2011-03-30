Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110330080923.413595315@linux.vnet.ibm.com>
Date: Wed, 30 Mar 2011 10:06:38 +0200
From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: v2 [patch 1/1] Do not unregister_cpu_notifier in case of wrong state 
References: <20110330080637.110679740@linux.vnet.ibm.com>
Content-Disposition: inline; filename=hwsampler-shutdown.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: robert.richter@amd.com
Cc: mingo@elte.hu, oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>

This patch avoids calling unregister_cpu_notifier() in case
hwsampler_shutdown() is invoked in wrong state. 
---
 arch/s390/oprofile/hwsampler.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Index: 2.6.39/arch/s390/oprofile/hwsampler.c
===================================================================
--- 2.6.39.orig/arch/s390/oprofile/hwsampler.c
+++ 2.6.39/arch/s390/oprofile/hwsampler.c
@@ -1142,12 +1142,15 @@ int hwsampler_shutdown()
 		}
 
 		unregister_external_interrupt(0x1407, hws_ext_handler);
-		hws_state = HWS_INIT;
+		hws_state = 0;
+
+		mutex_unlock(&hws_sem);
+		unregister_cpu_notifier(&hws_cpu_notifier);
+
 		rc = 0;
+	} else {
+		mutex_unlock(&hws_sem);
 	}
-	mutex_unlock(&hws_sem);
-
-	unregister_cpu_notifier(&hws_cpu_notifier);
 
 	return rc;
 }
