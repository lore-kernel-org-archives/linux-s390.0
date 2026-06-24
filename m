Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C043624D7
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288650; cv=none; b=JITVjoaIQnwzGBA6JZL8CR5QheMZFg7M4JoNcQWZMV/Ig6PDlrC5Igim0ZdcAgxS4XRL63ZBBK9crjzR6Wr3jM0iQWh+0xKaIoI1RaNsY7HNPUlpN/BThbjlYwPz2PdMNKBLxk6nlUZ9w0uccT+AWI6QthD1WehhE1ASTeWXrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288650; c=relaxed/simple;
	bh=iPYpe4wLN7c8arDSU4gP0C3H/3CLS8Dx7odisptFXi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0Rmr5n9+5z/o+wCo+oRG1p3wDr/qUjRk/kSToLjD9KsVzQR+HkQrzrhv96M90MGTHF4ua1PCsJpSq2gObfSOFVhVv4pQDjRL8BLN8d7jiRnqknwHFE9Syd8l5dh5EXUc2KkvvSZ+NAneyjNEcwRYYsRwi49RlHxEF3SEEHyvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fsJnzg4u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fsJnzg4u"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6Ibuf4169611;
	Wed, 24 Jun 2026 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v1Qbf2f72aNF/0uKT
	zWmJUlSJiFyzb/LM9TrkMNSRlk=; b=fsJnzg4ubndi2m4vLlnzmYrjUmUJ1UQYL
	ukIutjgp65Ofl3HoTLuJXUAhvi0XGJO1PF3OSoYvT/X6Zse0kCuBY21CkUCLVsJJ
	mZPZq1NxlL9gijKWD77bOk0dH7z8y00CQnDl9Ucy6gwwFsm8hvRHt7qb8Y98yMlZ
	uhVPF6m9q4ViTZb/bpGMKrSyZaPEAh6WQwa/d6Uzd5XAyaj7oOjLjCJFoZJCkLgq
	N975M7rhThbc2EoTkNWdRvHxgk/WZtwmRigLnvXV/q4wkziqFATRJGX6FI6qNIRB
	3I6TtrXnul3X4ZBxPypAxeeMMcFf41nBCwsI7Eu3m8ciFQAOGFW4w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gjx8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84cEc021911;
	Wed, 24 Jun 2026 08:10:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyq979-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AYnt34931168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8EA920040;
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DEB82004B;
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 16/18] docs/s390: Document CPACF instructions support
Date: Wed, 24 Jun 2026 10:10:13 +0200
Message-ID: <20260624081029.23815-17-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081029.23815-1-freude@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZQy8z0PZsVSJSebEoqDyGacHi7SY3NpK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX1YHMNDRiDfSF
 qVR9Qdzrk3+IqcTKeGgLhW7PP81tYA136GoNfRcqOLrutKD8zZ8nbjd5jfGCGAVt2qtx9ZAJiSm
 D/y/5KZHVKQEsDnkihjYdYbBhHIBJ3I=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3b90ff cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=IlYB4z8HrC9mJJy16gAA:9
 a=5wi_FRADO1KgGG3s:21 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX8nCg4GiMZQnv
 PcPHnoI3FxYeDiArDvLvIcjPLc1G+Y2tgDkrZmON0db2qsIbEiV97ySgcxU29RNWzQrSX6DlU7w
 73S9cg+9J6wxIC/MZZnzXyOecID5vwLDB7l6RDFs9agagSRWINJwtDHTzVBEnQO5LWQ5CgMWvy4
 +T4kpC+WGVihWbemPX3YDd0vGUmzKW7Z9tk1Kcgdq3k83cYB1UxgKqGTQbBUUxb/wzCcrMZNC0W
 mCXfiq6hyg0WqF77duVBLNDuUxwmax8cPqschJZ1XWMYONdl0MA+Zte4MjpCEKPE6v8JBjVEzKy
 tjoNFO1pq5TW55ZPxzHAsO1vDU7AghpeDAZVpkdBI3g4+rayBlZZfpPM7h5nDV1/jtX5ZCAee5v
 K5WqqHlBKyf/E3mJYEIwJgA+TlnhySnxffYj6/E7nvHLpAccMGjR57fuNAcOrRsxATvRg7ybaU/
 Rle/uhueIHJvvqtL+8Q==
X-Proofpoint-ORIG-GUID: ZQy8z0PZsVSJSebEoqDyGacHi7SY3NpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240063

Add a first document covering the Qemu s390 CPACF instructions
and functions supported.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 docs/system/s390x/cpacf.rst  | 144 +++++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst |   1 +
 2 files changed, 145 insertions(+)
 create mode 100644 docs/system/s390x/cpacf.rst

diff --git a/docs/system/s390x/cpacf.rst b/docs/system/s390x/cpacf.rst
new file mode 100644
index 0000000000..1c3a07c59d
--- /dev/null
+++ b/docs/system/s390x/cpacf.rst
@@ -0,0 +1,144 @@
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
+  bytes 0xFACEFACE...
+
+The PCKMO instruction implementation does exactly this - _derive_ a
+_protected_ key from the clear key given by xor 0xAAAA... and writing
+the fixed value for the WKVP of 0xFACEFACE into the blob.
+The other subfunctions of the CPACF instructions dealing with
+protected key treat the protected key blob by first checking for the
+WKVP (against the fixed value of 0xFACEFACE...) and second
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

