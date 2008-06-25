Return-Path: <linux-kernel-owner+w=401wt.eu-S1754512AbYFYOoL@vger.kernel.org>
Message-Id: <20080625143616.232435891@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 19/21] Cleanup netiucv printk messages.
Content-Disposition: inline; filename=818-printk-netiucv.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Jeff Garzik <jgarzik@redhat.com>, Ursula Braun <braunu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Ursula Braun <braunu@de.ibm.com>
---

 drivers/s390/net/netiucv.c |   61 ++++++---------------------------------------
 1 file changed, 9 insertions(+), 52 deletions(-)

Index: quilt-2.6/drivers/s390/net/netiucv.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/netiucv.c
+++ quilt-2.6/drivers/s390/net/netiucv.c
@@ -625,9 +625,6 @@ static void netiucv_unpack_skb(struct iu
 		offset += header->next;
 		header->next -= NETIUCV_HDRLEN;
 		if (skb_tailroom(pskb) < header->next) {
-			PRINT_WARN("%s: Illegal next field in iucv header: "
-			       "%d > %d\n",
-			       dev->name, header->next, skb_tailroom(pskb));
 			IUCV_DBF_TEXT_(data, 2, "Illegal next field: %d > %d\n",
 				header->next, skb_tailroom(pskb));
 			return;
@@ -636,8 +633,6 @@ static void netiucv_unpack_skb(struct iu
 		skb_reset_mac_header(pskb);
 		skb = dev_alloc_skb(pskb->len);
 		if (!skb) {
-			PRINT_WARN("%s Out of memory in netiucv_unpack_skb\n",
-			       dev->name);
 			IUCV_DBF_TEXT(data, 2,
 				"Out of memory in netiucv_unpack_skb\n");
 			privptr->stats.rx_dropped++;
@@ -674,7 +669,6 @@ static void conn_action_rx(fsm_instance 
 
 	if (!conn->netdev) {
 		iucv_message_reject(conn->path, msg);
-		PRINT_WARN("Received data for unlinked connection\n");
 		IUCV_DBF_TEXT(data, 2,
 			      "Received data for unlinked connection\n");
 		return;
@@ -682,8 +676,6 @@ static void conn_action_rx(fsm_instance 
 	if (msg->length > conn->max_buffsize) {
 		iucv_message_reject(conn->path, msg);
 		privptr->stats.rx_dropped++;
-		PRINT_WARN("msglen %d > max_buffsize %d\n",
-			   msg->length, conn->max_buffsize);
 		IUCV_DBF_TEXT_(data, 2, "msglen %d > max_buffsize %d\n",
 			       msg->length, conn->max_buffsize);
 		return;
@@ -695,7 +687,6 @@ static void conn_action_rx(fsm_instance 
 				  msg->length, NULL);
 	if (rc || msg->length < 5) {
 		privptr->stats.rx_errors++;
-		PRINT_WARN("iucv_receive returned %08x\n", rc);
 		IUCV_DBF_TEXT_(data, 2, "rc %d from iucv_receive\n", rc);
 		return;
 	}
@@ -778,7 +769,6 @@ static void conn_action_txdone(fsm_insta
 		fsm_newstate(fi, CONN_STATE_IDLE);
 		if (privptr)
 			privptr->stats.tx_errors += txpackets;
-		PRINT_WARN("iucv_send returned %08x\n",	rc);
 		IUCV_DBF_TEXT_(data, 2, "rc %d from iucv_send\n", rc);
 	} else {
 		if (privptr) {
@@ -806,8 +796,6 @@ static void conn_action_connaccept(fsm_i
 	path->flags = 0;
 	rc = iucv_path_accept(path, &netiucv_handler, NULL, conn);
 	if (rc) {
-		PRINT_WARN("%s: IUCV accept failed with error %d\n",
-		       netdev->name, rc);
 		IUCV_DBF_TEXT_(setup, 2, "rc %d from iucv_accept", rc);
 		return;
 	}
@@ -873,7 +861,7 @@ static void conn_action_start(fsm_instan
 	IUCV_DBF_TEXT(trace, 3, __func__);
 
 	fsm_newstate(fi, CONN_STATE_STARTWAIT);
-	PRINT_DEBUG("%s('%s'): connecting ...\n",
+	IUCV_DBF_TEXT_(setup, 2, "%s('%s'): connecting ...\n",
 		    conn->netdev->name, conn->userid);
 
 	/*
@@ -968,8 +956,8 @@ static void conn_action_inval(fsm_instan
 	struct iucv_connection *conn = arg;
 	struct net_device *netdev = conn->netdev;
 
-	PRINT_WARN("%s: Cannot connect without username\n", netdev->name);
-	IUCV_DBF_TEXT(data, 2, "conn_action_inval called\n");
+	IUCV_DBF_TEXT_(data, 2, "%s('%s'): conn_action_inval called\n",
+		netdev->name, conn->userid);
 }
 
 static const fsm_node conn_fsm[] = {
@@ -1077,9 +1065,6 @@ dev_action_connup(fsm_instance *fi, int 
 				"connection is up and running\n");
 			break;
 		case DEV_STATE_STOPWAIT:
-			PRINT_INFO(
-			       "%s: got connection UP event during shutdown!\n",
-			       dev->name);
 			IUCV_DBF_TEXT(data, 2,
 				"dev_action_connup: in DEV_STATE_STOPWAIT\n");
 			break;
@@ -1174,8 +1159,6 @@ static int netiucv_transmit_skb(struct i
 			nskb = alloc_skb(skb->len + NETIUCV_HDRLEN +
 					 NETIUCV_HDRLEN, GFP_ATOMIC | GFP_DMA);
 			if (!nskb) {
-				PRINT_WARN("%s: Could not allocate tx_skb\n",
-				       conn->netdev->name);
 				IUCV_DBF_TEXT(data, 2, "alloc_skb failed\n");
 				rc = -ENOMEM;
 				return rc;
@@ -1223,7 +1206,6 @@ static int netiucv_transmit_skb(struct i
 				skb_pull(skb, NETIUCV_HDRLEN);
 				skb_trim(skb, skb->len - NETIUCV_HDRLEN);
 			}
-			PRINT_WARN("iucv_send returned %08x\n",	rc);
 			IUCV_DBF_TEXT_(data, 2, "rc %d from iucv_send\n", rc);
 		} else {
 			if (copied)
@@ -1293,14 +1275,11 @@ static int netiucv_tx(struct sk_buff *sk
 	 * Some sanity checks ...
 	 */
 	if (skb == NULL) {
-		PRINT_WARN("%s: NULL sk_buff passed\n", dev->name);
 		IUCV_DBF_TEXT(data, 2, "netiucv_tx: skb is NULL\n");
 		privptr->stats.tx_dropped++;
 		return 0;
 	}
 	if (skb_headroom(skb) < NETIUCV_HDRLEN) {
-		PRINT_WARN("%s: Got sk_buff with head room < %ld bytes\n",
-		       dev->name, NETIUCV_HDRLEN);
 		IUCV_DBF_TEXT(data, 2,
 			"netiucv_tx: skb_headroom < NETIUCV_HDRLEN\n");
 		dev_kfree_skb(skb);
@@ -1393,7 +1372,6 @@ static ssize_t user_write(struct device 
 
 	IUCV_DBF_TEXT(trace, 3, __func__);
 	if (count > 9) {
-		PRINT_WARN("netiucv: username too long (%d)!\n", (int) count);
 		IUCV_DBF_TEXT_(setup, 2,
 			       "%d is length of username\n", (int) count);
 		return -EINVAL;
@@ -1409,7 +1387,6 @@ static ssize_t user_write(struct device 
 			/* trailing lf, grr */
 			break;
 		}
-		PRINT_WARN("netiucv: Invalid char %c in username!\n", *p);
 		IUCV_DBF_TEXT_(setup, 2,
 			       "username: invalid character %c\n", *p);
 		return -EINVAL;
@@ -1421,18 +1398,15 @@ static ssize_t user_write(struct device 
 	if (memcmp(username, priv->conn->userid, 9) &&
 	    (ndev->flags & (IFF_UP | IFF_RUNNING))) {
 		/* username changed while the interface is active. */
-		PRINT_WARN("netiucv: device %s active, connected to %s\n",
-			   dev->bus_id, priv->conn->userid);
-		PRINT_WARN("netiucv: user cannot be updated\n");
 		IUCV_DBF_TEXT(setup, 2, "user_write: device active\n");
-		return -EBUSY;
+		return -EPERM;
 	}
 	read_lock_bh(&iucv_connection_rwlock);
 	list_for_each_entry(cp, &iucv_connection_list, list) {
 		if (!strncmp(username, cp->userid, 9) && cp->netdev != ndev) {
 			read_unlock_bh(&iucv_connection_rwlock);
-			PRINT_WARN("netiucv: Connection to %s already "
-				   "exists\n", username);
+			IUCV_DBF_TEXT_(setup, 2, "user_write: Connection "
+				"to %s already exists\n", username);
 			return -EEXIST;
 		}
 	}
@@ -1466,13 +1440,10 @@ static ssize_t buffer_write (struct devi
 	bs1 = simple_strtoul(buf, &e, 0);
 
 	if (e && (!isspace(*e))) {
-		PRINT_WARN("netiucv: Invalid character in buffer!\n");
 		IUCV_DBF_TEXT_(setup, 2, "buffer_write: invalid char %c\n", *e);
 		return -EINVAL;
 	}
 	if (bs1 > NETIUCV_BUFSIZE_MAX) {
-		PRINT_WARN("netiucv: Given buffer size %d too large.\n",
-			bs1);
 		IUCV_DBF_TEXT_(setup, 2,
 			"buffer_write: buffer size %d too large\n",
 			bs1);
@@ -1480,16 +1451,12 @@ static ssize_t buffer_write (struct devi
 	}
 	if ((ndev->flags & IFF_RUNNING) &&
 	    (bs1 < (ndev->mtu + NETIUCV_HDRLEN + 2))) {
-		PRINT_WARN("netiucv: Given buffer size %d too small.\n",
-			bs1);
 		IUCV_DBF_TEXT_(setup, 2,
 			"buffer_write: buffer size %d too small\n",
 			bs1);
 		return -EINVAL;
 	}
 	if (bs1 < (576 + NETIUCV_HDRLEN + NETIUCV_HDRLEN)) {
-		PRINT_WARN("netiucv: Given buffer size %d too small.\n",
-			bs1);
 		IUCV_DBF_TEXT_(setup, 2,
 			"buffer_write: buffer size %d too small\n",
 			bs1);
@@ -1963,7 +1930,6 @@ static ssize_t conn_write(struct device_
 
 	IUCV_DBF_TEXT(trace, 3, __func__);
 	if (count>9) {
-		PRINT_WARN("netiucv: username too long (%d)!\n", (int)count);
 		IUCV_DBF_TEXT(setup, 2, "conn_write: too long\n");
 		return -EINVAL;
 	}
@@ -1976,7 +1942,6 @@ static ssize_t conn_write(struct device_
 		if (*p == '\n')
 			/* trailing lf, grr */
 			break;
-		PRINT_WARN("netiucv: Invalid character in username!\n");
 		IUCV_DBF_TEXT_(setup, 2,
 			       "conn_write: invalid character %c\n", *p);
 		return -EINVAL;
@@ -1989,8 +1954,8 @@ static ssize_t conn_write(struct device_
 	list_for_each_entry(cp, &iucv_connection_list, list) {
 		if (!strncmp(username, cp->userid, 9)) {
 			read_unlock_bh(&iucv_connection_rwlock);
-			PRINT_WARN("netiucv: Connection to %s already "
-				   "exists\n", username);
+			IUCV_DBF_TEXT_(setup, 2, "conn_write: Connection "
+				"to %s already exists\n", username);
 			return -EEXIST;
 		}
 	}
@@ -1998,9 +1963,6 @@ static ssize_t conn_write(struct device_
 
 	dev = netiucv_init_netdevice(username);
 	if (!dev) {
-		PRINT_WARN("netiucv: Could not allocate network device "
-			   "structure for user '%s'\n",
-			   netiucv_printname(username));
 		IUCV_DBF_TEXT(setup, 2, "NULL from netiucv_init_netdevice\n");
 		return -ENODEV;
 	}
@@ -2020,15 +1982,12 @@ static ssize_t conn_write(struct device_
 	if (rc)
 		goto out_unreg;
 
-	PRINT_INFO("%s: '%s'\n", dev->name, netiucv_printname(username));
 
 	return count;
 
 out_unreg:
 	netiucv_unregister_device(priv->dev);
 out_free_ndev:
-	PRINT_WARN("netiucv: Could not register '%s'\n", dev->name);
-	IUCV_DBF_TEXT(setup, 2, "conn_write: could not register\n");
 	netiucv_free_netdevice(dev);
 	return rc;
 }
@@ -2073,14 +2032,13 @@ static ssize_t remove_write (struct devi
                         PRINT_WARN("netiucv: %s cannot be removed\n",
 				   ndev->name);
 			IUCV_DBF_TEXT(data, 2, "remove_write: still active\n");
-                        return -EBUSY;
+			return -EPERM;
                 }
                 unregister_netdev(ndev);
                 netiucv_unregister_device(dev);
                 return count;
         }
 	read_unlock_bh(&iucv_connection_rwlock);
-        PRINT_WARN("netiucv: net device %s unknown\n", name);
 	IUCV_DBF_TEXT(data, 2, "remove_write: unknown device\n");
         return -EINVAL;
 }
@@ -2148,7 +2106,6 @@ static int __init netiucv_init(void)
 	netiucv_driver.groups = netiucv_drv_attr_groups;
 	rc = driver_register(&netiucv_driver);
 	if (rc) {
-		PRINT_ERR("NETIUCV: failed to register driver.\n");
 		IUCV_DBF_TEXT_(setup, 2, "ret %d from driver_register\n", rc);
 		goto out_iucv;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
