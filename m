Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789454;
	b=dYoVvmrUktxBh3eNUpomWUWsOrQCRKQQb6xw8j++bAOKkEQbWsyupifx2s5vQ9UnIhpY
	 WwZifXQxIBGpOJ6yclJzFgghesVl/OkCTjXS/CEoj+AZl/F5agfgIYA2XEi2WkB/ihcNT
	 gNce1QoFaghTJ2CMpw/B+EOhO1sXHarvwPWBjaVtw5CGvaJQ0Ms2F6qb4u48on2aZCaoX
	 lMcUE8aEI1mR4KeJ7IgtMSzELWwrLD4FgVofghcjW4Iqy1iEwyntsRi60qL3q4pcsZzmC
	 A3x4mD7CdiTK89g+t+ywHKI2qvqzQo2RG45axRRC4lvBRstTQgsjXmD8hE+h31vUo5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789454;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bpe0L+Ovicxjt0pkeM4hUG6GDwexetxJ0+15mm22iys=;
	b=uzwLfJQ+kyoJWOZDB45/RhILImis3sokHbe/Y0L9q5cXPVT44kxxZYm/OdXlHds9163o
	 F7jvDqk8bVvTEvEda11IcDt/2zVwXBta5cUlB9so5N7mchoGlVyrH/hIsuRuu06ECFRQQ
	 Gj7XtM6cDDK7cF8D0+Q70ijdtW/PUvaHi3Tyqi2YKxo/OfI6aM0BYSDKtZ7TPifC992K4
	 M4aBdJBdCV+GnrW+2sqeRBMiE734GHcyidhi8IZ0vrWu22Lv5PtQn4rt3LwPBCbEmWeCj
	 wHBfz749w5RjlilbxYq0ht1K80FH9YwLiWyjhW/lF/wJK9D+fsCW9D+F2mi3Ks856mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KpzwlV59;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DC606A69E;
	Fri, 27 Nov 2026 14:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 346DC606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KpzwlV59
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4l8F1650375;
	Fri, 27 Nov 2026 14:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bpe0L+
	Ovicxjt0pkeM4hUG6GDwexetxJ0+15mm22iys=; b=KpzwlV59Hdwn+MRIxhEHE4
	ed7u6ayz+jf9NDWV2M4bi6n4JLDNmUML6mSCZcMbRSbBpuAR73X1AS0DSBtMfBYz
	0AgqKDBUOVcwPX7oRYjku4TdXjJVox4hZwOSU4GHK2lbB88SiUUFosBmn/2gpC+h
	3Pw6aiY0r+pCmtgI4/E7wGtahIYIBx3bvqCRSubxiRfXK4BggXPAjxL6lyvFuMbi
	Mlyz15pMjh2m3xYGm6I0ZO8g9RG80hb5Lqi4C1YDaUQZe2bsyncV0OocGJ4jzuV2
	Q8gHejZ/F1BOTtBOpU8Z36zGhG/R+4De7CNaBjtM5zCPF4Qy3gi4xb+18D6aNcKQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3p7hn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4IY0861624;
	Fri, 27 Nov 2026 14:23:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg4d55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENIZ851118544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DF7B2006B;
	Fri, 27 Nov 2026 14:23:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D0DE20063;
	Fri, 27 Nov 2026 14:23:17 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:17 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:12 +0100
Subject: [PATCH v4 09/25] KVM: arm64: Prepare sys_regs.c for sharing with
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
Message-Id: <20261127-sysreg-v4-9-a6318d18aab5@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b09925b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=9-t8X3E59gj7HnmGAIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfXztHrbNQ9+1t4
 4txgJpRaYo0ZVD8vBSlrF8IcY+0yWQA3tzxh+HVhi1Oj+dT+5DhsqFiM5s8aWRqeDzJ/coWVu6+
 KW70gnY64icxAMNeDu7pAUH/GIuuSe0=
X-Proofpoint-ORIG-GUID: gIql_6EavJQIWXsp3f6GBHwMaMhvl1kW
X-Proofpoint-GUID: gIql_6EavJQIWXsp3f6GBHwMaMhvl1kW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX/BAhUjvWZ3KT
 jwWFAOBE0yL/sVlo3yNm4anfr1+S4U8t7qivCsdHBwtG4djKJ02jcu9ADHRNtP3zE4TY/3R3x5I
 mAj1qkRlXCqyjSMTGO5MTJL+mS9QOn85+oseVZubmYN5qjzliO2+Z6bIMq5sTIiy9JKyS37l5x9
 8gCuTO7CWZavUdvZGLnSJ4m6pLzvP3IRBnv/kEYq75J6f4pQRpLpJnU+4P2DMYDoXREKLiacYRo
 UNNTgxHZMwGRkXm0J4eMBolvdO9z5r6S/tHPhaA2zANzFpDz3W35LWNKv9tGPBzQuIsg0bcRcq/
 dPiDJ3dVTVdqjki6QZ2mvdYcMCY+7ostPIwrTg+b/Gtsubgt+PEG1I7wb/nNAkOxEItqkTdZeyd
 UIqcZVpDdnEsL7VlJN+uu+6WzUVnzH+OD6zjEMd1nSkjXz5jOHyihy7PKGhFyyvlBiR3LOTR5o1
 kefn0FHyTEnbaQjsrhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

Prepare sharing of sys_regs.c with s390 by moving
reset_{vm,vcpu}_ftr_id_regs just before the UAPI definitions. Also, move
kvm_handle_cp14_load_store to other cp functions. This small refactoring
allows to have less shared sections.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/sys_regs.c | 52 +++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index ac78ca0ba59c..abc49d4968f6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -4885,12 +4885,6 @@ static bool check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
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
@@ -4918,6 +4912,12 @@ static void perform_access(struct kvm_vcpu *vcpu,
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
@@ -5370,25 +5370,9 @@ void kvm_sys_regs_create_debugfs(struct kvm *kvm)
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
@@ -5462,6 +5446,26 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
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
2.56.1

