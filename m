Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3FB456E0A;
	Wed, 12 Aug 2026 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542771; cv=none; b=n3H5zK7AwhX77P55a6YRvnU1Cliu0FNip2PL63C+BpVU1QIQZs9dE3NzBA3We3Ll77INhR68R8rwfdgWnX3b9/UrQZE+HCHxAa1zdtXPhMzyUF33QnOQv1Ma68amBkeraahC7cPoVsjgMmsN/XtAHRBtPMaptmSGWmGHXuhPABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542771; c=relaxed/simple;
	bh=JGxFR2WkH5OzFWivlwh5R0QYCDV+0CIwji5kBydFv9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxQEdYIRVTQvNHuShZj+Yx6ToUYSyXvtLlu0Jy9OjzjLN3DMN1hDFApsfdtHNs9PTmBZ3zfgEwOBxNpx9kXmu3FOEuBhKcMgWAiGfwEeCoCmDqAJCGs1BxhZ7r8iUcHqoLZMIS2HUXfxHz47yjVznXgcn2CzgRW+ecsqbFU14qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cSbcCKP7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cSbcCKP7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3i0n2205427;
	Wed, 12 Aug 2026 13:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ucRc/j
	FKYAtqZhJIITp6PPtrRxHQUdUka0iTKkGTgWA=; b=cSbcCKP7PrDlb1OPZjPcwd
	drAXO/mnhuUfxIaWfZLqTcOZNsNrIHKaqzLYy8wZ1b6KWduEwu27LOcrMLtVZFL1
	qZzcFbgSFQcT2O6AaczfW0eeRMob+MfvZQzC05JILWm+CTD/hyFJKwpuhOZ1VFsJ
	OLYDyyGys77mT7tCNZSs6wVL/8JZwvD/35kTtVo131hjJ5PO8ou/Zn/vtEiqaX6s
	1IlA4U/T7m+V3VQnR2Dsgum6L334WDrbAiGqPqChWbGwEbFFYL9An1cgtMjqlk4t
	ZD4cpA6Wcj+oRIMoRK7+XsH8ZLAiGTBGA68K6nQdgTLiY/7d6tV8wEERhkDpwwjA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23u964-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfgG1012155;
	Wed, 12 Aug 2026 13:52:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h66e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqeBF45547920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32FB22004B;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 008F420043;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:45 +0200
Subject: [PATCH v4 16/20] KVM: s390: vsie: Allow guest-3 cpu add and remove
 with ssca
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-16-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=JGxFR2WkH5OzFWivlwh5R0QYCDV+0CIwji5kBydFv9g=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYvPXHmv6P5VXfRBydkeh3LLHb/kTF8ovoyb887pK
 buKfoJRRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABPx/cjI8HbPwVzbq5tcvCw0
 dm847bd2nmbIz0+zBNwkxWVY51n9OsjwvyS7ybckqlf0dUyh93Xtfd48Z9VOhCzbO8tZg7nDae4
 0DgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c7aad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=PXeH2Pb9wBGPeq1YnyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX9zbYndOnipUi
 NKWeSRjCRMWz9pgeVJOQt/2+9I3BTlmmhd/yVmWMTJo5qT71MzJLiGjW7XZjFZ/OMUEdjeDOYp/
 n2+K9Lg2ktpNHX73hAbnOQHLD7N9ubufcNt8B4o0FlElIL+UDcqzpGJiyTWNfMJXXPi15Q96BCc
 xtXLxzW1DiTxWO+os/C/05iolU21jH7ota8aYzJ+yO8HtqGw+C0zETCFh4I60Aly40Cl9/Nuu+b
 EIUNU/KsC1l57D6OR3MJvNIW2t1vjlVYIyAXDBxYCsg3Py4HexpOmBE31MpAPE87CI68ixWx7vD
 ep7Xqeb9I5bVhueZeZTSY/hoHLe82pakAZC/Fb3v71bWmZa1ekHVLH7kUAw1VQ0LOCFIteMz47y
 4+Uzr3sQXBHVUtwd6oIzGufsvp6ldD823htsdtuaX5S+7yLn2ARwH1mIBydMl5+Sj/F5WxVpDMr
 Pte3G0neAa9PCs4Q2wg==
X-Proofpoint-ORIG-GUID: f6pzkfZ_fNCFxuOojYsNV3EuBYUrl3ur
X-Proofpoint-GUID: f6pzkfZ_fNCFxuOojYsNV3EuBYUrl3ur
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX252TrTo1pItw
 DarMNWm2dBw4S3Ytpbn0Du1IJEmAo9+ez3runhNqHUQxes2DCn+W1uuetExWnnxs013BnDzKYXR
 +qTQUIJVL49GmdMIn9CBHWEthHsWuFs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120110

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
index 154772278d0a..6088a9c31564 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -2052,6 +2052,43 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
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
@@ -2071,18 +2108,16 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
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
@@ -2118,23 +2153,36 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
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

