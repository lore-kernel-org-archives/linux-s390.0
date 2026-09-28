Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63E1DFDA1;
	Mon, 28 Sep 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599016; cv=none; b=qlAOLAsGcvAusCf7E+d6a0e4Nrks0BpXUbiCRDCie6BMRL8hBxgsSXQTPbXthlZ14kyRjtUUuR65rIpKfXS3ui6RCxkt3RdWVjN/sqpwZ9XgwM+2twisTDYsN4d222nM2ItAvdf3wLpiQLWYtG30jU97wXFeUD1VkPlR9ayUY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599016; c=relaxed/simple;
	bh=JcVpP/WAcKJEy5+d7HpIk/XjfdT5QGI4HTQJj7O/sJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZczuaCtIp9rihUM2s+0wNDF2Cv66qhaPfAdzV/eeIMF6LJtRiBK2J2l0gKl7fMefYv5CVZRFMLs8y+ehpwEWXzYrdCLkKAAe5AOCg99rNSQu9N3ZxTD/0UP3UKOtyOCMYtgPfZKd2FDYhVRS3LXoxr3OlEQ3KG5JDpvSNql36Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nHW1iOrl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nHW1iOrl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZTxO1011258;
	Mon, 28 Sep 2026 12:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=73HcxSP7Xajty4Uf2
	Q0avce+cElikm/TsBuqVvI4vro=; b=nHW1iOrlpE8MjfS8igTplb9n76aGiNw7J
	K1j1aZH2rM9Bfizr5cttY5HX/ndtqltFQmz7r7LHLsmReLDUPOvGK3LqqJMj00HW
	n7D1OnDowU8M++Ygg5B6RJyO7OHrKxaZT1F/3osPgWfAOoGoGvmBufb9N7Olr/DP
	oxxoqhrSgaQ+ShA9z3YBDxJAp9LcPILE5a8TyTv5mY6buA0TE1eOoRNtXOHUhcOT
	+rAYJDERBeRkW6kjwjM+s363qiMu+wlckGjW+6xY8Bp2LCMRNslKLvdrpdJUIPRc
	gyG9yRl5vQtwVC2lUy/PmDP/if3YTLuWn+32oZKGifyimKKej1NXQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt0vg2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:36:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHZ2A057275;
	Mon, 28 Sep 2026 12:36:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y4xn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:36:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SCanxp40763720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 12:36:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 390FB20043;
	Mon, 28 Sep 2026 12:36:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17B062004E;
	Mon, 28 Sep 2026 12:36:49 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 12:36:49 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v5 3/3] KVM: s390: Add opportunistic floating IRQ delivery
Date: Mon, 28 Sep 2026 12:30:57 +0000
Message-ID: <20260928123639.34226-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928123639.34226-1-frankja@linux.ibm.com>
References: <20260928123639.34226-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rNZuWYxOZd_kWx85-FfHG0SK0vaErf-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1MCBTYWx0ZWRfXyyx8tgdNKDWW
 Gjh2eXOhC4pNCcJcdD7ghCXPN4vplCd5Kk28oanEilFkUnoJ0PIFOUmt1I/3ztKD+Hnx9JO4pDU
 yyu0Uh7hC7RUYneSQZr/EEth2C7drPkSJtkD5x2u7dIE/QmzbHV6B3y4eHtEQv/3ldkmTuzsjXI
 9q/bAE7gRbwrhMJa9S9S1z7aY3PRNXbjr3sQziQvBQz/yjYJP4SBFjrh30E2kGDeiZwC1vj6TgT
 5EB6VEWJ/aGcDukj7VKaZmHdMVROuce8c9nF2NOCu9od9muQwdSBPrfyy/ehxt1I1QYiNG8PRAN
 1ujd4ufXtvni2MGc1p7M4sT3t48EH9LSvvkh0Ewx9qPpoA4v3PO93ExAlMNRNfQ4FlRzntctXJv
 zZb12U6m7ZFAgFSpg8SHGqlb84/1tTsna0vUVYwMxXyrFFbpm+XG4AV1T4fD1XyUv/s/J3vUBNp
 DTPvfcOc35pJBCnb3YA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1MCBTYWx0ZWRfX7wpalZXEZJ6A
 RqSfz9NdTsIrnHFKHicSaPVTFpzlvXif5pKy34vbKXW4+vLdphzLxkzphArroU+aK/oRCsNeR6d
 4pfpK+AWmOkMaNdNHLMSxjWHMgixv3E=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6aba5f65 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=yyYbqD4tj2l4PXq5jccA:9
X-Proofpoint-GUID: rNZuWYxOZd_kWx85-FfHG0SK0vaErf-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280050

Try to distribute floating IRQs which haven't been taken by a VCPU yet
to sleeping VCPUs. This lowers the risk of floating IRQs not being
delivered.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h |  1 +
 arch/s390/kvm/s390/interrupt.c        | 34 +++++++++++++++++++++++++++
 arch/s390/kvm/s390/s390.c             |  1 +
 3 files changed, 36 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index cd692f8fb764..a86863e621b7 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -412,6 +412,7 @@ struct kvm_vm_stat {
 	u64 gmap_shadow_r3_entry;
 	u64 gmap_shadow_sg_entry;
 	u64 gmap_shadow_pg_entry;
+	u64 inject_redist;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrupt.c
index 3c0e6216eee3..1b06775e581b 100644
--- a/arch/s390/kvm/s390/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -372,6 +372,38 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 	return active_mask;
 }
 
+static void distribute_float_irqs(struct kvm *kvm)
+{
+	struct kvm_vcpu *dst_vcpu;
+	int sigcpu, online_vcpus;
+
+	if (!READ_ONCE(kvm->arch.float_int.pending_irqs))
+		return;
+
+	online_vcpus = atomic_read(&kvm->online_vcpus);
+
+	/*
+	 * Not too worried about synchronization for idle_mask. We
+	 * might burn too many cycles but apart from that waking a
+	 * vcpu is not harmful.
+	 */
+	sigcpu = find_first_bit(kvm->arch.idle_mask, online_vcpus);
+
+	/* Well nobody's sleeping so someone will likely take the IRQ soon */
+	if (sigcpu == online_vcpus)
+		return;
+
+	do {
+		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
+		if (deliverable_irqs(dst_vcpu)) {
+			kvm->stat.inject_redist++;
+			kvm_s390_vcpu_wakeup(dst_vcpu);
+			break;
+		}
+		sigcpu = find_next_bit(kvm->arch.idle_mask, online_vcpus, ++sigcpu);
+	} while (sigcpu < online_vcpus);
+}
+
 static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 {
 	kvm_s390_set_cpuflags(vcpu, CPUSTAT_WAIT);
@@ -1294,6 +1326,8 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 	if (!sltime)
 		return 0;
 
+	distribute_float_irqs(vcpu->kvm);
+
 	__set_cpu_idle(vcpu);
 	hrtimer_start(&vcpu->arch.ckc_timer, sltime, HRTIMER_MODE_REL);
 	VCPU_EVENT(vcpu, 4, "enabled wait: %llu ns", sltime);
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index efd77b9cd36c..252fde3abc9c 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -87,6 +87,7 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_COUNTER(VM, gmap_shadow_r3_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_sg_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_pg_entry),
+	STATS_DESC_COUNTER(VM, inject_redist),
 };
 
 const struct kvm_stats_header kvm_vm_stats_header = {
-- 
2.53.0

