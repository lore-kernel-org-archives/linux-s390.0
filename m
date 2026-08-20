Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07643D4EC;
	Thu, 20 Aug 2026 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228161; cv=none; b=i3mFgGBum93jqzU7pERp/Nf1gkUthy56LqU1E8+czaJfmd56K0bcUYfHhY7d1c6UDGj1vYeKCfoE5wTaqRSlTUG6S6RGw6JIOry17W5mbfKodUbt2KM3DHDLiTvuewg/1N9O7vyOGZZVn6EVZzIiV74xL3pbnCdEWQH1JBAZwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228161; c=relaxed/simple;
	bh=Vb96AKU11dTD8LoFEIhgDi398bKdhDxkXbvEcAQAVhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWyL4EJ7Ia4dLIeY0GoHFbT/dg4l2O8JDGs0qNaJtITErKfUGbP/jNQrfG51eRaYXdfPW+UUJAY85YjAAfiQ68U1y+bU3i4yP99GsotMPDGHdDgKht0Yy5FGy59VZCO8IHRayp64uNZaCLBa7+CBBixK/EK0Ukm0SXN9/hq5SgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l3xObP8R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l3xObP8R"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8PGYh471252;
	Thu, 20 Aug 2026 12:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Yxw7CrE7qOlNB+vNB
	maV1/xEAF5E9aB1pBaLv4vhn18=; b=l3xObP8RxxNRCnep9uYOcEMJVpyos5FV7
	mV7/QHhQGzHblu2plMVbFTLqwrA+lAiuwsV1DV9b6lX/MwXt0ELUC5sJunB7GtHe
	OcoONdQW8HisxtybpOw7TDZrBWS91Tluz7qOaXWtzX0S8CGpr3F4o7y4iRe8vrjN
	oz45wD/4cgTZUTWc0Oji18onAF8CznmNSAV3dCPksn6JP+oSFEr5cPb6kgUaK44n
	X3XP8513Hs9LKeYVTAkTnFBpfOSskTq4eFTNL37fYb+9WPPJCXUe2SRf5D9xqGoe
	ZvLg6LQTaWzafAPaUnRl3smWw6H2slY8GmB6WPfaLMjltMEI1GUeg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0j68m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 12:15:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KCBHR9019295;
	Thu, 20 Aug 2026 12:15:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqejwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 12:15:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KCFsus28443056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 12:15:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5848E20040;
	Thu, 20 Aug 2026 12:15:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BEF42004B;
	Thu, 20 Aug 2026 12:15:54 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 12:15:54 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, pasic@linux.ibm.com
Subject: [PATCH v4 3/3] KVM: s390: Add opportunistic floating IRQ injection
Date: Thu, 20 Aug 2026 12:12:18 +0000
Message-ID: <20260820121546.24694-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820121546.24694-1-frankja@linux.ibm.com>
References: <20260820121546.24694-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a86efff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ceVPMvoHt_UTMoFkilYA:9
X-Proofpoint-ORIG-GUID: fvO7uhiM1p0Y_xkw8MfesxvVdeCNyOYz
X-Proofpoint-GUID: fvO7uhiM1p0Y_xkw8MfesxvVdeCNyOYz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4OSBTYWx0ZWRfX2SrxhDHK/1ZD
 ojBY2DeSYdbjOpK6CjmOy714piq0hbdnTTXkZiPS9gF3iKVPvuCEwbzaE5yi5qAS/EEmC30cv/F
 Do64I+dxscmLpvy135tCrk7Wq25P0jk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4OSBTYWx0ZWRfX8Nfp/PbEZqbD
 /A11xd3HIFfjxEXGA4+O1TPgcLxV3RrS27iguUdZHJFEyMPz+PpJBC3IMlo58rUPnki1WYLVflw
 gk1WKmX4bkvqZ11ifHmq5/IMbKjinpIMO/JMZStr1+b2MPXALFojrdMabRywLGcfEbZP09RHu5W
 1QTHI6GxOMGPr3JbG8bKHC66uFTzPhAKKmKvnqEb4Zpop6lGjmjuBurWdzyV84nmAAJH6T96zFb
 VV9PTQeq3pHK6E8AWE0eCqCJyheH0AueKFg/f9eWG7fGMt4F5JbQO8zHFRprLs/L4x0WPPwGAzU
 GD1syudOgUQp79QVDiz5sJd1qBtT/gYQ4dkUMVW9bdVyaizToEQdFGq1Mbx4M3Y6JMgG8zCKZMS
 vKTFH7m1tgz8cdILHqhPb10a/HsaVyaKpkhy/6i3tSsXMP41zITrnt++Tb6rNUOS3q9w0SvPORw
 tTD+mGXBgLotC7gNccA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200089

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
index b3e4bfeacff2..54f20347f553 100644
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

