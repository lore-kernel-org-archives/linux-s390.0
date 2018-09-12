From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/4] s390/qeth: use vzalloc for QUERY OAT buffer
Date: Wed, 12 Sep 2018 15:31:34 +0200
Message-ID: <20180912133135.12335-4-jwi@linux.ibm.com>
References: <20180912133135.12335-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180912133135.12335-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Wenjia Zhang <wenjia@linux.ibm.com>

qeth_query_oat_command() currently allocates the kernel buffer for
the SIOC_QETH_QUERY_OAT ioctl with kzalloc. So on systems with
fragmented memory, large allocations may fail (eg. the qethqoat tool by
default uses 132KB).

Solve this issue by using vzalloc, backing the allocation with
non-contiguous memory.

Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b60055e9cb1a..de8282420f96 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -25,6 +25,7 @@
 #include <linux/netdevice.h>
 #include <linux/netdev_features.h>
 #include <linux/skbuff.h>
+#include <linux/vmalloc.h>
 
 #include <net/iucv/af_iucv.h>
 #include <net/dsfield.h>
@@ -4699,7 +4700,7 @@ static int qeth_query_oat_command(struct qeth_card *card, char __user *udata)
 
 	priv.buffer_len = oat_data.buffer_len;
 	priv.response_len = 0;
-	priv.buffer =  kzalloc(oat_data.buffer_len, GFP_KERNEL);
+	priv.buffer = vzalloc(oat_data.buffer_len);
 	if (!priv.buffer) {
 		rc = -ENOMEM;
 		goto out;
@@ -4740,7 +4741,7 @@ static int qeth_query_oat_command(struct qeth_card *card, char __user *udata)
 			rc = -EFAULT;
 
 out_free:
-	kfree(priv.buffer);
+	vfree(priv.buffer);
 out:
 	return rc;
 }
-- 
2.16.4
