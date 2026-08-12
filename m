Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F8E44C678;
	Wed, 12 Aug 2026 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542774; cv=none; b=pJsNFPcloTRaqv2uZi7KuVmKQKRwZZqYTeY2Q/YK/26XJZacnqobqtU1O9nxAURZSZURlK0owbReSTpczgJAhvbJTTWdnO0OkBgmYfp4kmHgxY3Sl2teMpGhautqWC2052ACQaFYHm4lLcP8+sD5szuna0F0hxPIz0Jg3liFNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542774; c=relaxed/simple;
	bh=WBghKP3JJ9FqfT0kBOoaQAPiNXUTe+EA2Aj+VhLH8so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9w9NbpLRZ0NgCIzDLPjdQm8A+ochmGsnqT2fRsGQG3L8KcTpD7fZPpwj0TPNUADaobCR27APlBFszjU09SzaPSIQQAklefmfC1cj371PMMIx/C2RMjHXTGqxxXjFkp5wa9Qyz/xyoFIftSysjQjv/LW9O1wlkYkI9Rh3bl5ZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dihSkKRs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dihSkKRs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3flp1433941;
	Wed, 12 Aug 2026 13:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YNxbCr
	veTw1nBNCfBwCbxf53SzIancyUCVac4rcCuFE=; b=dihSkKRsafGFrwWPuppcwP
	RXnjHqiIVVF83hDUGN2NiT1CMC5osug6b4nuvPSaBgMFyWGBKUyrWge2B16Hoicr
	w5D6xlGrs3xYPEW6yXZ4uEsFvRLWEz/v4Ie6TUNzhqpwKVbOUQQwHLTq4Na8a1Rl
	t0ty9OYSRq/iqr5Nx1gc3b/UHyMzoqPjOBlp73N8TTV2nHNuufND/BaC4GpBp6wf
	DH6Wp7Df9tkv4ma0vO4P2ErHsE6YgnBOr6l8X2cBdjMwGx0DwOUF8sX5If7X5L2M
	4/y+F3QL9bdvo817JInn/zhm8cQrPhViM+EdsgvmKeQeWGhEknyVtBDWc527JbyQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk02q0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDflCJ012373;
	Wed, 12 Aug 2026 13:52:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h66dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqbMo42009076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E0DB20040;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 701FD2004B;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:33 +0200
Subject: [PATCH v4 04/20] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-4-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2848;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=WBghKP3JJ9FqfT0kBOoaQAPiNXUTe+EA2Aj+VhLH8so=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYum7d6uoJg++bWy1CHeO2ZnplvwXlunnn0p0H5RS
 pn8jMw5HaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzk1WVGhle2Nhxrgh6KXL4z
 7eUCwYAHrecMH3/7d+Taj//xVTbd57IY/pe/s17J8LrMWeRwRfJ5FoW/RfNCJmXsKnvdseLEh2z
 jrWwA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfXx57kLb3MYpEk
 SYGViF4uHzXnMtLUOefpZqxCsXgdyoP4MzvzvUNjbuNW58Pyozgw87AXnQ0JOGcxAJunrVam3Dz
 D4jtxnNzL9mpD6TiU5quU/3eRVWu4di28pBXwI61hbonXhsx8ay9hPo9atdPLdjimkwvrLZmiu6
 o7AkUb9MVJ+q0ekULjmE45baRanTKco5e7T+4Hgdbr9YDt/37KpfZDXRJ1JuxFCHCOJU9ynE8ur
 VlMhJ82sP1MD+6S4fmi0adPNLLE40cT19HWvND8CUn1E5qbUYO1tQ6gKp5g84veUhYLyIW5frF5
 GxT41bJ+VbP/1VnEQhzrKjPgMcvkg5luJVkCXoFZRDgj/khdvwFGAAXxSe3nc2ltvM+26oUr98D
 tFgM5JRfcTvG53d+Oh0sJl3Uz4TGwb9YGVRNGfDe2w8RXi9lc/QTPLnT2mJXMFhb/GPK6D/YnD0
 kdZ9rZCH6GkEuK1TTtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX8ExRSbtAPeCh
 1SCCZ5ZOClT54FwgRlzV6wP31gGOHibtOTx6SsvIy/UX4INCDIqaG7j2WzjRsAKbI74guH7KauD
 cihKRtUTMU4xqxYQGxdVkCowbsUpbE0=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c7aab cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KXQrNVq8KaMVEL7Tj7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KGN3LO6eXFT4dKhFp5WmYmzWazQS0Z3I
X-Proofpoint-ORIG-GUID: KGN3LO6eXFT4dKhFp5WmYmzWazQS0Z3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

Add the required guest-1 structures for the ssca to the SIE
control block for use in later patches.

The shadow SCA features the address of the original SCA as well as an
entry for each original SIGP entry. The entries contain the addresses of
the shadow state description and original SIGP entry.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
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

