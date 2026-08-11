Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89454457DB;
	Tue, 11 Aug 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455418; cv=none; b=mNKpKbIVPgEbdFF7IJU52RcGXDrKkF0e11oQe+eHGaXeFHbUwNSYc3ruKXVDmo3kbvM7Xrr2y5uh1TDrg3x++1DmJkW/AMtD4XyzNgoCzDk2SW/P+BrooNH76RMnBf85vE+iKy/57feHHmq5pUJtVdyW5OLHfsNeNpmOFcwYim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455418; c=relaxed/simple;
	bh=pbKUNDDyEQnSiAGvSD6q9iktKaNo/9iyZDSRcSxQOzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbhluF5IRiAQKWQq4sM69NE9UISLPZd/GnJXwIFxkLoQbn0TDct1CgaAISND9fYkFZz5Xj574lRj/ZfH+6a/MJSEqLb6lniAh6WFkfyyvwfJX8vSc/mVm79M7ZncAo8ILa+tfX7XPlO1Rv0ljnUqR++F7NomG0VELiLlB9DeZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=puk1h9vs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="puk1h9vs"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWPTi492226;
	Tue, 11 Aug 2026 13:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eJEyXf
	apTU97DGj61icUtCk2YETHkxIuZSEjKmGH8D0=; b=puk1h9vsiKzLq2yQ3Cvn3x
	XlAIAGZkWXV5VGAYJN3jn49SwpojyWPzU3Z3RvtKDFlKRWpscehGxCt/TDc4Raeq
	MI1t2NqGH0BMC9s4bLAdqYkZ3OIGuAmL0tF0ueXZ4+T8Lxfm8q9Bay2BXaOGdxwP
	jOS/i+roe4H1UV1MfueNV/5Eucld7QBTW8RC6iwZBd6IS5C194wtlyjVA6jTgi7o
	MImgIy7Y+gwEZ/v33yu+fKWpO8f5vTHnwpkFGQfCZDSrfwj47f9FdZ0p4p2oLUA9
	twaw5nai9Wk1qAqP8CvL7aGjgyUZ+4AAGBx2RELAbOcZPoFq/FksBiaSLRkEePGQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9d3vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQFEe008262;
	Tue, 11 Aug 2026 13:36:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq1860-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDadls40632822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8278620040;
	Tue, 11 Aug 2026 13:36:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC9C42004B;
	Tue, 11 Aug 2026 13:36:38 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:38 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:31 +0200
Subject: [PATCH v3 16/20] KVM: s390: vsie: Allow guest-3 cpu add and remove
 with ssca
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-16-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=pbKUNDDyEQnSiAGvSD6q9iktKaNo/9iyZDSRcSxQOzQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqtGCmwsmc/eXrjj/Nri+K2Ddgs3cEa7ZAdf2Cvb18
 nH+6L7WUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwESuFzAydHBfnHHqco+EkV1b
 5EXZ15+c80JXNJw6Et5vt6E1hEk1lJHhedpr44d/X4fdcHfoOZv/KPhext1ZGRNuH7mQ59vYKX+
 LDQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YOlBjQTbNIz0tMV5BnvpzEXdV1dXom05
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b256c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=PXeH2Pb9wBGPeq1YnyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX8SKPrZh3/Dtl
 lxGAxaHX4XeNUgk0iI/hvxf2ZBkzUyJxAyBno0XmlWNH+0DA0+IMjxN7MRHDiTgEYO23ySfmW20
 /sdPqXWvzl9F8FL2jieCksRL7MftprWfxXvQRDe+QdWEA8z1oJE49COs5plBrUhEcJK0JMesrrc
 dUlC5XkOumFzeT9IALJiJcgnF4pb3m0rCWJ5jRXfPPChg/ZYmwUHHBpoL++GUowpRuCNDnwla0x
 d2vyHMX/CmoJiyOm/+N1ZqqpsyJ05WRF3TqODvuR2qu0LCO4wU7h8LvLyL5elfZb7CKG3K5XY24
 veeRBPbywNi1GKpryBkOYcpwVUSVHQK6ryljDdJeXkTEDSKWK+/K+9cDcJtSG3q4MJlgWnW9HcP
 OBF7dA1wWsiP2UyzpwR3Uc1yoQW26RiInaWutWKTAc/rFd9hAT6mPRCP6p27k+v8P+xkD3ocymE
 xg48L1SE/Q1Bvx2G7pg==
X-Proofpoint-ORIG-GUID: YOlBjQTbNIz0tMV5BnvpzEXdV1dXom05
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfXw7CzRNTfafVq
 TJ/BOlyaXrX6YNjIN8fcFVhJTLGbNhrui7HJEW9g52S/PtTj780JQjnxZg64bOWF1CeAUCZ1guo
 m+u1hUF7TqlnMhD6cuj1JrW1gifmZ2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110113

As we are shadowing the SCA we need to add and remove the pointers to
the shadowed control blocks and sca entries whenever the mcn /
processors in the configuration changes.

It is not expected that the mcn changes frequently for an already
running guest-3 configuration. So we can simply fully re-init the ssca
whenever the mcn changes.
To detect the mcn change we store the expected mcn in the struct
vsie_sca when running _shadow_sca().

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 68 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 844ffd3244fe..3ae346265b81 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -2051,6 +2051,43 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
 	return vsie_page;
 }
 
+/*
+ * Copy the mcn from the osca to the vsie_sca to be able to detect mcn changes later on.
+ *
+ * @vsie_sca: vsie_sca to copy mcn to.
+ * @sca: Pointer to a struct bsca_block or struct esca_block to read from.
+ */
+static void sca_mcn_copy(struct vsie_sca *vsie_sca, void *sca)
+{
+	int offset = offsetof(struct bsca_block, mcn);
+	int size = sizeof(unsigned long);
+
+	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags)) {
+		offset = offsetof(struct esca_block, mcn);
+		size = size * 4;
+	}
+	memcpy(&vsie_sca->mcn, sca + offset, size);
+}
+
+/*
+ * Compare the mcn from the given sca to the vsie_sca to be able to detect mcn changes.
+ *
+ * @vsie_sca: vsie_sca to compare mcn to.
+ * @sca: Pointer to a struct bsca_block or struct esca_block to compare to.
+ */
+static bool sca_mcn_equals(struct vsie_sca *vsie_sca, void *sca)
+{
+	int offset = offsetof(struct bsca_block, mcn);
+	int size = sizeof(unsigned long);
+
+	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags)) {
+		size = size * 4;
+		offset = offsetof(struct esca_block, mcn);
+	}
+
+	return !memcmp(&vsie_sca->mcn, sca + offset, size);
+}
+
 static void vsie_sca_update(struct vsie_sca *vsie_sca, unsigned int cpu_nr,
 			    struct vsie_page *vsie_page_n, hpa_t sca_o_entry_hpa)
 {
@@ -2070,18 +2107,16 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	struct vsie_page *vsie_page_n;
 	hpa_t sca_o_entry_hpa;
 	hva_t sca_o_entry_hva;
-	unsigned long *mcn;
 	gpa_t scb_o_gpa;
 	int rc;
 
 	if (is_esca)
-		mcn = phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct esca_block, mcn);
-	else
-		mcn = phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct bsca_block, mcn);
+		__set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
+	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
 
 	/* pin and make shadow for ALL scb in the sca */
 	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
-	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);
 		if (rc)
 			goto err;
@@ -2117,23 +2152,36 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	return 0;
 
 err:
-	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+	vsie_sca->ssca.osca = 0;
+	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		vsie_sca->ssca.cpu[cpu_nr].ssda = 0;
 		vsie_sca->ssca.cpu[cpu_nr].ossea = 0;
 	}
 	return rc;
 }
 
+static bool config_changed(struct vsie_page *vsie_page, struct vsie_sca *vsie_sca)
+{
+	bool changed = !vsie_sca->ssca.osca;
+
+	changed = changed || sie_uses_esca(vsie_page->scb_o) !=
+			     test_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
+	return changed || !sca_mcn_equals(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
+}
+
 /* Shadow or reshadow the SCA on VSIE enter. */
 static int shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct vsie_sca *vsie_sca)
 {
-	int rc = 0;
+	scoped_guard(rwsem_read, &vcpu->kvm->arch.vsie.vsie_sca_lock) {
+		if (!config_changed(vsie_page, vsie_sca))
+			return 0;
+	}
 
 	guard(rwsem_write)(&vcpu->kvm->arch.vsie.vsie_sca_lock);
-	if (!vsie_sca->ssca.osca)
-		rc = _shadow_sca(vcpu, vsie_page, vsie_sca);
+	if (!config_changed(vsie_page, vsie_sca))
+		return 0;
 
-	return rc;
+	return _shadow_sca(vcpu, vsie_page, vsie_sca);
 }
 
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)

-- 
2.55.0

