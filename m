Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0EA429034
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131079; cv=none; b=Js2hVcTDftydJ3wYYwDX2vXgbnzYxDz0s8RkcwC+QmzCP2rsJ+eIX+F83uZbnAjELLXNS8p2C2cWpnOmaqKw3IAh0p0fj7RRd0f+ETq7C9fkq2wU+4DZB7mXMj9dirJNdwgSvJhSOjrpLbR0HLx87GiKBnd5urp3tYReP0vZkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131079; c=relaxed/simple;
	bh=7vkNE2kGJ2pmjQ9Er9tTkvp3QGN2HFAwp/4M+UEsEpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kA98alWtnNcCKNunkRZNPeza4lP+gIbJYoXZBO6BdQSr3M/DKXCLTs7GN5vLx/pWRQRFWnrdk3OmfsElmm+z6Wjn8XCTAMyH45/gfs8PNvf55wcM5C541Crvaw/qow0m1pyf4cbVf54Rzy2vVoPbkkLtxpjQpPKdQ86aPWoHVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N2+dT2Cm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N2+dT2Cm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6Vqij2666929
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rJkUbdSF25/+GCP34
	O0JmKPSVeFwlXXLlngF/gCP1PE=; b=N2+dT2Cmn4BF3oDmKDgVUnYrsziJV8MxS
	hzrRSv07C8EQYycHFsXPr7W131/HsfXNHlB5yXIrKDBeqbGtJKd3WDpfGcpPbmug
	pQZ6J0JYn+BgD09uSewbCx62oky2iDoQ24pPqWWxYuFlU9VKf3J87Keq1Rzni13s
	KMQbJg+ZbNL7WUDWGhM627Va3jT/Ejxcx2KNCof/RCfPRfxJjklSpn/5srpoe/d0
	UCzZUud5QwTKFmKox2qthNHi84LocWWKPoo6rSpJAPaBu3Cz2bcDxk0iNr3DsDdJ
	ljVWkl3m2US4QEfWm1GotRtfiHkcrRNJmDgFYZQp6p0K2zXEXx49Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0ar8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9BRUo024004
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek84d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:17:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9HZ1e51315082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:17:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFA342004E;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F81E20043;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.129.41])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:17:35 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 3/7] s390/crypto: Fix use of mutex in atomic context in PAES
Date: Wed, 19 Aug 2026 11:17:30 +0200
Message-ID: <20260819091734.7331-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819091734.7331-1-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a8574b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=FX_TaYed26Q6Wz4qpTAA:9
X-Proofpoint-ORIG-GUID: bWw6o9Du5dmWneUXa6ZSdP-Jvs6i1gv3
X-Proofpoint-GUID: bWw6o9Du5dmWneUXa6ZSdP-Jvs6i1gv3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfXw8a3lK01S3jm
 goV4HGeqCbxGM7XV0wyWUDRhrm+PCshaODNBws1JTzU94TT7cMi29SchVbRqwq+jLEBnf6lbX/v
 rHK1t1hziacGXQbgCT5gnrr+ohfwQTs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2OCBTYWx0ZWRfX4gOpOg3PCWyu
 CgrtHi7X+4uXKy6UzA/De5PDwVe3LAic8avmgETV/zc7ago93vQLdey4yBEyoLRRu5L6oYbDSWh
 RcQMW/9AMvkOZuerA++IV34R3B3kzZ5UIjGmsGv2SvAHFaqpbLOfXVEmDaTl+2UNcd2baluZW4x
 RItxIzGRp2PllGO15x7T+WxG2gzX62CI16Dv6B1Yb0/DUivrEDzbxLuYyEnMSFXs1FCnfOiWMG8
 vX70VQAEWT/DKqyzi+I1j2Xb1HEA1nN5Q2Z4Ul9qx1/sJ6aHSvpxiVRB6Kkp2OH8lAqcuLvnlYj
 l6rb313D1uL6DaIIX4NCrOXj6LQqJsmd85AIB+FpDHK/sifTvm0Jt9PXMD2LAyd5SIEg2hjD0yu
 DL/H5ysa4bTXS2M+UWyQry1/QCeB8J9EsXGPjZvh1VgA1SoKJS+quAfup9QX41G3cHdgFbSEH/F
 fsmynydQnHVE4xX7wMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190068

The PAES CTR implementation used a mutex to lock one page of exclusive
memory for fast CTR processing. Unfortunately a mutex is not save to
use in atomic or interrupt context. So use a binary semaphore instead
which is save to use in such environments.

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16+
---
 arch/s390/crypto/paes_s390.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index d075b0241f1f..e8bbfc376ebb 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -19,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
+#include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
@@ -45,7 +45,7 @@ module_param_named(clrkey, pkey_clrkey_allowed, bool, 0444);
 MODULE_PARM_DESC(clrkey, "Allow clear key material (default N)");
 
 static u8 *ctrblk;
-static DEFINE_MUTEX(ctrblk_lock);
+static DEFINE_SEMAPHORE(ctrblk_sem, 1);
 
 static cpacf_mask_t km_functions, kmc_functions, kmctr_functions;
 
@@ -945,7 +945,8 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
 	struct skcipher_walk *walk = &req_ctx->walk;
 	u8 buf[AES_BLOCK_SIZE], *ctrptr;
 	unsigned int nbytes, n, k;
-	int pk_state, locked, rc = 0;
+	int pk_state, rc = 0;
+	bool locked;
 
 	if (!req_ctx->param_init_done) {
 		/* fetch and check protected key state */
@@ -971,7 +972,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
 	if (rc)
 		goto out;
 
-	locked = mutex_trylock(&ctrblk_lock);
+	locked = down_trylock(&ctrblk_sem) == 0;
 
 	/*
 	 * Note that in case of partial processing or failure the walk
@@ -993,21 +994,21 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
 			rc = skcipher_walk_done(walk, nbytes - k);
 			if (rc) {
 				if (locked)
-					mutex_unlock(&ctrblk_lock);
+					up(&ctrblk_sem);
 				goto out;
 			}
 		}
 		if (k < n) {
 			if (!maysleep) {
 				if (locked)
-					mutex_unlock(&ctrblk_lock);
+					up(&ctrblk_sem);
 				rc = -EKEYEXPIRED;
 				goto out;
 			}
 			rc = paes_convert_key(ctx, tested);
 			if (rc) {
 				if (locked)
-					mutex_unlock(&ctrblk_lock);
+					up(&ctrblk_sem);
 				goto out;
 			}
 			spin_lock_bh(&ctx->pk_lock);
@@ -1016,7 +1017,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
 		}
 	}
 	if (locked)
-		mutex_unlock(&ctrblk_lock);
+		up(&ctrblk_sem);
 
 	/* final block may be < AES_BLOCK_SIZE, copy only nbytes */
 	if (nbytes) {
-- 
2.43.0

