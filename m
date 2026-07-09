Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2E351C27;
	Thu,  9 Jul 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610134; cv=none; b=emQQ16sm9RiXeAnroYafIrt//33MPPue5kOcXRNO6ktA/WzQ+cSrwlX6c5Fjqkmhn91r8JPaf8AaJVJsDhpypdARAQceAgMGJSZncvTwihmLj8CVz2WVcE8HogEFUVqGQTwch85lKALfzIqjeLnVFNchHD5MEKjYMQ/5VENOz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610134; c=relaxed/simple;
	bh=UHYGmlc0PJjhX1HLorNbf1nHMP1buWPLONO5CYOekYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWWoZDCro0IB8/MMUS8FooU0ZsRo45fQsEN+QqFqfAL4RL67GiIxnbx57PgeAWQKBW4dqcwb4TqTyBRhckmiHqW0YcMDbn0A2s0u6Mh2AP27LV/06XO7niUFMTlWFGKQADvWsm/KU95VZN3lJ5Yd6wke+e0fcfu5H3MnUDta2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R93LsUsX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R93LsUsX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EISx21496698;
	Thu, 9 Jul 2026 15:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=odgWUh
	rAOpgsaMtewbnw8oqYuCylfFMkSi6ImAqUxmY=; b=R93LsUsXqOumaDcT2RkI+W
	HbNxUFaJbdwyGRUojR3QJYtEhGpQxUp+76b7mMEkkTpZfeOs29+zWL2RumcW7flo
	Azb9rm0qYZOa1F3KwtNlOi8Y1HCRv7fmTUv21fFoerPS7A+F5aJF8ncbZtgk5tJZ
	N8Zhbl4WeZrj/H+QLt26z8dVf10B9ivWwyTOjlbGMrHOoBCEqE1cIvec3ctGpISY
	CZKbh0X9LahCje2qlzNyTjHll24us5PqwfdEQHPdRUdB7OK0Pihb4BzltCSur/Im
	RBK/W+8kKlXPEkmU746Q1BnTMO75n7t7ToQjxHpNL9SriCCYmXlqMa0e4TwZWn+g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt2m0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669Ent5G029174;
	Thu, 9 Jul 2026 15:15:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkdpdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFODX59179392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C65420040;
	Thu,  9 Jul 2026 15:15:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D63B2004B;
	Thu,  9 Jul 2026 15:15:23 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:23 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:07 +0200
Subject: [PATCH 07/21] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs for vsie_ie
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-7-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2817;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=UHYGmlc0PJjhX1HLorNbf1nHMP1buWPLONO5CYOekYQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u5lPKqTfeC9gPv98ScXuux7rFBkvxqdx8nK+W5v4r
 WY7/2vTjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACYyXZzhn9aib7MseqOmJLwv
 VJxoZPtb07Rg8pUVOqGf1x/WKdi3TIThn+qUnZ47TH1y7stxfj/QsNX/7+mwTxe7t/zawnhZ9RF
 7HzMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dz4F1BgKowIpucO6iebwoYEhRnmmaA8_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX1H4P+2GXnIBW
 cDhwD1iNRLzMqsxd7AfkmnLEONlTEQ4ZY7mNhUylHOzKxx0d3TVuynSsy5+eycnBI4Aa1jJ6Mv4
 pWCQuqBgnH0zeEnhPEIxIBfFLhhgK6A=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4fbb10 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=KXQrNVq8KaMVEL7Tj7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Dz4F1BgKowIpucO6iebwoYEhRnmmaA8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX9tcJBrsQ4n1H
 6YMbTQR8un+rH8OhyfVeEbmoayUZ3y4FUPRy3kJY+OKQULxjL/uQs9oyay2LzzZgzAwXzi3koxz
 8L8ZCG7pegMnI+Npx1JeCF0yNzGAKvFJ8yJYxNf78g+BCkfQYjfqtSWB5F4qJHNtw8oXThQQRkV
 MDUqwLWAFl2deEv+6QfO47ByQ1oVsCllB9aXpHhNSUdBX/n69AucBQxcCSEAZ2z7wuRjNQ0FdD7
 4YBLCVzYuaK4m2o9BbnP80O9LxinNbgR4l8eSpm82T7O/HCf0nTQpQMiodPvNNc9r6yzQfx0qVH
 4PRSWWez9yPy4TKG8GFKYvfcJByrOj9/OK87QRa3awDYXcjZNI7fqpaMdmIV/upgChF6wTFCnuD
 q+Fw76MhmsnPU51b5gr5T6Evqf78VCBjWUE+5T39pxOsx1aSuEWd4uSaYYete54G1q4xVZEwnPT
 /CYBX3V95f7b6ZX/9Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090146

Add the required guest-1 structures for the vsie_sigpif to the SIE
control block and vsie_page for use in later patches.

The shadow SCA features the address of the original SCA as well as an
entry for each original SIGP entry. The entries contain the addresses of
the shadow state description and original SIGP entry.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_types.h         | 25 ++++++++++++++++++++++++-
 tools/testing/selftests/kvm/include/s390/sie.h |  2 +-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
index 3f50942bdfe6..6540146b4b00 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -6,6 +6,8 @@
 #include <linux/atomic.h>
 #include <linux/types.h>
 
+#define KVM_S390_MAX_VSIE_VCPUS 256
+
 #define KVM_S390_BSCA_CPU_SLOTS 64
 #define KVM_S390_ESCA_CPU_SLOTS 248
 
@@ -45,6 +47,13 @@ struct bsca_entry {
 	__u64	reserved2[2];
 };
 
+struct ssca_entry {
+	__u64	reserved1;
+	__u64	ssda;
+	__u64	ossea;
+	__u64	reserved2;
+};
+
 union ipte_control {
 	unsigned long val;
 	struct {
@@ -86,6 +95,20 @@ struct esca_block {
 	struct esca_entry cpu[KVM_S390_ESCA_CPU_SLOTS];
 };
 
+/*
+ * The shadow sca / ssca needs to cover both bsca and esca depending on what the
+ * guest uses so we allocate space for 256 entries that are defined in the
+ * architecture.
+ * The header part of the struct must not cross page boundaries.
+ */
+struct ssca_block {
+	__u64	osca;
+	__u64	reserved08[7];
+	struct ssca_entry cpu[KVM_S390_MAX_VSIE_VCPUS];
+};
+
+static_assert(offsetof(struct ssca_block, cpu) == 64);
+
 /*
  * This struct is used to store some machine check info from lowcore
  * for machine checks that happen while the guest is running.
@@ -315,7 +338,7 @@ struct kvm_s390_sie_block {
 	__u32	fac;			/* 0x01a0 */
 	__u8	reserved1a4[20];	/* 0x01a4 */
 	__u64	cbrlo;			/* 0x01b8 */
-	__u8	reserved1c0[8];		/* 0x01c0 */
+	__u64	osda;			/* 0x01c0 */
 #define ECD_HOSTREGMGMT	0x20000000
 #define ECD_MEF		0x08000000
 #define ECD_ETOKENF	0x02000000
diff --git a/tools/testing/selftests/kvm/include/s390/sie.h b/tools/testing/selftests/kvm/include/s390/sie.h
index 160acd4a1db9..4ff1c1a354af 100644
--- a/tools/testing/selftests/kvm/include/s390/sie.h
+++ b/tools/testing/selftests/kvm/include/s390/sie.h
@@ -223,7 +223,7 @@ struct kvm_s390_sie_block {
 	__u32	fac;			/* 0x01a0 */
 	__u8	reserved1a4[20];	/* 0x01a4 */
 	__u64	cbrlo;			/* 0x01b8 */
-	__u8	reserved1c0[8];		/* 0x01c0 */
+	__u64	osda;			/* 0x01c0 */
 #define ECD_HOSTREGMGMT	0x20000000
 #define ECD_MEF		0x08000000
 #define ECD_ETOKENF	0x02000000

-- 
2.55.0

