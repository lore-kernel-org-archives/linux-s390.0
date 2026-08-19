Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55037BE93;
	Wed, 19 Aug 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166272; cv=none; b=EUsG5x2+LlucZYUIUlQLRtDIAaeh/RFJeFOehH5SZ5DjD0u7fOqSGdWy/He+eJgS/2HCxBDtyY4EyHH8BEdk+NZ8UuU8Wdei/+6NDe0UQ4nhHCJ7DKOjQumZ700l2oFFUVG6kypw0q30kjvC547Lvp5GUZ5XCWmDK1m3Bize+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166272; c=relaxed/simple;
	bh=CkOCXQMFtoO2+1q07MePVqHPZL9SjxpzfC3yHmCKurI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyKkYU4JaBcNOhb8tOOAfh43jGnDckqCAVy43cg+wTiUGV3rJBRTpktgPRGndzW78YSn46Et1H+Zzgw+EPgm9SvnRVNYYg4WXk/LzESlIPjcfOLQETS7c+y5mYUVwRQuiNgjTERijC/R6jzgQATSZYH0423QAoUNOifDOWardGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S5lAF2jU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S5lAF2jU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JI1ocZ3087546;
	Wed, 19 Aug 2026 19:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0cpcF2NoyG9VG7aR6
	Yj30Zo3DZ9gS4JRSPADrCILExk=; b=S5lAF2jUiuh89UCHYw6qW2IzemUi4wZSX
	I/XAzT9+6/6MO3EgU23YJi5IOTpwHaz/mbsonRRWM0UL7yzQlQOBveQ69Uapfq6c
	MjCUDWwSaGxjYuFaxthqFVY2CqfHyMwzb3RgZyAowNn408bG8Q0sOdyDucXnurBe
	LClkT7XER0IZ/EXzaXiC6lAKwnMHxv1qOfduS9koHIjvlFA7xK4dc516zJp2rraW
	OzxTu4doi+e4uPVkIqXiBrW0KIKZGWUlZKSqhIg7M+PUXCB86m/B2xp9sHpN7OT+
	i89Ywas613CMrqboIQkjQg3va+C9hDI/fQud1ERaK+G4wPaKsIRgA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu25kgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 19:04:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JIuFaf023894;
	Wed, 19 Aug 2026 19:04:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yj7ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 19:04:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JJ4PcO29819592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 19:04:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27B6F20040;
	Wed, 19 Aug 2026 19:04:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B3F02004B;
	Wed, 19 Aug 2026 19:04:25 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 19:04:24 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v3 3/3] KVM: s390: Add opportunistic floating IRQ injection
Date: Wed, 19 Aug 2026 18:41:12 +0000
Message-ID: <20260819190408.247843-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819190408.247843-1-frankja@linux.ibm.com>
References: <20260819190408.247843-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a85fe3d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ceVPMvoHt_UTMoFkilYA:9
X-Proofpoint-GUID: lpVvfzRxwXCt7eP5NW7xVIL4NnXgAbzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE0NyBTYWx0ZWRfXwliLZIaRhqKP
 OgtkL83QEqBGxyiwusaT3Z8BunnA6ywNf8orwl6R8WUG88yhwuzbeDPguwEiJ1DwR8WYtJ7Fx3A
 2IfyZhYzqdtO0Vij16WSCkNaBa2FHdSYqHQrIIAprRmPvohC9v33JhG0V3vPhdzgtKsaExp7JSf
 5pQxp5xRfzIz21Lu2Ms13gmQZaLEhKw+gJToodDsJ0P9Iq+kfZndBjuuX516iKD3O9PmAsPmX8M
 XCTdpQKj822WTyzeLawLawiLeK92oFzv77cKytrNVzpwY82gRSrzmQdpKoYK7vNNeMXlaEStJTJ
 m/9Mhl0juX5/e+VaqmJBuM8da37pdJiidBeZQnUzDf8RHNglYkuCxpBC2116zixyBA2Pk8HUZdI
 fVCn81284Pp8JXWA+CGBeQPpy2h/qGSwBPxzeOUET7o9bpsTa4eFSzE1rNPjOa9p9VF8R1at7+P
 mhyESZYhHs/Sjj3dUKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE0NyBTYWx0ZWRfX5sXLjHt5W9rK
 201cW9N9lh8Y+D2hlaR9hdlJGW79hrl2M8f9YYXp7FadyCERNIYLV6veiYKHcLE6vhGhBfPOWMU
 VydhfkvgIMn7KpQ2HvkA3Q5MjHRMFQI=
X-Proofpoint-ORIG-GUID: lpVvfzRxwXCt7eP5NW7xVIL4NnXgAbzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190147

Try to distribute floating IRQs which haven't been taken by a VCPU yet
to sleeping VCPUs. This lowers the risk of floating IRQs not being
delivered.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/interrupt.c        | 31 +++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |  3 +++
 arch/s390/kvm/kvm-s390.h         |  1 +
 4 files changed, 36 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b4182ca4435f..1d62bdd7aca5 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -467,6 +467,7 @@ struct kvm_vm_stat {
 	u64 gmap_shadow_r3_entry;
 	u64 gmap_shadow_sg_entry;
 	u64 gmap_shadow_pg_entry;
+	u64 inject_redist;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 53ba74a749e8..1ee9ab250504 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -367,6 +367,37 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 	return active_mask;
 }
 
+void distribute_float_irqs(struct kvm *kvm)
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
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 518a69c55e85..d6d46688d980 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -86,6 +86,7 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_COUNTER(VM, gmap_shadow_r3_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_sg_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_pg_entry),
+	STATS_DESC_COUNTER(VM, inject_redist),
 };
 
 const struct kvm_stats_header kvm_vm_stats_header = {
@@ -4572,6 +4573,8 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 		rc = kvm_s390_deliver_pending_interrupts(vcpu);
 		if (rc || guestdbg_exit_pending(vcpu))
 			return rc;
+
+		distribute_float_irqs(vcpu->kvm);
 	}
 
 	rc = kvm_s390_handle_requests(vcpu);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 8e886bcef4a0..7115a8f5b188 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -376,6 +376,7 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_float_irqs(struct kvm *kvm);
 void kvm_s390_pv_sclp_kick(struct kvm_vcpu *vcpu);
+void distribute_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
 				    struct kvm_s390_interrupt *s390int,
 				    struct kvm_s390_interrupt_info *inti);
-- 
2.53.0

