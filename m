Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981324;
	b=1N43n7Er0vcRqTnQnUTqO6yvuDK5yZGnbS+IWh2/05xmByA9EdmVa/rudPlf/A+Cxbxf
	 BjmdBkIqSKL7lLczWA7e3TNHFHXII3VFvs6A2K4Cymxdjn2cJ2M9G3qZrlTputVICSurH
	 0YUNRpNcueETG+048IBCw/+Dv6Jeg/Ekgm0M3Qn6jvW8o6CWXA9xzj4pQnmaMyGy45Rj6
	 E0dukszouxczrD/JPP756rShHFEIt5J0ppOOO/+3uHxaVl4UorL24mcVx5feI1r1K8VJo
	 2a2wAenSZ2Ge4UTUMHCjvarFg6P5FPWntS+fLgueB/qUCM3ZXTKW3loY/854pYvEjjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981324;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+s0U0/RBz5gZJ5vCvPrWjCby1brugreY5tbfHdLekbc=;
	b=MmQpylGjoe6VBscvYmscR1Qgak6F54UO7FsKo2ubMBvx4OT2HYl22+tvqIb2DOydne3+
	 nZ0H4oqSFu4miD1WdkWEoqbAcrO13Dl2JSPAPUg1NEeNc6nhjWOmCBZEzNrvZoycq1x7n
	 q8bkhOKEKVqrdqXg8K3JK45Z66qJypGtHecv2mDy2KUL+3irPx1O88toqJ8QTtfA7bMlT
	 daR83YT95kOOQ5rb2AsMO7qM/E6QxK9+NLvWK4aoslVX/JQQAazN30cGfE4jp7h7fxxVe
	 Wzw8mw7CLzq7JTcGzACOKFVqdmLbjDYSuqAhantgMonVQ6TO0oiwInn3IsFfaGYAZxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c+UEGKEF;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3C606A33C;
	Fri,  6 Nov 2026 16:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C3C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c+UEGKEF
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEEmm2711388;
	Fri, 6 Nov 2026 16:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+s0U0/
	RBz5gZJ5vCvPrWjCby1brugreY5tbfHdLekbc=; b=c+UEGKEFwZCd+nahlAddja
	Ug2BE54rGNxegbXd+dKWdLTZjEcPp/guclsqwbUVaGNVaRUlbuv6Pc92Dpllnr/r
	s1oDoH4bkph3oY7Fgs8VAqY+8/a+HVzZgs1sJjujdvGMweTYCcmdk6vwmDLYrEi8
	JMj5vtE8aDYaKI3Jqvm0xOVE6aSm9xro5DiWJanTuG6qlNsuqTDO5kwb1R4xoj3W
	Ro3cbrarGzy8iFuz/8SuZud6xMWAlF+o1wS/aLULBxzWdHOWswBrht8OT9ETShf5
	XL4mLwkCDteN3yQNloMajdgBY3qgI9VGup/fe6XceQOa8wZ1scBKQIKqt9fDrhvQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r95gwu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4t2h3476036;
	Fri, 6 Nov 2026 16:08:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmress06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8GKJ47579594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C025920040;
	Fri,  6 Nov 2026 16:08:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 649F42004F;
	Fri,  6 Nov 2026 16:08:16 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:16 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:40 +0100
Subject: [PATCH v3 07/23] KVM: arm64: Prepare sys_regs.c for sharing with
 s390
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
Message-Id: <20261106-sysreg-v3-7-75e95980fb10@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedfb75 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=9-t8X3E59gj7HnmGAIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -pX1Z9GW6JL8QqSOMXXoNkiOmiJtCJQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX+PGo3QcJtNQc
 17Z8j6Ly0DToRWyb0IHl41E/zRHGDESPn0TME9Ti7wo53ZzOKEKRW+mCLe6JK+NW8LlSwy9rG4X
 UHuuDRWufNvruISz8QVK/fTIUwgZ8RAMNhzfokn1+4lXjkeuUXMOXpgJIBLrNLRoHXLfE+YQJIG
 gIdNQWoPc8d5fizcSuWiZ1TB8JaNtF9bgnFJWYzpNQNxYGaWpjuh2mskjlOxmlzAc1DoL1Kb77b
 nZNFvUSa8M1jZT83lkmqot/TfFLPQ7+JcEX1tHJxOcXGvvlBVZPKPAgvGPsRKziE+FASXodmZqq
 xeN74cZLiLF2pmrge6ltyyFKKLqeX/GPiWuhI6Ey+XsJulejMUsm+h7oq72AFEfbfM6QZr+jgfp
 9iCykS+nMnKxZlLUNp2UCKn6HHUZQW+6vF1+IrEjQv1JeRGuYXo4oHdB//gRMiYoIyTpktMEZ3z
 PXGOiHKhUYl+AGrkl6A==
X-Proofpoint-GUID: -pX1Z9GW6JL8QqSOMXXoNkiOmiJtCJQV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX6y+Q/GmXsJQj
 5INdRl7n449K11Er7eTKSEaks74XDwYPHQYKTllbzogGLAb7G/2lBtdVw2EFcTWSgGs5SSNwK3H
 3jNTjoPwVfd02bdWbinpTHF9Yn03beo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060062

Prepare sharing of sys_regs.c with s390 by moving
reset_{vm,vcpu}_ftr_id_regs just before the UAPI definitions. Also, move
kvm_handle_cp14_load_store to other cp functions. This small refactoring
allows to have less shared sections.

No functional changes.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/sys_regs.c | 52 +++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 8c91de6a4097..e71c1b169b49 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -4855,12 +4855,6 @@ static bool check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
 	return true;
 }
 
-int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu)
-{
-	kvm_inject_undefined(vcpu);
-	return 1;
-}
-
 static void perform_access(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *params,
 			   const struct sys_reg_desc *r)
@@ -4888,6 +4882,12 @@ static void perform_access(struct kvm_vcpu *vcpu,
 		kvm_incr_pc(vcpu);
 }
 
+int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu)
+{
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
 /*
  * emulate_cp --  tries to match a sys_reg access in a handling table, and
  *                call the corresponding trap handler.
@@ -5340,25 +5340,9 @@ void kvm_sys_regs_create_debugfs(struct kvm *kvm)
 			    &sr_resx_fops);
 }
 
-static void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *reg)
-{
-	u32 id = reg_to_encoding(reg);
-	struct kvm *kvm = vcpu->kvm;
-
-	if (test_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
-		return;
-
-	kvm_set_vm_id_reg(kvm, id, reg->reset(vcpu, reg));
-}
-
+static void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *reg);
 static void reset_vcpu_ftr_id_reg(struct kvm_vcpu *vcpu,
-				  const struct sys_reg_desc *reg)
-{
-	if (kvm_vcpu_initialized(vcpu))
-		return;
-
-	reg->reset(vcpu, reg);
-}
+				  const struct sys_reg_desc *reg);
 
 /**
  * kvm_reset_sys_regs - sets system registers to reset value
@@ -5432,6 +5416,26 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *reg)
+{
+	u32 id = reg_to_encoding(reg);
+	struct kvm *kvm = vcpu->kvm;
+
+	if (test_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags))
+		return;
+
+	kvm_set_vm_id_reg(kvm, id, reg->reset(vcpu, reg));
+}
+
+static void reset_vcpu_ftr_id_reg(struct kvm_vcpu *vcpu,
+				  const struct sys_reg_desc *reg)
+{
+	if (kvm_vcpu_initialized(vcpu))
+		return;
+
+	reg->reset(vcpu, reg);
+}
+
 /******************************************************************************
  * Userspace API
  *****************************************************************************/

-- 
2.56.0

