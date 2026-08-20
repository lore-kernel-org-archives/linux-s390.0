Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07ED4756B0
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235608; cv=none; b=dOAomL1IQkmSyzwnSfZludd/HX+hgqNh80VopO/ZwY2Fe8nJK+J+SaydjJnb5wXaycXpfAHgj6uTAaD35SoHV5cA9GqCalkOxvdkZTZFp/1Du3FzGdsxJW189CydDYyEovZ+wt6CD4JI/Xib+rIRydWX2w6HO+s6B1Nmqv90I58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235608; c=relaxed/simple;
	bh=7vkNE2kGJ2pmjQ9Er9tTkvp3QGN2HFAwp/4M+UEsEpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9T6ticDeO5EnAt3RbBEta3oW9ZP00hdhK/Ev4vLyb2rAg0gBmLoKSs0TOfa7qlMTVYBHSt/rV3hCijarRtCuT+whLyy7FSBB5GJQskK7tUXhJZvOr6vw0ojoXkkj2MszZm3V6ngOEnSg0kRcg9uQyr9q4wWObKrXmHY9CCCiAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mcyKhRfg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mcyKhRfg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K91IQr3544168
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rJkUbdSF25/+GCP34
	O0JmKPSVeFwlXXLlngF/gCP1PE=; b=mcyKhRfgGAGFlFLR7Odp6tDmM4kkS6m4f
	K6nchgTiwv3+1eGwOkGioFq2Nl3OZ2bdSGV2GFPvsDTdBZVlZHFEfznBG+OL3+Ys
	P4ViUjT1Bnd2keL2LAP0gUOOk0doJJnzZREnTMxGrjUs7m2odSeYeusLG/3NsaJ6
	TBxemdj97DUnM8ExRtgFRXFV+pXc26fA/jqqr+wm0tOm58BNZE8IVtKVEX9Dl4W8
	fMlsOwnrwiIqqJ053QOZf81bPvbndMgEcq2taNF94JiNBiRQGxVuqIw+a+tMRsma
	0DDkZJkBbeU1Yrxsuq+34nAt4bwQmQpgEL3O2ONva/JI32qnvYEGw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2aqxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEBnUN002656
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ypqjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:20:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KEJwVU12714466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:19:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E43E20040;
	Thu, 20 Aug 2026 14:19:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0D2A2004D;
	Thu, 20 Aug 2026 14:19:57 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.194.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:19:57 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 3/8] s390/crypto: Fix use of mutex in atomic context in PAES
Date: Thu, 20 Aug 2026 16:19:52 +0200
Message-ID: <20260820141957.19091-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820141957.19091-1-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a870d12 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=FX_TaYed26Q6Wz4qpTAA:9
X-Proofpoint-GUID: K88xNpluSSNvyF8oPvADB6A1dkUUzfqf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX3Z0qPc+iL8kN
 CVjH6LLGGynWMeHmg6ofr4YScYzQSTR55p+c032IClNwQ0/Pni28OmHmv2TwikD9p9Z7jmMf6XY
 UuDTMH/X4s44MSnhno7B5X6c+6A2i7n+Aw7NY2FgFCGi8AQIlxY6/f4kDrAlwIBBPX7boYVgpFu
 x8TihbkB8l2i04K40TJ9BdxeFbQSbfNUJF/wlBm0W36kAU/vi3TL7EygXsQp7bgNx8i54BiPhAh
 CHA1hDKpbIdFlfA5i8kme2vKjHj7IdO5k9MAOYC7i+/jec9qKWQZ4wlOkMlz9Nu1Cy7GdpY/ck8
 I+EAk6bjBg0nD/oQJrDC/pzugV2Gt5hV+n8hfmf7pvQ4dFPV7V2x6DBfR71v+n0IQFaJ3wGSQKk
 wdjzmYe5pZIY79n3OO6Hdnk/P80J4OQ2SLxBtVr3LwoK3L5Pi5uPfMFNlW7AH11Xi2NKml97OB9
 ofE5TMPNioN/Bw4T9Jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX03pIc22BKx5z
 iVUXplgcEDqiGV8mS7Raq4i1mJAKcIWUJHKmtNEuSiZNpL8VF7gxrQNGyKuKl/FZZPT28VE1wnd
 kDYOBj3bcBbc5rooTesir+0c+XPCgqE=
X-Proofpoint-ORIG-GUID: K88xNpluSSNvyF8oPvADB6A1dkUUzfqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200105

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

