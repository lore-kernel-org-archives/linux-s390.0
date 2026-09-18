Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0A4FECDD;
	Fri, 18 Sep 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744182; cv=none; b=crUAEFuY40AojNfxQ36Y0FCvvX5REqJL+WdSyX1dFxDb0uvIuQUxqroIz1X2BzZ7uvSoBSssFaopAIsnRRsJcEeVaKm2AT4AKoXlyIP7bu+x46fEpnjP1AoXUFNWRh8KGz4d4EGSmdJl1EA6Y7V6WllsDAgw6/UwPvgl63ZMYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744182; c=relaxed/simple;
	bh=RlOK7+/85o8NyNvhDLpEVWXMj68PMLlOpTprYyd4VS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iROzs7o/FozUU43xDPL7m/mdhlPV/HKj0uPftUYIqk8zhAjbSdFpx21YcS/n6Bf41kGITMwFIfUfhMuzwzkGptJ6JVdF7nAjg4as1ww9Hqlk/YpT6iXzK2MUbkQ/HbsYqsK0B3G4XegwnWl3bPaegWWfTu+2LX7LvWwnDiA0NJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sZQHVxHy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sZQHVxHy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVqv01421721;
	Fri, 18 Sep 2026 15:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0k8JNq
	C3APBMkYIH0AhM7AanL22iurBvxOljn1RJRjk=; b=sZQHVxHyCXxMUnMLGIw9qd
	/WgV0f2hGMJL/B41g51tRTz7m6A5HEQXhwV3QcTuNOnMOkeZIKva4JDt72WlpqT+
	Z/9WQC6lNg9QO81EyeH98e3jvKr6WZGbJbsCfYJRJgoruuJxAsQamXvrGxcYxARM
	NgPKlAVW0qbL7l6JoZ14rscwUbZ3dp92BR7Mlrto95c1HnSaR6NwvQXySwKtu5vz
	6Tgi82Dhn1R6+TdIkrbWmSSxhZ7ZVWBC7e/azXnuEawUhjTKgyJVogtPqUOvGt9O
	Vjx1LV2aE8DE6+DLkcHfzIx/JP3HzaNf48W6tvTVNsVI5zJEY/C3dsHlG5ojM41w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvg4v0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO5Zg777752;
	Fri, 18 Sep 2026 15:09:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yxxr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9P8Y52429150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D166220040;
	Fri, 18 Sep 2026 15:09:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DD6B20043;
	Fri, 18 Sep 2026 15:09:25 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:25 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:21 +0200
Subject: [PATCH v7 04/21] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-4-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxSbrCfOP2A6Q/v+XJukBS6GrvG7Xkx+Y3ThqcCij
 WGrUmMzO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZhI8X9Ghlln52x5YOxcorjl
 x9VHq37bhMz4/vKABku/56c5QvWME64w/PdKLvqzKvLhPJ8kd95r26bZrP1Wc79VbqrQ7ew7iWe
 Mw5kA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX2+M66lahvjgf
 2GOlW1wCkeqsasJwbBS6pMGoDqJ7fxuaLb0DehNGD5y8+CUKcT7MZdJ83tynGxHGtjF3kpQG6zv
 FdMs4De4vYNr2U2xbS4HI6wfmHWEIR8=
X-Proofpoint-ORIG-GUID: sZdPNvvJTcNeB8_81V3JJOdKG-wUuNNX
X-Proofpoint-GUID: _nz1pI0BXRm6SIYYHL1qiCZ8c_M-28Gu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXynbX7aMRlMWP
 PmEXzZ7XdqpwZLktiMreYjZ0Z6Y3yvYNFDrvQ739P/BcfjVIvOydwZd4D4xEygBiBLJHZAtyQYY
 QxobySMo7Qj1G2hOinB/QxrcR/2Efy30zjwh9tRjkkY9RrEXuoClGLsjehpwSXmfEUZWRQ4qJDS
 3pH/NWKvJvm/ZmXdLtOX63MaQHelG8UiIF3Lc2TzPQV8PMax/V8waA7z2u0twJiDvL79PAe0gNn
 n6wZpk5dA6tbXF+QXzQ9ZZTD5lWi2klQ4xH/+URoZD7dRd5DH8PWsL534NFTh7VFk2jIlqQq9iA
 T/nMSahnhRINPZ8jswtj5gxUPODj3ZzwIXLgwSqpE05iuKWpu65weLm6W7gOM6w8aybYeTcmJ9c
 Oq/gk+PY/xw6wwn8f55Cg1lTNEt2zD+5+Xu7MFF4/YwSsw54KkIJ8EPFp+skJDSFnLy7WM4MvTB
 ftxNt5u7c0tKTdyKBrQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad542a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=KXQrNVq8KaMVEL7Tj7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

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

