Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390034AbgLJO0z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 09:26:55 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/4] KVM: s390: track synchronous pfault events in kvm_stat
Date: Thu, 10 Dec 2020 15:25:59 +0100
Message-Id: <20201210142600.6771-5-borntraeger@de.ibm.com>
In-Reply-To: <20201210142600.6771-1-borntraeger@de.ibm.com>
References: <20201210142600.6771-1-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>

Right now we do count pfault (pseudo page faults aka async page faults
start and completion events). What we do not count is, if an async page
fault would have been possible by the host, but it was disabled by the
guest (e.g. interrupts off, pfault disabled, secure execution....).  Let
us count those as well in the pfault_sync counter.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Link: https://lore.kernel.org/r/20201125090658.38463-1-borntraeger@de.ibm.com
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 463c24e26000..74f9a036bab2 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -459,6 +459,7 @@ struct kvm_vcpu_stat {
 	u64 diagnose_308;
 	u64 diagnose_500;
 	u64 diagnose_other;
+	u64 pfault_sync;
 };
 
 #define PGM_OPERATION			0x01
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 19804c388d61..065f94f22fd3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -60,6 +60,7 @@
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("userspace_handled", exit_userspace),
 	VCPU_STAT("exit_null", exit_null),
+	VCPU_STAT("pfault_sync", pfault_sync),
 	VCPU_STAT("exit_validity", exit_validity),
 	VCPU_STAT("exit_stop_request", exit_stop_request),
 	VCPU_STAT("exit_external_request", exit_external_request),
@@ -4111,6 +4112,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 		current->thread.gmap_pfault = 0;
 		if (kvm_arch_setup_async_pf(vcpu))
 			return 0;
+		vcpu->stat.pfault_sync++;
 		return kvm_arch_fault_in_page(vcpu, current->thread.gmap_addr, 1);
 	}
 	return vcpu_post_run_fault_in_sie(vcpu);
-- 
2.28.0
