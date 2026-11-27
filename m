Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789442;
	b=RfHCTtYEIlo9/yRtFMT9dXdc4o00Ewf/WfLPKw1bCNbJPw2SPR3Misfm3OID09CKq9Bj
	 buXA6Z2Hif0H7ZR4TCgsvjXRwGFbqte9kXoPyPCD4JBQ5oe8JuorRosrm3zTD4wc3rgBM
	 IfnMdOhUdIp5FgymIhL2ZvoLLtzf642td4fQF5MChsX3KiCqnzHyzJFYdHbby/k/oQav3
	 UxIolThI7+RgCyIVQCToTOU3+5YgWCOevhpvS1Z0pMuuhMQhwpKfGeG7/snbWKZVbrwt0
	 y5amO9bPbINVPDwbRGZWd1Ia+BBxBNfUsjE6kCYgKqBQ2UMpHAhrLChs0jW0fJyMJoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789442;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GygX5KXmviqsNZpKTwwYNbDzb/k4z6PktHcu7Al6W3E=;
	b=uJ+RfTse3fYCDNyN1In2QD+HZ+N15rZg4Dxn1PGT0TL2uHbvzFkKy76hIqdH6rb8OBmM
	 3bPQ0NxTS2IU/T3ynSG1gElvaPOMkYFilTOrqVKFwuNgliHBp7i0qZMHNwJd2YvmU70Z7
	 Zzp8f4xosjBBFQ3/WAqZxqVew7S/hF3dPY/68zEqO+FTqEKbG80JEEI7452i633bcaa38
	 qFRiMa+2UuYYehvrfoNDgjxhqCne+xxZUks1UD8mAivp96sUEL3kDNdGmZviWwlFWFu3p
	 UtXBVOcQaUoKLj2Qspqz6MBNgUd/72rMD7EsV2uAIhznkZOFMcq5hj8qlW2R8G+Ktbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DMxa3JoJ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8F606A338;
	Fri, 27 Nov 2026 14:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF8F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DMxa3JoJ
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE52h92012374;
	Fri, 27 Nov 2026 14:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GygX5K
	XmviqsNZpKTwwYNbDzb/k4z6PktHcu7Al6W3E=; b=DMxa3JoJsPUWRaaSLWV9mO
	HyUBTW0NjOaruJ0ln8arKOdjZ0+BtsFtkERCOkSVeEflmz1TzwWz9nMu9PMZn3n/
	nffnT1jiot8t4q7RXuVcEmeslxOMzo4kh5fBsDXqjj4orVJgs5GQJ/nHoST7vMjO
	nNqI1TTgnWREz/rTg76Oog9Ck7cMQ/JDKBhPkJ+sv+My4+1pvP4nFtzRcHoOCUQB
	NBELtZ6XfxmtbTLIlBey//k4czDuGJY1Y1zgRRdTUdO5mWnfv/s33oP52gGLpeyK
	Ufy4gbJQnKKyoRzrX/DfGdkBmnLzLHK6EVb8DPSybQ5e7xIsqs7GY18p+FggkGrw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4w8fe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4M982819332;
	Fri, 27 Nov 2026 14:23:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfaahjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENFGq48627990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E53BE2006A;
	Fri, 27 Nov 2026 14:23:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4B82005A;
	Fri, 27 Nov 2026 14:23:14 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:14 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:06 +0100
Subject: [PATCH v4 03/25] KVM: arm64: Extract number of sys_reg_desc into a
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
Message-Id: <20261127-sysreg-v4-3-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX5ZQqd4ySVCE4
 37ft6Rg7i/IB5EzKWtFCe7H0r/3OvrdhWq5y3lJS3AB5VdF/Kowa2KgJZB0Ssmaba3xpYSCHrav
 Ad3yyclwhlDDrOnfTSapQZ/ZbEfUK68=
X-Proofpoint-GUID: GsjuZw2DM30cODSCOsLG-4dszYUD17B5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX+m35+Z4p710L
 NhtyoRX7fCA1OJ8sxvKjHoZHO9w1HK0+2nz0VIGB6EAPcE3J86Of6TtMpUl4ttnlgeCXC4e1g/5
 +sv9wzjPfsyjsTAY1ROaqn4GN79NRlpVRmQ6wfBaZGho5vjbehEVEMwBla6tVretm+SXbkuWAYm
 15WAUnYNmOa5IkZQzrPfgagO8EdvRQLw/jhpVdZu5gI6hT/BKlmlGuClWZz+Z08S8s+Ctmk10MN
 bqYMxdIrIUTFh/JUyXvoyLC50vEK1M0ZCL/VCA4Gi1aEoWYEiJzuMKFqXAPRV8yQecqKxUF4u3W
 e0HpmA9lp1hOiTOtnyv5+QSD/hAEdNxKtdH0rQIJ19q+V/SasRvjsFIJ9xA7g+G3ZDhH41e7MG6
 1ahHRGqJFFMGdDy09OJpZncB7PADaHUyqIgugIaF8Xm8VkbSKbqi7iAJaFNzr5XUkJ/swKoLefE
 9/8zRkgcvykJTvHTdKA==
X-Proofpoint-ORIG-GUID: GsjuZw2DM30cODSCOsLG-4dszYUD17B5
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b099258 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=7CQSdrXTAAAA:8 a=cPKN5jb6Pdq7kSXABbwA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

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

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Reviewed-by: Joey Gouly <joey.gouly@arm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/sys_regs.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b8daecbf16f6..950f32894d80 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3992,6 +3992,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	EL2_REG(SP_EL2, NULL, reset_unknown, 0),
 };
 
+static const size_t num_sys_reg_descs = ARRAY_SIZE(sys_reg_descs);
+
 static bool handle_at_s1e01(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			    const struct sys_reg_desc *r)
 {
@@ -5217,7 +5219,7 @@ static bool emulate_sys_reg(struct kvm_vcpu *vcpu,
 {
 	const struct sys_reg_desc *r;
 
-	r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	r = find_reg(params, sys_reg_descs, num_sys_reg_descs);
 	if (likely(r)) {
 		perform_access(vcpu, params, r);
 		return true;
@@ -5235,7 +5237,7 @@ static const struct sys_reg_desc *idregs_debug_find(struct kvm *kvm, loff_t pos)
 {
 	unsigned long i, idreg_idx = 0;
 
-	for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
+	for (i = 0; i < num_sys_reg_descs; i++) {
 		const struct sys_reg_desc *r = &sys_reg_descs[i];
 
 		if (!is_vm_ftr_id_reg(reg_to_encoding(r)))
@@ -5298,7 +5300,7 @@ static const struct sys_reg_desc *sr_resx_find(struct kvm *kvm, loff_t pos)
 {
 	unsigned long i, sr_idx = 0;
 
-	for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
+	for (i = 0; i < num_sys_reg_descs; i++) {
 		const struct sys_reg_desc *r = &sys_reg_descs[i];
 
 		if (r->reg < __SANITISED_REG_START__)
@@ -5400,7 +5402,7 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long i;
 
-	for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
+	for (i = 0; i < num_sys_reg_descs; i++) {
 		const struct sys_reg_desc *r = &sys_reg_descs[i];
 
 		if (!r->reset)
@@ -5624,8 +5626,8 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_get(vcpu, reg->id, uaddr);
 
-	return kvm_sys_reg_get_user(vcpu, reg,
-				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	return kvm_sys_reg_get_user(vcpu, reg, sys_reg_descs,
+				    num_sys_reg_descs);
 }
 
 int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
@@ -5664,8 +5666,8 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_set(vcpu, reg->id, uaddr);
 
-	return kvm_sys_reg_set_user(vcpu, reg,
-				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	return kvm_sys_reg_set_user(vcpu, reg, sys_reg_descs,
+				    num_sys_reg_descs);
 }
 
 static unsigned int num_demux_regs(void)
@@ -5753,7 +5755,7 @@ static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
 	int err;
 
 	i2 = sys_reg_descs;
-	end2 = sys_reg_descs + ARRAY_SIZE(sys_reg_descs);
+	end2 = sys_reg_descs + num_sys_reg_descs;
 
 	while (i2 != end2) {
 		err = walk_one_sys_reg(vcpu, i2++, &uind, &total);
@@ -5802,7 +5804,7 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
 	if (clear_user(masks, KVM_ARM_FEATURE_ID_RANGE_SIZE * sizeof(__u64)))
 		return -EFAULT;
 
-	for (int i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
+	for (int i = 0; i < num_sys_reg_descs; i++) {
 		const struct sys_reg_desc *reg = &sys_reg_descs[i];
 		u32 encoding = reg_to_encoding(reg);
 		u64 val;
@@ -6004,7 +6006,7 @@ int __init kvm_sys_reg_table_init(void)
 	int ret = 0;
 
 	/* Make sure tables are unique and in order. */
-	valid &= check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), true);
+	valid &= check_sysreg_table(sys_reg_descs, num_sys_reg_descs, true);
 	valid &= check_sysreg_table(cp14_regs, ARRAY_SIZE(cp14_regs), false);
 	valid &= check_sysreg_table(cp14_64_regs, ARRAY_SIZE(cp14_64_regs), false);
 	valid &= check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs), false);
@@ -6027,7 +6029,7 @@ int __init kvm_sys_reg_table_init(void)
 
 	check_feature_map();
 
-	for (i = 0; !ret && i < ARRAY_SIZE(sys_reg_descs); i++)
+	for (i = 0; !ret && i < num_sys_reg_descs; i++)
 		ret = populate_sysreg_config(sys_reg_descs + i, i,
 					     needs_nv_trap(sys_reg_descs + i));
 

-- 
2.56.1

