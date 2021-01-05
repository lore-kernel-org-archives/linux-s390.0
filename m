Return-Path: <netdev-owner@vger.kernel.org>
From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH v2 net-next 09/12] net: net_failover: ensure .ndo_get_stats64 can sleep
Date: Tue,  5 Jan 2021 20:58:59 +0200
Message-Id: <20210105185902.3922928-10-olteanv@gmail.com>
In-Reply-To: <20210105185902.3922928-1-olteanv@gmail.com>
References: <20210105185902.3922928-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Benc <jbenc@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, George McCollister <george.mccollister@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Jay Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Taehee Yoo <ap420073@gmail.com>, Jiri Pirko <jiri@mellanox.com>, =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>, Paolo Abeni <pabeni@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Florian Westphal <fw@strlen.de>, linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-parisc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, dev@openvswitch.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The failover framework sets up a virtio_net interface [ when it has the
VIRTIO_NET_F_STANDBY feature ] and a VF interface, having the same MAC
address, in a standby/active relationship. When the active VF is
unplugged, the standby virtio_net temporarily kicks in.

The failover framework registers a common upper for the active and the
standby interface, which is what the application layer uses. This is
similar to bonding/team. The statistics of the upper interface are the
sum of the statistics of the active and of the standby interface.

There is an effort to convert .ndo_get_stats64 to sleepable context, and
for that to work, we need to prevent callers of dev_get_stats from using
atomic locking. The failover driver needs protection via an RCU
read-side critical section to access the standby and the active
interface. This has two features:
- It is atomic: this needs to change.
- It is reentrant: this is ok, because generally speaking, dev_get_stats
  is recursive, and taking global locks is a bad thing from a recursive
  context.

A better locking architecture would be to do what the team driver does.
Instead of using something as broad as the rtnl_mutex to ensure
serialization of updates, it should use something more specific, like a
private mutex. This patch adds that and names it slaves_lock. The
slaves_lock now protects the only updater, the rcu_assign_pointer
sections from net_failover_slave_register.

In the team driver, a separate lockdep class is created for each team
lock, to account for possible nesting (team over team over ...). For the
net_failover driver, we can do something simpler, which is to just not
hold any lock while we call dev_get_stats recursively. We can "cheat"
and use dev_hold to take a reference on the active and backup interfaces,
and netdev_wait_allrefs() will just have to wait until we finish.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/net_failover.c | 62 +++++++++++++++++++++++++++-----------
 include/net/net_failover.h |  9 ++++--
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 4f83165412bd..c83066b0ef70 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -27,6 +27,9 @@
 #include <uapi/linux/if_arp.h>
 #include <net/net_failover.h>
 
+#define nfo_dereference(nfo_info, p)				\
+	rcu_dereference_protected(p, lockdep_is_held(&nfo_info->slaves_lock))
+
 static bool net_failover_xmit_ready(struct net_device *dev)
 {
 	return netif_running(dev) && netif_carrier_ok(dev);
@@ -183,32 +186,48 @@ static void net_failover_get_stats(struct net_device *dev,
 				   struct rtnl_link_stats64 *stats)
 {
 	struct net_failover_info *nfo_info = netdev_priv(dev);
-	struct rtnl_link_stats64 temp;
-	struct net_device *slave_dev;
+	struct rtnl_link_stats64 primary_stats;
+	struct rtnl_link_stats64 standby_stats;
+	struct net_device *primary_dev;
+	struct net_device *standby_dev;
 
-	spin_lock(&nfo_info->stats_lock);
-	memcpy(stats, &nfo_info->failover_stats, sizeof(*stats));
+	mutex_lock(&nfo_info->slaves_lock);
 
-	rcu_read_lock();
+	primary_dev = nfo_dereference(nfo_info, nfo_info->primary_dev);
+	if (primary_dev)
+		dev_hold(primary_dev);
 
-	slave_dev = rcu_dereference(nfo_info->primary_dev);
-	if (slave_dev) {
-		dev_get_stats(slave_dev, &temp);
-		net_failover_fold_stats(stats, &temp, &nfo_info->primary_stats);
-		memcpy(&nfo_info->primary_stats, &temp, sizeof(temp));
+	standby_dev = nfo_dereference(nfo_info, nfo_info->standby_dev);
+	if (standby_dev)
+		dev_hold(standby_dev);
+
+	mutex_unlock(&nfo_info->slaves_lock);
+
+	/* Don't hold slaves_lock while calling dev_get_stats, just a
+	 * reference to ensure they won't get unregistered.
+	 */
+	if (primary_dev) {
+		dev_get_stats(primary_dev, &primary_stats);
+		dev_put(primary_dev);
 	}
 
-	slave_dev = rcu_dereference(nfo_info->standby_dev);
-	if (slave_dev) {
-		dev_get_stats(slave_dev, &temp);
-		net_failover_fold_stats(stats, &temp, &nfo_info->standby_stats);
-		memcpy(&nfo_info->standby_stats, &temp, sizeof(temp));
+	if (standby_dev) {
+		dev_get_stats(standby_dev, &standby_stats);
+		dev_put(standby_dev);
 	}
 
-	rcu_read_unlock();
+	mutex_lock(&nfo_info->stats_lock);
+
+	memcpy(stats, &nfo_info->failover_stats, sizeof(*stats));
+
+	net_failover_fold_stats(stats, &primary_stats, &nfo_info->primary_stats);
+	memcpy(&nfo_info->primary_stats, &primary_stats, sizeof(primary_stats));
+	net_failover_fold_stats(stats, &standby_stats, &nfo_info->standby_stats);
+	memcpy(&nfo_info->standby_stats, &standby_stats, sizeof(standby_stats));
 
 	memcpy(&nfo_info->failover_stats, stats, sizeof(*stats));
-	spin_unlock(&nfo_info->stats_lock);
+
+	mutex_unlock(&nfo_info->stats_lock);
 }
 
 static int net_failover_change_mtu(struct net_device *dev, int new_mtu)
@@ -540,6 +559,8 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	primary_dev = rtnl_dereference(nfo_info->primary_dev);
 	slave_is_standby = slave_dev->dev.parent == failover_dev->dev.parent;
 
+	mutex_lock(&nfo_info->slaves_lock);
+
 	if (slave_is_standby) {
 		rcu_assign_pointer(nfo_info->standby_dev, slave_dev);
 		standby_dev = slave_dev;
@@ -552,6 +573,8 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 		failover_dev->max_mtu = slave_dev->max_mtu;
 	}
 
+	mutex_unlock(&nfo_info->slaves_lock);
+
 	net_failover_lower_state_changed(slave_dev, primary_dev, standby_dev);
 	net_failover_compute_features(failover_dev);
 
@@ -709,6 +732,7 @@ static struct failover_ops net_failover_ops = {
 struct failover *net_failover_create(struct net_device *standby_dev)
 {
 	struct device *dev = standby_dev->dev.parent;
+	struct net_failover_info *nfo_info;
 	struct net_device *failover_dev;
 	struct failover *failover;
 	int err;
@@ -753,6 +777,10 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 	failover_dev->min_mtu = standby_dev->min_mtu;
 	failover_dev->max_mtu = standby_dev->max_mtu;
 
+	nfo_info = netdev_priv(failover_dev);
+	mutex_init(&nfo_info->slaves_lock);
+	mutex_init(&nfo_info->stats_lock);
+
 	err = register_netdev(failover_dev);
 	if (err) {
 		dev_err(dev, "Unable to register failover_dev!\n");
diff --git a/include/net/net_failover.h b/include/net/net_failover.h
index b12a1c469d1c..988cdfaf14ca 100644
--- a/include/net/net_failover.h
+++ b/include/net/net_failover.h
@@ -23,8 +23,13 @@ struct net_failover_info {
 	/* aggregated stats */
 	struct rtnl_link_stats64 failover_stats;
 
-	/* spinlock while updating stats */
-	spinlock_t stats_lock;
+	/* lock for updating stats */
+	struct mutex stats_lock;
+
+	/* lock for protecting lower interfaces.
+	 * TODO: convert all rtnl_dereference instances to nfo_dereference
+	 */
+	struct mutex slaves_lock;
 };
 
 struct failover *net_failover_create(struct net_device *standby_dev);
-- 
2.25.1
