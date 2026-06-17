Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4F3A168C
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689721; cv=none; b=nsKUlb4hdDKSQyotiPPoDpBPDChQn87uzN/3KulPIi1SpAK35br1H0u3fcdNXJStyMiKE1g0m/yikSJB99WJreTTxkl1Pb8HzoPB5GxKI+1KRr7LvR6awUQbYNsBxCUO3LG4/xuU/NmacxprhaASlhs+vMASUpjMA3Z1NqCJNC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689721; c=relaxed/simple;
	bh=sL+CwSZxbPdgFoaOSHI/7tTAWk/JdxwigDS6GTxNZDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USBt5e1wX0OuQic+aaNh3r4Rfrtkf3CIK/AmgwRzTm4Vv4nByn2u9J/xrGdzErRApyrwCKIbu8cItQqBJlXyC4k7ZamURJbJrIsQWkvIRIk7VPv9YHZJb3r+ZNKZHBYDBTZF6y5u6yGUZv+pQsuQezHJatAQY+/RW4cBZroAekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SsWK/QkY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SsWK/QkY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8mti04042154;
	Wed, 17 Jun 2026 09:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tun5NYFOsftXK46/U
	RD4ae+acA1hTWaly0US/HOM/R4=; b=SsWK/QkYcCB67K5g2ihsDHxDHuftAvi31
	oK6UMN5vo2UtCqcNmFCzWllwuR2W1e/hH+gl3mXYRIWodEfTZVuOzhlyS7n+eqzS
	/halcCXbJr4OVBpcY8S19eGfSI1al7E1+EMI49AFwOUvF9+C0kY4sYdUQGv4EgwB
	9zR1ZOAvZTc8EvXmwlLb67rMaMw0z7XZ/mZ7aY6wUW8NmrL2xMzDd2Ii6GcFkuZt
	uiZj0qfsqSvYgIVmukKwQjx7r6RlkdZ1mWZQhWKAXlUOz7DGVry8X8WlBfGyg6Wa
	vjqNPggN/Cm5jwR4SVaGX5Rr5o/b2FI8uoE0wAK3EwJXBqX/VMGqg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxa7xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9Ye2x022006;
	Wed, 17 Jun 2026 09:48:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva2h5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65H9mO6L46465512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 09:48:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F57920043;
	Wed, 17 Jun 2026 09:48:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33F162004E;
	Wed, 17 Jun 2026 09:48:24 +0000 (GMT)
Received: from funtu2.ehn-de.ibm.com (unknown [9.224.92.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 09:48:24 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v7 15/17] docs/s390: Document CPACF instructions support
Date: Wed, 17 Jun 2026 11:48:18 +0200
Message-ID: <20260617094820.34402-16-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617094820.34402-1-freude@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a326d6c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=yFZ0Su8qAlDFIkEhSqQA:9
 a=5wi_FRADO1KgGG3s:21 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX0QC0dd0Lq6q0
 e1ppgAnRcldp4AbSRbiDmuwstsSR1TkrT0ShshIe/3d2f1cGK1DztySTdILfCgnecKTh6v4BMmX
 wqlPXeMJYMz9tlPSjQeDv4My/Ps/uYsJlMW9vfA80qRz1Tm6AncSK9n+TUc5iqmg55VlOFrcgqZ
 AZquevEcKQ7/oBlTM4rngyTdJV3bK755S14go1jNq4T+84fFcS4NCdj3UCF27EUTulSmlxtqhE8
 RXzUJZ14SRtYwmxwPcJzIL1wMWn8UGuVuplKbGi8FZlHWOdDz/YIrJKqCwI7JstNAa6BkyyWSi3
 eZa6bT+0asxtdGYnk0woueMGs4R0D/AWFylLMmSX1T1099i0XbRjODf6IHNaX4D//BnOKjZYUen
 KxFHDtRBApCnGo96LRjj5t9zWAoMYtWP2JaRtH2S+Ppk6ZTDykipEUlwVk0yzFa8Z9xKa5ROCYT
 Hw73OSIloU0HsD+xjEg==
X-Proofpoint-GUID: sa6fKmT46F8-35g2JtmvgmU5mEdVMk3N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX8u6t4g1Vt6GC
 +VPSskN63vHHcTKvIYH4judjW1OuW0le1LgxC4AjrnwdqtgQm1ZP7wC3NU9bOqnqfHN/U0w6ENF
 L0faWsaHrOi5kbOQZuUAivtjaL6/Lw4=
X-Proofpoint-ORIG-GUID: sa6fKmT46F8-35g2JtmvgmU5mEdVMk3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092

Add a first document covering the Qemu s390 CPACF instructions
and functions supported.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 docs/system/s390x/cpacf.rst  | 116 +++++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst |   1 +
 2 files changed, 117 insertions(+)
 create mode 100644 docs/system/s390x/cpacf.rst

diff --git a/docs/system/s390x/cpacf.rst b/docs/system/s390x/cpacf.rst
new file mode 100644
index 0000000000..85f35b4e9c
--- /dev/null
+++ b/docs/system/s390x/cpacf.rst
@@ -0,0 +1,116 @@
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
+Documentation about CPACF instructions is public available and
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
+Not listed CPACF instructions (KMF, KMO) cause an Operation Exception
+when used. Not listed functions cause a Specification Exception when
+called. If only the query function is listed (KDSA), then the query
+function will return a function status word with all but the query
+function bit set to 0.
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

