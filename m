From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: [PATCH 3/6] qeth: make local functions static in qeth_l3 module
Date: Wed, 22 Oct 2014 12:18:04 +0200
Message-ID: <1413973087-18740-4-git-send-email-blaschka@linux.vnet.ibm.com>
References: <1413973087-18740-1-git-send-email-blaschka@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1413973087-18740-1-git-send-email-blaschka@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

This patch makes 4 local functions static and removes
the prototypes from the header file.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <blaschka@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3.h      | 4 ----
 drivers/s390/net/qeth_l3_main.c | 8 ++++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index 29c1c00..551a4b4 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -42,10 +42,6 @@ struct qeth_ipato_entry {
 };
 
 
-void qeth_l3_ipaddr4_to_string(const __u8 *, char *);
-int qeth_l3_string_to_ipaddr4(const char *, __u8 *);
-void qeth_l3_ipaddr6_to_string(const __u8 *, char *);
-int qeth_l3_string_to_ipaddr6(const char *, __u8 *);
 void qeth_l3_ipaddr_to_string(enum qeth_prot_versions, const __u8 *, char *);
 int qeth_l3_string_to_ipaddr(const char *, enum qeth_prot_versions, __u8 *);
 int qeth_l3_create_device_attributes(struct device *);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 857a990..625227ad 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -55,12 +55,12 @@ static int qeth_l3_isxdigit(char *buf)
 	return 1;
 }
 
-void qeth_l3_ipaddr4_to_string(const __u8 *addr, char *buf)
+static void qeth_l3_ipaddr4_to_string(const __u8 *addr, char *buf)
 {
 	sprintf(buf, "%i.%i.%i.%i", addr[0], addr[1], addr[2], addr[3]);
 }
 
-int qeth_l3_string_to_ipaddr4(const char *buf, __u8 *addr)
+static int qeth_l3_string_to_ipaddr4(const char *buf, __u8 *addr)
 {
 	int count = 0, rc = 0;
 	unsigned int in[4];
@@ -78,12 +78,12 @@ int qeth_l3_string_to_ipaddr4(const char *buf, __u8 *addr)
 	return 0;
 }
 
-void qeth_l3_ipaddr6_to_string(const __u8 *addr, char *buf)
+static void qeth_l3_ipaddr6_to_string(const __u8 *addr, char *buf)
 {
 	sprintf(buf, "%pI6", addr);
 }
 
-int qeth_l3_string_to_ipaddr6(const char *buf, __u8 *addr)
+static int qeth_l3_string_to_ipaddr6(const char *buf, __u8 *addr)
 {
 	const char *end, *end_tmp, *start;
 	__u16 *in;
-- 
1.8.5.5
