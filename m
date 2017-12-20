From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 15/15] s390/qeth: replace open-coded in*_pton()
Date: Wed, 20 Dec 2017 20:11:09 +0100
Message-ID: <20171220191109.90487-16-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

There's a common helper for parsing an IP address string, let's use it.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3.h      |  1 -
 drivers/s390/net/qeth_l3_main.c | 88 -----------------------------------------
 drivers/s390/net/qeth_l3_sys.c  | 12 ++++++
 3 files changed, 12 insertions(+), 89 deletions(-)

diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index 071c00841208..49f92ebbc5ad 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -69,7 +69,6 @@ struct qeth_ipato_entry {
 extern const struct attribute_group *qeth_l3_attr_groups[];
 
 void qeth_l3_ipaddr_to_string(enum qeth_prot_versions, const __u8 *, char *);
-int qeth_l3_string_to_ipaddr(const char *, enum qeth_prot_versions, __u8 *);
 int qeth_l3_create_device_attributes(struct device *);
 void qeth_l3_remove_device_attributes(struct device *);
 int qeth_l3_setrouting_v4(struct qeth_card *);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index e31cc4fa544c..92bcb02671bc 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -48,93 +48,16 @@ static int qeth_l3_register_addr_entry(struct qeth_card *,
 static int qeth_l3_deregister_addr_entry(struct qeth_card *,
 		struct qeth_ipaddr *);
 
-static int qeth_l3_isxdigit(char *buf)
-{
-	while (*buf) {
-		if (!isxdigit(*buf++))
-			return 0;
-	}
-	return 1;
-}
-
 static void qeth_l3_ipaddr4_to_string(const __u8 *addr, char *buf)
 {
 	sprintf(buf, "%pI4", addr);
 }
 
-static int qeth_l3_string_to_ipaddr4(const char *buf, __u8 *addr)
-{
-	int count = 0, rc = 0;
-	unsigned int in[4];
-	char c;
-
-	rc = sscanf(buf, "%u.%u.%u.%u%c",
-		    &in[0], &in[1], &in[2], &in[3], &c);
-	if (rc != 4 && (rc != 5 || c != '\n'))
-		return -EINVAL;
-	for (count = 0; count < 4; count++) {
-		if (in[count] > 255)
-			return -EINVAL;
-		addr[count] = in[count];
-	}
-	return 0;
-}
-
 static void qeth_l3_ipaddr6_to_string(const __u8 *addr, char *buf)
 {
 	sprintf(buf, "%pI6", addr);
 }
 
-static int qeth_l3_string_to_ipaddr6(const char *buf, __u8 *addr)
-{
-	const char *end, *end_tmp, *start;
-	__u16 *in;
-	char num[5];
-	int num2, cnt, out, found, save_cnt;
-	unsigned short in_tmp[8] = {0, };
-
-	cnt = out = found = save_cnt = num2 = 0;
-	end = start = buf;
-	in = (__u16 *) addr;
-	memset(in, 0, 16);
-	while (*end) {
-		end = strchr(start, ':');
-		if (end == NULL) {
-			end = buf + strlen(buf);
-			end_tmp = strchr(start, '\n');
-			if (end_tmp != NULL)
-				end = end_tmp;
-			out = 1;
-		}
-		if ((end - start)) {
-			memset(num, 0, 5);
-			if ((end - start) > 4)
-				return -EINVAL;
-			memcpy(num, start, end - start);
-			if (!qeth_l3_isxdigit(num))
-				return -EINVAL;
-			sscanf(start, "%x", &num2);
-			if (found)
-				in_tmp[save_cnt++] = num2;
-			else
-				in[cnt++] = num2;
-			if (out)
-				break;
-		} else {
-			if (found)
-				return -EINVAL;
-			found = 1;
-		}
-		start = ++end;
-	}
-	if (cnt + save_cnt > 8)
-		return -EINVAL;
-	cnt = 7;
-	while (save_cnt)
-		in[cnt--] = in_tmp[--save_cnt];
-	return 0;
-}
-
 void qeth_l3_ipaddr_to_string(enum qeth_prot_versions proto, const __u8 *addr,
 				char *buf)
 {
@@ -144,17 +67,6 @@ void qeth_l3_ipaddr_to_string(enum qeth_prot_versions proto, const __u8 *addr,
 		qeth_l3_ipaddr6_to_string(addr, buf);
 }
 
-int qeth_l3_string_to_ipaddr(const char *buf, enum qeth_prot_versions proto,
-				__u8 *addr)
-{
-	if (proto == QETH_PROT_IPV4)
-		return qeth_l3_string_to_ipaddr4(buf, addr);
-	else if (proto == QETH_PROT_IPV6)
-		return qeth_l3_string_to_ipaddr6(buf, addr);
-	else
-		return -EINVAL;
-}
-
 static void qeth_l3_convert_addr_to_bits(u8 *addr, u8 *bits, int len)
 {
 	int i, j;
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 6ea2b528a64e..00a10b66c01f 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -10,11 +10,23 @@
 #include <linux/slab.h>
 #include <asm/ebcdic.h>
 #include <linux/hashtable.h>
+#include <linux/inet.h>
 #include "qeth_l3.h"
 
 #define QETH_DEVICE_ATTR(_id, _name, _mode, _show, _store) \
 struct device_attribute dev_attr_##_id = __ATTR(_name, _mode, _show, _store)
 
+static int qeth_l3_string_to_ipaddr(const char *buf,
+				    enum qeth_prot_versions proto, u8 *addr)
+{
+	const char *end;
+
+	if ((proto == QETH_PROT_IPV4 && !in4_pton(buf, -1, addr, -1, &end)) ||
+	    (proto == QETH_PROT_IPV6 && !in6_pton(buf, -1, addr, -1, &end)))
+		return -EINVAL;
+	return 0;
+}
+
 static ssize_t qeth_l3_dev_route_show(struct qeth_card *card,
 			struct qeth_routing_info *route, char *buf)
 {
-- 
2.13.5
