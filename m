Return-Path: <netdev-owner@vger.kernel.org>
From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH v2 net-next 02/12] net: introduce a mutex for the netns interface lists
Date: Tue,  5 Jan 2021 20:58:52 +0200
Message-Id: <20210105185902.3922928-3-olteanv@gmail.com>
In-Reply-To: <20210105185902.3922928-1-olteanv@gmail.com>
References: <20210105185902.3922928-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Benc <jbenc@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, George McCollister <george.mccollister@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Jay Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Taehee Yoo <ap420073@gmail.com>, Jiri Pirko <jiri@mellanox.com>, =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>, Paolo Abeni <pabeni@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Florian Westphal <fw@strlen.de>, linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-parisc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, dev@openvswitch.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Currently, any writer that wants to alter the lists of network
interfaces (either the plain list net->dev_base_head, or the hash tables
net->dev_index_head and net->dev_name_head) can keep other writers at
bay using the RTNL mutex.

However, the RTNL mutex has become a very contended resource over the
years, so there is a movement to do finer grained locking.

This patch adds one more way for writers to the network interface lists
to serialize themselves. We assume that all writers to the network
interface lists are easily identifiable because the write side of
dev_base_lock also needs to be held (note that some instances of that
were deliberately skipped, since they only dealt with protecting the
operational state of the netdev).

Holding the RTNL mutex is now optional for new code that alters the
lists, since all relevant writers were made to also hold the new lock.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/netdevice.h   | 10 +++++++++
 include/net/net_namespace.h |  6 +++++
 net/core/dev.c              | 44 +++++++++++++++++++++++++------------
 3 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7bf167993c05..199b3be2cce4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4393,6 +4393,16 @@ static inline void netif_addr_unlock_bh(struct net_device *dev)
 	spin_unlock_bh(&dev->addr_list_lock);
 }
 
+static inline void netif_lists_lock(struct net *net)
+{
+	mutex_lock(&net->netif_lists_lock);
+}
+
+static inline void netif_lists_unlock(struct net *net)
+{
+	mutex_unlock(&net->netif_lists_lock);
+}
+
 /*
  * dev_addrs walker. Should be used only for read access. Call with
  * rcu_read_lock held.
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 29567875f428..cac64c3c7ce0 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -183,6 +183,12 @@ struct net {
 	struct sock		*crypto_nlsk;
 #endif
 	struct sock		*diag_nlsk;
+
+	/* Serializes writers to @dev_base_head, @dev_name_head and
+	 * @dev_index_head. It does _not_ protect the netif adjacency lists
+	 * (struct net_device::adj_list).
+	 */
+	struct mutex		netif_lists_lock;
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index 2aa613d22318..1bd41cc91f71 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -175,13 +175,16 @@ static struct napi_struct *napi_by_id(unsigned int napi_id);
  *
  * Pure readers should hold rcu_read_lock() which should protect them against
  * concurrent changes to the interface lists made by the writers. Pure writers
- * must serialize by holding the RTNL mutex while they loop through the list
- * and make changes to it.
+ * must serialize by holding the @net->netif_lists_lock mutex while they loop
+ * through the list and make changes to it.
+ *
+ * It is possible to hold the RTNL mutex for serializing the writers too, but
+ * this should be avoided in new code due to lock contention.
  *
  * It is also possible to hold the global rwlock_t @dev_base_lock for
  * protection (holding its read side as an alternative to rcu_read_lock, and
- * its write side as an alternative to the RTNL mutex), however this should not
- * be done in new code, since it is deprecated and pending removal.
+ * its write side as an alternative to @net->netif_lists_lock), however this
+ * should not be done in new code, since it is deprecated and pending removal.
  *
  * One other role of @dev_base_lock is to protect against changes in the
  * operational state of a network interface.
@@ -360,12 +363,14 @@ static void list_netdevice(struct net_device *dev)
 
 	ASSERT_RTNL();
 
+	netif_lists_lock(net);
 	write_lock_bh(&dev_base_lock);
 	list_add_tail_rcu(&dev->dev_list, &net->dev_base_head);
 	netdev_name_node_add(net, dev->name_node);
 	hlist_add_head_rcu(&dev->index_hlist,
 			   dev_index_hash(net, dev->ifindex));
 	write_unlock_bh(&dev_base_lock);
+	netif_lists_unlock(net);
 
 	dev_base_seq_inc(net);
 }
@@ -375,16 +380,20 @@ static void list_netdevice(struct net_device *dev)
  */
 static void unlist_netdevice(struct net_device *dev)
 {
+	struct net *net = dev_net(dev);
+
 	ASSERT_RTNL();
 
 	/* Unlink dev from the device chain */
+	netif_lists_lock(net);
 	write_lock_bh(&dev_base_lock);
 	list_del_rcu(&dev->dev_list);
 	netdev_name_node_del(dev->name_node);
 	hlist_del_rcu(&dev->index_hlist);
 	write_unlock_bh(&dev_base_lock);
+	netif_lists_unlock(net);
 
-	dev_base_seq_inc(dev_net(dev));
+	dev_base_seq_inc(net);
 }
 
 /*
@@ -850,11 +859,11 @@ EXPORT_SYMBOL_GPL(dev_fill_metadata_dst);
  *	@net: the applicable net namespace
  *	@name: name to find
  *
- *	Find an interface by name. Must be called under RTNL semaphore
- *	or @dev_base_lock. If the name is found a pointer to the device
- *	is returned. If the name is not found then %NULL is returned. The
- *	reference counters are not incremented so the caller must be
- *	careful with locks.
+ *	Find an interface by name. Must be called under RTNL semaphore,
+ *	@net->netif_lists_lock or @dev_base_lock. If the name is found,
+ *	a pointer to the device is returned. If the name is not found then
+ *	%NULL is returned. The reference counters are not incremented so the
+ *	caller must be careful with locks.
  */
 
 struct net_device *__dev_get_by_name(struct net *net, const char *name)
@@ -920,8 +929,8 @@ EXPORT_SYMBOL(dev_get_by_name);
  *	Search for an interface by index. Returns %NULL if the device
  *	is not found or a pointer to the device. The device has not
  *	had its reference counter increased so the caller must be careful
- *	about locking. The caller must hold either the RTNL semaphore
- *	or @dev_base_lock.
+ *	about locking. The caller must hold either the RTNL semaphore,
+ *	@net->netif_lists_lock or @dev_base_lock.
  */
 
 struct net_device *__dev_get_by_index(struct net *net, int ifindex)
@@ -1330,15 +1339,19 @@ int dev_change_name(struct net_device *dev, const char *newname)
 
 	netdev_adjacent_rename_links(dev, oldname);
 
+	netif_lists_lock(net);
 	write_lock_bh(&dev_base_lock);
 	netdev_name_node_del(dev->name_node);
 	write_unlock_bh(&dev_base_lock);
+	netif_lists_unlock(net);
 
 	synchronize_rcu();
 
+	netif_lists_lock(net);
 	write_lock_bh(&dev_base_lock);
 	netdev_name_node_add(net, dev->name_node);
 	write_unlock_bh(&dev_base_lock);
+	netif_lists_unlock(net);
 
 	ret = call_netdevice_notifiers(NETDEV_CHANGENAME, dev);
 	ret = notifier_to_errno(ret);
@@ -9397,8 +9410,9 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
  *	@net: the applicable net namespace
  *
  *	Returns a suitable unique value for a new device interface
- *	number.  The caller must hold the rtnl semaphore or the
- *	dev_base_lock to be sure it remains unique.
+ *	number.
+ *	The caller must hold the rtnl semaphore, @net->netif_lists_lock or the
+ *	@dev_base_lock to be sure it remains unique.
  */
 static int dev_new_index(struct net *net)
 {
@@ -10981,6 +10995,8 @@ static int __net_init netdev_init(struct net *net)
 	if (net->dev_index_head == NULL)
 		goto err_idx;
 
+	mutex_init(&net->netif_lists_lock);
+
 	RAW_INIT_NOTIFIER_HEAD(&net->netdev_chain);
 
 	return 0;
-- 
2.25.1
