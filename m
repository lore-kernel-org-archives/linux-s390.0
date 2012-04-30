From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: [PATCH] net: skb_set_dev do not unconditionally drop ref to dst
Date: Mon, 30 Apr 2012 07:38:04 +0200
Message-ID: <20120430053804.GA59677@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

commit 8a83a00b0735190384a348156837918271034144 unconditionally
drops dst reference when skb->dev is set. This causes a regression
with VLAN and the qeth_l3 network driver. qeth_l3 can not get gw
information from the skb coming from the vlan driver. It is only
valid to drop the dst in case of different name spaces.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1881,8 +1881,8 @@ EXPORT_SYMBOL(netif_device_attach);
 #ifdef CONFIG_NET_NS
 void skb_set_dev(struct sk_buff *skb, struct net_device *dev)
 {
-	skb_dst_drop(skb);
 	if (skb->dev && !net_eq(dev_net(skb->dev), dev_net(dev))) {
+		skb_dst_drop(skb);
 		secpath_reset(skb);
 		nf_reset(skb);
 		skb_init_secmark(skb);
