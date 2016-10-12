From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 2/3] s390/netiucv: improve checking of sysfs attribute buffer
Date: Wed, 12 Oct 2016 12:38:50 +0200
Message-ID: <bfb6b0a86cff8aa480d6f08a5b0d586c2329d8c4.1476263985.git.ursula.braun@de.ibm.com>
References: <cover.1476263985.git.ursula.braun@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1476263985.git.ursula.braun@de.ibm.com>
In-Reply-To: <cover.1476263985.git.ursula.braun@de.ibm.com>
References: <cover.1476263985.git.ursula.braun@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

High values are always wrong for netiucv's sysfs attribute "buffer".
But the current code does not detect values between 2**31 and 2**32
as invalid. Choosing type "unsigned int" for variable "bs1" and making
use of "kstrtouint()" improves the syntax checking for "buffer".

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/s390/net/netiucv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index 88b6e9c..2f0f391 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -1563,21 +1563,21 @@ static ssize_t buffer_write (struct device *dev, struct device_attribute *attr,
 {
 	struct netiucv_priv *priv = dev_get_drvdata(dev);
 	struct net_device *ndev = priv->conn->netdev;
-	char         *e;
-	int          bs1;
+	unsigned int bs1;
+	int rc;
 
 	IUCV_DBF_TEXT(trace, 3, __func__);
 	if (count >= 39)
 		return -EINVAL;
 
-	bs1 = simple_strtoul(buf, &e, 0);
+	rc = kstrtouint(buf, 0, &bs1);
 
-	if (e && (!isspace(*e))) {
-		IUCV_DBF_TEXT_(setup, 2, "buffer_write: invalid char %02x\n",
-			*e);
+	if (rc == -EINVAL) {
+		IUCV_DBF_TEXT_(setup, 2, "buffer_write: invalid char %s\n",
+			buf);
 		return -EINVAL;
 	}
-	if (bs1 > NETIUCV_BUFSIZE_MAX) {
+	if ((rc == -ERANGE) || (bs1 > NETIUCV_BUFSIZE_MAX)) {
 		IUCV_DBF_TEXT_(setup, 2,
 			"buffer_write: buffer size %d too large\n",
 			bs1);
-- 
2.8.4
