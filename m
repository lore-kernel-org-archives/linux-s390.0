Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D247143D
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069922; cv=none; b=Le1hNqXuhn+jaro6dfkWWMGVEqqPauMykeswQH65zEe6ONzb4sNMCcNTS9ywOPvd4A0tOx+c21nNTujedivF32w8a09V7i9ucIkxGingkVdFT4T0bhbRVzTqvNHBp30hRmqt8ApQSGAC5ixNF5SMtSJEPNzvVwNGAKpo1b4kVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069922; c=relaxed/simple;
	bh=BaQSPNp2dtlquaSI8FbmWsII+/qFnRA4vpy1xRqPFCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4WPaWrCHXbrWn+5FFVJE/KTQHioqpd5xo/jbF9i1ZgIEWdxkhRc1yQKUcBYTa5zROiXtlJpgeBo7A47zYZXzWe/mv/UPV9PHWqIOzy4VfWzLtBJKretxfTmE7/sIu6yUpSv+U3ZjgCD/Q/Ld+wP8g9qSWpC0bu6UigkFId+xtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h5MqxsO2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h5MqxsO2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3avY542384;
	Tue, 18 Aug 2026 16:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IaP6OTnkRYy7rVD5d
	CUh9nBymV7HxQjuYWG6a5humWY=; b=h5MqxsO2LxwkA3egYvxG+DRSzmPKshP0A
	veJAPdlHDW3+ZCmqnNq0N0yR+cw2E/VZ5b1E64l9oUcZMLuXoY//j614e1Y7rwOW
	BW+lgQIi98V75CzNXZHOU+MRrt3QG+n8pARglU6iWIXLbYVsFjvI3wsewgc5+Iqu
	dzd5Oqc8bp4rivVqFRQhYre6/B91T1VIeMvvN/sgMTtDfMqNsJh+qn+8cN+LaHAa
	5iSePzWCPCXFdNbGNOz7RPHsHs8Byq1XUkljQz48ibJuL83CZv3/598HbyG200/N
	T1PWMbds4/WHrrF4R5iUL6XfLANSPIKkUCISEZv4abMkkxKugb9ow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8u9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBS20018427;
	Tue, 18 Aug 2026 16:18:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybvy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGIQ5R40305100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E0242004D;
	Tue, 18 Aug 2026 16:18:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1446B2004B;
	Tue, 18 Aug 2026 16:18:26 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.161.134])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:18:26 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v15 06/20] target/s390x: Adjust addressing mode checks for sha512 and sha256
Date: Tue, 18 Aug 2026 18:18:10 +0200
Message-ID: <20260818161824.100746-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818161824.100746-1-freude@linux.ibm.com>
References: <20260818161824.100746-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a8485d6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=2oDd-pRd1qGgCFYxvY4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfXxwjN1yT5j3Gu
 dHBz1foE+5Jlh3bN7DP4El4RbkB1bJ2ENXHeX6IFLsSHnKZrHIKXmlOyHAydMUgXrA840pZjuHu
 AzwGvFbFiSvSy4atmaP/Hp1F3FWQads=
X-Proofpoint-GUID: H5iZ2ZlRoRX7sX3BgA6xK55XGpVF2ufg
X-Proofpoint-ORIG-GUID: H5iZ2ZlRoRX7sX3BgA6xK55XGpVF2ufg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX6j1W2y6GFrxb
 IO8+ggc1A7p30lF9s/9ipts5EyqSuwfSVypypkKJM8Vd6X04lPMC7tXZ+Si9fIPBPeWwodd+XZ8
 YtfrUOU1MN+r562HRkcVwdT1XsG19aBKzjJ/VNzvwYUS7QZZlQ1/rdZvFOGXbgcMcCvpWDcGYNR
 J8nQbsRtwimIHBZ6TmV16QWC7SIzPPNd4HLGaehDSF81RWppU2AjzwjAgmukh5U81tyRLMD3ykD
 WRrb9LjiYqzdq7vKSfOV3tYb4zVAYrIv4sNK7xpsoKr+hOmQlJWdL7tgEc1fZZ5ywJ0xgveM1pm
 6RdmVWdEu5LKep63kxXdizme5JH6wnwxKKoLMnhrOuw1RPnO7ZAscnTOrtmYbEFHEwDSvZ+GTHW
 wNe5I9v9xTUUxnkDIv0NDlYrfjyzl36NnEH++u/oNH4dc3sNBMqjEgwBBgZzLw367aupXkZfBMV
 4sSORM3DwrVdQ0WxGqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

The handling for different addressing modes in the both sha
implementations cpacf sha256 and sha512 was incomplete. Rework this
addressing checking to clearly have support for s390 64 bit and 32 bit
addressing mode but raise an exception otherwise.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/cpacf_sha256.c | 16 +++++++++++++---
 target/s390x/tcg/cpacf_sha512.c | 16 +++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/s390x/tcg/cpacf_sha256.c b/target/s390x/tcg/cpacf_sha256.c
index 67321b565c..5882c30a65 100644
--- a/target/s390x/tcg/cpacf_sha256.c
+++ b/target/s390x/tcg/cpacf_sha256.c
@@ -111,14 +111,24 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 128 }; /* 128 * 64 = 8K */
     uint64_t len = *len_reg, processed = 0;
-    int message_reg_len = 64;
+    int message_reg_len;
     uint32_t a[8];
 
     g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
 
-    if (!(env->psw.mask & PSW_MASK_64)) {
+    /* check addressing mode, raise exception if not supported here */
+    if (env->psw.mask & PSW_MASK_64) {
+        message_reg_len = 64;
+    } else if (env->psw.mask & PSW_MASK_32) {
+        message_reg_len = 32;
         len = (uint32_t)len;
-        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    } else {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* early bail out if length is zero */
+    if (!len) {
+            return 0;
     }
 
     /* KIMD: length has to be properly aligned. */
diff --git a/target/s390x/tcg/cpacf_sha512.c b/target/s390x/tcg/cpacf_sha512.c
index edd8dae78f..1c5f4b028e 100644
--- a/target/s390x/tcg/cpacf_sha512.c
+++ b/target/s390x/tcg/cpacf_sha512.c
@@ -126,13 +126,23 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
     uint64_t len = *len_reg, a[8], processed = 0;
-    int message_reg_len = 64;
+    int message_reg_len;
 
     g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
 
-    if (!(env->psw.mask & PSW_MASK_64)) {
+    /* check addressing mode, raise exception if not supported here */
+    if (env->psw.mask & PSW_MASK_64) {
+        message_reg_len = 64;
+    } else if (env->psw.mask & PSW_MASK_32) {
+        message_reg_len = 32;
         len = (uint32_t)len;
-        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    } else {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* early bail out if length is zero */
+    if (!len) {
+            return 0;
     }
 
     /* KIMD: length has to be properly aligned. */
-- 
2.43.0

