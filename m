Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2D48D87E;
	Thu, 13 Aug 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635663; cv=none; b=PIf+F8R87ZtXCISysr/VTZcsvLc8RGOfWzpWk0e/zEK/y9+A9V6jBkGDtjdUKbIBCDDWPzyGC5M+lv4U5hCuffl5OppZJgcXaMw2cEn1G5R1yFceOvUNRHsmw135iFw8BmT/Jb/F1cL8p2Iriu6AqXwj18hkwQeS7P9L6lg3KmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635663; c=relaxed/simple;
	bh=Hcb38o3x3BLrXWMFwgxvA7KELaSam0G2TLB55T7WeG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRGgvHgYnGEDLfW/vWiWqPCPEU6Vy42ECu/og2CTeZ7tt1695g2qtiX6w6M75NBlkkKYnysApnfyXEC+6/w6/R3+dEg3ElVH5c50AQuLL1e0RTffOd45LrlybBdGFEsZcTs3QrxVQJyMIrhq3CwTohw9W3Z/7Og+hlYRAODNB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EMYQdmsD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EMYQdmsD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFX2TU861887;
	Thu, 13 Aug 2026 15:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3gzANj3yKV/apWNwW3G07NFhXV1h4RuOK0M/lNmYT
	D4=; b=EMYQdmsDy+/BpRy2Uxi90IoDkQKupxEAkLZBLxdWy0BLq4Ce7+rlj3l2k
	bqqLdLIdSZ3P1CkCERBmm+iuD3HkjocWW4U7B5FUhZkU6CcGSt0sClKRwv0iiU8E
	OfsEh/d3TTjLN2KZKsIReQwDvwwjR7M/VslVCFAtS6OkkZpZcjQnUQL9H0+gGCD0
	lGq8SefBC7v+iX4NGyjuqIYqD2l9rfDuFiYMIY0JjjUE2f4E9FS3+jxU+VYMsbSc
	fxvVXda1mDQfcYjRnVJHTdonmfyIIbPWwlNsJu/xtK963tfOTy4om3iLUERmtoTD
	gdTxK/V51tNsRIvuOSwJ1tJ5pYR2Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk08mrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 15:40:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DFQQ92026035;
	Thu, 13 Aug 2026 15:40:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk3j9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 15:40:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DFejU944892616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 15:40:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEC1B20043;
	Thu, 13 Aug 2026 15:40:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95EC820040;
	Thu, 13 Aug 2026 15:40:45 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 15:40:45 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com
Subject: [PATCH] kvm: s390: Improve floating IRQ injection behavior
Date: Thu, 13 Aug 2026 14:56:23 +0000
Message-ID: <20260813154040.73437-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExMSBTYWx0ZWRfX+UyAQh6scq0r
 i4QQUyDEOMqZE86HTXL7P6lcWReh92Coq4qY+FmPcEwjf64RkLI44BsHG7gTO1C6iGoWGfW88gW
 v9G4dwClTOgLGRNYx1TxVCu6yjfKfh69UDSAMpaIsiZZXPG9BmjTvTuyj5gMQp2PJWmgiLySbHB
 eLqqFuCzyQst/1xB8smXA9+bKPJUY5QcxFV6VMHywmG6ZNd9FqL1fx3W7INxrShVVjIv9gAuXMP
 OhINzPhjAn0mBsN2OjZTjA8BPPa29FMFwrD0Nx3/JW9on73iDrDLGbPUXixdCtpSjGsnnM33qIK
 98JD+elWKehoDjM6voXg8J791hs6hziHnZZbw7bHQDIA2KHGFO8o4nOdKvfQmlYMHoj0cGcfZzk
 q77AkoGCyQ3F+axnCrUSQSoHZWmx28coimTnHM8WfQyNAPd4r9wsYMJNJsSr+U/LIjY6UmzYio5
 /JkDM5nEvIGyZfoolkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExMSBTYWx0ZWRfX+vwbBgZVahzw
 gip51Sonp6ClH+Oa189m44Q8bG+PcOjbC4mI+gSgv9ycmkkRmQO1NOeRcbx8jzE0FobfARIM4KO
 kOMaGYbpQBNzxnP9AjyWmgHQUyhFq4s=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7de584 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eafQdAodyzljY6xa4VIA:9
X-Proofpoint-GUID: fg93QdYc-_pVnNvgx6i2UmTdxAhakapL
X-Proofpoint-ORIG-GUID: fg93QdYc-_pVnNvgx6i2UmTdxAhakapL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130111

Floating IRQs can be handled by any VCPU that opened its masks. The
current design does not check if the mask is open when a floating IRQ
is injected via the FLIC. It will wakeup the last VCPU that went
sleeping hoping it's the correct one.

Improve this by at least checking if the VCPU has pending IRQs and if
not try to find another VCPU which can take the IRQ.

Also add a function to distribute floating IRQs which can be called on
VCPU enter or exit. It will check for pending floating IRQs and wakeup
sleeping VCPUs which have pending IRQs.

This is not the final fix around this topic but we'll eventually
inject a pending IRQ. The current code can easily deadlock a VM and
with this fix we work around that.

This will fix this test's hangs as well as another hang that's already
been present before I added the new test code. See:
https://lore.kernel.org/kvm/20260813144058.7125-1-frankja@linux.ibm.com/T/#u

Fixes: 352ccf890a3e ("KVM: s390: improve interrupt cpu for wakeup")
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

Currently this is in the entry path and therefore might affect
latency. I chose to do it this way as we inject IRQs into the current
cpu a couple of lines above the distribute_float_irqs() call which
should mean we have a higher chance that no other floating IRQs are
pending since we already handled an IRQ.

A simple boot of a smp guest resulted in 275 injects via the new code.

I haven't done any performance tests yet.

---
 arch/s390/include/asm/kvm_host_s390.h |  1 +
 arch/s390/kvm/s390/interrupt.c        | 34 ++++++++++++++++++++++++++-
 arch/s390/kvm/s390/s390.c             |  3 +++
 arch/s390/kvm/s390/s390.h             |  1 +
 4 files changed, 38 insertions(+), 1 deletion(-)

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
index 0381ae981703..663fc2e3eca5 100644
--- a/arch/s390/kvm/s390/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -372,6 +372,37 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
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
@@ -1933,7 +1964,8 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
 		sigcpu %= online_vcpus;
 		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
-		if (!is_vcpu_stopped(dst_vcpu))
+		if (!is_vcpu_stopped(dst_vcpu) &&
+		    deliverable_irqs(dst_vcpu))
 			break;
 		/* avoid endless loops if all vcpus are stopped */
 		if (nr_tries++ >= online_vcpus)
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index b0839e887221..2ee0ab6b926a 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -87,6 +87,7 @@ const struct kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_COUNTER(VM, gmap_shadow_r3_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_sg_entry),
 	STATS_DESC_COUNTER(VM, gmap_shadow_pg_entry),
+	STATS_DESC_COUNTER(VM, inject_redist),
 };
 
 const struct kvm_stats_header kvm_vm_stats_header = {
@@ -4549,6 +4550,8 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 		rc = kvm_s390_deliver_pending_interrupts(vcpu);
 		if (rc || guestdbg_exit_pending(vcpu))
 			return rc;
+
+		distribute_float_irqs(vcpu->kvm);
 	}
 
 	rc = kvm_s390_handle_requests(vcpu);
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index d284a263ba70..e518339fb290 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -375,6 +375,7 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_float_irqs(struct kvm *kvm);
+void distribute_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
 				    struct kvm_s390_interrupt *s390int,
 				    struct kvm_s390_interrupt_info *inti);
-- 
2.53.0

