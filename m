Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389129AbgEZLFw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 07:05:52 -0400
Received: by mail-wr1-f72.google.com with SMTP id q24so4262269wra.14
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2020 04:05:46 -0700 (PDT)
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v3 7/7] [not for merge] netstats: example use of stats_fs API
Date: Tue, 26 May 2020 13:03:17 +0200
Message-Id: <20200526110318.69006-8-eesposit@redhat.com>
In-Reply-To: <20200526110318.69006-1-eesposit@redhat.com>
References: <20200526110318.69006-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, David Rientjes <rientjes@google.com>, Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, Emanuele Giuseppe Esposito <eesposit@redhat.com>

Apply stats_fs on the networking statistics subsystem.

Currently it only works with disabled network namespace
(CONFIG_NET_NS=n), because multiple namespaces will have the same
device name under the same root source that will cause a conflict in
stats_fs.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 include/linux/netdevice.h |  2 ++
 net/Kconfig               |  1 +
 net/core/dev.c            | 66 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 130a668049ab..408c4e7b0e21 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -48,6 +48,7 @@
 #include <uapi/linux/if_bonding.h>
 #include <uapi/linux/pkt_cls.h>
 #include <linux/hashtable.h>
+#include <linux/stats_fs.h>
 
 struct netpoll_info;
 struct device;
@@ -2117,6 +2118,7 @@ struct net_device {
 	unsigned		wol_enabled:1;
 
 	struct list_head	net_notifier_list;
+	struct stats_fs_source	*stats_fs_src;
 
 #if IS_ENABLED(CONFIG_MACSEC)
 	/* MACsec management functions */
diff --git a/net/Kconfig b/net/Kconfig
index df8d8c9bd021..3441d5bb6107 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -8,6 +8,7 @@ menuconfig NET
 	select NLATTR
 	select GENERIC_NET_UTILS
 	select BPF
+	select STATS_FS_API
 	---help---
 	  Unless you really know what you are doing, you should say Y here.
 	  The reason is that some programs need kernel networking support even
diff --git a/net/core/dev.c b/net/core/dev.c
index 522288177bbd..3db48cd1a097 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -142,6 +142,7 @@
 #include <linux/net_namespace.h>
 #include <linux/indirect_call_wrapper.h>
 #include <net/devlink.h>
+#include <linux/stats_fs.h>
 
 #include "net-sysfs.h"
 
@@ -150,6 +151,11 @@
 /* This should be increased if a protocol with a bigger head is added. */
 #define GRO_MAX_HEAD (MAX_HEADER + 128)
 
+#define NETDEV_STAT(str, m, ...)						\
+	{ str, offsetof(struct rtnl_link_stats64, m),				\
+	  &stats_fs_type_netdev_u64,						\
+	  STATS_FS_SUM, ## __VA_ARGS__ }
+
 static DEFINE_SPINLOCK(ptype_lock);
 static DEFINE_SPINLOCK(offload_lock);
 struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
@@ -196,6 +202,53 @@ static DEFINE_READ_MOSTLY_HASHTABLE(napi_hash, 8);
 
 static seqcount_t devnet_rename_seq;
 
+static uint64_t stats_fs_get_netdev_u64(struct stats_fs_value *val,
+					void *base)
+{
+	struct net_device *netdev = (struct net_device *)base;
+	struct rtnl_link_stats64 net_stats;
+
+	dev_get_stats(netdev, &net_stats);
+
+	return stats_fs_get_u64(val, &net_stats);
+}
+
+static struct stats_fs_type stats_fs_type_netdev_u64 = {
+	.get = stats_fs_get_netdev_u64,
+	.clear = NULL,
+	.sign = false
+};
+
+static struct stats_fs_source *netdev_root;
+
+static struct stats_fs_value stats_fs_netdev_entries[] = {
+	NETDEV_STAT("rx_packets", rx_packets),
+	NETDEV_STAT("tx_packets", tx_packets),
+	NETDEV_STAT("rx_bytes", rx_bytes),
+	NETDEV_STAT("tx_bytes", tx_bytes),
+	NETDEV_STAT("rx_errors", rx_errors),
+	NETDEV_STAT("tx_errors", tx_errors),
+	NETDEV_STAT("rx_dropped", rx_dropped),
+	NETDEV_STAT("tx_dropped", tx_dropped),
+	NETDEV_STAT("multicast", multicast),
+	NETDEV_STAT("collisions", collisions),
+	NETDEV_STAT("rx_length_errors", rx_length_errors),
+	NETDEV_STAT("rx_over_errors", rx_over_errors),
+	NETDEV_STAT("rx_crc_errors", rx_crc_errors),
+	NETDEV_STAT("rx_frame_errors", rx_frame_errors),
+	NETDEV_STAT("rx_fifo_errors", rx_fifo_errors),
+	NETDEV_STAT("rx_missed_errors", rx_missed_errors),
+	NETDEV_STAT("tx_aborted_errors", tx_aborted_errors),
+	NETDEV_STAT("tx_carrier_errors", tx_carrier_errors),
+	NETDEV_STAT("tx_fifo_errors", tx_fifo_errors),
+	NETDEV_STAT("tx_heartbeat_errors", tx_heartbeat_errors),
+	NETDEV_STAT("tx_window_errors", tx_window_errors),
+	NETDEV_STAT("rx_compressed", rx_compressed),
+	NETDEV_STAT("tx_compressed", tx_compressed),
+	NETDEV_STAT("rx_nohandler", rx_nohandler),
+	{ NULL }
+};
+
 static inline void dev_base_seq_inc(struct net *net)
 {
 	while (++net->dev_base_seq == 0)
@@ -8783,6 +8836,11 @@ static void rollback_registered_many(struct list_head *head)
 	ASSERT_RTNL();
 
 	list_for_each_entry_safe(dev, tmp, head, unreg_list) {
+		stats_fs_source_remove_subordinate(netdev_root,
+						   dev->stats_fs_src);
+		stats_fs_source_revoke(dev->stats_fs_src);
+		stats_fs_source_put(dev->stats_fs_src);
+
 		/* Some devices call without registering
 		 * for initialization unwind. Remove those
 		 * devices and proceed with the remaining.
@@ -9436,6 +9494,11 @@ int register_netdevice(struct net_device *dev)
 	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
 		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL);
 
+	dev->stats_fs_src = stats_fs_source_create(0, dev->name);
+	stats_fs_source_add_subordinate(netdev_root, dev->stats_fs_src);
+	stats_fs_source_add_values(dev->stats_fs_src, stats_fs_netdev_entries,
+				   dev, 0);
+
 out:
 	return ret;
 
@@ -10500,6 +10563,9 @@ static int __init net_dev_init(void)
 	if (netdev_kobject_init())
 		goto out;
 
+	netdev_root = stats_fs_source_create(0, "net");
+	stats_fs_source_register(netdev_root);
+
 	INIT_LIST_HEAD(&ptype_all);
 	for (i = 0; i < PTYPE_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&ptype_base[i]);
-- 
2.25.4
