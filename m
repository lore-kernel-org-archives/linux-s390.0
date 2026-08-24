Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C23ACEFE
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560385; cv=none; b=jkVFQc6/MCE4x7PWdL6tfwfXWP13VcPIzHXK2Y6zJ8BsxGTFR7JlzIOJDbeKMK828aHrg3fuioQIY6iiZ+CEVqFyEbb1jd3kh26Kuf0uv/85Bd38WOnk/XMpcvDx0WvXVc5lQyNH7hjT0zyNER84bqxJlfBWWfeDXpcrXj8SP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560385; c=relaxed/simple;
	bh=W1jTfn8ubt+uIHI2z+/TtD1eBb86Jd+NZVAUiJ+wGTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvmIe3uJ4rFQoOYuG52qNZ+zVQt/a1nIbh6J1ZYzfEXotH2sGNxQlWEwBXlM8Y2YjywbsQ6wyywN7WTU73JqBqQHdngeI1CTuEUvmfYgKn+WcluwWXzeA9QJodQ1xdY7mFXdPVs6+mLfq4xEsv+TLfHZuxJEy7u5Zq9/pAwh/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P2+kosEE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P2+kosEE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VbPB1014041;
	Mon, 24 Aug 2026 08:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h+L5a2OT0UD3JAMy3
	UeNJ6dQnu2XTEbWzI0KLQWqq1s=; b=P2+kosEEeVXt0W2NxD/plrxK1Sn/+pwUl
	wGZXGoSOxfQrAWYVHzfmbBRpNi7wN8h38EEblT7JbnTUUheUjg4suGBU9kNiwbQY
	/fyC3WNiWQVf9ZOsHd7fo2Tn1JZvVTDAycPqcrBrE7rULF287xr69ojCPYwTmrjp
	wicYiZcv91E9jU9geVYOniHGQwPirgZXnGM9OxUKHvx8Oy3JSdVkOljbz0xZLPm1
	67DIXdi+9MXySm/4Q6wIsN1Y4kTffjsMrZIHUROtbsoobeE62JuXSWeBXffMsNRG
	UV5yYMulU20jCLkwwNWdpEH67h5+qEd8VGOWrEVMLJgMudBroeJAQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwyx5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QOC3029668;
	Mon, 24 Aug 2026 08:32:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag4mv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8W5VL20841100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:32:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0DCE20040;
	Mon, 24 Aug 2026 08:32:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8448F2004B;
	Mon, 24 Aug 2026 08:32:05 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:32:05 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 02/20] target/s390x: Rework s390 cpacf implementations
Date: Mon, 24 Aug 2026 10:31:46 +0200
Message-ID: <20260824083204.40877-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfXwTg0I7IwCbZc
 ARPceYox62kbFzc3csCZl/eNUArn7ot1moXcG2e61F3FXzLuJQRWnrKuplyo+gCv9w0g9avLVYl
 GV5+nyS2u6CDFea7dijZs+k5MP2aLP4=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c018a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4KKJp7DvKucWb6I3c-QA:9
X-Proofpoint-ORIG-GUID: zllSt5XF7z55HNbdG_wY0i9Tj2-uCBUu
X-Proofpoint-GUID: zllSt5XF7z55HNbdG_wY0i9Tj2-uCBUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX1X+X2821p5BM
 2v+epA2KJ/CVSPBeetNrp6GgAP1ahv8ms4BFcJ7UmHdPnQkuZB0eTMOBSk+b4A5hanIb1+FPKx6
 FoogfnUTVYV005RQ8AwxIQg8ny70oo21rINUUJoaucZ1Ab52raquA7v5DimOeHuRInOFVSZzcXV
 zhWOInnrvRvQbd24e0HFdDh3MolR0/kkF6+wO4qXMjh5uFLxrqxBkIUKfJ07KcSMJMaH2F+SrGw
 l4ZJcFeoD/JR/soS6TfryCKreFKJ9YnXUCwNrPSsqCITDX/SrUoMbHnL5F95v2FZ0AFFEf5a3yn
 zLIxCEaSxCYJE+irSs4RCh8fVPPYczplXQsq7J/lN0Z6RkmdfctYV+FGHqWlKY9q5bdvnVi8/Mr
 tUWiREDlSB72cZPSmKr1/Q8z1HscY9tfBkiVdvUq1dwDhfDBI5qP7ZWv7zMvONYXyB1Njl2YF8m
 V3UNerg2L3YpDb7sODQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240074

Fix missing parts for MSA 9 kdsa and rework the cpacf handling code
so that further extensions can be made in a clean and structured way.

Introduce a new header file cpacf-arch.h to hold defines, structs and
function prototypes around s390 cpacf. Use the cpcaf function defines
in the existing code.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/cpacf-arch.h    | 226 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 101 +++++++++++---
 target/s390x/tcg/insn-data.h.inc |   1 +
 target/s390x/tcg/translate.c     |   2 +
 4 files changed, 311 insertions(+), 19 deletions(-)
 create mode 100644 target/s390x/tcg/cpacf-arch.h

diff --git a/target/s390x/tcg/cpacf-arch.h b/target/s390x/tcg/cpacf-arch.h
new file mode 100644
index 0000000000..f92e4b44e3
--- /dev/null
+++ b/target/s390x/tcg/cpacf-arch.h
@@ -0,0 +1,226 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * s390x cpacf-arch
+ *
+ */
+
+#ifndef S390X_CPACF_ARCH_H
+#define S390X_CPACF_ARCH_H
+
+/*
+ * Function codes for the KM instruction
+ */
+#define CPACF_KM_QUERY          0x00
+#define CPACF_KM_DEA            0x01
+#define CPACF_KM_TDEA_128       0x02
+#define CPACF_KM_TDEA_192       0x03
+#define CPACF_KM_AES_128        0x12
+#define CPACF_KM_AES_192        0x13
+#define CPACF_KM_AES_256        0x14
+#define CPACF_KM_PAES_128       0x1a
+#define CPACF_KM_PAES_192       0x1b
+#define CPACF_KM_PAES_256       0x1c
+#define CPACF_KM_XTS_128        0x32
+#define CPACF_KM_XTS_256        0x34
+#define CPACF_KM_PXTS_128       0x3a
+#define CPACF_KM_PXTS_256       0x3c
+#define CPACF_KM_FULL_XTS_128   0x52
+#define CPACF_KM_FULL_XTS_256   0x54
+#define CPACF_KM_FULL_PXTS_128  0x5a
+#define CPACF_KM_FULL_PXTS_256  0x5c
+
+/*
+ * Function codes for the KMC instruction
+ */
+#define CPACF_KMC_QUERY         0x00
+#define CPACF_KMC_DEA           0x01
+#define CPACF_KMC_TDEA_128      0x02
+#define CPACF_KMC_TDEA_192      0x03
+#define CPACF_KMC_AES_128       0x12
+#define CPACF_KMC_AES_192       0x13
+#define CPACF_KMC_AES_256       0x14
+#define CPACF_KMC_PAES_128      0x1a
+#define CPACF_KMC_PAES_192      0x1b
+#define CPACF_KMC_PAES_256      0x1c
+#define CPACF_KMC_PRNG          0x43
+
+/*
+ * Function codes for the KMCTR instruction
+ */
+#define CPACF_KMCTR_QUERY       0x00
+#define CPACF_KMCTR_DEA         0x01
+#define CPACF_KMCTR_TDEA_128    0x02
+#define CPACF_KMCTR_TDEA_192    0x03
+#define CPACF_KMCTR_AES_128     0x12
+#define CPACF_KMCTR_AES_192     0x13
+#define CPACF_KMCTR_AES_256     0x14
+#define CPACF_KMCTR_PAES_128    0x1a
+#define CPACF_KMCTR_PAES_192    0x1b
+#define CPACF_KMCTR_PAES_256    0x1c
+
+/*
+ * Function codes for the KIMD instruction
+ */
+#define CPACF_KIMD_QUERY        0x00
+#define CPACF_KIMD_SHA_1        0x01
+#define CPACF_KIMD_SHA_256      0x02
+#define CPACF_KIMD_SHA_512      0x03
+#define CPACF_KIMD_SHA3_224     0x20
+#define CPACF_KIMD_SHA3_256     0x21
+#define CPACF_KIMD_SHA3_384     0x22
+#define CPACF_KIMD_SHA3_512     0x23
+#define CPACF_KIMD_SHAKE_128    0x24
+#define CPACF_KIMD_SHAKE_256    0x25
+#define CPACF_KIMD_GHASH        0x41
+
+/*
+ * Function codes for the KLMD instruction
+ */
+#define CPACF_KLMD_QUERY        0x00
+#define CPACF_KLMD_SHA_1        0x01
+#define CPACF_KLMD_SHA_256      0x02
+#define CPACF_KLMD_SHA_512      0x03
+#define CPACF_KLMD_SHA3_224     0x20
+#define CPACF_KLMD_SHA3_256     0x21
+#define CPACF_KLMD_SHA3_384     0x22
+#define CPACF_KLMD_SHA3_512     0x23
+#define CPACF_KLMD_SHAKE_128    0x24
+#define CPACF_KLMD_SHAKE_256    0x25
+
+/*
+ * function codes for the KMAC instruction
+ */
+#define CPACF_KMAC_QUERY         0x00
+#define CPACF_KMAC_DEA           0x01
+#define CPACF_KMAC_TDEA_128      0x02
+#define CPACF_KMAC_TDEA_192      0x03
+#define CPACF_KMAC_AES_128       0x12
+#define CPACF_KMAC_AES_192       0x13
+#define CPACF_KMAC_AES_256       0x14
+#define CPACF_KMAC_PAES_128      0x1A
+#define CPACF_KMAC_PAES_192      0x1B
+#define CPACF_KMAC_PAES_256      0x1C
+#define CPACF_KMAC_HMAC_SHA_224  0x70
+#define CPACF_KMAC_HMAC_SHA_256  0x71
+#define CPACF_KMAC_HMAC_SHA_384  0x72
+#define CPACF_KMAC_HMAC_SHA_512  0x73
+#define CPACF_KMAC_PHMAC_SHA_224 0x78
+#define CPACF_KMAC_PHMAC_SHA_256 0x79
+#define CPACF_KMAC_PHMAC_SHA_384 0x7a
+#define CPACF_KMAC_PHMAC_SHA_512 0x7b
+
+/*
+ * Function codes for the PCKMO instruction
+ */
+#define CPACF_PCKMO_QUERY                      0x00
+#define CPACF_PCKMO_ENC_DES_KEY                0x01
+#define CPACF_PCKMO_ENC_TDES_128_KEY           0x02
+#define CPACF_PCKMO_ENC_TDES_192_KEY           0x03
+#define CPACF_PCKMO_ENC_AES_128_KEY            0x12
+#define CPACF_PCKMO_ENC_AES_192_KEY            0x13
+#define CPACF_PCKMO_ENC_AES_256_KEY            0x14
+#define CPACF_PCKMO_ENC_AES_XTS_128_DOUBLE_KEY 0x15
+#define CPACF_PCKMO_ENC_AES_XTS_256_DOUBLE_KEY 0x16
+#define CPACF_PCKMO_ENC_ECC_P256_KEY           0x20
+#define CPACF_PCKMO_ENC_ECC_P384_KEY           0x21
+#define CPACF_PCKMO_ENC_ECC_P521_KEY           0x22
+#define CPACF_PCKMO_ENC_ECC_ED25519_KEY        0x28
+#define CPACF_PCKMO_ENC_ECC_ED448_KEY          0x29
+#define CPACF_PCKMO_ENC_HMAC_512_KEY           0x76
+#define CPACF_PCKMO_ENC_HMAC_1024_KEY          0x7a
+
+/*
+ * Function codes for the PRNO instruction
+ */
+#define CPACF_PRNO_QUERY                0x00
+#define CPACF_PRNO_SHA512_DRNG_GEN      0x03
+#define CPACF_PRNO_SHA512_DRNG_SEED     0x83
+#define CPACF_PRNO_TRNG_Q_R2C_RATIO     0x70
+#define CPACF_PRNO_TRNG                 0x72
+
+/*
+ * Function codes for the KMA instruction
+ */
+#define CPACF_KMA_QUERY         0x00
+#define CPACF_KMA_GCM_AES_128   0x12
+#define CPACF_KMA_GCM_AES_192   0x13
+#define CPACF_KMA_GCM_AES_256   0x14
+#define CPACF_KMA_GCM_PAES_128  0x1A
+#define CPACF_KMA_GCM_PAES_192  0x1B
+#define CPACF_KMA_GCM_PAES_256  0x1C
+
+/*
+ * Function codes for the KMF instruction
+ */
+#define CPACF_KMF_QUERY      0
+#define CPACF_KMF_DEA        1
+#define CPACF_KMF_TDEA_128   2
+#define CPACF_KMF_TDEA_192   3
+#define CPACF_KMF_AES_128   18
+#define CPACF_KMF_AES_192   19
+#define CPACF_KMF_AES_256   20
+#define CPACF_KMF_PAES_128  26
+#define CPACF_KMF_PAES_192  27
+#define CPACF_KMF_PAES_256  28
+
+/*
+ * Function codes for the KMO instruction
+ */
+#define CPACF_KMO_QUERY      0
+#define CPACF_KMO_DEA        1
+#define CPACF_KMO_TDEA_128   2
+#define CPACF_KMO_TDEA_192   3
+#define CPACF_KMO_AES_128   18
+#define CPACF_KMO_AES_192   19
+#define CPACF_KMO_AES_256   20
+#define CPACF_KMO_PAES_128  26
+#define CPACF_KMO_PAES_192  27
+#define CPACF_KMO_PAES_256  28
+
+/*
+ * Function codes for the PCC instruction
+ */
+#define CPACF_PCC_QUERY            0
+#define CPACF_PCC_CMAC_DEA         1
+#define CPACF_PCC_CMAC_TDEA_128    2
+#define CPACF_PCC_CMAC_TDEA_192    3
+#define CPACF_PCC_CMAC_AES_128    18
+#define CPACF_PCC_CMAC_AES_192    19
+#define CPACF_PCC_CMAC_AES_256    20
+#define CPACF_PCC_CMAC_PAES_128   26
+#define CPACF_PCC_CMAC_PAES_192   27
+#define CPACF_PCC_CMAC_PAES_256   28
+#define CPACF_PCC_XTS_AES_128     50
+#define CPACF_PCC_XTS_AES_256     52
+#define CPACF_PCC_XTS_PAES_128    58
+#define CPACF_PCC_XTS_PAES_256    60
+#define CPACF_PCC_SM_P256         64
+#define CPACF_PCC_SM_P384         65
+#define CPACF_PCC_SM_P521         66
+#define CPACF_PCC_SM_ED25519      72
+#define CPACF_PCC_SM_ED448        73
+#define CPACF_PCC_SM_X25519       80
+#define CPACF_PCC_SM_X448         81
+
+/*
+ * Function codes for the KDSA instruction
+ */
+#define CPACF_KDSA_QUERY            0
+#define CPACF_KDSA_VERIFY_P256      1
+#define CPACF_KDSA_VERIFY_P384      2
+#define CPACF_KDSA_VERIFY_P521      3
+#define CPACF_KDSA_SIGN_P256        9
+#define CPACF_KDSA_SIGN_P384       10
+#define CPACF_KDSA_SIGN_P521       11
+#define CPACF_KDSA_PSIGN_P256      17
+#define CPACF_KDSA_PSIGN_P384      18
+#define CPACF_KDSA_PSIGN_P521      19
+#define CPACF_KDSA_VERIFY_ED25519  32
+#define CPACF_KDSA_VERIFY_ED448    36
+#define CPACF_KDSA_SIGN_ED25519    40
+#define CPACF_KDSA_SIGN_ED448      44
+#define CPACF_KDSA_PSIGN_ED25519   48
+#define CPACF_KDSA_PSIGN_ED448     52
+
+#endif /* S390X_CPACF_ARCH_H */
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 6a5dbe1caf..e39ad153a8 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -20,6 +20,7 @@
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "target/s390x/tcg/cpacf-arch.h"
 
 static uint64_t R(uint64_t x, int c)
 {
@@ -275,6 +276,61 @@ static int fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return len == 0 ? 0 : 3;
 }
 
+static int cpacf_kimd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
+                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_KIMD_SHA_512:
+        rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KIMD);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
+static int cpacf_klmd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
+                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_KLMD_SHA_512:
+        rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KLMD);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
+static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_PRNO_TRNG:
+        rc = fill_buf_random(env, mmu_idx, ra,
+                             &env->regs[r1], &env->regs[r1 + 1]);
+        if (!rc) {
+            rc = fill_buf_random(env, mmu_idx, ra,
+                                 &env->regs[r2], &env->regs[r2 + 1]);
+        }
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
@@ -285,14 +341,15 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
     MemOpIdx oi;
-    int cc;
+    int rc = 0;
 
     switch (type) {
-    case S390_FEAT_TYPE_KMAC:
+    case S390_FEAT_TYPE_KDSA:
     case S390_FEAT_TYPE_KIMD:
     case S390_FEAT_TYPE_KLMD:
-    case S390_FEAT_TYPE_PCKMO:
+    case S390_FEAT_TYPE_KMAC:
     case S390_FEAT_TYPE_PCC:
+    case S390_FEAT_TYPE_PCKMO:
         if (mod) {
             tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         }
@@ -304,29 +361,35 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    switch (fc) {
-    case 0: /* query subfunction */
+    /* handle query subfunction */
+    if (fc == 0) {
         oi = make_memop_idx(MO_8, mmu_idx);
-        for (int i = 0; i < 16; i++) {
+        for (int i = 0; i < sizeof(subfunc); i++) {
             param_addr = wrap_address(env, env->regs[1] + i);
             cpu_stb_mmu(env, param_addr, subfunc[i], oi, ra);
         }
+        goto out;
+    }
+
+    switch (type) {
+    case S390_FEAT_TYPE_KIMD:
+        rc = cpacf_kimd(env, mmu_idx, ra, r1, r2, r3, fc);
+        break;
+    case S390_FEAT_TYPE_KLMD:
+        rc = cpacf_klmd(env, mmu_idx, ra, r1, r2, r3, fc);
+        break;
+    case S390_FEAT_TYPE_PPNO:
+        rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
+        break;
+    case S390_FEAT_TYPE_KDSA:
+    case S390_FEAT_TYPE_KMAC:
+        /* subfunctions (other than query) are not implemented yet */
+        tcg_s390_program_interrupt(env, PGM_OPERATION, ra);
         break;
-    case 3: /* CPACF_*_SHA_512 */
-        return cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
-                            &env->regs[r2 + 1], type);
-    case 114: /* CPACF_PRNO_TRNG */
-        cc = fill_buf_random(env, mmu_idx, ra,
-                             &env->regs[r1], &env->regs[r1 + 1]);
-        if (cc == 0) {
-            cc = fill_buf_random(env, mmu_idx, ra,
-                                 &env->regs[r2], &env->regs[r2 + 1]);
-        }
-        return cc;
     default:
-        /* we don't implement any other subfunction yet */
         g_assert_not_reached();
     }
 
-    return 0;
+out:
+    return rc;
 }
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index b2e402216b..f2d0a6c664 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -1015,6 +1015,7 @@
     D(0xb92e, KM,      RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KM)
     D(0xb92f, KMC,     RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMC)
     D(0xb929, KMA,     RRF_b, MSA8, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMA)
+    D(0xb93a, KDSA,    RRE,   MSA9, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KDSA)
     E(0xb93c, PPNO,    RRE,   MSA5, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PPNO, IF_IO)
     D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KIMD)
     D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KLMD)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 1b6023168b..1fbd40a038 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2585,6 +2585,7 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
     case S390_FEAT_TYPE_KMAC:
     case S390_FEAT_TYPE_KIMD:
     case S390_FEAT_TYPE_KLMD:
+    case S390_FEAT_TYPE_KDSA:
         if (r2 & 1 || !r2) {
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
@@ -6048,6 +6049,7 @@ enum DisasInsnEnum {
 #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
 #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
 #define FAC_MSA8        S390_FEAT_MSA_EXT_8 /* msa-extension-8 facility */
+#define FAC_MSA9        S390_FEAT_MSA_EXT_9 /* msa-extension-9 facility */
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
-- 
2.43.0

