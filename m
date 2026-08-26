Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351C43F089;
	Wed, 26 Aug 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756729; cv=none; b=LoRy6E33Q9/8oZDnFz7Xxel431dDL+xvEePAsrr9N8aL38yayb5IILfNeMf3tDbNVofMSW2OVF2voqZGdsbsLPw+4fxWLY00bqtVFO5F7dpPSZyphHWey6H5sBOcEfabxNtL+kaf/5OIeHuWl/rvd3uF3GwiBtPQpkqlYg4f/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756729; c=relaxed/simple;
	bh=RlOK7+/85o8NyNvhDLpEVWXMj68PMLlOpTprYyd4VS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbNflASPenZ0DiQrno+AW/MYRmQfc/I/vdsRP31xJ/uOo+heW8FaPArMxHZKazUWpMIJhRSWaxtKjaZxJh1SI3an0wsKhKUc46vccbVVTXxH1rJtpxf54Svgbh5hKBJya1lUnLIeHa81Y/NsSGkpHmGHqlnAw3/3jPueD3v5Vzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nMsjgRYb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nMsjgRYb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1WKe4184853;
	Wed, 26 Aug 2026 15:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0k8JNq
	C3APBMkYIH0AhM7AanL22iurBvxOljn1RJRjk=; b=nMsjgRYbq3ykF5ryTF3EW2
	6rViiKnx7NbgWR5wdL5vN5e0QDyi0758xP3HaBS4rnGjqI7gJxDuSuoM80KZkXo8
	yZcALayBxRgRiaOAI+osbl+KqZ+nNsuUCwJSzunEGm6SJEca/7HwmKMSxifnYx3z
	KxzDpoLjlcz2tQw1iNSi+Yhmnc7JenUst4GYdgVI2Lz6tA9UBRr5lBLP49JUP7eg
	lRJzAMvoPXFHD/N9UDqZf5P85thExHWsgQ2aEQib1tqTkjQ+Lkq3v2ztF90z59oY
	Px/8PzrblzsVxkrMpfsWWgvxTQ3xsRnFC396rcKmu3joq3bKHmjyonZLS3KfxKww
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73947ew5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuIid015627;
	Wed, 26 Aug 2026 15:05:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhagwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5HOk43778344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8FF420040;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BE4620043;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:06 +0200
Subject: [PATCH v5 04/21] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-4-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=RlOK7+/85o8NyNvhDLpEVWXMj68PMLlOpTprYyd4VS4=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKtO+WQsOs26QOeg9O4fH9Xyd09tWDz/7lE9IY7u4
 /yrKvqndZSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjARrR2MDH+nZv3Z3VMzNUPx
 5O2AOTlLOVnqY8/OWHpotVGLme62+x8Z/seZ19gVdk19MosjzNuYnzny5eSGeYtfLIhNfb4gb+H
 bxbwA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: jXlXhIY4MHd5UA8zRJ0l-G_SWXhkegZu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX+VnhwtdVXgMb
 olMIMRnonuHga5OqSPITcnAXZJwHTHx2C9kKWz6yrthUsuS069J+qECNiKgwG1NexiNKw2zR+rI
 EHEYwBZHD0iclnct3GSlFvIgD1j2eGpJZGmCo/P6Rs+q/aLzpNHyHjFdmwN4odJafuvDc0vUWz+
 FDQtDoJXA5JgjfO7PiaRSnRxtQyrhaVngxJ/QQKc0X/rKy8/hzBq5yPxYapLJIiU57BocDo2Fc3
 H9Ejq3w/BZgZvMBXs6MuUINo8yiIFUEn7Nvy4K+pFSr1/j6XuyGPsf/GJL0UVyvPzgai8B6TcS+
 G9huWBOMkYYykogpXNjj1zcvmYg3kLifqIRw972S+ZF8QanqgtNmpps6jRwkUjzuARFjURHaTcB
 rum5fwqhwf52ibgKvshpEv2qC7ZY+YRSlP81JvyRTTd4i65H1sXr4nxMIIyfOv2xD3+o6r5IQk3
 alYi34WFTkhL1KWfWCA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8f00b3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=KXQrNVq8KaMVEL7Tj7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXz4AwiXYvBj47
 P/CM984rKNq4StapVncFiv3ZjklXL98pi9dbjqHEQBdtjTZy5ex5xD2yE5+dsiORXEuJAdpQ5zb
 pLeRSm1ACSzElrySngb6/mfOoYC+UMY=
X-Proofpoint-ORIG-GUID: UnQTHJECiWNMgHEdeTEHPwaeubezaKVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

Add the required guest-1 structures for the ssca to the SIE
control block for use in later patches.

The shadow SCA features the address of the original SCA as well as an
entry for each original SIGP entry. The entries contain the addresses of
the shadow state description and original SIGP entry.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390_types.h    | 25 ++++++++++++++++++++++++-
 tools/testing/selftests/kvm/include/s390/sie.h |  2 +-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_s390_types.h b/arch/s390/include/asm/kvm_host_s390_types.h
index 9e348a530421..0b69e71bc8ee 100644
--- a/arch/s390/include/asm/kvm_host_s390_types.h
+++ b/arch/s390/include/asm/kvm_host_s390_types.h
@@ -6,6 +6,8 @@
 #include <linux/atomic.h>
 #include <linux/types.h>
 
+#define KVM_S390_MAX_VSIE_VCPUS 256
+
 #define KVM_S390_BSCA_CPU_SLOTS 64
 #define KVM_S390_ESCA_CPU_SLOTS 248
 
@@ -47,6 +49,13 @@ struct bsca_entry {
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
@@ -88,6 +97,20 @@ struct esca_block {
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
@@ -317,7 +340,7 @@ struct kvm_s390_sie_block {
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

