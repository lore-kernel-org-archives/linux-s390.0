Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE4450903;
	Mon,  6 Jul 2026 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328003; cv=none; b=V2d9tTBavlSjo+ZsSHsydkOG+Pvc3+dwvWoYzzeCtS5gF9rOGSyVSIGm4dRSx9Q9x4Pm7G92yCPa2zidrSSAtvsGDYARTrR5/R+s/0dmcUqdMlO/8cQVCUEZmLV+ms+2ja4ST0fzJfg/jeYnS70yzs8nriEx8Jy5N/7d8d0/DJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328003; c=relaxed/simple;
	bh=5mfIgye/Uhx4IgSarklyhbrnLmljJK0s/ZdFN4FCLFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoqsE2QJI+yFkFUMtCdeOfEe7Y6PePZiuLxFlyAXl065bfZ1ddpyXb05Yyi6u4sczFyC82WCG3I/b84c/NDxDWlDyAfNREb/wEc6WvYmljUBFEDi0NIrKAwhhYPt3Xg/vfmw5vqzyvwsCvNkVHDGryD1pRJ9pQ319R+T2O2LdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ojvvnk4F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ojvvnk4F"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIXdo1515271;
	Mon, 6 Jul 2026 08:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FygMkskWWauJrTWGr
	4Lk4tJwoERu7VPvRrn22eMwQrE=; b=Ojvvnk4FGriyUQ8tASVOGwG/gb8SoC/Nt
	P4NeK1n8K4cpk5XJzD84ZkgLS8zgWj/fARzFgBokssiZxQm60O0NXaiFlQxmsZYa
	0tCrNzW+YuX5rkiobSUf9GzWTgGJdSxsUs1X0qTS1jpgdY02iYMnnC9w2T750qDn
	ziUu5u30+oYclr5BF7FZC1aeqC377Fg+Tyof+LSlHrLU9HxYzxNK2LDqh7IlQoww
	7EVM/ct5mE7PRtwjE8ltpmnQIBKeLmZ+sM9MOnZyp4hgDWWxmQ1Us5D93mB6asLO
	r8NUTEvlsnbsi492VqVogdNMTSVPlxzXThuVehuu8Gm8w8QqMyFYw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdh6v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668ndsf022416;
	Mon, 6 Jul 2026 08:52:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4qdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qYAE56754512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16A5A20040;
	Mon,  6 Jul 2026 08:52:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B05B12004B;
	Mon,  6 Jul 2026 08:52:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:33 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v4 10/27] KVM: arm64: Refactor core-reset into a separate function
Date: Mon,  6 Jul 2026 10:52:10 +0200
Message-ID: <20260706085229.979525-11-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b6cda cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=mG5WgqR7HocGrkJ2-aYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX+2pc5gaR5lgs
 McArzd/Wvdx9+a1cJuc200vfLPgSiPywgyBj2/v5tIbBaa2zh5E9q0/HRhTaS/kE/eH2+Ab+Atk
 kDBKDpr8qaVmTJZDVrfjsd8jTu4GBEe3HXzZ4L45AT9llKFmmwq2MOxoq6558QNYOD4xNMkJer7
 /MSm8/ZeCdlM/9k4gemye5btVledPljG7uAuEYZzXkAlQQhRDqf4E5MMZDsmJY0auZg6ArZOu8B
 Foz7X5kjFQMwvRfPfWw2iNu08hZb2mzmWomaFniCn9TkWx5W+6y6GfMEmRdQ7fK6rFVntSJD2nb
 aO1xfBlZHSwuoWbyNH1IIeH29e+aKvC4EkrAH88HmVgNqnbkyf+iBX8UN606Co41O1d0e7GHdU5
 lgWE5l4ebCH8IdW7LabhxZtm/cUrfKv3RzE0T0D2VQvtop1MD+nnIWVNdEljrP0nay1PrmAsY6H
 La3Bxp8jUALwpCnuC4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX8++TuY1nZ9P2
 J1rGyJSUuljWtfChmpd8M5NkJcxvY0SpkBPKwZaoNHLlcJeaQ9ddL4oDKStdEOguNRHptFcZo5e
 FUDpT+dp39CRF8xEdjiBD1kXIxmi238=
X-Proofpoint-GUID: -OKD7cXNc3gJJKyLlheCLezqMa4UyYV3
X-Proofpoint-ORIG-GUID: -OKD7cXNc3gJJKyLlheCLezqMa4UyYV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Move the reset of the arm core register into a separate function and
share it with s390.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/reset.c | 45 ++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 1ce3b26cc1ae..81d9f0faede2 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -172,6 +172,33 @@ static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
 		memset(vcpu->arch.sve_state, 0, vcpu_sve_state_size(vcpu));
 }
 
+#ifdef ARM64_S390_COMMON
+static void kvm_reset_vcpu_core_regs(struct kvm_vcpu *vcpu)
+{
+	u32 pstate;
+
+	if (vcpu_el1_is_32bit(vcpu))
+		pstate = VCPU_RESET_PSTATE_SVC;
+	else if (vcpu_has_nv(vcpu))
+		pstate = VCPU_RESET_PSTATE_EL2;
+	else
+		pstate = VCPU_RESET_PSTATE_EL1;
+
+	memset(vcpu_gp_regs(vcpu), 0, sizeof(vcpu_gp_regs(vcpu)));
+	*vcpu_pc(vcpu) = 0;
+	*vcpu_sp_el0(vcpu) = 0;
+	memset(kvm_vcpu_get_vregs(vcpu), 0, sizeof(*kvm_vcpu_get_vregs(vcpu)));
+	memset(kvm_vcpu_get_fpsr(vcpu), 0, sizeof(*kvm_vcpu_get_fpsr(vcpu)));
+	memset(kvm_vcpu_get_fpcr(vcpu), 0, sizeof(*kvm_vcpu_get_fpcr(vcpu)));
+	vcpu->arch.ctxt.spsr_abt = 0;
+	vcpu->arch.ctxt.spsr_und = 0;
+	vcpu->arch.ctxt.spsr_irq = 0;
+	vcpu->arch.ctxt.spsr_fiq = 0;
+	*vcpu_cpsr(vcpu) = pstate;
+}
+
+#endif /* ARM64_S390_COMMON */
+
 /**
  * kvm_reset_vcpu - sets core registers and sys_regs to reset value
  * @vcpu: The VCPU pointer
@@ -194,7 +221,6 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_reset_state reset_state;
 	bool loaded;
-	u32 pstate;
 
 	spin_lock(&vcpu->arch.mp_state_lock);
 	reset_state = vcpu->arch.reset_state;
@@ -213,23 +239,8 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		kvm_vcpu_reset_sve(vcpu);
 	}
 
-	if (vcpu_el1_is_32bit(vcpu))
-		pstate = VCPU_RESET_PSTATE_SVC;
-	else if (vcpu_has_nv(vcpu))
-		pstate = VCPU_RESET_PSTATE_EL2;
-	else
-		pstate = VCPU_RESET_PSTATE_EL1;
-
 	/* Reset core registers */
-	memset(vcpu_gp_regs(vcpu), 0, sizeof(vcpu_gp_regs(vcpu)));
-	*vcpu_pc(vcpu) = 0;
-	*vcpu_sp_el0(vcpu) = 0;
-	memset(&vcpu->arch.ctxt.fp_regs, 0, sizeof(vcpu->arch.ctxt.fp_regs));
-	vcpu->arch.ctxt.spsr_abt = 0;
-	vcpu->arch.ctxt.spsr_und = 0;
-	vcpu->arch.ctxt.spsr_irq = 0;
-	vcpu->arch.ctxt.spsr_fiq = 0;
-	*vcpu_cpsr(vcpu) = pstate;
+	kvm_reset_vcpu_core_regs(vcpu);
 
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
-- 
2.53.0

