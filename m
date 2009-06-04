Return-Path: <linux-kernel-owner+w=401wt.eu-S1759636AbZFDQ0l@vger.kernel.org>
Message-Id: <20090604161906.066208246@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/38] iucv: establish reboot notifier
Content-Disposition: inline; filename=pm_iucv_reboot.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

To guarantee a proper cleanup, patch adds a reboot notifier to
the iucv base code, which disables iucv interrupts, shuts down
established iucv pathes, and removes iucv declarations for z/VM.

Checks have to be added to the iucv-API functions, whether 
iucv-buffers removed at reboot time are still declared.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 net/iucv/iucv.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 2 deletions(-)

Index: linux-2.6/net/iucv/iucv.c
===================================================================
--- linux-2.6.orig/net/iucv/iucv.c
+++ linux-2.6/net/iucv/iucv.c
@@ -1,7 +1,8 @@
 /*
  * IUCV base infrastructure.
  *
- * Copyright 2001, 2006 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Copyright IBM Corp. 2001, 2009
+ *
  * Author(s):
  *    Original source:
  *	Alan Altmark (Alan_Altmark@us.ibm.com)	Sept. 2000
@@ -45,6 +46,7 @@
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/reboot.h>
 #include <net/iucv/iucv.h>
 #include <asm/atomic.h>
 #include <asm/ebcdic.h>
@@ -758,6 +760,28 @@ void iucv_unregister(struct iucv_handler
 }
 EXPORT_SYMBOL(iucv_unregister);
 
+static int iucv_reboot_event(struct notifier_block *this,
+			     unsigned long event, void *ptr)
+{
+	int i, rc;
+
+	get_online_cpus();
+	on_each_cpu(iucv_block_cpu, NULL, 1);
+	preempt_disable();
+	for (i = 0; i < iucv_max_pathid; i++) {
+		if (iucv_path_table[i])
+			rc = iucv_sever_pathid(i, NULL);
+	}
+	preempt_enable();
+	put_online_cpus();
+	iucv_disable();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block iucv_reboot_notifier = {
+	.notifier_call = iucv_reboot_event,
+};
+
 /**
  * iucv_path_accept
  * @path: address of iucv path structure
@@ -777,6 +801,10 @@ int iucv_path_accept(struct iucv_path *p
 	int rc;
 
 	local_bh_disable();
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	/* Prepare parameter block. */
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
@@ -792,6 +820,7 @@ int iucv_path_accept(struct iucv_path *p
 		path->msglim = parm->ctrl.ipmsglim;
 		path->flags = parm->ctrl.ipflags1;
 	}
+out:
 	local_bh_enable();
 	return rc;
 }
@@ -821,6 +850,10 @@ int iucv_path_connect(struct iucv_path *
 
 	spin_lock_bh(&iucv_table_lock);
 	iucv_cleanup_queue();
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->ctrl.ipmsglim = path->msglim;
@@ -855,6 +888,7 @@ int iucv_path_connect(struct iucv_path *
 			rc = -EIO;
 		}
 	}
+out:
 	spin_unlock_bh(&iucv_table_lock);
 	return rc;
 }
@@ -876,12 +910,17 @@ int iucv_path_quiesce(struct iucv_path *
 	int rc;
 
 	local_bh_disable();
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (userdata)
 		memcpy(parm->ctrl.ipuser, userdata, sizeof(parm->ctrl.ipuser));
 	parm->ctrl.ippathid = path->pathid;
 	rc = iucv_call_b2f0(IUCV_QUIESCE, parm);
+out:
 	local_bh_enable();
 	return rc;
 }
@@ -903,12 +942,17 @@ int iucv_path_resume(struct iucv_path *p
 	int rc;
 
 	local_bh_disable();
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (userdata)
 		memcpy(parm->ctrl.ipuser, userdata, sizeof(parm->ctrl.ipuser));
 	parm->ctrl.ippathid = path->pathid;
 	rc = iucv_call_b2f0(IUCV_RESUME, parm);
+out:
 	local_bh_enable();
 	return rc;
 }
@@ -927,6 +971,10 @@ int iucv_path_sever(struct iucv_path *pa
 	int rc;
 
 	preempt_disable();
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	if (iucv_active_cpu != smp_processor_id())
 		spin_lock_bh(&iucv_table_lock);
 	rc = iucv_sever_pathid(path->pathid, userdata);
@@ -934,6 +982,7 @@ int iucv_path_sever(struct iucv_path *pa
 	list_del_init(&path->list);
 	if (iucv_active_cpu != smp_processor_id())
 		spin_unlock_bh(&iucv_table_lock);
+out:
 	preempt_enable();
 	return rc;
 }
@@ -956,6 +1005,10 @@ int iucv_message_purge(struct iucv_path 
 	int rc;
 
 	local_bh_disable();
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->purge.ippathid = path->pathid;
@@ -967,6 +1020,7 @@ int iucv_message_purge(struct iucv_path 
 		msg->audit = (*(u32 *) &parm->purge.ipaudit) >> 8;
 		msg->tag = parm->purge.ipmsgtag;
 	}
+out:
 	local_bh_enable();
 	return rc;
 }
@@ -1043,6 +1097,10 @@ int __iucv_message_receive(struct iucv_p
 	if (msg->flags & IUCV_IPRMDATA)
 		return iucv_message_receive_iprmdata(path, msg, flags,
 						     buffer, size, residual);
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->db.ipbfadr1 = (u32)(addr_t) buffer;
@@ -1058,6 +1116,7 @@ int __iucv_message_receive(struct iucv_p
 		if (residual)
 			*residual = parm->db.ipbfln1f;
 	}
+out:
 	return rc;
 }
 EXPORT_SYMBOL(__iucv_message_receive);
@@ -1111,6 +1170,10 @@ int iucv_message_reject(struct iucv_path
 	int rc;
 
 	local_bh_disable();
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->db.ippathid = path->pathid;
@@ -1118,6 +1181,7 @@ int iucv_message_reject(struct iucv_path
 	parm->db.iptrgcls = msg->class;
 	parm->db.ipflags1 = (IUCV_IPTRGCLS | IUCV_IPFGMID | IUCV_IPFGPID);
 	rc = iucv_call_b2f0(IUCV_REJECT, parm);
+out:
 	local_bh_enable();
 	return rc;
 }
@@ -1145,6 +1209,10 @@ int iucv_message_reply(struct iucv_path 
 	int rc;
 
 	local_bh_disable();
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (flags & IUCV_IPRMDATA) {
@@ -1162,6 +1230,7 @@ int iucv_message_reply(struct iucv_path 
 		parm->db.iptrgcls = msg->class;
 	}
 	rc = iucv_call_b2f0(IUCV_REPLY, parm);
+out:
 	local_bh_enable();
 	return rc;
 }
@@ -1190,6 +1259,10 @@ int __iucv_message_send(struct iucv_path
 	union iucv_param *parm;
 	int rc;
 
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (flags & IUCV_IPRMDATA) {
@@ -1212,6 +1285,7 @@ int __iucv_message_send(struct iucv_path
 	rc = iucv_call_b2f0(IUCV_SEND, parm);
 	if (!rc)
 		msg->id = parm->db.ipmsgid;
+out:
 	return rc;
 }
 EXPORT_SYMBOL(__iucv_message_send);
@@ -1272,6 +1346,10 @@ int iucv_message_send2way(struct iucv_pa
 	int rc;
 
 	local_bh_disable();
+	if (!cpu_isset(smp_processor_id(), iucv_buffer_cpumask)) {
+		rc = -EIO;
+		goto out;
+	}
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	if (flags & IUCV_IPRMDATA) {
@@ -1297,6 +1375,7 @@ int iucv_message_send2way(struct iucv_pa
 	rc = iucv_call_b2f0(IUCV_SEND, parm);
 	if (!rc)
 		msg->id = parm->db.ipmsgid;
+out:
 	local_bh_enable();
 	return rc;
 }
@@ -1738,15 +1817,20 @@ static int __init iucv_init(void)
 	rc = register_hotcpu_notifier(&iucv_cpu_notifier);
 	if (rc)
 		goto out_free;
+	rc = register_reboot_notifier(&iucv_reboot_notifier);
+	if (rc)
+		goto out_cpu;
 	ASCEBC(iucv_error_no_listener, 16);
 	ASCEBC(iucv_error_no_memory, 16);
 	ASCEBC(iucv_error_pathid, 16);
 	iucv_available = 1;
 	rc = bus_register(&iucv_bus);
 	if (rc)
-		goto out_cpu;
+		goto out_reboot;
 	return 0;
 
+out_reboot:
+	unregister_reboot_notifier(&iucv_reboot_notifier);
 out_cpu:
 	unregister_hotcpu_notifier(&iucv_cpu_notifier);
 out_free:
@@ -1781,6 +1865,7 @@ static void __exit iucv_exit(void)
 	list_for_each_entry_safe(p, n, &iucv_work_queue, list)
 		kfree(p);
 	spin_unlock_irq(&iucv_queue_lock);
+	unregister_reboot_notifier(&iucv_reboot_notifier);
 	unregister_hotcpu_notifier(&iucv_cpu_notifier);
 	for_each_possible_cpu(cpu) {
 		kfree(iucv_param_irq[cpu]);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
