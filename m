Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110727125808.028895659@linux.vnet.ibm.com>
Date: Wed, 27 Jul 2011 14:55:08 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v2 04/10] kdump: Trigger kdump via panic notifier chain on s390
References: <20110727125504.491183728@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-common-shutdown-action.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: vgoyal@redhat.com
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

On s390 we have the possibility to configure actions that are executed in
case of a kernel panic. E.g. it is possible to automatically trigger an s390
stand-alone dump. The actions are called via a panic notifier.  We also want
to trigger kdump via the notifier call chain. Therefore this patch disables
for s390 the direct kdump invocation in the panic() function.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/panic.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -84,9 +84,12 @@ NORET_TYPE void panic(const char * fmt,
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
+	 * For s390 kdump is triggered via the panic notifier call chain.
 	 * Do we want to call this before we try to display a message?
 	 */
+#if !defined(CONFIG_S390)
 	crash_kexec(NULL);
+#endif
 
 	kmsg_dump(KMSG_DUMP_PANIC);
 
