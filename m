Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FEA3F7891;
	Fri, 29 May 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070516; cv=none; b=LB+a4sgqIwxU4zUvaoByC7H3bVbpmGRwZgPE/bH4GSIaGVWPA7ldcjxXg2HOpX9w/AHkH7j+Of1sUHEUdFTT4kPuMLafq0NBOx8EYuqF3o7sitPTHA+2b3Ag0SDFWUOkJP11sGAcsXi0jBxK1z4NR100N5nmy1SWSuwNgoQvHfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070516; c=relaxed/simple;
	bh=2DnL581tiMP0xz3bQis3dMPdfTPq2gIL8VpTvpHoZ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFoFwsXLcemLG6lWKYuOf6F0LzyufQoB1nenoz2SyU+oyprTPWCZ9eUWBamVTJWrSXWYmBCrsuRe8tZSlXgXnfa/5L11q8vuDZXjzDUjL7L5QZiqIo4E7vycWe5Y5ZBa0CC9AOjMVdDNZyHylTrT+bM0dFKjS+ixl8NIUE94In4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kL1F6keG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kL1F6keG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFDh9g1467773;
	Fri, 29 May 2026 15:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J4lB+fU5DdjjQ/QpM
	hV9CNZD0t3w/aRQR+zfaUlpeSE=; b=kL1F6keG/qqmfuhVM3ACxkRQ6/oAiceJA
	usauQSDAeEvlYyJPXNOB9tq83YKMRAepuwx45XfYOHesOqkaduurvCnQ68Rm6p/o
	Pmh4XrNhIr7prw8pkUaStUIP+PszaRgGorGNaaKz/yOAmXf1tYM3IiDp/veCKoWx
	NDrOQAjC40HYlNKcqnojiRrI8CLR3wxFJV5cbn+/9nr38jcc2IL2r3xuRV42uv7x
	B7f/Ii9I63US33AwVqNGbmNxgA7hpJhqIQflO+97uKcXzKlB2d/8qEqvyg/U7YA9
	/deYZAC6GjNjYXnnQiixx8X4ttPoUI/8BtO+lTCwRnPOgiu2CStqw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886mgg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs7To027773;
	Fri, 29 May 2026 15:56:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc8jmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu6gp36700646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DBF120040;
	Fri, 29 May 2026 15:56:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 115E92004D;
	Fri, 29 May 2026 15:56:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:06 +0000 (GMT)
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
Subject: [PATCH v1 11/26] KVM: arm64: Move definitions from sys_regs.c to sys_regs.h
Date: Fri, 29 May 2026 17:55:44 +0200
Message-ID: <20260529155601.2927240-12-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UC2v4yac9XJv9onHFWDc9OYBfj2NePhe
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19b71d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=zJUOOSkNxElFdCtx_FUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX8/oZd7tugLX4
 VT1BjfXkRoZiX97FWd9xENgoBEOimXfjRSHnS4ASmTMGMpGduJ/02jpXxbpeEFwee07o2moF7s/
 72lctKgbrzKFtic0CA7WNwrweU9zW+jO8B8kX8expd9rO6WoAANeefTVv67e9M7MnYTS3h0VRsQ
 RQE+HcfA1XHoInM25N7I4WEtz3MwMX8xnUzVF2AtdDSXE29RGOiob5glD3ByDwGAPwc9c/Ci5KK
 sJcJegVKO6vPsppxdRK6lzdVcZ0wcXLGleifHxJUS1DnRFMTiwQf/nIHxcmQbjrITwVrhNdEJLv
 XGu923W7/zKh6xVsNwn6dAt18w8VSyKWakOjgRUt8hAghGrzlHg4GftQiyb12Rf/l101U5ISOhi
 NxbmGF+asOiPRKI9ZTU8n9+ahODDZpICEDMKcEih6N212FCAm+z3qY9mPdRVyd3BrHY96fUEblZ
 jnObIFztGgWVZjFwmIw==
X-Proofpoint-ORIG-GUID: UC2v4yac9XJv9onHFWDc9OYBfj2NePhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Make kvm_sanitised_host_ftr_reg() and kvm_read_sanitised_id_reg()
available to enable code sharing with s390. Move some helper and ID
register macro definitions to the header file. No functional changes.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/sys_regs.c | 12 ++----
 arch/arm64/kvm/sys_regs.h | 87 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 6522f9302967..46b24529ec70 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1852,7 +1852,7 @@ static u8 pmuver_to_perfmon(u8 pmuver)
 /*
  * Sanitise based on the host implementation.
  */
-static u64 kvm_sanitised_host_ftr_reg(u32 id)
+u64 kvm_sanitised_host_ftr_reg(u32 id)
 {
 	u64 val = read_sanitised_ftr_reg(id);
 
@@ -2039,8 +2039,8 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 	return val;
 }
 
-static u64 kvm_read_sanitised_id_reg(struct kvm_vcpu *vcpu,
-				     const struct sys_reg_desc *r)
+u64 kvm_read_sanitised_id_reg(struct kvm_vcpu *vcpu,
+			      const struct sys_reg_desc *r)
 {
 	return __kvm_read_sanitised_id_reg(vcpu, r);
 }
@@ -2123,12 +2123,6 @@ static unsigned int aa32_id_visibility(const struct kvm_vcpu *vcpu,
 	return id_visibility(vcpu, r);
 }
 
-static unsigned int raz_visibility(const struct kvm_vcpu *vcpu,
-				   const struct sys_reg_desc *r)
-{
-	return REG_RAZ;
-}
-
 /* cpufeature ID register access trap handlers */
 
 static bool access_id_reg(struct kvm_vcpu *vcpu,
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 2a983664220c..75d581050b09 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -108,6 +108,12 @@ struct sys_reg_desc {
 #define REG_RAZ			(1 << 1) /* RAZ from userspace and guest */
 #define REG_USER_WI		(1 << 2) /* WI from userspace only */
 
+static inline unsigned int raz_visibility(const struct kvm_vcpu *vcpu,
+				   const struct sys_reg_desc *r)
+{
+	return REG_RAZ;
+}
+
 static __printf(2, 3)
 inline void print_sys_reg_msg(const struct sys_reg_params *p,
 				       char *fmt, ...)
@@ -237,6 +243,12 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index);
 
 int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu);
 
+u64 kvm_read_sanitised_id_reg(struct kvm_vcpu *vcpu,
+			      const struct sys_reg_desc *r);
+
+/* Implemented by each architecture */
+u64 kvm_sanitised_host_ftr_reg(u32 id);
+
 #define AA32(_x)	.aarch32_map = AA32_##_x
 #define Op0(_x) 	.Op0 = _x
 #define Op1(_x) 	.Op1 = _x
@@ -257,6 +269,81 @@ int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu);
 	CRn(sys_reg_CRn(reg)), CRm(sys_reg_CRm(reg)),	\
 	Op2(sys_reg_Op2(reg))
 
+/*
+ * Since reset() callback and field val are not used for idregs, they will be
+ * used for specific purposes for idregs.
+ * The reset() would return KVM sanitised register value. The value would be the
+ * same as the host kernel sanitised value if there is no KVM sanitisation.
+ * The val would be used as a mask indicating writable fields for the idreg.
+ * Only bits with 1 are writable from userspace. This mask might not be
+ * necessary in the future whenever all ID registers are enabled as writable
+ * from userspace.
+ */
+
+#define ID_DESC_DEFAULT_CALLBACKS		\
+	.access	= access_id_reg,		\
+	.get_user = get_id_reg,			\
+	.set_user = set_id_reg,			\
+	.visibility = id_visibility,		\
+	.reset = kvm_read_sanitised_id_reg
+
+#define ID_DESC(name)				\
+	SYS_DESC(SYS_##name),			\
+	ID_DESC_DEFAULT_CALLBACKS
+
+/* sys_reg_desc initialiser for known cpufeature ID registers */
+#define ID_SANITISED(name) {			\
+	ID_DESC(name),				\
+	.val = 0,				\
+}
+
+/* sys_reg_desc initialiser for writable ID registers */
+#define ID_WRITABLE(name, mask) {		\
+	ID_DESC(name),				\
+	.val = mask,				\
+}
+
+/*
+ * 32bit ID regs are fully writable when the guest is 32bit
+ * capable. Nothing in the KVM code should rely on 32bit features
+ * anyway, only 64bit, so let the VMM do its worse.
+ */
+#define AA32_ID_WRITABLE(name) {		\
+	ID_DESC(name),				\
+	.visibility = aa32_id_visibility,	\
+	.val = GENMASK(31, 0),			\
+}
+
+/* sys_reg_desc initialiser for cpufeature ID registers that need filtering */
+#define ID_FILTERED(sysreg, name, mask) {	\
+	ID_DESC(sysreg),				\
+	.set_user = set_##name,				\
+	.val = (mask),					\
+}
+
+/*
+ * sys_reg_desc initialiser for architecturally unallocated cpufeature ID
+ * register with encoding Op0=3, Op1=0, CRn=0, CRm=crm, Op2=op2
+ * (1 <= crm < 8, 0 <= Op2 < 8).
+ */
+#define ID_UNALLOCATED(crm, op2) {			\
+	.name = "S3_0_0_" #crm "_" #op2,		\
+	Op0(3), Op1(0), CRn(0), CRm(crm), Op2(op2),	\
+	ID_DESC_DEFAULT_CALLBACKS,			\
+	.visibility = raz_visibility,			\
+	.val = 0,					\
+}
+
+/*
+ * sys_reg_desc initialiser for known ID registers that we hide from guests.
+ * For now, these are exposed just like unallocated ID regs: they appear
+ * RAZ for the guest.
+ */
+#define ID_HIDDEN(name) {			\
+	ID_DESC(name),				\
+	.visibility = raz_visibility,		\
+	.val = 0,				\
+}
 #define ID_REG_LIMIT_FIELD_ENUM(val, reg, field, limit)			       \
 ({									       \
 	u64 __f_val = FIELD_GET(reg##_##field##_MASK, val);		       \
-- 
2.53.0

