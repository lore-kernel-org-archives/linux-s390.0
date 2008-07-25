Return-Path: <linux-kernel-owner+w=401wt.eu-S1755245AbYGYB6T@vger.kernel.org>
Date: Fri, 25 Jul 2008 03:57:55 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [BUG] qeth doesn't work anymore because of netdev_priv changes
Message-ID: <20080725015755.GA5179@osiris.boeblingen.de.ibm.com>
References: <20080724184624.GB8969@osiris.boeblingen.de.ibm.com> <20080724.135602.196740386.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080724.135602.196740386.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: frank.blaschka@de.ibm.com, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <braunu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 24, 2008 at 01:56:02PM -0700, David Miller wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Thu, 24 Jul 2008 20:46:24 +0200
> 
> > git commit e3c50d5d25ac09efd9acbe2b2a3e365466de84ed
> > "netdev: netdev_priv() can now be sane again." breaks qeth on s390
> > (no more networking possible). Reverting the patch fixes it.
> > I haven't looked into this any further.
> 
> You guys have to stop overriding netdev->priv if that's what
> you're doing.
> 
> If you need a mid-layer private pointer, use netdev->ml_priv
> as it's created exactly for that purpose.

Ok, with the patch below it works again.

Subject: [PATCH] qeth: use dev->ml_priv instead of dev->priv

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This makes qeth working again after git commit
e3c50d5d25ac09efd9acbe2b2a3e365466de84ed
"netdev: netdev_priv() can now be sane again.".

Cc: Ursula Braun <braunu@de.ibm.com>
Cc: Frank Blaschka <frank.blaschka@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |   14 +++++++-------
 drivers/s390/net/qeth_l2_main.c   |   26 +++++++++++++-------------
 drivers/s390/net/qeth_l3_main.c   |   30 +++++++++++++++---------------
 3 files changed, 35 insertions(+), 35 deletions(-)

Index: linux-2.6/drivers/s390/net/qeth_core_main.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/qeth_core_main.c
+++ linux-2.6/drivers/s390/net/qeth_core_main.c
@@ -3321,7 +3321,7 @@ int qeth_change_mtu(struct net_device *d
 	struct qeth_card *card;
 	char dbf_text[15];
 
-	card = netdev_priv(dev);
+	card = dev->ml_priv;
 
 	QETH_DBF_TEXT(TRACE, 4, "chgmtu");
 	sprintf(dbf_text, "%8x", new_mtu);
@@ -3343,7 +3343,7 @@ struct net_device_stats *qeth_get_stats(
 {
 	struct qeth_card *card;
 
-	card = netdev_priv(dev);
+	card = dev->ml_priv;
 
 	QETH_DBF_TEXT(TRACE, 5, "getstat");
 
@@ -3395,7 +3395,7 @@ void qeth_tx_timeout(struct net_device *
 {
 	struct qeth_card *card;
 
-	card = netdev_priv(dev);
+	card = dev->ml_priv;
 	card->stats.tx_errors++;
 	qeth_schedule_recovery(card);
 }
@@ -3403,7 +3403,7 @@ EXPORT_SYMBOL_GPL(qeth_tx_timeout);
 
 int qeth_mdio_read(struct net_device *dev, int phy_id, int regnum)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	int rc = 0;
 
 	switch (regnum) {
@@ -4253,7 +4253,7 @@ EXPORT_SYMBOL_GPL(qeth_core_get_stats_co
 void qeth_core_get_ethtool_stats(struct net_device *dev,
 		struct ethtool_stats *stats, u64 *data)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	data[0] = card->stats.rx_packets -
 				card->perf_stats.initial_rx_packets;
 	data[1] = card->perf_stats.bufs_rec;
@@ -4313,7 +4313,7 @@ EXPORT_SYMBOL_GPL(qeth_core_get_strings)
 void qeth_core_get_drvinfo(struct net_device *dev,
 		struct ethtool_drvinfo *info)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	if (card->options.layer2)
 		strcpy(info->driver, "qeth_l2");
 	else
@@ -4331,7 +4331,7 @@ EXPORT_SYMBOL_GPL(qeth_core_get_drvinfo)
 int qeth_core_ethtool_get_settings(struct net_device *netdev,
 					struct ethtool_cmd *ecmd)
 {
-	struct qeth_card *card = netdev_priv(netdev);
+	struct qeth_card *card = netdev->ml_priv;
 	enum qeth_link_types link_type;
 
 	if ((card->info.type == QETH_CARD_TYPE_IQD) || (card->info.guestlan))
Index: linux-2.6/drivers/s390/net/qeth_l2_main.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/qeth_l2_main.c
+++ linux-2.6/drivers/s390/net/qeth_l2_main.c
@@ -35,7 +35,7 @@ static int qeth_l2_recover(void *);
 
 static int qeth_l2_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	struct mii_ioctl_data *mii_data;
 	int rc = 0;
 
@@ -317,7 +317,7 @@ static void qeth_l2_process_vlans(struct
 
 static void qeth_l2_vlan_rx_add_vid(struct net_device *dev, unsigned short vid)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	struct qeth_vlan_vid *id;
 
 	QETH_DBF_TEXT_(TRACE, 4, "aid:%d", vid);
@@ -334,7 +334,7 @@ static void qeth_l2_vlan_rx_add_vid(stru
 static void qeth_l2_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
 {
 	struct qeth_vlan_vid *id, *tmpid = NULL;
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 
 	QETH_DBF_TEXT_(TRACE, 4, "kid:%d", vid);
 	spin_lock_bh(&card->vlanlock);
@@ -566,7 +566,7 @@ static int qeth_l2_request_initial_mac(s
 static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 {
 	struct sockaddr *addr = p;
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	int rc = 0;
 
 	QETH_DBF_TEXT(TRACE, 3, "setmac");
@@ -590,7 +590,7 @@ static int qeth_l2_set_mac_address(struc
 
 static void qeth_l2_set_multicast_list(struct net_device *dev)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	struct dev_mc_list *dm;
 
 	if (card->info.type == QETH_CARD_TYPE_OSN)
@@ -612,7 +612,7 @@ static int qeth_l2_hard_start_xmit(struc
 	int rc;
 	struct qeth_hdr *hdr = NULL;
 	int elements = 0;
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	struct sk_buff *new_skb = skb;
 	int ipv = qeth_get_ip_version(skb);
 	int cast_type = qeth_get_cast_type(card, skb);
@@ -767,7 +767,7 @@ static void qeth_l2_qdio_input_handler(s
 
 static int qeth_l2_open(struct net_device *dev)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 
 	QETH_DBF_TEXT(TRACE, 4, "qethopen");
 	if (card->state != CARD_STATE_SOFTSETUP)
@@ -791,7 +791,7 @@ static int qeth_l2_open(struct net_devic
 
 static int qeth_l2_stop(struct net_device *dev)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 
 	QETH_DBF_TEXT(TRACE, 4, "qethstop");
 	netif_tx_disable(dev);
@@ -838,7 +838,7 @@ static void qeth_l2_remove_device(struct
 
 static int qeth_l2_ethtool_set_tso(struct net_device *dev, u32 data)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 
 	if (data) {
 		if (card->options.large_send == QETH_LARGE_SEND_NO) {
@@ -894,7 +894,7 @@ static int qeth_l2_setup_netdev(struct q
 	if (!card->dev)
 		return -ENODEV;
 
-	card->dev->priv = card;
+	card->dev->ml_priv = card;
 	card->dev->tx_timeout = &qeth_tx_timeout;
 	card->dev->watchdog_timeo = QETH_TX_TIMEOUT;
 	card->dev->open = qeth_l2_open;
@@ -1178,7 +1178,7 @@ int qeth_osn_assist(struct net_device *d
 	QETH_DBF_TEXT(TRACE, 2, "osnsdmc");
 	if (!dev)
 		return -ENODEV;
-	card = netdev_priv(dev);
+	card = dev->ml_priv;
 	if (!card)
 		return -ENODEV;
 	if ((card->state != CARD_STATE_UP) &&
@@ -1201,7 +1201,7 @@ int qeth_osn_register(unsigned char *rea
 	*dev = qeth_l2_netdev_by_devno(read_dev_no);
 	if (*dev == NULL)
 		return -ENODEV;
-	card = netdev_priv(*dev);
+	card = (*dev)->ml_priv;
 	if (!card)
 		return -ENODEV;
 	if ((assist_cb == NULL) || (data_cb == NULL))
@@ -1219,7 +1219,7 @@ void qeth_osn_deregister(struct net_devi
 	QETH_DBF_TEXT(TRACE, 2, "osndereg");
 	if (!dev)
 		return;
-	card = netdev_priv(dev);
+	card = dev->ml_priv;
 	if (!card)
 		return;
 	card->osn_info.assist_cb = NULL;
Index: linux-2.6/drivers/s390/net/qeth_l3_main.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/qeth_l3_main.c
+++ linux-2.6/drivers/s390/net/qeth_l3_main.c
@@ -1813,7 +1813,7 @@ static void qeth_l3_free_vlan_addresses(
 static void qeth_l3_vlan_rx_register(struct net_device *dev,
 			struct vlan_group *grp)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	unsigned long flags;
 
 	QETH_DBF_TEXT(TRACE, 4, "vlanreg");
@@ -1825,7 +1825,7 @@ static void qeth_l3_vlan_rx_register(str
 static void qeth_l3_vlan_rx_add_vid(struct net_device *dev, unsigned short vid)
 {
 	struct net_device *vlandev;
-	struct qeth_card *card = (struct qeth_card *) dev->priv;
+	struct qeth_card *card = dev->ml_priv;
 	struct in_device *in_dev;
 
 	if (card->info.type == QETH_CARD_TYPE_IQD)
@@ -1851,7 +1851,7 @@ static void qeth_l3_vlan_rx_add_vid(stru
 
 static void qeth_l3_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	unsigned long flags;
 
 	QETH_DBF_TEXT_(TRACE, 4, "kid:%d", vid);
@@ -2013,7 +2013,7 @@ static int qeth_l3_verify_vlan_dev(struc
 		}
 	}
 
-	if (rc && !(netdev_priv(vlan_dev_real_dev(dev)) == (void *)card))
+	if (rc && !(vlan_dev_real_dev(dev)->ml_priv == (void *)card))
 		return 0;
 
 	return rc;
@@ -2047,9 +2047,9 @@ static struct qeth_card *qeth_l3_get_car
 
 	rc = qeth_l3_verify_dev(dev);
 	if (rc == QETH_REAL_CARD)
-		card = netdev_priv(dev);
+		card = dev->ml_priv;
 	else if (rc == QETH_VLAN_CARD)
-		card = netdev_priv(vlan_dev_real_dev(dev));
+		card = vlan_dev_real_dev(dev)->ml_priv;
 	if (card && card->options.layer2)
 		card = NULL;
 	QETH_DBF_TEXT_(TRACE, 4, "%d", rc);
@@ -2110,7 +2110,7 @@ static int qeth_l3_stop_card(struct qeth
 
 static void qeth_l3_set_multicast_list(struct net_device *dev)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 
 	QETH_DBF_TEXT(TRACE, 3, "setmulti");
 	qeth_l3_delete_mc_addresses(card);
@@ -2438,7 +2438,7 @@ static int qeth_l3_arp_flush_cache(struc
 
 static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	struct qeth_arp_cache_entry arp_entry;
 	struct mii_ioctl_data *mii_data;
 	int rc = 0;
@@ -2595,7 +2595,7 @@ static int qeth_l3_hard_start_xmit(struc
 	u16 *tag;
 	struct qeth_hdr *hdr = NULL;
 	int elements_needed = 0;
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	struct sk_buff *new_skb = NULL;
 	int ipv = qeth_get_ip_version(skb);
 	int cast_type = qeth_get_cast_type(card, skb);
@@ -2763,7 +2763,7 @@ tx_drop:
 
 static int qeth_l3_open(struct net_device *dev)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 
 	QETH_DBF_TEXT(TRACE, 4, "qethopen");
 	if (card->state != CARD_STATE_SOFTSETUP)
@@ -2780,7 +2780,7 @@ static int qeth_l3_open(struct net_devic
 
 static int qeth_l3_stop(struct net_device *dev)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 
 	QETH_DBF_TEXT(TRACE, 4, "qethstop");
 	netif_tx_disable(dev);
@@ -2792,14 +2792,14 @@ static int qeth_l3_stop(struct net_devic
 
 static u32 qeth_l3_ethtool_get_rx_csum(struct net_device *dev)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 
 	return (card->options.checksum_type == HW_CHECKSUMMING);
 }
 
 static int qeth_l3_ethtool_set_rx_csum(struct net_device *dev, u32 data)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 	enum qeth_card_states old_state;
 	enum qeth_checksum_types csum_type;
 
@@ -2825,7 +2825,7 @@ static int qeth_l3_ethtool_set_rx_csum(s
 
 static int qeth_l3_ethtool_set_tso(struct net_device *dev, u32 data)
 {
-	struct qeth_card *card = netdev_priv(dev);
+	struct qeth_card *card = dev->ml_priv;
 
 	if (data) {
 		if (card->options.large_send == QETH_LARGE_SEND_NO) {
@@ -2915,7 +2915,7 @@ static int qeth_l3_setup_netdev(struct q
 		return -ENODEV;
 
 	card->dev->hard_start_xmit = qeth_l3_hard_start_xmit;
-	card->dev->priv = card;
+	card->dev->ml_priv = card;
 	card->dev->tx_timeout = &qeth_tx_timeout;
 	card->dev->watchdog_timeo = QETH_TX_TIMEOUT;
 	card->dev->open = qeth_l3_open;
