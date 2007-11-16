Return-Path: <linux-kernel-owner+w=401wt.eu-S934076AbXKPO3W@vger.kernel.org>
Message-Id: <20071116142526.818181701@de.ibm.com>
References: <20071116142441.484714036@de.ibm.com>
Date: Fri, 16 Nov 2007 15:24:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/10] appldata: remove unused binary sysctls.
Content-Disposition: inline; filename=005-appldata.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <geraldsc@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Remove binary sysctls that never worked due to missing strategy functions.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata.h         |    1 
 arch/s390/appldata/appldata_base.c    |   74 ++++++----------------------------
 arch/s390/appldata/appldata_mem.c     |    1 
 arch/s390/appldata/appldata_net_sum.c |    1 
 arch/s390/appldata/appldata_os.c      |    1 
 include/linux/sysctl.h                |    1 
 kernel/sysctl_check.c                 |   11 -----
 7 files changed, 15 insertions(+), 75 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2007-11-16 14:27:30.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2007-11-16 14:27:42.000000000 +0100
@@ -53,29 +53,26 @@ static int appldata_interval_handler(ctl
 static struct ctl_table_header *appldata_sysctl_header;
 static struct ctl_table appldata_table[] = {
 	{
-		.ctl_name	= CTL_APPLDATA_TIMER,
 		.procname	= "timer",
 		.mode		= S_IRUGO | S_IWUSR,
 		.proc_handler	= &appldata_timer_handler,
 	},
 	{
-		.ctl_name	= CTL_APPLDATA_INTERVAL,
 		.procname	= "interval",
 		.mode		= S_IRUGO | S_IWUSR,
 		.proc_handler	= &appldata_interval_handler,
 	},
-	{ .ctl_name = 0 }
+	{ },
 };
 
 static struct ctl_table appldata_dir_table[] = {
 	{
-		.ctl_name	= CTL_APPLDATA,
 		.procname	= appldata_proc_name,
 		.maxlen		= 0,
 		.mode		= S_IRUGO | S_IXUGO,
 		.child		= appldata_table,
 	},
-	{ .ctl_name = 0 }
+	{ },
 };
 
 /*
@@ -441,75 +438,38 @@ out:
  */
 int appldata_register_ops(struct appldata_ops *ops)
 {
-	struct list_head *lh;
-	struct appldata_ops *tmp_ops;
-	int i;
-
-	i = 0;
+	if ((ops->size > APPLDATA_MAX_REC_SIZE) || (ops->size < 0))
+		return -EINVAL;
 
-	if ((ops->size > APPLDATA_MAX_REC_SIZE) ||
-		(ops->size < 0)){
-		P_ERROR("Invalid size of %s record = %i, maximum = %i!\n",
-			ops->name, ops->size, APPLDATA_MAX_REC_SIZE);
-		return -ENOMEM;
-	}
-	if ((ops->ctl_nr == CTL_APPLDATA) ||
-	    (ops->ctl_nr == CTL_APPLDATA_TIMER) ||
-	    (ops->ctl_nr == CTL_APPLDATA_INTERVAL)) {
-		P_ERROR("ctl_nr %i already in use!\n", ops->ctl_nr);
-		return -EBUSY;
-	}
-	ops->ctl_table = kzalloc(4*sizeof(struct ctl_table), GFP_KERNEL);
-	if (ops->ctl_table == NULL) {
-		P_ERROR("Not enough memory for %s ctl_table!\n", ops->name);
+	ops->ctl_table = kzalloc(4 * sizeof(struct ctl_table), GFP_KERNEL);
+	if (!ops->ctl_table)
 		return -ENOMEM;
-	}
 
 	spin_lock(&appldata_ops_lock);
-	list_for_each(lh, &appldata_ops_list) {
-		tmp_ops = list_entry(lh, struct appldata_ops, list);
-		P_DEBUG("register_ops loop: %i) name = %s, ctl = %i\n",
-			++i, tmp_ops->name, tmp_ops->ctl_nr);
-		P_DEBUG("Comparing %s (ctl %i) with %s (ctl %i)\n",
-			tmp_ops->name, tmp_ops->ctl_nr, ops->name,
-			ops->ctl_nr);
-		if (strncmp(tmp_ops->name, ops->name,
-				APPLDATA_PROC_NAME_LENGTH) == 0) {
-			P_ERROR("Name \"%s\" already registered!\n", ops->name);
-			kfree(ops->ctl_table);
-			spin_unlock(&appldata_ops_lock);
-			return -EBUSY;
-		}
-		if (tmp_ops->ctl_nr == ops->ctl_nr) {
-			P_ERROR("ctl_nr %i already registered!\n", ops->ctl_nr);
-			kfree(ops->ctl_table);
-			spin_unlock(&appldata_ops_lock);
-			return -EBUSY;
-		}
-	}
 	list_add(&ops->list, &appldata_ops_list);
 	spin_unlock(&appldata_ops_lock);
 
-	ops->ctl_table[0].ctl_name = CTL_APPLDATA;
 	ops->ctl_table[0].procname = appldata_proc_name;
 	ops->ctl_table[0].maxlen   = 0;
 	ops->ctl_table[0].mode     = S_IRUGO | S_IXUGO;
 	ops->ctl_table[0].child    = &ops->ctl_table[2];
 
-	ops->ctl_table[1].ctl_name = 0;
-
-	ops->ctl_table[2].ctl_name = ops->ctl_nr;
 	ops->ctl_table[2].procname = ops->name;
 	ops->ctl_table[2].mode     = S_IRUGO | S_IWUSR;
 	ops->ctl_table[2].proc_handler = appldata_generic_handler;
 	ops->ctl_table[2].data = ops;
 
-	ops->ctl_table[3].ctl_name = 0;
-
 	ops->sysctl_header = register_sysctl_table(ops->ctl_table);
-
+	if (!ops->sysctl_header)
+		goto out;
 	P_INFO("%s-ops registered!\n", ops->name);
 	return 0;
+out:
+	spin_lock(&appldata_ops_lock);
+	list_del(&ops->list);
+	spin_unlock(&appldata_ops_lock);
+	kfree(ops->ctl_table);
+	return -ENOMEM;
 }
 
 /*
@@ -519,15 +479,11 @@ int appldata_register_ops(struct appldat
  */
 void appldata_unregister_ops(struct appldata_ops *ops)
 {
-	void *table;
 	spin_lock(&appldata_ops_lock);
 	list_del(&ops->list);
-	/* at that point any incoming access will fail */
-	table = ops->ctl_table;
-	ops->ctl_table = NULL;
 	spin_unlock(&appldata_ops_lock);
 	unregister_sysctl_table(ops->sysctl_header);
-	kfree(table);
+	kfree(ops->ctl_table);
 	P_INFO("%s-ops unregistered!\n", ops->name);
 }
 /********************** module-ops management <END> **************************/
diff -urpN linux-2.6/arch/s390/appldata/appldata.h linux-2.6-patched/arch/s390/appldata/appldata.h
--- linux-2.6/arch/s390/appldata/appldata.h	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata.h	2007-11-16 14:27:42.000000000 +0100
@@ -45,7 +45,6 @@ struct appldata_ops {
 	int    active;				/* monitoring status */
 
 	/* fill in from here */
-	unsigned int ctl_nr;			/* sysctl ID */
 	char name[APPLDATA_PROC_NAME_LENGTH];	/* name of /proc fs node */
 	unsigned char record_nr;		/* Record Nr. for Product ID */
 	void (*callback)(void *data);		/* callback function */
diff -urpN linux-2.6/arch/s390/appldata/appldata_mem.c linux-2.6-patched/arch/s390/appldata/appldata_mem.c
--- linux-2.6/arch/s390/appldata/appldata_mem.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_mem.c	2007-11-16 14:27:42.000000000 +0100
@@ -147,7 +147,6 @@ static void appldata_get_mem_data(void *
 
 
 static struct appldata_ops ops = {
-	.ctl_nr    = CTL_APPLDATA_MEM,
 	.name      = "mem",
 	.record_nr = APPLDATA_RECORD_MEM_ID,
 	.size	   = sizeof(struct appldata_mem_data),
diff -urpN linux-2.6/arch/s390/appldata/appldata_net_sum.c linux-2.6-patched/arch/s390/appldata/appldata_net_sum.c
--- linux-2.6/arch/s390/appldata/appldata_net_sum.c	2007-11-16 14:27:30.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_net_sum.c	2007-11-16 14:27:42.000000000 +0100
@@ -142,7 +142,6 @@ static void appldata_get_net_sum_data(vo
 
 
 static struct appldata_ops ops = {
-	.ctl_nr    = CTL_APPLDATA_NET_SUM,
 	.name	   = "net_sum",
 	.record_nr = APPLDATA_RECORD_NET_SUM_ID,
 	.size	   = sizeof(struct appldata_net_sum_data),
diff -urpN linux-2.6/arch/s390/appldata/appldata_os.c linux-2.6-patched/arch/s390/appldata/appldata_os.c
--- linux-2.6/arch/s390/appldata/appldata_os.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_os.c	2007-11-16 14:27:42.000000000 +0100
@@ -82,7 +82,6 @@ struct appldata_os_data {
 static struct appldata_os_data *appldata_os_data;
 
 static struct appldata_ops ops = {
-	.ctl_nr    = CTL_APPLDATA_OS,
 	.name	   = "os",
 	.record_nr = APPLDATA_RECORD_OS_ID,
 	.owner	   = THIS_MODULE,
diff -urpN linux-2.6/include/linux/sysctl.h linux-2.6-patched/include/linux/sysctl.h
--- linux-2.6/include/linux/sysctl.h	2007-11-16 14:27:42.000000000 +0100
+++ linux-2.6-patched/include/linux/sysctl.h	2007-11-16 14:27:42.000000000 +0100
@@ -70,7 +70,6 @@ enum
 	CTL_ABI=9,		/* Binary emulation */
 	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
 	CTL_ARLAN=254,		/* arlan wireless driver */
-	CTL_APPLDATA=2120,	/* s390 appldata */
 	CTL_S390DBF=5677,	/* s390 debug */
 	CTL_SUNRPC=7249,	/* sunrpc debug */
 	CTL_PM=9899,		/* frv power management */
diff -urpN linux-2.6/kernel/sysctl_check.c linux-2.6-patched/kernel/sysctl_check.c
--- linux-2.6/kernel/sysctl_check.c	2007-11-16 14:27:42.000000000 +0100
+++ linux-2.6-patched/kernel/sysctl_check.c	2007-11-16 14:27:42.000000000 +0100
@@ -1216,16 +1216,6 @@ static struct trans_ctl_table trans_arla
 	{}
 };
 
-static struct trans_ctl_table trans_appldata_table[] = {
-	{ CTL_APPLDATA_TIMER,		"timer" },
-	{ CTL_APPLDATA_INTERVAL,	"interval" },
-	{ CTL_APPLDATA_OS,		"os" },
-	{ CTL_APPLDATA_NET_SUM,		"net_sum" },
-	{ CTL_APPLDATA_MEM,		"mem" },
-	{}
-
-};
-
 static struct trans_ctl_table trans_s390dbf_table[] = {
 	{ 5678 /* CTL_S390DBF_STOPPABLE */,	"debug_stoppable" },
 	{ 5679 /* CTL_S390DBF_ACTIVE */,	"debug_active" },
@@ -1270,7 +1260,6 @@ static struct trans_ctl_table trans_root
 	{ CTL_ABI,	"abi" },
 	/* CTL_CPU not used */
 	{ CTL_ARLAN,	"arlan",	trans_arlan_table },
-	{ CTL_APPLDATA,	"appldata",	trans_appldata_table },
 	{ CTL_S390DBF,	"s390dbf",	trans_s390dbf_table },
 	{ CTL_SUNRPC,	"sunrpc",	trans_sunrpc_table },
 	{ CTL_PM,	"pm",		trans_pm_table },

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
