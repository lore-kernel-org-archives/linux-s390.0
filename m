Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981324;
	b=G9Fyz9/Qnsvd2d+oxIWx+8wwTYGUeXVjlYe0GzkqBy5V/bkB0dpYeOhbyhwSAyz6mnDA
	 9XO5wePIFVn/O6LoBBIYjT+sKgBvzS+fv+qEEp5HBJx+F/YXnCNzuNfqDgR1E2XTT95Wj
	 Aqqffw5NE1D9q0j/SASfkBsF7w105KMTMHDJ0TpPVPpkRD26hR43Jc3nACBVD6bz3qWrC
	 SgU+ze2wU/6339IxFcZupBsSdK6MELFI49GOaYuE0wT5fscLvysZT2LHyDmKEBHZM8z9E
	 A4lwJxg68jTK1OfL5+dA9zayNmVfMO/nxeOMRa5Smp1Eqz0GkTO9bhk+OKMq5Av+6TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981324;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IrWQ8uyRNpiuUgwIHv/xG8dMDSEjnpkf5UrJq74oLLM=;
	b=u9kHeGrEp9WAMHuKAjp+mV5fzKzJKsZb4xdgCQq5+12HQlapcz8K4jACOHAi2DZOQKiE
	 YYV63wPWRdUuOMyK0IQAaqZyuprwFH5/2gXKns8JQtBU2mXgXiHShk1HKOeubZpW3Kzam
	 qM0XI1ojjVdOQWCi0c2BUW48xPURXvXQJOOcKWuV8cfp1i1/2sYaj0EoSiU0tftTiuVal
	 ZXuH/bmpezDI1tLbJwqHaj15TXAtyMiIuPJHCgOXv9ExjQqutBifThv0mxM0oucouZHAR
	 /UJAWs7DZwFpMzeYBcN3xPmLKuT3K+72oG62MxyLSar8qqTJsXWGZHT45iVIUafR7Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gS8sw9Wa;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EE606A33E;
	Fri,  6 Nov 2026 16:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2EE606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gS8sw9Wa
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEEud2936029;
	Fri, 6 Nov 2026 16:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IrWQ8u
	yRNpiuUgwIHv/xG8dMDSEjnpkf5UrJq74oLLM=; b=gS8sw9Wa9BfYd08n8DTEbD
	XBD6xQxut0Tm0+QFg8a3hjC+3XZJQCWIj0jp5rH4t4eGJ0DOh/NAHszVLeedyr8V
	6sLi1+3q1FyZoxMA8LMDFDnexPRAr7w0y8f/2cKSPAnwIZ3f061IKPFbFmYCa9my
	r6Qxo0Y0LnQl1apyyF9jqP+BCMyIsce8aqRYOCs3epxdJhzg4osV/6Lb5T9VuZUA
	6Qa8cmLLozN2m4uvED2DwhcYzrJhZDYFByh8WaBSahfWF3hPesovj7RladGsHqqk
	duUAObWQ8YZtb89xnroSUEH857Obquzwr3aa8cSINuORK3cO3R5yMQC0/1TaOExA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcdhet-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FK7xv3577902;
	Fri, 6 Nov 2026 16:08:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v870k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8EZ735389860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9DC92004F;
	Fri,  6 Nov 2026 16:08:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5889C2004B;
	Fri,  6 Nov 2026 16:08:14 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:14 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:35 +0100
Subject: [PATCH v3 02/23] KVM: arm64: Extract number of sys_reg_desc into a
 constant
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sysreg-v3-2-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: okE7hTDatj3n1WZfogT40Zd1Y7MAF8xp
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedfb73 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=cPKN5jb6Pdq7kSXABbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: okE7hTDatj3n1WZfogT40Zd1Y7MAF8xp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX5OUXNknPa1yT
 PYi4gahsDzI3H5QhTYRjRp1Z6le/XUUYgJZJMMdjh/vNzlD2uROGkaQTE5dlc+R7S2fHGlPFph2
 9TFCHSYelbppSkotpNJCSkrl08O6+sHwUpflo9xmZM7+jnRazWTs+Ew3ybHTvYp7wrNJZ6xOjqr
 abMbTXfXva809pF7qYNFx1Hv6/c+Qm82/XxPPTQomlx+eUPwhKocjNS24tdOFwvsc4jqt6nIqwG
 cuh+aVsMXAj7m2NTEKnz4z+eDKUUxgoCW+3l8UDPYZcBeCy4vslROF733JOP57qDBQGWzzHkUE4
 DE3hV+Ly/12T/1C0pPTw4tqj8sm4FbH5GTX2Mi9i0w7WqWEwx/X3KoQ81L+zym4t3GgO2lTeEa/
 aQzTkjpYQ2b757C2pK5BmXqL/VtAU01gD/6q10Ly3+5OPpRCLXPNrbBuo6TrHjk/XU4gThe1ZfO
 BimHVFdzRufJIz/Y1sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX/oR6f3OGjERy
 hJlSRmiMUQMGwEJdcWPXBmY1XZ0tsmnVp2gcNi7a7gFq71/5H/oFdzu64vsuIaUArHfUgeNx2m1
 cqeF9iwXS29qR/YLH33qQwDb8LMUsKo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Define the constant `num_sys_reg_descs` which stores the number of
elements in the sys_reg_descs array. Replace all occurrences of
ARRAY_SIZE(sys_reg_descs) with the new constant.

This refactoring eases the integration of handling system registers for
arm on s390. s390 needs code from the shared code to define the
sys_reg_descs. But also the shared code needs the definition of the
sys_reg_array and we cannot forward declare arrays and use their size
before it is properly defined. This patch solves this chicken or egg
problem. For the time being s390 cannot process the full arm64 defined
sys_reg_descs array.

No functional changes.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/sys_regs.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0f0b0495b710..2b28b929f9f3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3976,6 +3976,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	EL2_REG(SP_EL2, NULL, reset_unknown, 0),
 };
 
+static const size_t num_sys_reg_descs = ARRAY_SIZE(sys_reg_descs);
+
 static bool handle_at_s1e01(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			    const struct sys_reg_desc *r)
 {
@@ -5187,7 +5189,7 @@ static bool emulate_sys_reg(struct kvm_vcpu *vcpu,
 {
 	const struct sys_reg_desc *r;
 
-	r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	r = find_reg(params, sys_reg_descs, num_sys_reg_descs);
 	if (likely(r)) {
 		perform_access(vcpu, params, r);
 		return true;
@@ -5205,7 +5207,7 @@ static const struct sys_reg_desc *idregs_debug_find(struct kvm *kvm, loff_t pos)
 {
 	unsigned long i, idreg_idx = 0;
 
-	for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
+	for (i = 0; i < num_sys_reg_descs; i++) {
 		const struct sys_reg_desc *r = &sys_reg_descs[i];
 
 		if (!is_vm_ftr_id_reg(reg_to_encoding(r)))
@@ -5268,7 +5270,7 @@ static const struct sys_reg_desc *sr_resx_find(struct kvm *kvm, loff_t pos)
 {
 	unsigned long i, sr_idx = 0;
 
-	for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
+	for (i = 0; i < num_sys_reg_descs; i++) {
 		const struct sys_reg_desc *r = &sys_reg_descs[i];
 
 		if (r->reg < __SANITISED_REG_START__)
@@ -5370,7 +5372,7 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long i;
 
-	for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
+	for (i = 0; i < num_sys_reg_descs; i++) {
 		const struct sys_reg_desc *r = &sys_reg_descs[i];
 
 		if (!r->reset)
@@ -5594,8 +5596,8 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_get(vcpu, reg->id, uaddr);
 
-	return kvm_sys_reg_get_user(vcpu, reg,
-				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	return kvm_sys_reg_get_user(vcpu, reg, sys_reg_descs,
+				    num_sys_reg_descs);
 }
 
 int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
@@ -5634,8 +5636,8 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_set(vcpu, reg->id, uaddr);
 
-	return kvm_sys_reg_set_user(vcpu, reg,
-				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	return kvm_sys_reg_set_user(vcpu, reg, sys_reg_descs,
+				    num_sys_reg_descs);
 }
 
 static unsigned int num_demux_regs(void)
@@ -5723,7 +5725,7 @@ static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
 	int err;
 
 	i2 = sys_reg_descs;
-	end2 = sys_reg_descs + ARRAY_SIZE(sys_reg_descs);
+	end2 = sys_reg_descs + num_sys_reg_descs;
 
 	while (i2 != end2) {
 		err = walk_one_sys_reg(vcpu, i2++, &uind, &total);
@@ -5772,7 +5774,7 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
 	if (clear_user(masks, KVM_ARM_FEATURE_ID_RANGE_SIZE * sizeof(__u64)))
 		return -EFAULT;
 
-	for (int i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
+	for (int i = 0; i < num_sys_reg_descs; i++) {
 		const struct sys_reg_desc *reg = &sys_reg_descs[i];
 		u32 encoding = reg_to_encoding(reg);
 		u64 val;
@@ -5957,7 +5959,7 @@ int __init kvm_sys_reg_table_init(void)
 	int ret = 0;
 
 	/* Make sure tables are unique and in order. */
-	valid &= check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), true);
+	valid &= check_sysreg_table(sys_reg_descs, num_sys_reg_descs, true);
 	valid &= check_sysreg_table(cp14_regs, ARRAY_SIZE(cp14_regs), false);
 	valid &= check_sysreg_table(cp14_64_regs, ARRAY_SIZE(cp14_64_regs), false);
 	valid &= check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs), false);
@@ -5980,7 +5982,7 @@ int __init kvm_sys_reg_table_init(void)
 
 	check_feature_map();
 
-	for (i = 0; !ret && i < ARRAY_SIZE(sys_reg_descs); i++)
+	for (i = 0; !ret && i < num_sys_reg_descs; i++)
 		ret = populate_sysreg_config(sys_reg_descs + i, i);
 
 	for (i = 0; !ret && i < ARRAY_SIZE(sys_insn_descs); i++)

-- 
2.56.0

