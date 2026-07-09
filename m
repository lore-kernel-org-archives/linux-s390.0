Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925C3876D6;
	Thu,  9 Jul 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610144; cv=none; b=dY5AW8cTI5jfWayvJilEU5tnB3Dp8sM3MSBoHxlHKGmZGSPuE/KcPeZy41UURIG3TQABQH/Ck+jfdU4t7+NTSVAPv2O27usYS95Pc77cbbUleHnNQPN/XmO8+IcYpN4SvfxmU3R8tfUDj36KOunxPFCKo0orduiBaDhT91EzRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610144; c=relaxed/simple;
	bh=/Qv/0vxPGPL6AeoZo1fukCfXgdU7V154S6/zt352ABM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJJZn6DFKBBJmfgAhrt5mzZXaWefof47fw/fN4P9K/j3ehXrtg9kGGnHKheu+kbq1JZboSj1AhVHBCSFU/7xBpldHEoq/i2DctspBHKj8EWxMp1i2UtOwFMpmkEmgcbz9A6cdWif0Xp1djTo8HD/r4o1LZjCiTQV61+/iajD+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BSLuCOcs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BSLuCOcs"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIH9w2408814;
	Thu, 9 Jul 2026 15:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aV3flC
	KsuMEZP/KoJP1XZa/glAhmT26t9i+v8VKfsh8=; b=BSLuCOcsKWJ6LB7h9LMzra
	LHZdLT8WoDK1lF7olluR/Pihymb++oQLO4mtbkW6q+8vN6o3mU9bTuRB+TouCEP2
	GOn+GfDPnE/qOMrJXBYYWG+XUS4o8OcqIwNuEaJLS2GnD9HdFOfqS13bflfcsbOy
	OmjeFh38zC7mgk4lQ5Hlw6mwJZJeZTlaW9m2CbkQr8UpVuWwgxxgkcySZkqgNBwp
	g1CRCishQvw0U1XY0PZc+Hh0gfuMsRJNoqZUa4gJCP/+2AMKPofo2lB9gcbwqNrS
	B/mdl0YSuAs4AmsNuOyVEMkwfwwrL6VxHraSNSGBCFmemSdcuo+MKr8MPXyRl0fQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp42e7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4dpO012241;
	Thu, 9 Jul 2026 15:15:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ydc29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFUPX46661954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 309BF20040;
	Thu,  9 Jul 2026 15:15:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C0C420043;
	Thu,  9 Jul 2026 15:15:29 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:29 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:16 +0200
Subject: [PATCH 16/21] KVM: s390: vsie: Shadow VSIE SCA in guest-1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-16-ea9f12066408@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=27695;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=/Qv/0vxPGPL6AeoZo1fukCfXgdU7V154S6/zt352ABM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u1k/efOmb63M+8T1UrHp3n7tnxV77IzP2BmyS59Xe
 DW3vC2go5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIlIrGb4Z7849tOlkI1qSruF
 wsJZMour2/6VbrNjXbPm++Snp76I8zAyPFiV/mnFQ+Y3T7Jse2cqpfLNk/ikIrHm2qG/ei5lj05
 N4AcA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4fbb17 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=HrsuKxA9y7BI6QpYe8MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXwoQgnyT7/EEX
 cRVylUmxfewolGSATYnAzU7IqjK5FJAwLOtKZ7u1GR+d5d+op6aV4soIJj6RQstEtF/vxp/fMRv
 Ywo88IRZWle+O490kVqNnz/tRlLwT14=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX/vfzZ7KoBi0X
 xnYF4o2yt9PVhMy/1apNyHiVMpBh0rbBvDRHB4fW8DVK4bW4eHT2jXic2PC2w06miPvFdF/KHWr
 we7GvKlSr0AU6W0Vupk2gIpCBK5C58hJjcD1T2X8WlYXOqKSjZLD4//E4Ll/1gFDn8rv7FwOUXb
 eM4188Xnu1KgSZtCkTpSGcXWO9bn+5FuY9Czfl2OHhG3kaFNe1wUdtKFAdSw06hqx/ourPvsWZv
 4aMf+eGqR0OJF32WVCR+Rl7w39UDozcjZ3Bci8amm/Lf4JIZySr/Kx6G0XTjGgXXbq10s5kM7BG
 Te86VL55rlskB5oT9YtslUayu9iVOUVG6jlsWpyxCTVNi/ioK09k5Nvy4OzvmntSyp+/uPgzoEE
 Q+tcy6QwrNS1ZJpYCIYUf3BaHCywnlDJC1AuOr5aEGWKQhP4GitBNyCKGnqUkbVmusZgxmzJl4J
 wjCob+WFuBWQxVg84jg==
X-Proofpoint-ORIG-GUID: oltpWUD1Cy_vrM38_p67qSFtTnxWIeZd
X-Proofpoint-GUID: oltpWUD1Cy_vrM38_p67qSFtTnxWIeZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Restructure kvm_s390_handle_vsie() to create a guest-1 shadow of the SCA
if guest-2 attempts to enter SIE with an SCA. If the SCA is used the
vsie_pages are stored in a new vsie_sca struct instead of the arch vsie
struct.

When the VSIE-Interpretation-Extension Facility is active the shadow SCA
(ssca_block) will be created and shadows of all CPUs defined in the
configuration are created. SCAOL/H in the VSIE control block are
overwritten with references to the shadow SCA.

The shadow SCA contains the addresses of the original guest-3 SCA as
well as the original VSIE control blocks. With these addresses the
machine can directly monitor the intervention bits within the original
SCA entries, enabling it to handle SENSE_RUNNING and EXTERNAL_CALL sigp
instructions without exiting VSIE.

The original SCA will be pinned in guest-2 memory and only be unpinned
before reuse. This means some pages might still be pinned even after the
guest 3 VM does no longer exist.

The vsie_scas including the ssca_blocks are also kept within a map to
reuse already existing ssca_blocks efficiently. While the map and array
with references to the vsie_scas are held in the arch vsie struct. The
use of vsie_scas is tracked using an ref_count.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h       |  21 +-
 arch/s390/include/asm/kvm_host_types.h |   2 +
 arch/s390/kvm/vsie.c                   | 575 +++++++++++++++++++++++++++++----
 3 files changed, 528 insertions(+), 70 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 1439f9496bd0..c0e5caf0eb16 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -621,13 +621,32 @@ struct sie_page2 {
 };
 
 struct vsie_page;
+struct vsie_sca;
 
+/*
+ * vsie_pages, scas and accompanied management vars
+ */
 struct kvm_s390_vsie {
 	struct mutex mutex;
 	struct xarray addr_to_page;
 	int page_count;
 	int next;
-	struct vsie_page *pages[KVM_MAX_VCPUS];
+	struct vsie_page *pages[KVM_S390_MAX_VSIE_VCPUS];
+	/*
+	 * The vsie_sca_lock is used to synchronize access to
+	 * - the kvm_s390_vsie.scas[]
+	 * - the kvm_s390_vsie.osca_to_sca map
+	 * - new vsie_sca creation and initialization
+	 */
+	struct rw_semaphore vsie_sca_lock;
+	struct xarray osca_to_sca;
+	int sca_count;
+	int sca_next;
+	/*
+	 * In addition to the use of the array when entering and exiting vsie the scas[] is
+	 * accessed from the gmap_notifier without any lock held.
+	 */
+	struct vsie_sca *scas[KVM_S390_MAX_VSIE_VCPUS];
 };
 
 struct kvm_s390_gisa_iam {
diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
index d6025b34a66d..ae0c56393475 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -6,6 +6,8 @@
 #include <linux/atomic.h>
 #include <linux/types.h>
 
+#define BYTES_PER_LONG 8
+
 #define KVM_S390_MAX_VSIE_VCPUS 256
 #define KVM_S390_MAX_SCA_PAGES 5
 
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4b492af15542..74455c689c51 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -86,6 +86,7 @@ enum vsie_sca_flags {
 struct vsie_sca {
 	struct ssca_block	ssca;
 	struct vsie_page	*pages[KVM_S390_MAX_VSIE_VCPUS];
+	/* The mutex is used to synchronize access to the pages[] */
 	struct mutex		mutex;
 	atomic_t		ref_count;
 	gpa_t			sca_gpa;
@@ -120,6 +121,17 @@ static void write_scao(struct kvm_s390_sie_block *scb, unsigned long hpa)
 	scb->scaol = (u32)(u64)hpa;
 }
 
+static inline bool use_vsie_sigpif(struct kvm *kvm, struct kvm_s390_sie_block *scb)
+{
+	if (!kvm->arch.use_vsie_sigpif)
+		return false;
+	if (!(scb->eca & ECA_SIGPI) && !(scb->ecb & ECB_SRSI))
+		return false;
+	if (!read_scao(kvm, scb))
+		return false;
+	return true;
+}
+
 /* trigger a validity icpt for the given scb */
 static int set_validity_icpt(struct kvm_s390_sie_block *scb,
 			     __u16 reason_code)
@@ -822,14 +834,18 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 }
 
 /* unpin the scb provided by guest 2, marking it as dirty */
-static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
-		      gpa_t gpa)
+static void unpin_scb(struct kvm *kvm, struct vsie_page *vsie_page)
 {
-	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
+	hpa_t hpa;
 
+	if (!test_bit(VSIE_PAGE_PINNED, &vsie_page->flags))
+		return;
+
+	hpa = virt_to_phys(vsie_page->scb_o);
 	if (hpa)
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		unpin_guest_page(kvm, vsie_page->scb_gpa, hpa);
 	vsie_page->scb_o = NULL;
+	__clear_bit(VSIE_PAGE_PINNED, &vsie_page->flags);
 }
 
 /*
@@ -838,19 +854,22 @@ static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
  * Returns: - 0 if the scb was pinned.
  *          - > 0 if control has to be given to guest 2
  */
-static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
-		   gpa_t gpa)
+static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	hpa_t hpa;
 	int rc;
 
-	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+	if (test_bit(VSIE_PAGE_PINNED, &vsie_page->flags))
+		return 0;
+
+	rc = pin_guest_page(vcpu->kvm, vsie_page->scb_gpa, &hpa);
 	if (rc) {
 		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		WARN_ON_ONCE(rc);
 		return 1;
 	}
 	vsie_page->scb_o = phys_to_virt(hpa);
+	__set_bit(VSIE_PAGE_PINNED, &vsie_page->flags);
 	return 0;
 }
 
@@ -898,6 +917,74 @@ static int pin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
 	return 0;
 }
 
+static int get_sca_entry_addr(struct kvm *kvm, struct vsie_sca *vsie_sca, u16 cpu_nr, gpa_t *gpa,
+			      hpa_t *hpa)
+{
+	hpa_t offset;
+	int pn;
+
+	/*
+	 * We cannot simply access the hva since the esca_block has typically
+	 * 4 pages (arch max 5 pages) that might not be continuous in g1 memory.
+	 * The bsca_block may also be stretched over two pages. Only the header
+	 * is guaranteed to be on the same page.
+	 */
+	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags))
+		offset = offsetof(struct esca_block, cpu[cpu_nr]);
+	else
+		offset = offsetof(struct bsca_block, cpu[cpu_nr]);
+	pn = ((vsie_sca->sca_gpa & ~PAGE_MASK) + offset) >> PAGE_SHIFT;
+	if (WARN_ON_ONCE(pn >= vsie_sca->sca_o_nr_pages))
+		return -EINVAL;
+
+	if (gpa)
+		*gpa = vsie_sca->sca_o_pages[pn].gpa + offset;
+	if (hpa)
+		*hpa = vsie_sca->sca_o_pages[pn].hpa + offset;
+	return 0;
+}
+
+static void put_vsie_sca(struct vsie_sca *vsie_sca)
+{
+	if (!vsie_sca)
+		return;
+
+	WARN_ON_ONCE(atomic_dec_return(&vsie_sca->ref_count) < 0);
+}
+
+/*
+ * Try to find the address of an existing shadow system control area.
+ * @sca_o_gpa: original system control area address; guest-2 physical
+ *
+ * Called with lock on vsie_sca_lock.
+ */
+static struct vsie_sca *get_existing_vsie_sca(struct kvm *kvm, hpa_t sca_o_gpa)
+{
+	struct vsie_sca *vsie_sca = xa_load(&kvm->arch.vsie.osca_to_sca, sca_o_gpa >> 6);
+
+	WARN_ON_ONCE(vsie_sca && atomic_inc_return(&vsie_sca->ref_count) < 1);
+	return vsie_sca;
+}
+
+/* Try to find and get a currently unused vsie_sca from the vsie struct. */
+static struct vsie_sca *get_reuseable_vsie_sca(struct kvm *kvm)
+{
+	struct vsie_sca *vsie_sca;
+	int i, ref_count;
+
+	for (i = 0; i < kvm->arch.vsie.sca_count; i++) {
+		vsie_sca = READ_ONCE(kvm->arch.vsie.scas[kvm->arch.vsie.sca_next]);
+		kvm->arch.vsie.sca_next++;
+		kvm->arch.vsie.sca_next %= kvm->arch.vsie.sca_count;
+		ref_count = atomic_inc_return(&vsie_sca->ref_count);
+		WARN_ON_ONCE(ref_count < 1);
+		if (ref_count == 1)
+			return vsie_sca;
+		atomic_dec(&vsie_sca->ref_count);
+	}
+	return ERR_PTR(-EAGAIN);
+}
+
 static void free_vsie_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
 {
 	free_pages_exact(vsie_sca, sizeof(*vsie_sca));
@@ -905,7 +992,131 @@ static void free_vsie_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
 
 static struct vsie_sca *alloc_vsie_sca(void)
 {
-	return alloc_pages_exact(sizeof(struct vsie_sca), GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	struct vsie_sca *vsie_sca;
+
+	vsie_sca = alloc_pages_exact(sizeof(*vsie_sca), GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (vsie_sca)
+		mutex_init(&vsie_sca->mutex);
+
+	return vsie_sca;
+}
+
+/* Clear the vsie_sca struct but keep the vsie_page references and ref_count */
+static void clear_vsie_sca(struct vsie_sca *vsie_sca)
+{
+	static_assert(offsetof(struct vsie_sca, pages) < offsetof(struct vsie_sca, ref_count));
+
+	unsigned long offset = offsetof(struct vsie_sca, ref_count) + sizeof(vsie_sca->ref_count);
+	void *vsie_sca_data = (void *)vsie_sca + offset;
+
+	memset(&vsie_sca->ssca, 0, sizeof(vsie_sca->ssca));
+	memset(vsie_sca_data, 0, sizeof(struct vsie_sca) - offset);
+}
+
+/* Pin and get an existing or new guest-3 system control area.*/
+static struct vsie_sca *get_vsie_sca(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb_o,
+				     gpa_t sca_gpa)
+{
+	struct vsie_sca *vsie_sca, *vsie_sca_new = NULL;
+	struct vsie_page *vsie_page_n;
+	struct kvm *kvm = vcpu->kvm;
+	unsigned int max_vsie_sca;
+	int rc, cpu_nr;
+
+	rc = validate_scao(vcpu, scb_o, sca_gpa);
+	if (rc)
+		return ERR_PTR(-EINVAL);
+
+	down_read(&kvm->arch.vsie.vsie_sca_lock);
+	vsie_sca = get_existing_vsie_sca(kvm, sca_gpa);
+	up_read(&kvm->arch.vsie.vsie_sca_lock);
+	if (vsie_sca)
+		return vsie_sca;
+
+	/*
+	 * Allocate new vsie_sca, it will likely be needed below.
+	 * We want at least #online_vcpus shadows, so every VCPU can execute the
+	 * VSIE in parallel. (Worst case all single core VMs.)
+	 */
+	max_vsie_sca = MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE_VCPUS);
+
+	if (kvm->arch.vsie.sca_count < max_vsie_sca) {
+		vsie_sca_new = alloc_vsie_sca();
+		if (!vsie_sca_new)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Now we're taking the vsie_sca_lock in write mode so that we can manipulate
+	 * the radix tree and recheck for existing SCAs with exclusive access.
+	 *
+	 * In the next lines we try three things to get an SCA:
+	 *   - Retry getting an existing vsie_sca
+	 *   - Using our newly allocated vsie_sca if we're under the limit
+	 *   - Reusing an vsie_sca including ssca to shadow a different osca
+	 */
+	down_write(&kvm->arch.vsie.vsie_sca_lock);
+	vsie_sca = get_existing_vsie_sca(kvm, sca_gpa);
+	if (vsie_sca)
+		goto out;
+
+	/* check again under write lock if we are still under our vsie_sca limit */
+	if (vsie_sca_new && kvm->arch.vsie.sca_count < max_vsie_sca) {
+		/* make use of vsie_sca just created */
+		vsie_sca = vsie_sca_new;
+		vsie_sca_new = NULL;
+
+		kvm->arch.vsie.scas[kvm->arch.vsie.sca_count] = vsie_sca;
+		kvm->arch.vsie.sca_count++;
+		atomic_set(&vsie_sca->ref_count, 1);
+	} else {
+		/* reuse previously created vsie_sca allocation for different osca */
+		vsie_sca = get_reuseable_vsie_sca(kvm);
+		/* with nr_vcpus scas one must be reusable */
+		if (IS_ERR(vsie_sca))
+			goto out;
+		WARN_ON_ONCE(atomic_read(&vsie_sca->ref_count) != 1);
+
+		xa_erase(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> 6);
+		for (cpu_nr = 0; cpu_nr < KVM_S390_MAX_VSIE_VCPUS; cpu_nr++) {
+			vsie_page_n = vsie_sca->pages[cpu_nr];
+			if (!vsie_page_n)
+				continue;
+
+			/* unpin but keep the vsie_page for reuse */
+			unpin_scb(kvm, vsie_page_n);
+			release_gmap_shadow_safe(kvm, vsie_page_n);
+			memset(vsie_page_n, 0, sizeof(struct vsie_page));
+			vsie_page_n->scb_gpa = ULONG_MAX;
+		}
+		unpin_sca(kvm, vsie_sca);
+		clear_vsie_sca(vsie_sca);
+	}
+
+	if (sie_uses_esca(scb_o))
+		__set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
+	vsie_sca->sca_gpa = sca_gpa;
+
+	/*
+	 * The pinned original sca will only be unpinned lazily to limit the
+	 * required amount of pins/unpins on each vsie entry/exit.
+	 * The unpin is done in the reuse vsie_sca allocation path above and
+	 * kvm_s390_vsie_destroy().
+	 */
+	rc = pin_sca(kvm, vsie_sca);
+	if (rc) {
+		vsie_sca = ERR_PTR(rc);
+		goto out;
+	}
+
+	WARN_ON_ONCE(xa_store(&kvm->arch.vsie.osca_to_sca,
+			      vsie_sca->sca_gpa >> 6, vsie_sca, GFP_KERNEL));
+
+out:
+	up_write(&kvm->arch.vsie.vsie_sca_lock);
+	if (vsie_sca_new)
+		free_vsie_sca(kvm, vsie_sca_new);
+	return vsie_sca;
 }
 
 void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, gpa_t start, gpa_t end)
@@ -974,11 +1185,13 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	hpa_t hpa;
 
-	hpa = read_scao(vcpu->kvm, scb_s);
-	if (hpa) {
-		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
-		vsie_page->sca_gpa = 0;
-		write_scao(scb_s, 0);
+	if (!vsie_page->vsie_sca) {
+		hpa = read_scao(vcpu->kvm, scb_s);
+		if (hpa) {
+			unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
+			vsie_page->sca_gpa = 0;
+			write_scao(scb_s, 0);
+		}
 	}
 
 	hpa = scb_s->itdba;
@@ -1017,9 +1230,6 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
  * This works as long as the data lies in one page. If blocks ever exceed one
  * page, we have to fall back to shadowing.
  *
- * As we reuse the sca, the vcpu pointers contained in it are invalid. We must
- * therefore not enable any facilities that access these pointers (e.g. SIGPIF).
- *
  * Returns: - 0 if all blocks were pinned.
  *          - > 0 if control has to be given to guest 2
  *          - -ENOMEM if out of memory
@@ -1032,8 +1242,8 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	gpa_t gpa;
 	int rc = 0;
 
-	gpa = read_scao(vcpu->kvm, scb_o);
-	if (gpa) {
+	gpa = vsie_page->sca_gpa;
+	if (gpa && !vsie_page->vsie_sca) {
 		rc = validate_scao(vcpu, scb_o, gpa);
 		if (rc)
 			goto unpin;
@@ -1042,7 +1252,6 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = set_validity_icpt(scb_s, 0x0034U);
 			goto unpin;
 		}
-		vsie_page->sca_gpa = gpa;
 		write_scao(scb_s, hpa);
 	}
 
@@ -1645,17 +1854,42 @@ static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
 	return vsie_page;
 }
 
+static int vsie_page_init(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, unsigned long scb_gpa)
+{
+	struct kvm *kvm = vcpu->kvm;
+	int rc;
+
+	if (vsie_page->scb_gpa != ULONG_MAX)
+		xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> 9);
+	vsie_page->scb_gpa = scb_gpa;
+	rc = pin_scb(vcpu, vsie_page);
+	if (rc)
+		return -ENOMEM;
+
+	vsie_page->sca_gpa = read_scao(kvm, vsie_page->scb_o);
+	WARN_ON_ONCE(xa_store(&kvm->arch.vsie.addr_to_page, scb_gpa >> 9, vsie_page, GFP_KERNEL));
+
+	return 0;
+}
+
 /*
  * Get or create a vsie page for a scb address.
  *
+ * Original control blocks are pinned when the vsie_page pointing to them is
+ * returned.
+ * Newly created vsie_pages only have vsie_page->scb_gpa and vsie_page->sca_gpa
+ * set.
+ *
  * Returns: - address of a vsie page (cached or new one)
  *          - NULL if the same scb address is already used by another VCPU
  *          - ERR_PTR(-ENOMEM) if out of memory
  */
-static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
+static struct vsie_page *get_vsie_page(struct kvm_vcpu *vcpu, unsigned long addr)
 {
-	struct vsie_page *vsie_page;
-	int nr_vcpus;
+	struct vsie_page *vsie_page, *vsie_page_new = NULL;
+	struct kvm *kvm = vcpu->kvm;
+	unsigned int max_vsie_page;
+	int rc, pages_idx;
 
 	vsie_page = xa_load(&kvm->arch.vsie.addr_to_page, addr >> 9);
 	if (vsie_page && try_get_vsie_page(vsie_page)) {
@@ -1668,59 +1902,205 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		put_vsie_page(vsie_page);
 	}
 
-	/*
-	 * We want at least #online_vcpus shadows, so every VCPU can execute
-	 * the VSIE in parallel.
-	 */
-	nr_vcpus = atomic_read(&kvm->online_vcpus);
+	max_vsie_page = MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE_VCPUS);
+
+	/* allocate new vsie_page - we will likely need it */
+	if (kvm->arch.vsie.page_count < max_vsie_page) {
+		vsie_page_new = alloc_vsie_page(kvm);
+		if (!vsie_page_new)
+			return ERR_PTR(-ENOMEM);
+		__set_bit(VSIE_PAGE_IN_USE, &vsie_page_new->flags);
+	}
 
 	mutex_lock(&kvm->arch.vsie.mutex);
-	if (kvm->arch.vsie.page_count < nr_vcpus) {
-		vsie_page = alloc_vsie_page(kvm);
-		if (!vsie_page) {
+	vsie_page = xa_load(&kvm->arch.vsie.addr_to_page, addr >> 9);
+	if (vsie_page && try_get_vsie_page(vsie_page)) {
+		if (vsie_page->scb_gpa == addr) {
 			mutex_unlock(&kvm->arch.vsie.mutex);
-			return ERR_PTR(-ENOMEM);
+			if (vsie_page_new)
+				free_vsie_page(vsie_page_new);
+			return vsie_page;
 		}
-		__set_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
-		kvm->arch.vsie.pages[kvm->arch.vsie.page_count] = vsie_page;
+		/*
+		 * We raced with someone reusing + putting this vsie
+		 * page before we grabbed it.
+		 */
+		put_vsie_page(vsie_page);
+	}
+
+	if (kvm->arch.vsie.page_count < max_vsie_page) {
+		pages_idx = kvm->arch.vsie.page_count;
+		vsie_page = vsie_page_new;
+		vsie_page_new = NULL;
+		WRITE_ONCE(kvm->arch.vsie.pages[kvm->arch.vsie.page_count], vsie_page);
 		kvm->arch.vsie.page_count++;
 	} else {
 		/* reuse an existing entry that belongs to nobody */
 		while (true) {
-			vsie_page = kvm->arch.vsie.pages[kvm->arch.vsie.next];
+			pages_idx = kvm->arch.vsie.next;
+			kvm->arch.vsie.next++;
+			kvm->arch.vsie.next %= kvm->arch.vsie.page_count;
+			vsie_page = kvm->arch.vsie.pages[pages_idx];
 			if (try_get_vsie_page(vsie_page))
 				break;
-			kvm->arch.vsie.next++;
-			kvm->arch.vsie.next %= nr_vcpus;
 		}
-		if (vsie_page->scb_gpa != ULONG_MAX)
-			xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> 9);
-		/* Mark it as invalid until it resides in the tree. */
-		vsie_page->scb_gpa = ULONG_MAX;
+
+		unpin_scb(kvm, vsie_page);
 	}
 
-	/* Double use of the same address or allocation failure. */
-	if (xa_store(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_page, GFP_KERNEL)) {
+	rc = vsie_page_init(vcpu, vsie_page, addr);
+	mutex_unlock(&kvm->arch.vsie.mutex);
+	if (vsie_page_new)
+		free_vsie_page(vsie_page_new);
+	if (WARN_ON_ONCE(rc)) {
+		unpin_scb(kvm, vsie_page);
+		vsie_page->scb_gpa = ULONG_MAX;
 		put_vsie_page(vsie_page);
-		mutex_unlock(&kvm->arch.vsie.mutex);
-		return NULL;
+		return ERR_PTR(rc);
 	}
-	vsie_page->scb_gpa = addr;
-	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
 	release_gmap_shadow_safe(kvm, vsie_page);
 	prefix_unmapped(vsie_page);
 	vsie_page->fault_addr = 0;
 	vsie_page->scb_s.ihcpu = 0xffffU;
+
 	return vsie_page;
 }
 
+static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie_sca *vsie_sca,
+					      gpa_t scb_gpa, u16 cpu_nr)
+{
+	struct vsie_page *vsie_page, *vsie_page_new = NULL;
+	int rc;
+
+	vsie_page = vsie_sca->pages[cpu_nr];
+	if (!vsie_page) {
+		vsie_page_new = alloc_vsie_page(vcpu->kvm);
+		if (!vsie_page_new)
+			return ERR_PTR(-ENOMEM);
+		vsie_page_new->vsie_sca = vsie_sca;
+		__set_bit(VSIE_PAGE_IN_USE, &vsie_page_new->flags);
+
+		/* be careful to not loose a page here if we raced */
+		scoped_guard(mutex, &vsie_sca->mutex) {
+			vsie_page = vsie_sca->pages[cpu_nr];
+			if (!vsie_page) {
+				WRITE_ONCE(vsie_sca->pages[cpu_nr], vsie_page_new);
+				vsie_page = vsie_page_new;
+			}
+		}
+	}
+	if (vsie_page != vsie_page_new) {
+		if (vsie_page_new)
+			free_vsie_page(vsie_page_new);
+
+		/* not a new vsie_page so get it */
+		if (!try_get_vsie_page(vsie_page))
+			return ERR_PTR(-EAGAIN);
+		vsie_page->vsie_sca = vsie_sca;
+	}
+	if (vsie_page->scb_gpa != scb_gpa || vsie_page->sca_gpa != vsie_sca->sca_gpa) {
+		scoped_guard(mutex, &vcpu->kvm->arch.vsie.mutex) {
+			unpin_scb(vcpu->kvm, vsie_page);
+			rc = vsie_page_init(vcpu, vsie_page, scb_gpa);
+		}
+		if (WARN_ON_ONCE(rc)) {
+			put_vsie_page(vsie_page);
+			return ERR_PTR(rc);
+		}
+	}
+
+	return vsie_page;
+}
+
+static void vsie_sca_update(struct vsie_sca *vsie_sca, unsigned int cpu_nr,
+			    struct vsie_page *vsie_page_n, hpa_t sca_o_entry_hpa)
+{
+	vsie_sca->ssca.cpu[cpu_nr].ssda = virt_to_phys(&vsie_page_n->scb_s);
+	vsie_sca->ssca.cpu[cpu_nr].ossea = sca_o_entry_hpa;
+	WRITE_ONCE(vsie_sca->pages[cpu_nr], vsie_page_n);
+}
+
+/* Fill the shadow system control area used for VSIE SIGPI. */
+static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
+		       struct vsie_sca *vsie_sca)
+{
+	hpa_t sca_o_entry_hpa, sca_o_hpa = vsie_sca->sca_o_pages[0].hpa;
+	bool is_esca = sie_uses_esca(vsie_page->scb_o);
+	unsigned int cpu_nr, cpu_slots;
+	struct vsie_page *vsie_page_n;
+	hva_t sca_o_entry_hva;
+	unsigned long *mcn;
+	gpa_t scb_o_gpa;
+	int rc;
+
+	if (is_esca)
+		mcn = phys_to_virt(sca_o_hpa) + offsetof(struct esca_block, mcn);
+	else
+		mcn = phys_to_virt(sca_o_hpa) + offsetof(struct bsca_block, mcn);
+
+	/* pin and make shadow for ALL scb in the sca */
+	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
+	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);
+		if (rc)
+			goto err;
+
+		if (vsie_page->scb_o->icpua == cpu_nr) {
+			vsie_sca_update(vsie_sca, cpu_nr, vsie_page, sca_o_entry_hpa);
+		} else {
+			sca_o_entry_hva = (hva_t)phys_to_virt(sca_o_entry_hpa);
+			if (is_esca)
+				scb_o_gpa = ((struct esca_entry *)sca_o_entry_hva)->sda;
+			else
+				scb_o_gpa = ((struct bsca_entry *)sca_o_entry_hva)->sda;
+			vsie_page_n = get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_o_gpa, cpu_nr);
+			if (!vsie_page_n)
+				rc = -EAGAIN;
+			if (IS_ERR(vsie_page_n))
+				rc = PTR_ERR(vsie_page_n);
+			if (rc)
+				goto err;
+			rc = shadow_scb(vcpu, vsie_page_n);
+			vsie_sca_update(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
+			put_vsie_page(vsie_page_n);
+			if (rc)
+				goto err;
+		}
+	}
+	vsie_sca->ssca.osca = sca_o_hpa;
+
+	return 0;
+
+err:
+	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+		vsie_sca->ssca.cpu[cpu_nr].ssda = 0;
+		vsie_sca->ssca.cpu[cpu_nr].ossea = 0;
+	}
+	return rc;
+}
+
+/* Shadow or reshadow the SCA on VSIE enter. */
+static int shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct vsie_sca *vsie_sca)
+{
+	int rc = 0;
+
+	guard(rwsem_write)(&vcpu->kvm->arch.vsie.vsie_sca_lock);
+	if (!vsie_sca->ssca.osca)
+		rc = _shadow_sca(vcpu, vsie_page, vsie_sca);
+
+	return rc;
+}
+
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_sie_block *scb_o;
+	struct vsie_sca *vsie_sca = NULL;
 	struct vsie_page *vsie_page;
-	unsigned long scb_addr;
-	int rc;
+	gpa_t scb_addr;
+	hpa_t scb_hpa;
+	int rc = 0;
 
 	vcpu->stat.instruction_sie++;
 	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_SIEF2))
@@ -1731,7 +2111,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	scb_addr = kvm_s390_get_base_disp_s(vcpu, NULL);
 
 	/* 512 byte alignment */
-	if (unlikely(scb_addr & 0x1ffUL))
+	if (unlikely(!scb_addr || scb_addr & 0x1ffUL))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	if (kvm_s390_vcpu_has_irq(vcpu, 0) || kvm_s390_vcpu_sie_inhibited(vcpu)) {
@@ -1739,34 +2119,65 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);
-	if (IS_ERR(vsie_page)) {
-		return PTR_ERR(vsie_page);
-	} else if (!vsie_page) {
+	rc = pin_guest_page(vcpu->kvm, scb_addr, &scb_hpa);
+	if (rc)
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	scb_o = (struct kvm_s390_sie_block *)phys_to_virt(scb_hpa);
+
+	if (!use_vsie_sigpif(vcpu->kvm, scb_o)) {
+		/* get the vsie_page with pinned scb_o */
+		vsie_page = get_vsie_page(vcpu, scb_addr);
+		if (IS_ERR(vsie_page)) {
+			rc = PTR_ERR(vsie_page);
+			goto out_unpin;
+		}
+	} else {
+		/* get the vsie_sca with pinned sca_gpa */
+		vsie_sca = get_vsie_sca(vcpu, scb_o, read_scao(vcpu->kvm, scb_o));
+		if (IS_ERR(vsie_sca)) {
+			rc = PTR_ERR(vsie_sca);
+			goto out_unpin;
+		}
+		vsie_page = get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_addr, scb_o->icpua);
+		if (IS_ERR(vsie_page)) {
+			rc = PTR_ERR(vsie_page);
+			goto out_put_sca;
+		}
+	}
+	if (!vsie_page) {
 		/* double use of sie control block - simply do nothing */
 		kvm_s390_rewind_psw(vcpu, 4);
-		return 0;
+		rc = 0;
+		goto out_put_sca;
 	}
 
-	rc = pin_scb(vcpu, vsie_page, scb_addr);
-	if (rc)
-		goto out_put;
 	rc = shadow_scb(vcpu, vsie_page);
 	if (rc)
-		goto out_unpin_scb;
+		goto out_put;
+	if (vsie_sca) {
+		/* pin and shadow the sca including all scb_o in the g3 conf */
+		rc = shadow_sca(vcpu, vsie_page, vsie_sca);
+		if (rc)
+			goto out_unshadow;
+	}
+
 	rc = pin_blocks(vcpu, vsie_page);
 	if (rc)
 		goto out_unshadow;
 	register_shadow_scb(vcpu, vsie_page);
+
 	rc = vsie_run(vcpu, vsie_page);
+
 	unregister_shadow_scb(vcpu);
 	unpin_blocks(vcpu, vsie_page);
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
-out_unpin_scb:
-	unpin_scb(vcpu, vsie_page, scb_addr);
 out_put:
 	put_vsie_page(vsie_page);
+out_put_sca:
+	put_vsie_sca(vsie_sca);
+out_unpin:
+	unpin_guest_page(vcpu->kvm, scb_addr, scb_hpa);
 
 	return rc < 0 ? rc : 0;
 }
@@ -1776,27 +2187,53 @@ void kvm_s390_vsie_init(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.vsie.mutex);
 	xa_init_flags(&kvm->arch.vsie.addr_to_page, XA_FLAGS_ALLOC);
+	init_rwsem(&kvm->arch.vsie.vsie_sca_lock);
+	xa_init_flags(&kvm->arch.vsie.osca_to_sca, XA_FLAGS_ALLOC);
+}
+
+static void kvm_s390_vsie_destroy_page(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
+		if (vsie_page->gmap_cache.gmap)
+			release_gmap_shadow(vsie_page);
+	/* free the radix tree entry */
+	if (vsie_page->scb_gpa != ULONG_MAX)
+		xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> 9);
+	free_vsie_page(vsie_page);
 }
 
 /* Destroy the vsie data structures. To be called when a vm is destroyed. */
 void kvm_s390_vsie_destroy(struct kvm *kvm)
 {
 	struct vsie_page *vsie_page;
-	int i;
+	struct vsie_sca *vsie_sca;
+	int i, cpu_nr;
+
+	guard(mutex)(&kvm->arch.vsie.mutex);
 
-	mutex_lock(&kvm->arch.vsie.mutex);
 	for (i = 0; i < kvm->arch.vsie.page_count; i++) {
 		vsie_page = kvm->arch.vsie.pages[i];
-		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
-			if (vsie_page->gmap_cache.gmap)
-				release_gmap_shadow(vsie_page);
 		kvm->arch.vsie.pages[i] = NULL;
-		if (vsie_page->scb_gpa != ULONG_MAX)
-			xa_erase(&kvm->arch.vsie.addr_to_page, vsie_page->scb_gpa >> 9);
-		free_vsie_page(vsie_page);
+		kvm_s390_vsie_destroy_page(kvm, vsie_page);
 	}
 	kvm->arch.vsie.page_count = 0;
-	mutex_unlock(&kvm->arch.vsie.mutex);
+	for (i = 0; i < kvm->arch.vsie.sca_count; i++) {
+		vsie_sca = kvm->arch.vsie.scas[i];
+		kvm->arch.vsie.scas[i] = NULL;
+
+		for (cpu_nr = 0; cpu_nr < KVM_S390_MAX_VSIE_VCPUS; cpu_nr++) {
+			vsie_page = vsie_sca->pages[cpu_nr];
+			vsie_sca->pages[cpu_nr] = NULL;
+			if (!vsie_page)
+				continue;
+			unpin_scb(kvm, vsie_page);
+			kvm_s390_vsie_destroy_page(kvm, vsie_page);
+		}
+
+		unpin_sca(kvm, vsie_sca);
+		free_vsie_sca(kvm, vsie_sca);
+	}
+	kvm->arch.vsie.sca_count = 0;
 }
 
 void kvm_s390_vsie_kick(struct kvm_vcpu *vcpu)

-- 
2.55.0

