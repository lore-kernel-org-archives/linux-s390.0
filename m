Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F737F30C;
	Thu, 27 Aug 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845988; cv=none; b=oTOpgI5lXT1QtoxC6x1XmnkYPW5T29JX9vCNN8pIHjXKkAdFSzn/Xk5nf/s41bko21ZpDAWCW/wTJ3rooDafjSRQ0GYxfilbhSehJlzk4lXrWk+tDtWvsj4tWI9u1XtB83JR7qsoUpqjCDPHNCkk42vTB3Nz0fbstwF2rrlmj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845988; c=relaxed/simple;
	bh=RlOK7+/85o8NyNvhDLpEVWXMj68PMLlOpTprYyd4VS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HRErNMo1R3hDWrBgUn1dyuCUxctYRWofxt8xTUcLZd0EisAx/oj9UdhB5PKHQuGePl2cUD+cA+JAABUl6l9VH7ox3j3W11n4skrmFhrjseXz32neB+6a7CHnD0IvhP4S7DccL93wS/vXi3osjaLGxA7gE2fAmGamjDucGoBk1P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a+SNH44/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a+SNH44/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF58xI1478404;
	Thu, 27 Aug 2026 15:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0k8JNq
	C3APBMkYIH0AhM7AanL22iurBvxOljn1RJRjk=; b=a+SNH44/yMRKWFTgVIp+rE
	WDGRjQHh1QGI8kG+7eJfQu4Cg8OXeDfqqK2X7MCZCKn83ZPUM9LEk1T+DkGnGJN1
	dSRWejGfqGNe+c6Hv67UfNDIffx3qXh9y8g+FOJgzz9FL1pMk+utd9/jd4CxasaM
	tCcr84rNpvKrfDI/70Wq1j+rbV7wOvOO/gpNRC6bSakd62/if0YWPryhP55FYCyp
	CZ7w2AkmRQ1vYE+GE53hDN+iLiONQdx0wHQ6uDOF+G2mIW6kK+/pM/pxUhZJ73Qd
	yMoulBOrZkw60wx0pbiwCE0um31r0v1kAFIHw6bJE+4X0I/eTII3uhsedmVOnQFA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er6b89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfk3h015154;
	Thu, 27 Aug 2026 15:53:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwgyyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFqvoF50201052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:52:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B4692004B;
	Thu, 27 Aug 2026 15:52:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 547E52004E;
	Thu, 27 Aug 2026 15:52:56 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:52:56 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:44 +0200
Subject: [PATCH v6 04/21] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-4-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoOCZ4uWtQluvCP05TnX5OAHXE5TJLO/Hb648vU/3
 Te1Oyc4dZSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjART01GhlNfl8sIvUhyyTZ1
 m3mC5cXPSwsbP9beP947bx77PNH0poWMDO+NIoSF/t/OCMmMkbhxPnjf9SPO2TZTgzt23lP4rT7
 HihEA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Gge00735JdiXbGt-RDg_YCc3G6Dj4KpX
X-Proofpoint-ORIG-GUID: -KCKZr4FQIGosZbPFEbWwzBKWRtAZsU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX1wYNLd9QLuf2
 s7Vuq50uHyHjbfM8q4+hpMX2ZFwMI8Vm+i4D9Y9RLBhQGImI81cPsZpvA8PtslNxLMm4ZdqL3yf
 ARvWWQJOHAknW3ZDNgTa+xab/CRxUjr+XB50NuJXWf2Wrjh+HzZMVmPQsngyeHeyoSUeZg0LRJw
 b8GPvGTMTvNIHPsIt/d/anzKpVVuTou69413uCz/GcTKkZ/4CLgWnyZBg1I2penOBX8hGxu68tm
 ae1mY2MSV9/vkfAGbtXOmo0ch67aJQxrZbjpcwe3w9Py+/Qh1EEwNOLIKV3oxcj8m4bz4s1kzvz
 ER6ZaHw/fMqgxA1IjzPZauqw1PeIWCVN1j27zf3tt3hXvMSmP/DcZQLJ+TgrJ9rM8FD9bwjpRPj
 RN5DJe2fOxNndQnvyQUNGvir1ncm3O2ECNq8qpuUXfl9kfHyFNoV2T52za0ozkEm3iO8i+VzYeJ
 MdbLgTLV7pBJ3YhjFjg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a905d5f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KXQrNVq8KaMVEL7Tj7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX3nafvVkfqwBw
 A07+s+qWz3Ux2WVumVzihGrYY2Ua6kXbosMPpI5gJ0Znu8GFuQEmsuNpc2Bkp2bwPu3tg/9FZ8Q
 kC4KWF/YrnK2aEYhdWXLbTW38rjLeoM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

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

