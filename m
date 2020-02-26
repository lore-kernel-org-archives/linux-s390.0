Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net] net/smc: check for valid ib_client_data
Date: Wed, 26 Feb 2020 17:52:46 +0100
Message-Id: <20200226165246.3426-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

In smc_ib_remove_dev() check if the provided ib device was actually
initialized for SMC before.

Reported-by: syzbot+84484ccebdd4e5451d91@syzkaller.appspotmail.com
Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_ib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 6756bd5a3fe4..da18871f360f 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -587,6 +587,8 @@ static void smc_ib_remove_dev(struct ib_device *ibdev, void *client_data)
 	struct smc_ib_device *smcibdev;
 
 	smcibdev = ib_get_client_data(ibdev, &smc_ib_client);
+	if (!smcibdev || smcibdev->ibdev != ibdev)
+		return;
 	ib_set_client_data(ibdev, &smc_ib_client, NULL);
 	spin_lock(&smc_ib_devices.lock);
 	list_del_init(&smcibdev->list); /* remove from smc_ib_devices */
-- 
2.17.1
