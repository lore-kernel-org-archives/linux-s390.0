Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 08/16] s390: remove trailing space in messages
Date: Sat,  6 Feb 2010 18:47:15 +0100
Message-Id: <1265478443-31072-8-git-send-email-elendil@planet.nl>
In-Reply-To: <201002061844.45212.elendil@planet.nl>
References: <201002061844.45212.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/math-emu/math.c        |    2 +-
 drivers/s390/block/dasd_eckd.c   |    2 +-
 drivers/s390/block/dasd_proc.c   |    2 +-
 drivers/s390/block/dcssblk.c     |    2 +-
 drivers/s390/block/xpram.c       |    4 ++--
 drivers/s390/char/vmlogrdr.c     |    2 +-
 drivers/s390/cio/device_status.c |    2 +-
 drivers/s390/net/claw.c          |    4 ++--
 drivers/s390/net/ctcm_fsms.c     |    4 ++--
 drivers/s390/net/ctcm_main.c     |    2 +-
 drivers/s390/net/ctcm_mpc.c      |   16 ++++++++--------
 drivers/s390/net/lcs.c           |    2 +-
 drivers/s390/net/qeth_l2_main.c  |    2 +-
 drivers/s390/net/qeth_l3_main.c  |    2 +-
 14 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/s390/math-emu/math.c b/arch/s390/math-emu/math.c
index cd4e9c1..aa6fb75 100644
--- a/arch/s390/math-emu/math.c
+++ b/arch/s390/math-emu/math.c
@@ -106,7 +106,7 @@ static void display_emulation_not_implemented(struct pt_regs *regs, char *instr)
         {
                 location = (__u16 *)(regs->psw.addr-S390_lowcore.pgm_ilc);
                 printk("%s ieee fpu instruction not emulated "
-                       "process name: %s pid: %d \n",
+                       "process name: %s pid: %d\n",
                        instr, current->comm, current->pid);
                 printk("%s's PSW:    %08lx %08lx\n", instr,
                        (unsigned long) regs->psw.mask,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 1cca21a..0922829 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3198,7 +3198,7 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 			break;
 		case 3: /* tsa_intrg */
 			len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-				      " tsb->tsa.intrg.: not supportet yet \n");
+				      " tsb->tsa.intrg.: not supportet yet\n");
 			break;
 		}
 
diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index 71f95f5..9c70b8a 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -246,7 +246,7 @@ dasd_statistics_read(char *page, char **start, off_t off,
 	str = dasd_statistics_array(str, prof->dasd_io_time2ps, factor);
 	str += sprintf(str, "Histogram of I/O time between irq and end\n");
 	str = dasd_statistics_array(str, prof->dasd_io_time3, factor);
-	str += sprintf(str, "# of req in chanq at enqueuing (1..32) \n");
+	str += sprintf(str, "# of req in chanq at enqueuing (1..32)\n");
 	str = dasd_statistics_array(str, prof->dasd_io_nr_req, factor);
 	len = str - page;
 #else
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 9b43ae9..c8f8204 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -1089,7 +1089,7 @@ MODULE_PARM_DESC(segments, "Name of DCSS segment(s) to be loaded, "
 		 "names of contiguous segments and each name max. 8 chars.\n"
 		 "Adding \"(local)\" to the end of each set equals echoing 0 "
 		 "to /sys/devices/dcssblk/<device name>/shared after loading "
-		 "the contiguous segments - \n"
+		 "the contiguous segments -\n"
 		 "e.g. segments=\"mydcss1,mydcss2:mydcss3,mydcss4(local)\"");
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 118de39..d9cce33 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -71,7 +71,7 @@ module_param_array(sizes, charp, NULL, 0);
 MODULE_PARM_DESC(devs, "number of devices (\"partitions\"), " \
 		 "the default is " __MODULE_STRING(XPRAM_DEVS) "\n");
 MODULE_PARM_DESC(sizes, "list of device (partition) sizes " \
-		 "the defaults are 0s \n" \
+		 "the defaults are 0s\n" \
 		 "All devices with size 0 equally partition the "
 		 "remaining space on the expanded strorage not "
 		 "claimed by explicit sizes\n");
@@ -294,7 +294,7 @@ static int __init xpram_setup_sizes(unsigned long pages)
 			mem_auto_no++;
 	}
 	
-	pr_info("  number of devices (partitions): %d \n", xpram_devs);
+	pr_info("  number of devices (partitions): %d\n", xpram_devs);
 	for (i = 0; i < xpram_devs; i++) {
 		if (xpram_sizes[i])
 			pr_info("  size of partition %d: %u kB\n",
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 7dfa541..5c51c18 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -345,7 +345,7 @@ static int vmlogrdr_open (struct inode *inode, struct file *filp)
 				       logptr);
 	if (connect_rc) {
 		pr_err("vmlogrdr: iucv connection to %s "
-		       "failed with rc %i \n",
+		       "failed with rc %i\n",
 		       logptr->system_service, connect_rc);
 		goto out_path;
 	}
diff --git a/drivers/s390/cio/device_status.c b/drivers/s390/cio/device_status.c
index 66d8066..1b9c304 100644
--- a/drivers/s390/cio/device_status.c
+++ b/drivers/s390/cio/device_status.c
@@ -60,7 +60,7 @@ ccw_device_path_notoper(struct ccw_device *cdev)
 		goto doverify;
 
 	CIO_MSG_EVENT(0, "%s(0.%x.%04x) - path(s) %02x are "
-		      "not operational \n", __func__,
+		      "not operational\n", __func__,
 		      sch->schid.ssid, sch->schid.sch_no,
 		      sch->schib.pmcw.pnom);
 
diff --git a/drivers/s390/net/claw.c b/drivers/s390/net/claw.c
index 147bb1a..31bc864 100644
--- a/drivers/s390/net/claw.c
+++ b/drivers/s390/net/claw.c
@@ -738,7 +738,7 @@ claw_irq_handler(struct ccw_device *cdev,
 				privptr->stats.rx_errors++;
 				dev_info(&cdev->dev,
 					"%s: Restart is required after remote "
-					"side recovers \n",
+					"side recovers\n",
 					dev->name);
 			}
 			CLAW_DBF_TEXT(4, trace, "notrdy");
@@ -3075,7 +3075,7 @@ claw_shutdown_device(struct ccwgroup_device *cgdev)
 	ndev = priv->channel[READ].ndev;
 	if (ndev) {
 		/* Close the device */
-		dev_info(&cgdev->dev, "%s: shutting down \n",
+		dev_info(&cgdev->dev, "%s: shutting down\n",
 			ndev->name);
 		if (ndev->flags & IFF_RUNNING)
 			ret = claw_release(ndev);
diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
index 70eb7f1..ed43a6f 100644
--- a/drivers/s390/net/ctcm_fsms.c
+++ b/drivers/s390/net/ctcm_fsms.c
@@ -1292,7 +1292,7 @@ static void ctcmpc_chx_txdone(fsm_instance *fi, int event, void *arg)
 		else
 			p_header->pdu_flag |= 0x20;
 
-		CTCM_PR_DBGDATA("%s: trans_skb len:%04x \n",
+		CTCM_PR_DBGDATA("%s: trans_skb len:%04x\n",
 				__func__, ch->trans_skb->len);
 		CTCM_PR_DBGDATA("%s: pdu header and data for up"
 				" to 32 bytes sent to vtam\n", __func__);
@@ -1330,7 +1330,7 @@ static void ctcmpc_chx_txdone(fsm_instance *fi, int event, void *arg)
 
 	kfree(header);
 
-	CTCM_PR_DBGDATA("%s: trans_skb len:%04x \n",
+	CTCM_PR_DBGDATA("%s: trans_skb len:%04x\n",
 		       __func__, ch->trans_skb->len);
 	CTCM_PR_DBGDATA("%s: up-to-50 bytes of trans_skb "
 			"data to vtam from collect_q\n", __func__);
diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index e35713d..6359328 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -697,7 +697,7 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
 		memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header,
 		       PDU_HEADER_LENGTH);
 
-		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x \n"
+		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x\n"
 				"pdu header and data for up to 32 bytes:\n",
 				__func__, dev->name, skb->len);
 		CTCM_D3_DUMP((char *)skb->data, min_t(int, 32, skb->len));
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 5978b39..f20c92f 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -253,7 +253,7 @@ void ctcmpc_dump_skb(struct sk_buff *skb, int offset)
 	header = (struct th_header *)p;
 
 	ctcm_pr_debug("dump:\n");
-	ctcm_pr_debug("skb len=%d \n", skb->len);
+	ctcm_pr_debug("skb len=%d\n", skb->len);
 	if (skb->len > 2) {
 		switch (header->th_ch_flag) {
 		case TH_HAS_PDU:
@@ -1079,7 +1079,7 @@ static void ctcmpc_unpack_skb(struct channel *ch, struct sk_buff *pskb)
 
 	CTCM_PR_DBGDATA("%s: th_header\n", __func__);
 	CTCM_D3_DUMP((char *)header, TH_HEADER_LENGTH);
-	CTCM_PR_DBGDATA("%s: pskb len: %04x \n", __func__, pskb->len);
+	CTCM_PR_DBGDATA("%s: pskb len: %04x\n", __func__, pskb->len);
 
 	pskb->dev = dev;
 	pskb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -1119,7 +1119,7 @@ static void ctcmpc_unpack_skb(struct channel *ch, struct sk_buff *pskb)
 
 			CTCM_PR_DBGDATA("%s: pdu_header\n", __func__);
 			CTCM_D3_DUMP((char *)pskb->data, PDU_HEADER_LENGTH);
-			CTCM_PR_DBGDATA("%s: pskb len: %04x \n",
+			CTCM_PR_DBGDATA("%s: pskb len: %04x\n",
 						__func__, pskb->len);
 
 			skb_pull(pskb, PDU_HEADER_LENGTH);
@@ -1143,7 +1143,7 @@ static void ctcmpc_unpack_skb(struct channel *ch, struct sk_buff *pskb)
 			}
 			skb_reset_mac_header(pskb);
 			new_len = curr_pdu->pdu_offset;
-			CTCM_PR_DBGDATA("%s: new_len: %04x \n",
+			CTCM_PR_DBGDATA("%s: new_len: %04x\n",
 						__func__, new_len);
 			if ((new_len == 0) || (new_len > pskb->len)) {
 				/* should never happen		    */
@@ -1177,7 +1177,7 @@ static void ctcmpc_unpack_skb(struct channel *ch, struct sk_buff *pskb)
 				ctcm_pr_debug("%s: ToDCM_pdu_seq= %08x\n",
 						__func__, ch->pdu_seq);
 				ctcm_pr_debug("%s: skb:%0lx "
-					"skb len: %d \n", __func__,
+					"skb len: %d\n", __func__,
 					(unsigned long)skb, skb->len);
 				ctcm_pr_debug("%s: up to 32 bytes "
 					"of pdu_data sent\n", __func__);
@@ -1982,7 +1982,7 @@ static void mpc_action_rcvd_xid0(fsm_instance *fsm, int event, void *arg)
 	struct ctcm_priv   *priv = dev->ml_priv;
 	struct mpc_group   *grp  = priv->mpcg;
 
-	CTCM_PR_DEBUG("%s: ch-id:%s xid2:%i xid7:%i xidt_p2:%i \n",
+	CTCM_PR_DEBUG("%s: ch-id:%s xid2:%i xid7:%i xidt_p2:%i\n",
 			__func__, ch->id, grp->outstanding_xid2,
 			grp->outstanding_xid7, grp->outstanding_xid7_p2);
 
@@ -2021,10 +2021,10 @@ static void mpc_action_rcvd_xid0(fsm_instance *fsm, int event, void *arg)
 	}
 	kfree(mpcginfo);
 
-	CTCM_PR_DEBUG("ctcmpc:%s() %s xid2:%i xid7:%i xidt_p2:%i \n",
+	CTCM_PR_DEBUG("ctcmpc:%s() %s xid2:%i xid7:%i xidt_p2:%i\n",
 		__func__, ch->id, grp->outstanding_xid2,
 		grp->outstanding_xid7, grp->outstanding_xid7_p2);
-	CTCM_PR_DEBUG("ctcmpc:%s() %s grpstate: %s chanstate: %s \n",
+	CTCM_PR_DEBUG("ctcmpc:%s() %s grpstate: %s chanstate: %s\n",
 		__func__, ch->id,
 		fsm_getstate_str(grp->fsm), fsm_getstate_str(ch->fsm));
 	return;
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index f6cc46d..d502e78 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1418,7 +1418,7 @@ lcs_irq(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 	if (rc || (dstat & DEV_STAT_UNIT_EXCEP)) {
 		dev_warn(&cdev->dev,
 			"The LCS device stopped because of an error,"
-			" dstat=0x%X, cstat=0x%X \n",
+			" dstat=0x%X, cstat=0x%X\n",
 			    dstat, cstat);
 		if (rc) {
 			channel->state = LCS_CH_STATE_ERROR;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 0b76339..5371409 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -132,7 +132,7 @@ static int qeth_l2_send_setgroupmac_cb(struct qeth_card *card,
 	mac = &cmd->data.setdelmac.mac[0];
 	/* MAC already registered, needed in couple/uncouple case */
 	if (cmd->hdr.return_code ==  IPA_RC_L2_DUP_MAC) {
-		QETH_DBF_MESSAGE(2, "Group MAC %pM already existing on %s \n",
+		QETH_DBF_MESSAGE(2, "Group MAC %pM already existing on %s\n",
 			  mac, QETH_CARD_IFNAME(card));
 		cmd->hdr.return_code = 0;
 	}
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index fd1b6ed..67a1f06 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1221,7 +1221,7 @@ static int qeth_l3_start_ipa_ip_fragmentation(struct qeth_card *card)
 			QETH_CARD_IFNAME(card));
 	} else
 		dev_info(&card->gdev->dev,
-			"Hardware IP fragmentation enabled \n");
+			"Hardware IP fragmentation enabled\n");
 	return rc;
 }
 
-- 
1.6.6.1
