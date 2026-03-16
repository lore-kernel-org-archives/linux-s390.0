Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54233E373;
	Mon, 16 Mar 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684276; cv=none; b=M+zQiqxo4CS1K39IqD6rQbHdgRkRLMjgS+MiIf84idLo9FprUIsSNskKkMnCVV+g4vxv0DQaYKOU7qaFkp9V46G/lRL/KgCYYwMLKcExZNLIOSDzXI5dVoyz2nxEPknk+nuSuV4vsXoe+B+hiTE3tMNSgpx3qgdo7AxtUhJJJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684276; c=relaxed/simple;
	bh=4RcjO76RJhLxVACQXXLgrJZUY8y65zw/UJhUSy6L5E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pClEiAC2HjCtC4svf514WgEl083BE//bYCkpqtGGlQHKUzorP9bd6DvSnQ/B0gpp1Ac4aM7bK06StDHgNbNDXzx1tE8zSLqHm6uXvAMi0oPhoG6Rss3nWk75MKtzTl5FDo2aTezhnbzu9Q1jrap0H05G3VaR4P1Y4AO0kU3ModY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dRZH9FrG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dRZH9FrG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GDr68n384426;
	Mon, 16 Mar 2026 18:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2RS1MI6PpN4Fs5GN7
	ptXcWzsDtrgUHMYA6IHF4xonp4=; b=dRZH9FrG7ogRcH6v7mnuzhYlPxnWHcYtH
	5VOrNu2bOchL2fUNzzQwvepnyqYjwQ1LsI7EualMO4VzBiQTPCPUR0xIdKkwBSXG
	1h0HHGz7Y6ZnyeNUWLojUmWTj+FF6oZozd5rnR6i9ynxzdbyYxd+I+kMfDXkYzro
	ZHY2538xDw5vf3jQ0n6MjVxmcjD0qfKbeIn1qOCaMmy2Yl8dFFLT4Q9GuxhRRdUw
	gbJdAkvt4prvGlaZvN/V7bdp3tNtLAZxz1DiVekqiD1Tu7Jb2SePG25ODBsk/dL6
	m+iL6OVt/Gt3sWTxSSwfkiUmtFfxvkIR/cdQv3BxvSOO8SntlSyoQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cru57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GFaSjV015601;
	Mon, 16 Mar 2026 18:04:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n5tsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4LTt28705220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93EA520043;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 748162004E;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 08/10] KVM: s390: Use gpa_t in priv.c
Date: Mon, 16 Mar 2026 16:23:55 +0000
Message-ID: <20260316180310.17765-9-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316180310.17765-1-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b8462a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=7VvbTqNW6zJRGpI7ogIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfXyS3TqJDHHlxR
 uSmV9URSe7kBYDLNxXkQEV+wlCsZVu0163wtIXrxfroupl98YTcdSaY3pJt6EYRO0UCwYWTdJsR
 7OlLvfSLwx9/doIoVhjcOX04uJFNEYngDkDYgrxQGw2H3XvoSI0N8xmss8KwcqoUZJjbTYWacqr
 LOShkapWuG8yuwa6rfJaw4Xnq4ulbydO2+oj3tvPYY2Wvt5lWISPBO5jsLGqWJeytnHVAlBy5zt
 K8t/J51s/got1PnIp8c6Z0KQ8wzKxqhV4jtQhduZtSKCm/ySkbGiegOHWEFR0ljnUO+3+JbkxTt
 YzYtZhtvSoehycoXN7B2r9lrtNHpSjDP5X5F+0EoQxbj6V6TlapNHLreYg2Xfvmmcl2OXZKG7BN
 +6tFlDR2Lv4kvK4ba25qTim/W/DJrHYlTS47iituCdjHm6ariY1QfjwqWBUKLP4IjwcegUAbpHS
 d+1vN9pvv23Q+yTT14A==
X-Proofpoint-GUID: UCYgr9DEn_Gj9mUvM5IX6PhK359oYepd
X-Proofpoint-ORIG-GUID: UCYgr9DEn_Gj9mUvM5IX6PhK359oYepd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160139

More unsigned long to gpa_t conversions.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/gaccess.h |  8 ++++++++
 arch/s390/kvm/priv.c    | 27 ++++++++++++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index f23dc0729649..970d9020dc14 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -89,6 +89,14 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
 	return _kvm_s390_logical_to_effective(&vcpu->arch.sie_block->gpsw, ga);
 }
 
+static inline gpa_t kvm_s390_real_to_abs_effective(struct kvm_vcpu *vcpu,
+						   unsigned long gra)
+{
+	gra = kvm_s390_logical_to_effective(vcpu, gra);
+
+	return kvm_s390_real_to_abs(vcpu, gra);
+}
+
 static inline gpa_t lc_addr_from_offset(struct kvm_vcpu *vcpu, unsigned int off)
 {
 	gpa_t addr = kvm_s390_get_prefix(vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 780186eb6037..78d3338afdb2 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -256,9 +256,9 @@ static int try_handle_skey(struct kvm_vcpu *vcpu)
 
 static int handle_iske(struct kvm_vcpu *vcpu)
 {
-	unsigned long gaddr;
 	int reg1, reg2;
 	union skey key;
+	gpa_t gpa;
 	int rc;
 
 	vcpu->stat.instruction_iske++;
@@ -271,12 +271,10 @@ static int handle_iske(struct kvm_vcpu *vcpu)
 		return rc != -EAGAIN ? rc : 0;
 
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
+	gpa = kvm_s390_real_to_abs_effective(vcpu, vcpu->run->s.regs.gprs[reg2] & PAGE_MASK);
 
-	gaddr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
-	gaddr = kvm_s390_logical_to_effective(vcpu, gaddr);
-	gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
 	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-		rc = dat_get_storage_key(vcpu->arch.gmap->asce, gpa_to_gfn(gaddr), &key);
+		rc = dat_get_storage_key(vcpu->arch.gmap->asce, gpa_to_gfn(gpa), &key);
 	if (rc > 0)
 		return kvm_s390_inject_program_int(vcpu, rc);
 	if (rc < 0)
@@ -288,8 +286,8 @@ static int handle_iske(struct kvm_vcpu *vcpu)
 
 static int handle_rrbe(struct kvm_vcpu *vcpu)
 {
-	unsigned long gaddr;
 	int reg1, reg2;
+	gpa_t gpa;
 	int rc;
 
 	vcpu->stat.instruction_rrbe++;
@@ -302,12 +300,10 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
 		return rc != -EAGAIN ? rc : 0;
 
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
+	gpa = kvm_s390_real_to_abs_effective(vcpu, vcpu->run->s.regs.gprs[reg2] & PAGE_MASK);
 
-	gaddr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
-	gaddr = kvm_s390_logical_to_effective(vcpu, gaddr);
-	gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
 	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-		rc = dat_reset_reference_bit(vcpu->arch.gmap->asce, gpa_to_gfn(gaddr));
+		rc = dat_reset_reference_bit(vcpu->arch.gmap->asce, gpa_to_gfn(gpa));
 	if (rc > 0)
 		return kvm_s390_inject_program_int(vcpu, rc);
 	if (rc < 0)
@@ -1142,8 +1138,8 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
 	int r1, r2, nappended, entries;
 	union essa_state state;
 	unsigned long *cbrlo;
-	unsigned long gfn;
 	bool dirtied;
+	gpa_t gpa;
 
 	/*
 	 * We don't need to set SD.FPF.SK to 1 here, because if we have a
@@ -1151,10 +1147,11 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
 	 */
 
 	kvm_s390_get_regs_rre(vcpu, &r1, &r2);
-	gfn = gpa_to_gfn(vcpu->run->s.regs.gprs[r2]);
+	gpa = vcpu->run->s.regs.gprs[r2];
 	entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
 
-	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state, &dirtied);
+	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gpa_to_gfn(gpa),
+				     orc, &state, &dirtied);
 	vcpu->run->s.regs.gprs[r1] = state.val;
 	if (nappended < 0)
 		return 0;
@@ -1166,7 +1163,7 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
 	 */
 	if (nappended > 0) {
 		cbrlo = phys_to_virt(vcpu->arch.sie_block->cbrlo & PAGE_MASK);
-		cbrlo[entries] = gfn << PAGE_SHIFT;
+		cbrlo[entries] = gpa;
 	}
 
 	if (dirtied)
@@ -1447,10 +1444,10 @@ int kvm_s390_handle_eb(struct kvm_vcpu *vcpu)
 static int handle_tprot(struct kvm_vcpu *vcpu)
 {
 	u64 address, operand2;
-	unsigned long gpa;
 	u8 access_key;
 	bool writable;
 	int ret, cc;
+	gpa_t gpa;
 	u8 ar;
 
 	vcpu->stat.instruction_tprot++;
-- 
2.51.0

