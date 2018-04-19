From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/6] s390/qeth: handle failure on workqueue creation
Date: Thu, 19 Apr 2018 12:52:08 +0200
Message-ID: <20180419105211.83935-4-jwi@linux.ibm.com>
References: <20180419105211.83935-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180419105211.83935-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Creating the global workqueue during driver init may fail, deal with it.
Also, destroy the created workqueue on any subsequent error.

Fixes: 0f54761d167f ("qeth: Support VEPA mode")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 5ec47c6ebaa6..9a08b545d018 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6540,10 +6540,14 @@ static int __init qeth_core_init(void)
 	mutex_init(&qeth_mod_mutex);
 
 	qeth_wq = create_singlethread_workqueue("qeth_wq");
+	if (!qeth_wq) {
+		rc = -ENOMEM;
+		goto out_err;
+	}
 
 	rc = qeth_register_dbf_views();
 	if (rc)
-		goto out_err;
+		goto dbf_err;
 	qeth_core_root_dev = root_device_register("qeth");
 	rc = PTR_ERR_OR_ZERO(qeth_core_root_dev);
 	if (rc)
@@ -6580,6 +6584,8 @@ static int __init qeth_core_init(void)
 	root_device_unregister(qeth_core_root_dev);
 register_err:
 	qeth_unregister_dbf_views();
+dbf_err:
+	destroy_workqueue(qeth_wq);
 out_err:
 	pr_err("Initializing the qeth device driver failed\n");
 	return rc;
-- 
2.13.5
