Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B047CC78
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069928; cv=none; b=nwtJKLRW+U38VG+Ar8iVWIFfEzgC7pGfZ8XsxMHlPiTdQXDxh/q/sGgD2D1Xvzya1iAxPFAw5pqtK1TbKjq72sPpRVO2Y0+u6YZIKMXM6dTtTqegK7L37/vDXufQpogQIfwbb8WFMZ1zuSjSaWrYKG0xfRS5NiGvunIxZccrOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069928; c=relaxed/simple;
	bh=x8Gk4gnHB6sXNqqDAORyg6tRnGzcz1nqKpgvKJ1vk3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOoe1fMG3mh1Ohqd1OmDhDpRrGTJHOUqWA6SMNrbhF0XK4DvSlugBjzSY+nwyEiJFCnrTe51yWeiWu9Pp/RkyBLJn7saCotBU1h/lMu1Q8g64P4S8iSHJN4mRyCQ6XUqFITvRN3pMR5UrrQ538guqPPRRTVNvo26e0OYLvl92l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FxjzQ7Sf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FxjzQ7Sf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3kTZ2831485;
	Tue, 18 Aug 2026 16:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vC/AKqTbBJJ19cLJ0
	CcxiJxwdVnlL50bkDsELIDrVMc=; b=FxjzQ7SfV36rQVIS/Fk6wfTx9TtCAstFG
	yg8Wf8qQiG1zptMivKYL8JIA4wXi5vBt+F6Gaj5xACYIVhmuI1vnzqzTONEnsNTb
	hLj0Y4Zdm/dmlX/VKIdTv/XDb9LqbnBGQQCumeKpoox3hsyRONXRUJY/VKGRIt8t
	DkcsePoRxudnxVEciv/0YSYENuBNPwgIzDY64Q+kj4qnqNaR2ebXpL9D15D53LKT
	Uzo37EDRP7FihHDxpYhrZuTANbuNKpDJzHwmXAx/FFMV5dkSmN62D47LXhMnq5I2
	+C4jWRTzAXhfSGgstzYxw3lk+IchGPKwWyex+/gkF/PGpALCNpskg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqsck8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBLhe002189;
	Tue, 18 Aug 2026 16:18:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek455t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGITFu44433760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E94C22004B;
	Tue, 18 Aug 2026 16:18:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE7212004D;
	Tue, 18 Aug 2026 16:18:28 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.161.134])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:18:28 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v15 19/20] docs/s390: Document CPACF instructions support
Date: Tue, 18 Aug 2026 18:18:23 +0200
Message-ID: <20260818161824.100746-20-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX9ycdJhy+1JiX
 cSqT4Oia+xBYQCUZOSYhlYkWegbwYwZAugH+zHU+Wa0YVJ3aTL8zi2vfkgba7WiVvOEOJxCnFlX
 KyATpESOsJuUtyVZdFJvKlsY0uO8zWBCyUFSE3ZjWbC2fu1t/TmMN/5uK+BspgynBDUbJgsGvWc
 zEoLIRCf4VV3wtiCjbUrv880P5EMz7cS81hewEvTlLU8Buz4V2weOqbGlELqr9AU7E56w2MajR9
 SbiCLkBUfwCCZSGhPfqiim+LY6HIkRpczlbszpCykdQxtk/yY3v5vckPazIb1Q1hH0msWSDMe+b
 7imR8kHu9QOFr/GhP5+oDFK9S48nItOezAYqmtREnQjOi5f78g+HIRGVB0DOOoR3BvGxwI3FHtA
 oNsKMpfF2VfnKO74Z0Y7Q/FGj91FsnS7JbPaNTFe3wqEMjtscl+H4JWTc7bArJXVSlImdQe0qKT
 FqJV2x7E7j2FBjTvChA==
X-Proofpoint-ORIG-GUID: ZGJCNniujBS9jCVH3hghipuu6pLS6mcn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX3DldNWmAbtOA
 O7A0HmSgWZmuIz6b/r4hmrvBwKxiRi5OVXwdSbcBx6KyvhJS9erwYib95Pjip9K9iKj+qrA+weR
 TwnD70tLmPgyGp3TUGk9Md8nIVGPbW8=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a8485da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=IlYB4z8HrC9mJJy16gAA:9
 a=5wi_FRADO1KgGG3s:21 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: ZGJCNniujBS9jCVH3hghipuu6pLS6mcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

Add a first document covering the Qemu s390 CPACF instructions
and functions supported.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 docs/system/s390x/cpacf.rst  | 146 +++++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst |   1 +
 2 files changed, 147 insertions(+)
 create mode 100644 docs/system/s390x/cpacf.rst

diff --git a/docs/system/s390x/cpacf.rst b/docs/system/s390x/cpacf.rst
new file mode 100644
index 0000000000..7215d3301b
--- /dev/null
+++ b/docs/system/s390x/cpacf.rst
@@ -0,0 +1,146 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+CPACF Support
+=============
+
+CPACF
+-----
+
+CP Assist for Cryptographic Function (CPACF) is a hardware-integrated
+coprocessor feature built into every  processor core of IBM Z and
+LinuxONE mainframes (s390x architecture). It provides high-speed,
+hardware-accelerated encryption and hashing directly on the CPU.
+
+CPACF provides a set of z/Architecture instructions (known as Message
+Security Assist or MSA) that execute cryptographic operations
+synchronously with the main processor.
+
+- Symmetric Encryption: Support for AES (128, 192, 256-bit), DES, and
+  Triple-DES (TDES).
+- Hashing: Acceleration for SHA-1, SHA-2 (up to SHA-512), SHA-3 and
+  SHAKE.
+- Random Number Generation: Pseudo Random Number Generator (PRNG) and
+  a hardware-based True Random Number Generator (TRNG).
+- Asymmetric Support: Elliptic Curve Cryptography (ECC) primitives
+  P-256, P-384, P-521, Montgomery/Edwards curves (e.g., Ed25519).
+
+Documentation about CPACF instructions is publicly available and
+can be found in the "z/Architecture Principles of Operation"
+accessible at the IBM documentation hub https://www.ibm.com/docs/en.
+For example the latest version as a pdf is available here:
+https://www.ibm.com/support/pages/zvm/library/other/22783214.pdf
+
+
+CPACF instructions
+------------------
+
+Here is a list of implemented CPACF instructions and the supported
+functions for each instruction:
+
+KDSA (COMPUTE DIGITAL SIGNATURE AUTHENTICATION)
+- Function code 0x00 - Function Query
+
+KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST)
+- Function code 0x00 - Function Query
+- Function code 0x02 - CPACF_KIMD_SHA_256
+- Function code 0x03 - CPACF_KIMD_SHA_512
+
+KLMD (COMPUTE LAST MESSAGE DIGEST)
+- Function code 0x00 - Function Query
+- Function code 0x02 - CPACF_KLMD_SHA_256
+- Function code 0x03 - CPACF_KLMD_SHA_512
+
+KM (CIPHER MESSAGE)
+- Function code 0x00 - Function Query
+- Function code 0x12 - CPACF_KM_AES_128
+- Function code 0x13 - CPACF_KM_AES_192
+- Function code 0x14 - CPACF_KM_AES_256
+- Function code 0x1a - CPACF_KM_PAES_128
+- Function code 0x1b - CPACF_KM_PAES_192
+- Function code 0x1c - CPACF_KM_PAES_256
+- Function code 0x32 - CPACF_KM_XTS_128
+- Function code 0x34 - CPACF_KM_XTS_256
+- Function code 0x3a - CPACF_KM_PXTS_128
+- Function code 0x3c - CPACF_KM_PXTS_256
+
+KMAC (COMPUTE MESSAGE AUTHENTICATION CODE)
+- Function code 0x00 - Function Query
+
+KMC (CIPHER MESSAGE WITH CHAINING)
+- Function code 0x00 - Function Query
+- Function code 0x12 - CPACF_KMC_AES_128
+- Function code 0x13 - CPACF_KMC_AES_192
+- Function code 0x14 - CPACF_KMC_AES_256
+- Function code 0x1a - CPACF_KMC_PAES_128
+- Function code 0x1b - CPACF_KMC_PAES_192
+- Function code 0x1c - CPACF_KMC_PAES_256
+
+KMCTR (CIPHER MESSAGE WITH COUNTER)
+- Function code 0x00 - Function Query
+- Function code 0x12 - CPACF_KMCTR_AES_128
+- Function code 0x13 - CPACF_KMCTR_AES_192
+- Function code 0x14 - CPACF_KMCTR_AES_256
+- Function code 0x1a - CPACF_KMCTR_PAES_128
+- Function code 0x1b - CPACF_KMCTR_PAES_192
+- Function code 0x1c - CPACF_KMCTR_PAES_256
+
+KMF (CIPHER MESSAGE WITH CIPHER FEEDBACK)
+- not supported
+
+KMO (CIPHER MESSAGE WITH OUTPUT FEEDBACK)
+- not supported
+
+PCC (PERFORM CRYPTOGRAPHIC COMPUTATION)
+- Function code 0x00 - Function Query
+- Function code 0x32 - compute XTS param AES-128
+- Function code 0x34 - compute XTS param AES-256
+- Function code 0x3a - compute XTS param Encrypted AES-128
+- Function code 0x3c - compute XTS param Encrypted AES-256
+
+PCKMO (PERFORM CRYPTOGRAPHIC KEY MANAGEMENT OPERATION)
+- Function code 0x00 - Function Query
+- Function code 0x12 - CPACF_PCKMO_ENC_AES_128_KEY
+- Function code 0x13 - CPACF_PCKMO_ENC_AES_192_KEY
+- Function code 0x14 - CPACF_PCKMO_ENC_AES_256_KEY
+
+PRNO (PERFORM RANDOM NUMBER OPERATION)
+- Function code 0x00 - Function Query
+- Function code 0x72 - CPACF_PRNO_TRNG
+
+Note that the use of a not supported CPACF instruction (KMF and KMO)
+or invocation of a not listed function will result in a Specification
+Exception.
+
+Not listed CPACF instructions (KMA, KMF, KMO) cause an Operation
+Exception when used. Not listed functions cause a Specification
+Exception when called. If only the query function is listed (KDSA),
+then the query function will return a function status word with all
+but the query function bit set to 0.
+
+
+Protected key support
+---------------------
+
+The qemu version for protected key support is only a fake provided
+here for developing and testing purpose:
+
+- The protected key is _derived_ from the clear key by xoring the
+  fixed pattern 0xAAAA... onto the key value.
+- The AES Wrapping Key Verification Pattern is a fixed value of 32
+  bytes 0x0F0A0C0E0F0A0C0E...
+
+The PCKMO instruction implementation does exactly this - _derive_ a
+_protected_ key from the clear key given by xor 0xAAAA... and writing
+the fixed value for the WKVP of 0x0F0A0C0E0F0A0C0E... into the blob.
+The other subfunctions of the CPACF instructions dealing with
+protected key treat the protected key blob by first checking for the
+WKVP (against the fixed value of 0x0F0A0C0E0F0A0C0E...) and second
+_decrypting_ the key value by xoring 0xAAAA... and then execute the
+clear key operation with the decrypted key value.
+This is suitable for testing purpose but such keys are not for real
+production load and would open up a huge security breach!
+
+For more details about protected keys see the "z/Architecture
+Principles of Operation" document chapter "General Instructions"
+sub-chapter "Protection of Cryptographic Keys" and again the
+implementation here does NOT implement what is explained there.
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index 94c981e732..49159826eb 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -35,3 +35,4 @@ Architectural features
    s390x/bootdevices
    s390x/protvirt
    s390x/cpu-topology
+   s390x/cpacf
-- 
2.43.0

