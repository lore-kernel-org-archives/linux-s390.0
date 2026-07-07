Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B502430CDC
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441112; cv=none; b=h47eIaLBZgbEabmkWiTiKfYMFGoRivM6T2lkeFKQZl3LkU4e0zbmukvt3ypLnkpAGVReEIs9alYNrQWqeG7DZ3UvELR9EBFwWHTGvbM77YUluuNpdPQfLa6q6Dzb86c1NCWqV81lrL+eCc5q5F8CaTf05s10zm1/KrhC/OaCiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441112; c=relaxed/simple;
	bh=c/Ld3plpTLk2GfUfGS2DM8hGLPCHXgKtkwIYrQIU5p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGElk5zChO3L43fKCTHjIAwxwhrcg8OAe7W0Jh8IC782b9FW41mQRJl4XopXC0eD/8vy5CFye1U3oXl3vyPxD3hyvp17ZSls6rM2D708MP82cq5J9dhpdEOxyfoEnTI8hX7tLgqK+/QGtibw6QyJrgdmkvcgJLs/gzW+BGukovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FbToLxGe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FbToLxGe"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FmLNk4084929;
	Tue, 7 Jul 2026 16:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s7XbP3NXFrOl+6eff
	IgLJ+MIGqKsuVCxmppm7IMXE1Y=; b=FbToLxGe6C2jBui84zYgXbZb20ndA4wiR
	VFt4Q8QRC+V6SWR6kB5B86zYBgfFAf62fw5X9bY5EdyyOn//R3xLY5RHR9AY5rHX
	3zrJAC7D4CnC+cwt2jsZfVb8kQwCZoHy2NI+rh9e9YQRc9chz31AN5+VhxyrXwmM
	GDbS5CeQQhhIQFKi7oDBwOEDNZVMB60hD5YcCSq2K7qvW3JxY3J8PusBDJbodKD5
	BDOHYQpn3opYHaPQ9sJfPsoZ/SFC54YEbxuJfpqwssqIhtwQtv92Z3JQSwyFll8I
	KWGYQRpaD4Y2JVgSXaniz5PNWE9wD5WWAmECcP5m5HL1p0n+lTtLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4r5pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667G4bsu005421;
	Tue, 7 Jul 2026 16:18:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw3sjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667GIEe824052114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 16:18:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D22520040;
	Tue,  7 Jul 2026 16:18:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 392FD2004B;
	Tue,  7 Jul 2026 16:18:14 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.140.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 16:18:14 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v11 02/21] target/s390x: Rework s390 cpacf implementations
Date: Tue,  7 Jul 2026 18:17:49 +0200
Message-ID: <20260707161815.40919-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707161815.40919-1-freude@linux.ibm.com>
References: <20260707161815.40919-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tn-Ho9uNIAU7senPDrQLHIJGG-1z0iod
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX1Z7gI2rwPJ+z
 qV34SSCOS5bEkKIsNTYeAxUjvl5rfcjlRTzwZHRFYFxh9qt1fUWJDNgwa275hk73rnParK4tamW
 sZfbbSecySituGyOhleKBaO5dq5rFbssv5wzmzHyZHxV8FBczc+A1b8Ei9DZlK7I49hWeL/+SJX
 437rrCoTeW/eLl5eXuF5UN3oYTO1iwAcoWG3y6ktfMIAPnnTBTIr804NKyBjXvgHD6p4Zjn8T1P
 pOgxllE6/mxgQDByC2ql3x9D/RjGvQ9HbeDapSIz0iws1W2s6U4QZDHB7ZTRWHz2egSTCf3175a
 ZOeL6Sy9sO+ZgbiphIP9u6Rf+iil17TwI2Zvdz7HXA8tqA5CtyKcF1bdqkM3dFloczWSLm2re6E
 KIPz2sgTuBnRBJrIWMp5UlSD/X4kv0sF5zh9f7Z354Pw8WhVpuI5jIW2xFRIlLGYCZQ/8GLcrBK
 ZnZyhKlfsiIHYMbGSYg==
X-Proofpoint-ORIG-GUID: Tn-Ho9uNIAU7senPDrQLHIJGG-1z0iod
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4d26cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4KKJp7DvKucWb6I3c-QA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX3177V7SX1ZCg
 WlplIz44J7qy8kDlJI+4Kz7mAf9E5UbqGYbCDYNNNt496/gAo5x6x0QG6utrWRHbEZpxUxOm28O
 oJc90Kuczemp0+j1y2ZwZnSwaot8d6A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070160

Fix missing parts for MSA 9 kdsa and rework the cpacf handling code
so that further extensions can be made in a clean and structured way.

Introduce a new header file to hold defines, structs and function
prototypes around s390 cpacf. Use the cpcaf function defines in the
existing code.

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/cpacf.h         | 226 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  90 ++++++++++--
 target/s390x/tcg/insn-data.h.inc |   1 +
 target/s390x/tcg/translate.c     |   2 +
 4 files changed, 306 insertions(+), 13 deletions(-)
 create mode 100644 target/s390x/tcg/cpacf.h

diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
new file mode 100644
index 0000000000..49496d39ed
--- /dev/null
+++ b/target/s390x/tcg/cpacf.h
@@ -0,0 +1,226 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * s390x cpacf
+ *
+ */
+
+#ifndef S390X_CPACF_H
+#define S390X_CPACF_H
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
+#define CPACF_PCKMO_ENC_AES_XTS_128_DOUBLE_KEY 0x14
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
+#endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 8fe0a22219..987bc72ae9 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -19,6 +19,7 @@
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "target/s390x/tcg/cpacf.h"
 
 static uint64_t R(uint64_t x, int c)
 {
@@ -268,6 +269,57 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
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
+        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
+        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
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
@@ -278,13 +330,15 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
     MemOpIdx oi;
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
@@ -296,25 +350,35 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
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
         break;
-    case 3: /* CPACF_*_SHA_512 */
-        return cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
-                            &env->regs[r2 + 1], type);
-    case 114: /* CPACF_PRNO_TRNG */
-        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
-        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
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
     default:
-        /* we don't implement any other subfunction yet */
         g_assert_not_reached();
     }
 
-    return 0;
+out:
+    return rc;
 }
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0d5392eac5..6a0a7aacda 100644
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
index 82165ac1ec..cef1b55149 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2592,6 +2592,7 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
         /* FALL THROUGH */
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
+    case S390_FEAT_TYPE_KDSA:
         break;
     default:
         g_assert_not_reached();
@@ -6046,6 +6047,7 @@ enum DisasInsnEnum {
 #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
 #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
 #define FAC_MSA8        S390_FEAT_MSA_EXT_8 /* msa-extension-8 facility */
+#define FAC_MSA9        S390_FEAT_MSA_EXT_9 /* msa-extension-9 facility */
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
-- 
2.43.0

