Return-Path: <netdev-owner@vger.kernel.org>
From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH v2 net-next 07/12] parisc/led: hold the netdev lists lock when retrieving device statistics
Date: Tue,  5 Jan 2021 20:58:57 +0200
Message-Id: <20210105185902.3922928-8-olteanv@gmail.com>
In-Reply-To: <20210105185902.3922928-1-olteanv@gmail.com>
References: <20210105185902.3922928-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Benc <jbenc@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, George McCollister <george.mccollister@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Jay Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Taehee Yoo <ap420073@gmail.com>, Jiri Pirko <jiri@mellanox.com>, =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>, Paolo Abeni <pabeni@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Florian Westphal <fw@strlen.de>, linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-parisc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, dev@openvswitch.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In the effort of making .ndo_get_stats64 be able to sleep, we need to
ensure the callers of dev_get_stats do not use atomic context.

The LED driver for HP-PARISC workstations uses a workqueue to
periodically check for updates in network interface statistics, and
flicker when those have changed (i.e. there has been activity on the
line). Ignoring the fact that this driver is completely duplicating
drivers/leds/trigger/ledtrig-netdev.c, there is an even bigger problem.
Now, the dev_get_stats call can sleep, and iterating through the list of
network interfaces still needs to ensure the integrity of list of
network interfaces. So that leaves us only one locking option given the
current design of the network stack, and that is the netns mutex.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/parisc/led.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 3cada632a4be..c8c6b2301dc9 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -38,7 +38,6 @@
 #include <linux/ctype.h>
 #include <linux/blkdev.h>
 #include <linux/workqueue.h>
-#include <linux/rcupdate.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/hardware.h>
@@ -355,25 +354,29 @@ static __inline__ int led_get_net_activity(void)
 	int retval;
 
 	rx_total = tx_total = 0;
-	
-	/* we are running as a workqueue task, so we can use an RCU lookup */
-	rcu_read_lock();
-	for_each_netdev_rcu(&init_net, dev) {
+
+	/* we are running as a workqueue task, so we can sleep */
+	netif_lists_lock(&init_net);
+
+	for_each_netdev(&init_net, dev) {
+		struct in_device *in_dev = in_dev_get(dev);
 		const struct rtnl_link_stats64 *stats;
 		struct rtnl_link_stats64 temp;
-		struct in_device *in_dev = __in_dev_get_rcu(dev);
 
-		if (!in_dev || !in_dev->ifa_list)
+		if (!in_dev || !in_dev->ifa_list ||
+		    ipv4_is_loopback(in_dev->ifa_list->ifa_local)) {
+			in_dev_put(in_dev);
 			continue;
+		}
 
-		if (ipv4_is_loopback(in_dev->ifa_list->ifa_local))
-			continue;
+		in_dev_put(in_dev);
 
 		stats = dev_get_stats(dev, &temp);
 		rx_total += stats->rx_packets;
 		tx_total += stats->tx_packets;
 	}
-	rcu_read_unlock();
+
+	netif_lists_unlock(&init_net);
 
 	retval = 0;
 
-- 
2.25.1
