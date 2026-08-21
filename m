Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7588388E43
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302016; cv=none; b=pDvfI3KLAJbsjXzGdyw2cWMZiVOk3HtvDjA2nB0vScCZJaMzhydHH+mdPUGmYkEdhTJb+bxnSwpfFC/6j6N4vBZC/nvMUepT7Q/MWrdzY7jMDbWXzeqelup1YMiYxLqK098vYNZN7L5hMaSHc3MNJ7OcgvNzmTyacB30GvS1piw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302016; c=relaxed/simple;
	bh=7vkNE2kGJ2pmjQ9Er9tTkvp3QGN2HFAwp/4M+UEsEpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTwNcps848di448rML/MCMr8RUY2dY+mQ9X/eDvg2Y83Re4h11io7RChsCikgdI6Bqek7j9ew96FOgNvlDFaHEVxNMY71jYMk/h1vI4U4S+/e8nLQ9hnXLxw96WdLan5TOVKzFIIXWhTuT5qMmZtIQaF5KKjoc1ElPX+zD2J3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lhXuKLK9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lhXuKLK9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8Wp4l4042674
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rJkUbdSF25/+GCP34
	O0JmKPSVeFwlXXLlngF/gCP1PE=; b=lhXuKLK9lphGB99TCstQTFHP2zJgRDIhj
	mMH7mKhVNVLHVgcLdfLaFh3ufN7AxSizeeY0APwBHUYy4jZL/rM6U1ga1wNCBY5o
	PsSdv24vgo/ODLq4aaqBB8nhD2KSBumUZ8U+K14JGyljn+4ElmTCrqOuj+yMVhNd
	zs3Xbn0WP7jfywxalfHjN/JHxfJShQWGXHi5qtk5cY7dyl38Kqmi+SPL8/hrmhSW
	yeCxXTgGoBsMAKwSgnN26CbDu9Y4ZB7agsN6mcojw0kX81yT8ZgO9fTgkPgecLRJ
	McAFJukqZ4u0+V1DfnrN/G/SHG0fFj7ohzmN3I/qWWHIZsigRBzrQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2g354-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8fcRF001663
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqkrsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8kmuJ52035878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:46:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B67E920043;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A9C20040;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.162.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:46:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v6 3/9] s390/crypto: Fix use of mutex in atomic context in PAES
Date: Fri, 21 Aug 2026 10:46:42 +0200
Message-ID: <20260821084648.23222-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821084648.23222-1-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88107d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=FX_TaYed26Q6Wz4qpTAA:9
X-Proofpoint-GUID: wuFO5P8zTrtJ05jmnFBObV-pHhlbcQSq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfXzhCgylJiZSqq
 r+fK2q1tYh9X0DJajFvAPUWu+NaPVaVX8u9agVLoW5SikGyrXcDHTdYQcms+bWkQcXYVpjvfwhm
 4kpbum7EOc7BWqhhFl2pTue2rfJrwpNti8CNsT2yu2ngJTthlLgfmmbMEn8ybFlPKFmHaj8qoDz
 kaQBgoTPFDkryVTtMwJQVlVwC7aCX/JVAn5d/sztOTG8L4+eZqzcaeTe4dI9G5hzm7j/c4KJRXE
 xzEvxpW1Qs5jr90+cLv9iTJpkg3uyLdLk2KFSy++USkqUhxJSy018hUSPvJ+L0bZGzdm3O7TOzp
 z/ws9448B7YHfxr9jaa32ClpgcP084Fb9I8vPPnR50u2Od0Nae/oajjLwq5tcXVFSqk0hbONG1R
 +LYTyfv8eYayFKzrB1B4ZzFvOsNBF4RR9pZ50QtLYERtBtCCv46ebwyFCrXiFd0fOuQ4GjsSdiU
 GdrUVMuZab+zasjph+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX+pHO3+gqc/Si
 lmkzuhc2yf4GsgiQrLpuYFqevvMLR2oXcMGF+/zAKGFMX6vgBLfy254QYxwm4C0E9x6UhdQQT5P
 PyMsv1iwe5EAN6DNNblMlUgiLx/Mwxo=
X-Proofpoint-ORIG-GUID: wuFO5P8zTrtJ05jmnFBObV-pHhlbcQSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210061

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

