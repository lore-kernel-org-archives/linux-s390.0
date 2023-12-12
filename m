Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B3AD0;
	Tue, 12 Dec 2023 00:52:49 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VyLmjaC_1702371163;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyLmjaC_1702371163)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 16:52:45 +0800
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
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	lzinux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 05/10] net/smc: introduce virtual ISM device support feature
Date: Tue, 12 Dec 2023 16:52:26 +0800
Message-Id: <1702371151-125258-6-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

This introduces virtual ISM device support feature to SMCv2.1 as the
first supplemental feature.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 95f56c7..0dc722b 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -58,9 +58,12 @@ enum smc_state {		/* possible states of an SMC socket */
 	SMC_PROCESSABORT	= 27,
 };
 
-#define SMC_FEATURE_MASK	0	/* bitmask of
-					 * supported supplemental features
-					 */
+enum smc_supplemental_features {
+	SMC_SPF_VIRT_ISM_DEV	= 0,
+};
+
+#define SMC_FEATURE_MASK \
+	(BIT(SMC_SPF_VIRT_ISM_DEV))
 
 struct smc_link_group;
 
-- 
1.8.3.1

