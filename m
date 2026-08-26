Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AC450917;
	Wed, 26 Aug 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756734; cv=none; b=SutBq+2d9PLwThdiYAfQ9AIqehW+TdW/XZull31axIoDMr7uEwF5BZHi0BXWuBNB7ImcnRGbLt84n+MziljOtX9AsGqGKuUGhOuIQ+TM70fSDyqtMxxbDp1ugh2U6YgfBAgcwZsaMjah9G0iB0iuS56/IRHz/5NCUW74x2Or2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756734; c=relaxed/simple;
	bh=5V0Kt9OoRQ2hB4rFKrKJmrN/xQxJXLzd8xUFiTf0N7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPvgd5UzhRbtl8B9KKosoEqJTSXuTBQWhfYwihBHg9YbgyUY3yiK+RddU0HteAgj14ElxJdvpFVn7XGYFYmt5sgED6dcrXy4CSVeNDDCq19aGVkPV5vvF66rQIm4IUzPD5Ot46wB2jwu/MXumQEiayYxgWzjDsee7UeeRc3Leps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TROcC+jS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TROcC+jS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1Z072333849;
	Wed, 26 Aug 2026 15:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kRTBSR
	lra9hKLds5Akerc0qiFAr6SOHR9KYMH5zq9jE=; b=TROcC+jSeHfPNL/s+jQeBW
	MoK6SVbEUYTPXPXr3TZrET5tI5J2gNU7BjIev+z9ukLT5pMsw9L/myhTYZQKq+qP
	y+XXlVLy9Je9yH3Vt355XRQTd2hH17RSqhlPsrHeVYG9bFm4X/DRl7IjHlfyqYaM
	dRUNZKTjjz0gqgnPjWvoY7Xpvoxhf1MEtp5cHi2l/Rhb0j+QPqqAoaqgYaahSzKK
	yHz66L3qi/CBIi0soJ1SIjZMzG0k+Dmtv1ygO7rY8E49nU8b9uYoUX72i7OJH6fN
	djtNopV5+RF3hEVNWJcJLtLt2JA72Vc7ySbhi+aEUx9m4TTIYQak2vZ5ae5jIhyQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqycg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuHcN032398;
	Wed, 26 Aug 2026 15:05:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyab18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5KBr45351410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 867D22004B;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5997C20043;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:19 +0200
Subject: [PATCH v5 17/21] KVM: s390: vsie: Allow guest-3 cpu add and remove
 with ssca
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-17-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4222;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=5V0Kt9OoRQ2hB4rFKrKJmrN/xQxJXLzd8xUFiTf0N7Y=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DGvaZm4+8JV9D69cVd+81z/Su33Pdgfr3N8tNaGBR
 3XRuelsHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzEfT/DP92v5oJhvVWrjHlK
 QqNtVeY6PhZuy6mNvHtnkWbAh4f1nxgZNu27tKpEdMXxre/SXzX+MBDY55fkuOzK8eVNcRyHudn
 bOQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tsS5O8dA30kfTDlskKfdglSL_cB5SVIW
X-Proofpoint-ORIG-GUID: jKFprO1qiSs1HHUyfbWat9fLOuuQCyKq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX6oW9PYZFdhrI
 7YCPzeQIzCrgRLXdsZeQopXwtu9wGTRazimnWs/LJrq6ujTep425mE6h9Y9FJWdc4GbxEzCa+Tn
 oFgOvR9GD3CJtR3MzvHmomiwGLrP9uTGbCl61C+/uF+9b0PEmmvIAlkEhhLl9ICXZQXa7p2T9VH
 VqthiYEc7A10dIH7hNConeO1WRx4yZ5mmcMfTAbQd93iEdvK+l7WkLuvYqvXx5f5KNfwT78S/sj
 xJebhhdQUiiRydc+7tVxZLIEThem5yUApVtcXCDAGhfVML1Jk5CetkCN4Nue8OE2Vx1RqJMyYhW
 EAJC0LVCffVg9v1kYHeRUtUsaZ2Wxv8/u0pJGZO8djH5g0ZrWa4Nn0L2QOp9BM16h3qqV4xnwY2
 3hUsR6XQ8tSxHplvcbnfggJ4SGQNW+hN0vwGUFsMtK9siqK1tKRgJkAEZjxIaMwLwYcpXNIEQkM
 f6ndfEuowSf6GOgPamQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f00b5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=PXeH2Pb9wBGPeq1YnyQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX6JLtzuFP4eaQ
 8+A1QWUVYgxHqmkeR3rS72EQAD2HxuOjX85ZMxMCBe8ITalFkjMvUVzE5Fh8tUzm5sLuDHB39+0
 7x2YU2ZsgNxJS96Bp4ov6bIOCGSZAVo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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
 arch/s390/kvm/s390/vsie.c | 66 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 4bd11eaa7d81..6e42b00206bd 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -2075,6 +2075,43 @@ static struct vsie_page *get_vsie_page_cpu_nr(struct kvm_vcpu *vcpu, struct vsie
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
 static void update_vsie_sca(struct vsie_sca *vsie_sca, unsigned int cpu_nr,
 			    struct vsie_page *vsie_page_n, hpa_t sca_o_entry_hpa)
 {
@@ -2126,17 +2163,17 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	bool is_esca = sie_uses_esca(vsie_page->scb_o);
 	unsigned int cpu_nr, cpu_slots;
 	hpa_t sca_o_entry_hpa;
-	unsigned long *mcn;
 	int rc;
 
 	if (is_esca)
-		mcn = phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct esca_block, mcn);
+		set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
 	else
-		mcn = phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct bsca_block, mcn);
+		clear_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
+	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
 
 	/* pin and make shadow for ALL scb in the sca */
 	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
-	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
+	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);
 		if (rc)
 			break;
@@ -2163,19 +2200,26 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	return rc;
 }
 
+static bool shadow_sca_needed(struct vsie_sca *vsie_sca)
+{
+	if (!vsie_sca->ssca.osca)
+		return true;
+	return !sca_mcn_equals(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
+}
+
 /* Shadow or reshadow the SCA on VSIE enter. */
 static int shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct vsie_sca *vsie_sca)
 {
-	int rc = 0;
+	scoped_guard(rwsem_read, &vcpu->kvm->arch.vsie.vsie_sca_lock) {
+		if (!shadow_sca_needed(vsie_sca))
+			return 0;
+	}
 
 	guard(rwsem_write)(&vcpu->kvm->arch.vsie.vsie_sca_lock);
-	if (!vsie_sca->ssca.osca)
-		rc = _shadow_sca(vcpu, vsie_page, vsie_sca);
-
-	if (!rc)
-		write_scao(&vsie_page->scb_s, virt_to_phys(&vsie_sca->ssca));
+	if (!shadow_sca_needed(vsie_sca))
+		return 0;
 
-	return rc;
+	return _shadow_sca(vcpu, vsie_page, vsie_sca);
 }
 
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)

-- 
2.55.0

