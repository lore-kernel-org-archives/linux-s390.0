Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727158AbgA3MgG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 07:36:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UCZwKF113147
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 07:36:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xuagny9rk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 07:36:03 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 30 Jan 2020 12:34:50 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v9 2/6] KVM: s390: Cleanup initial cpu reset
Date: Thu, 30 Jan 2020 07:34:30 -0500
In-Reply-To: <20200130123434.68129-1-frankja@linux.ibm.com>
References: <20200130123434.68129-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200130123434.68129-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

The code seems to be quite old and uses lots of unneeded spaces for
alignment, which doesn't really help with readability.

Let's:
* Get rid of the extra spaces
* Remove the ULs as they are not needed on 0s
* Define constants for the CR 0 and 14 initial values
* Use the sizeof of the gcr array to memset it to 0

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/kvm_host.h |  5 +++++
 arch/s390/kvm/kvm-s390.c         | 18 +++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 11ecc4071a29..1726224e7772 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -122,6 +122,11 @@ struct mcck_volatile_info {
 	__u32 reserved;
 };
 
+#define CR0_INITIAL_MASK (CR0_UNUSED_56 | CR0_INTERRUPT_KEY_SUBMASK | \
+			  CR0_MEASUREMENT_ALERT_SUBMASK)
+#define CR14_INITIAL_MASK (CR14_UNUSED_32 | CR14_UNUSED_33 | \
+			   CR14_EXTERNAL_DAMAGE_SUBMASK)
+
 #define CPUSTAT_STOPPED    0x80000000
 #define CPUSTAT_WAIT       0x10000000
 #define CPUSTAT_ECALL_PEND 0x08000000
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 328dee666b24..e0a0799b384e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2811,19 +2811,15 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 {
 	/* this equals initial cpu reset in pop, but we don't switch to ESA */
-	vcpu->arch.sie_block->gpsw.mask = 0UL;
-	vcpu->arch.sie_block->gpsw.addr = 0UL;
+	vcpu->arch.sie_block->gpsw.mask = 0;
+	vcpu->arch.sie_block->gpsw.addr = 0;
 	kvm_s390_set_prefix(vcpu, 0);
 	kvm_s390_set_cpu_timer(vcpu, 0);
-	vcpu->arch.sie_block->ckc       = 0UL;
-	vcpu->arch.sie_block->todpr     = 0;
-	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
-	vcpu->arch.sie_block->gcr[0]  = CR0_UNUSED_56 |
-					CR0_INTERRUPT_KEY_SUBMASK |
-					CR0_MEASUREMENT_ALERT_SUBMASK;
-	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
-					CR14_UNUSED_33 |
-					CR14_EXTERNAL_DAMAGE_SUBMASK;
+	vcpu->arch.sie_block->ckc = 0;
+	vcpu->arch.sie_block->todpr = 0;
+	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr));
+	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL_MASK;
+	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL_MASK;
 	vcpu->run->s.regs.fpc = 0;
 	current->thread.fpu.fpc = 0;
 	vcpu->arch.sie_block->gbea = 1;
-- 
2.20.1
