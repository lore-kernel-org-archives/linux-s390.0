Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8FD10C;
	Sun, 10 Dec 2023 05:24:30 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy8BEmd_1702214666;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy8BEmd_1702214666)
          by smtp.aliyun-inc.com;
          Sun, 10 Dec 2023 21:24:28 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 05/13] net/smc: implement some unsupported operations of loopback-ism
Date: Sun, 10 Dec 2023 21:24:06 +0800
Message-Id: <1702214654-32069-6-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
References: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

vlan operations are not supported currently since the need for vlan in
loopback situation does not seem to be strong.

signal_event operation is not supported since no event now needs to be
processed by loopback-ism device.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 39e8c8d..349a969 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -50,6 +50,32 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 	return 0;
 }
 
+static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_set_vlan_required(struct smcd_dev *smcd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_reset_vlan_required(struct smcd_dev *smcd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
+			       u32 trigger_irq, u32 event_code, u64 info)
+{
+	return 0;
+}
+
 static int smc_lo_supports_v2(void)
 {
 	return SMC_LO_V2_CAPABLE;
@@ -78,11 +104,11 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
 	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb		= NULL,
 	.unregister_dmb		= NULL,
-	.add_vlan_id		= NULL,
-	.del_vlan_id		= NULL,
-	.set_vlan_required	= NULL,
-	.reset_vlan_required	= NULL,
-	.signal_event		= NULL,
+	.add_vlan_id = smc_lo_add_vlan_id,
+	.del_vlan_id = smc_lo_del_vlan_id,
+	.set_vlan_required = smc_lo_set_vlan_required,
+	.reset_vlan_required = smc_lo_reset_vlan_required,
+	.signal_event = smc_lo_signal_event,
 	.move_data		= NULL,
 	.supports_v2 = smc_lo_supports_v2,
 	.get_local_gid = smc_lo_get_local_gid,
-- 
1.8.3.1

