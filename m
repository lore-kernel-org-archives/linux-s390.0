From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 04/13] s390/qeth: use kstrtobool() in qeth_bridgeport_hostnotification_store()
Date: Wed, 18 Oct 2017 17:40:16 +0200
Message-ID: <20171018154025.73630-5-jwi@linux.vnet.ibm.com>
References: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The sysfs enabled value is a boolean, so kstrtobool() is a better fit
for parsing the input string since it does the range checking for us.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_sys.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index 4608daedb204..470a4e5f3c62 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -146,18 +146,15 @@ static ssize_t qeth_bridgeport_hostnotification_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
-	int rc = 0;
-	int enable;
+	bool enable;
+	int rc;
 
 	if (!card)
 		return -EINVAL;
 
-	if (sysfs_streq(buf, "0"))
-		enable = 0;
-	else if (sysfs_streq(buf, "1"))
-		enable = 1;
-	else
-		return -EINVAL;
+	rc = kstrtobool(buf, &enable);
+	if (rc)
+		return rc;
 
 	mutex_lock(&card->conf_mutex);
 
-- 
2.13.5
