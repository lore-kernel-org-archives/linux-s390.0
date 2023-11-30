Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E421709;
	Thu, 30 Nov 2023 03:28:34 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VxROoLH_1701343710;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VxROoLH_1701343710)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 19:28:32 +0800
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
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/7] net/smc: define a reserved CHID range for virtual ISM devices
Date: Thu, 30 Nov 2023 19:28:12 +0800
Message-Id: <1701343695-122657-5-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

According to virtual ISM support feature defined by SMCv2.1, CHIDs in
the range 0xFF00 to 0xFFFF are reserved for use by virtual ISM devices.

And two helpers are introduced to distinguish virtual ISM devices from
the existing platform firmware ISM devices.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 832b2f4..d1228a6 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -15,6 +15,8 @@
 
 #include "smc.h"
 
+#define SMC_VIRTUAL_ISM_CHID_MASK	0xFF00
+
 struct smcd_dev_list {	/* List of SMCD devices */
 	struct list_head list;
 	struct mutex mutex;	/* Protects list of devices */
@@ -56,4 +58,22 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
 	return rc < 0 ? rc : 0;
 }
 
+static inline bool __smc_ism_is_virtual(u16 chid)
+{
+	/* CHIDs in range of 0xFF00 to 0xFFFF are reserved
+	 * for virtual ISM device.
+	 *
+	 * loopback-ism:	0xFFFF
+	 * virtio-ism:		0xFF00 ~ 0xFFFE
+	 */
+	return ((chid & 0xFF00) == 0xFF00);
+}
+
+static inline bool smc_ism_is_virtual(struct smcd_dev *smcd)
+{
+	u16 chid = smcd->ops->get_chid(smcd);
+
+	return __smc_ism_is_virtual(chid);
+}
+
 #endif
-- 
1.8.3.1

