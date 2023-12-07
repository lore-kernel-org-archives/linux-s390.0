Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00BD73;
	Wed,  6 Dec 2023 19:50:17 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vy-JsEG_1701921013;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy-JsEG_1701921013)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 11:50:15 +0800
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 7/9] net/smc: disable SEID on non-s390 archs where virtual ISM may be used
Date: Thu,  7 Dec 2023 11:49:52 +0800
Message-Id: <1701920994-73705-8-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
References: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The system EID (SEID) is an internal EID used by SMC-D to represent the
s390 physical machine that OS is executing on. On s390 architecture, it
predefined by fixed string and part of cpuid and is enabled regardless
of whether underlay device is virtual ISM or platform firmware ISM.

However on non-s390 architectures where SMC-D can be used with virtual
ISM devices, there is no similar information to identify physical
machines, especially in virtualization scenarios. So in such cases, SEID
is forcibly disabled and the user-defined UEID will be used to represent
the communicable space.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_clc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 3604150..6d6cfa5 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -155,10 +155,12 @@ static int smc_clc_ueid_remove(char *ueid)
 			rc = 0;
 		}
 	}
+#if IS_ENABLED(CONFIG_S390)
 	if (!rc && !smc_clc_eid_table.ueid_cnt) {
 		smc_clc_eid_table.seid_enabled = 1;
 		rc = -EAGAIN;	/* indicate success and enabling of seid */
 	}
+#endif
 	write_unlock(&smc_clc_eid_table.lock);
 	return rc;
 }
@@ -273,22 +275,30 @@ int smc_nl_dump_seid(struct sk_buff *skb, struct netlink_callback *cb)
 
 int smc_nl_enable_seid(struct sk_buff *skb, struct genl_info *info)
 {
+#if IS_ENABLED(CONFIG_S390)
 	write_lock(&smc_clc_eid_table.lock);
 	smc_clc_eid_table.seid_enabled = 1;
 	write_unlock(&smc_clc_eid_table.lock);
 	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 int smc_nl_disable_seid(struct sk_buff *skb, struct genl_info *info)
 {
 	int rc = 0;
 
+#if IS_ENABLED(CONFIG_S390)
 	write_lock(&smc_clc_eid_table.lock);
 	if (!smc_clc_eid_table.ueid_cnt)
 		rc = -ENOENT;
 	else
 		smc_clc_eid_table.seid_enabled = 0;
 	write_unlock(&smc_clc_eid_table.lock);
+#else
+	rc = -EOPNOTSUPP;
+#endif
 	return rc;
 }
 
@@ -1336,7 +1346,11 @@ void __init smc_clc_init(void)
 	INIT_LIST_HEAD(&smc_clc_eid_table.list);
 	rwlock_init(&smc_clc_eid_table.lock);
 	smc_clc_eid_table.ueid_cnt = 0;
+#if IS_ENABLED(CONFIG_S390)
 	smc_clc_eid_table.seid_enabled = 1;
+#else
+	smc_clc_eid_table.seid_enabled = 0;
+#endif
 }
 
 void smc_clc_exit(void)
-- 
1.8.3.1

