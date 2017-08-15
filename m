From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 10/12] s390/qeth: reject multicast rxip addresses
Date: Tue, 15 Aug 2017 17:02:48 +0200
Message-ID: <20170815150250.67158-11-jwi@linux.vnet.ibm.com>
References: <20170815150250.67158-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170815150250.67158-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>

There exist different commands to add unicast and multicast addresses on
the OSA card. rxip addresses are always set as unicast addresses and
thus just unicast addresses should be allowed.

Adding a multicast address now fails and a grace message is generated.

Signed-off-by: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_sys.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index f2f94f59e0fa..2000ef190e94 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -895,9 +895,26 @@ static ssize_t qeth_l3_dev_rxip_add4_show(struct device *dev,
 static int qeth_l3_parse_rxipe(const char *buf, enum qeth_prot_versions proto,
 		 u8 *addr)
 {
+	__be32 ipv4_addr;
+	struct in6_addr ipv6_addr;
+
 	if (qeth_l3_string_to_ipaddr(buf, proto, addr)) {
 		return -EINVAL;
 	}
+	if (proto == QETH_PROT_IPV4) {
+		memcpy(&ipv4_addr, addr, sizeof(ipv4_addr));
+		if (ipv4_is_multicast(ipv4_addr)) {
+			QETH_DBF_MESSAGE(2, "multicast rxip not supported.\n");
+			return -EINVAL;
+		}
+	} else if (proto == QETH_PROT_IPV6) {
+		memcpy(&ipv6_addr, addr, sizeof(ipv6_addr));
+		if (ipv6_addr_is_multicast(&ipv6_addr)) {
+			QETH_DBF_MESSAGE(2, "multicast rxip not supported.\n");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.11.2
