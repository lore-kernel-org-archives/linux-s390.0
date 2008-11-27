Return-Path: <linux-kernel-owner+w=401wt.eu-S1757411AbYK0Kvk@vger.kernel.org>
Message-Id: <20081127103142.083671467@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:11 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 51/60] convert iucv printks to dev_xxx and pr_xxx macros.
Content-Disposition: inline; filename=166-kmsg-iucv.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <braunu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/netiucv.c |   64 ++++++++++++++++++++++++++-------------------
 net/iucv/af_iucv.c         |   19 +++++++++++--
 net/iucv/iucv.c            |    9 ++++--
 3 files changed, 60 insertions(+), 32 deletions(-)

Index: quilt-2.6/drivers/s390/net/netiucv.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/netiucv.c
+++ quilt-2.6/drivers/s390/net/netiucv.c
@@ -31,6 +31,9 @@
  *
  */
 
+#define KMSG_COMPONENT "netiucv"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #undef DEBUG
 
 #include <linux/module.h>
@@ -846,7 +849,8 @@ static void conn_action_connsever(fsm_in
 
 	fsm_deltimer(&conn->timer);
 	iucv_path_sever(conn->path, NULL);
-	PRINT_INFO("%s: Remote dropped connection\n", netdev->name);
+	dev_info(privptr->dev, "The peer interface of the IUCV device"
+		" has closed the connection\n");
 	IUCV_DBF_TEXT(data, 2,
 		      "conn_action_connsever: Remote dropped connection\n");
 	fsm_newstate(fi, CONN_STATE_STARTWAIT);
@@ -856,13 +860,15 @@ static void conn_action_connsever(fsm_in
 static void conn_action_start(fsm_instance *fi, int event, void *arg)
 {
 	struct iucv_connection *conn = arg;
+	struct net_device *netdev = conn->netdev;
+	struct netiucv_priv *privptr = netdev_priv(netdev);
 	int rc;
 
 	IUCV_DBF_TEXT(trace, 3, __func__);
 
 	fsm_newstate(fi, CONN_STATE_STARTWAIT);
 	IUCV_DBF_TEXT_(setup, 2, "%s('%s'): connecting ...\n",
-		    conn->netdev->name, conn->userid);
+		netdev->name, conn->userid);
 
 	/*
 	 * We must set the state before calling iucv_connect because the
@@ -876,41 +882,45 @@ static void conn_action_start(fsm_instan
 			       NULL, iucvMagic, conn);
 	switch (rc) {
 	case 0:
-		conn->netdev->tx_queue_len = conn->path->msglim;
+		netdev->tx_queue_len = conn->path->msglim;
 		fsm_addtimer(&conn->timer, NETIUCV_TIMEOUT_5SEC,
 			     CONN_EVENT_TIMER, conn);
 		return;
 	case 11:
-		PRINT_INFO("%s: User %s is currently not available.\n",
-			   conn->netdev->name,
-			   netiucv_printname(conn->userid));
+		dev_warn(privptr->dev,
+			"The IUCV device failed to connect to z/VM guest %s\n",
+			netiucv_printname(conn->userid));
 		fsm_newstate(fi, CONN_STATE_STARTWAIT);
 		break;
 	case 12:
-		PRINT_INFO("%s: User %s is currently not ready.\n",
-			   conn->netdev->name,
-			   netiucv_printname(conn->userid));
+		dev_warn(privptr->dev,
+			"The IUCV device failed to connect to the peer on z/VM"
+			" guest %s\n", netiucv_printname(conn->userid));
 		fsm_newstate(fi, CONN_STATE_STARTWAIT);
 		break;
 	case 13:
-		PRINT_WARN("%s: Too many IUCV connections.\n",
-			   conn->netdev->name);
+		dev_err(privptr->dev,
+			"Connecting the IUCV device would exceed the maximum"
+			" number of IUCV connections\n");
 		fsm_newstate(fi, CONN_STATE_CONNERR);
 		break;
 	case 14:
-		PRINT_WARN("%s: User %s has too many IUCV connections.\n",
-			   conn->netdev->name,
-			   netiucv_printname(conn->userid));
+		dev_err(privptr->dev,
+			"z/VM guest %s has too many IUCV connections"
+			" to connect with the IUCV device\n",
+			netiucv_printname(conn->userid));
 		fsm_newstate(fi, CONN_STATE_CONNERR);
 		break;
 	case 15:
-		PRINT_WARN("%s: No IUCV authorization in CP directory.\n",
-			   conn->netdev->name);
+		dev_err(privptr->dev,
+			"The IUCV device cannot connect to a z/VM guest with no"
+			" IUCV authorization\n");
 		fsm_newstate(fi, CONN_STATE_CONNERR);
 		break;
 	default:
-		PRINT_WARN("%s: iucv_connect returned error %d\n",
-			   conn->netdev->name, rc);
+		dev_err(privptr->dev,
+			"Connecting the IUCV device failed with error %d\n",
+			rc);
 		fsm_newstate(fi, CONN_STATE_CONNERR);
 		break;
 	}
@@ -1059,8 +1069,9 @@ dev_action_connup(fsm_instance *fi, int 
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_STARTWAIT:
 			fsm_newstate(fi, DEV_STATE_RUNNING);
-			PRINT_INFO("%s: connected with remote side %s\n",
-			       dev->name, privptr->conn->userid);
+			dev_info(privptr->dev,
+				"The IUCV device has been connected"
+				" successfully to %s\n", privptr->conn->userid);
 			IUCV_DBF_TEXT(setup, 3,
 				"connection is up and running\n");
 			break;
@@ -1982,6 +1993,8 @@ static ssize_t conn_write(struct device_
 	if (rc)
 		goto out_unreg;
 
+	dev_info(priv->dev, "The IUCV interface to %s has been"
+		" established successfully\n", netiucv_printname(username));
 
 	return count;
 
@@ -2027,10 +2040,9 @@ static ssize_t remove_write (struct devi
 			continue;
 		read_unlock_bh(&iucv_connection_rwlock);
                 if (ndev->flags & (IFF_UP | IFF_RUNNING)) {
-			PRINT_WARN("netiucv: net device %s active with peer "
-				   "%s\n", ndev->name, priv->conn->userid);
-                        PRINT_WARN("netiucv: %s cannot be removed\n",
-				   ndev->name);
+			dev_warn(dev, "The IUCV device is connected"
+				" to %s and cannot be removed\n",
+				priv->conn->userid);
 			IUCV_DBF_TEXT(data, 2, "remove_write: still active\n");
 			return -EPERM;
                 }
@@ -2062,7 +2074,7 @@ static struct attribute_group *netiucv_d
 
 static void netiucv_banner(void)
 {
-	PRINT_INFO("NETIUCV driver initialized\n");
+	pr_info("driver initialized\n");
 }
 
 static void __exit netiucv_exit(void)
@@ -2088,7 +2100,7 @@ static void __exit netiucv_exit(void)
 	iucv_unregister(&netiucv_handler, 1);
 	iucv_unregister_dbf_views();
 
-	PRINT_INFO("NETIUCV driver unloaded\n");
+	pr_info("driver unloaded\n");
 	return;
 }
 
Index: quilt-2.6/net/iucv/af_iucv.c
===================================================================
--- quilt-2.6.orig/net/iucv/af_iucv.c
+++ quilt-2.6/net/iucv/af_iucv.c
@@ -8,6 +8,9 @@
  *  Author(s):	Jennifer Hunt <jenhunt@us.ibm.com>
  */
 
+#define KMSG_COMPONENT "af_iucv"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/list.h>
@@ -616,6 +619,8 @@ static int iucv_sock_sendmsg(struct kioc
 	struct iucv_sock *iucv = iucv_sk(sk);
 	struct sk_buff *skb;
 	struct iucv_message txmsg;
+	char user_id[9];
+	char appl_id[9];
 	int err;
 
 	err = sock_error(sk);
@@ -651,8 +656,15 @@ static int iucv_sock_sendmsg(struct kioc
 		err = iucv_message_send(iucv->path, &txmsg, 0, 0,
 					(void *) skb->data, skb->len);
 		if (err) {
-			if (err == 3)
-				printk(KERN_ERR "AF_IUCV msg limit exceeded\n");
+			if (err == 3) {
+				user_id[8] = 0;
+				memcpy(user_id, iucv->dst_user_id, 8);
+				appl_id[8] = 0;
+				memcpy(appl_id, iucv->dst_name, 8);
+				pr_err("Application %s on z/VM guest %s"
+				       " exceeds message limit\n",
+				       user_id, appl_id);
+			}
 			skb_unlink(skb, &iucv->send_skb_q);
 			err = -EPIPE;
 			goto fail;
@@ -1190,7 +1202,8 @@ static int __init afiucv_init(void)
 	int err;
 
 	if (!MACHINE_IS_VM) {
-		printk(KERN_ERR "AF_IUCV connection needs VM as base\n");
+		pr_err("The af_iucv module cannot be loaded"
+		       " without z/VM\n");
 		err = -EPROTONOSUPPORT;
 		goto out;
 	}
Index: quilt-2.6/net/iucv/iucv.c
===================================================================
--- quilt-2.6.orig/net/iucv/iucv.c
+++ quilt-2.6/net/iucv/iucv.c
@@ -30,6 +30,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define KMSG_COMPONENT "iucv"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
@@ -424,8 +427,8 @@ static void iucv_declare_cpu(void *data)
 			err = "Paging or storage error";
 			break;
 		}
-		printk(KERN_WARNING "iucv_register: iucv_declare_buffer "
-		       "on cpu %i returned error 0x%02x (%s)\n", cpu, rc, err);
+		pr_warning("Defining an interrupt buffer on CPU %i"
+			   " failed with 0x%02x (%s)\n", cpu, rc, err);
 		return;
 	}
 
@@ -1652,7 +1655,7 @@ static void iucv_external_interrupt(u16 
 	BUG_ON(p->iptype  < 0x01 || p->iptype > 0x09);
 	work = kmalloc(sizeof(struct iucv_irq_list), GFP_ATOMIC);
 	if (!work) {
-		printk(KERN_WARNING "iucv_external_interrupt: out of memory\n");
+		pr_warning("iucv_external_interrupt: out of memory\n");
 		return;
 	}
 	memcpy(&work->data, p, sizeof(work->data));

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
