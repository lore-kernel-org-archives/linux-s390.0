Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409267AbfJXLma (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBb7kh127893
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vua4vav31-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:27 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 22/37] KVM: s390: protvirt: Add SCLP handling
Date: Thu, 24 Oct 2019 07:40:44 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-23-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

From: Christian Borntraeger <borntraeger@de.ibm.com>

Unmask the SCLP IRQ once we get the notification intercept on SCLP.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 25 +++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c  |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index a1df8a43c88b..510b1dee3320 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -460,11 +460,36 @@ static int handle_pv_spx(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int handle_pv_sclp(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
+
+	spin_lock(&fi->lock);
+	/*
+	 * 2 cases:
+	 * a: an sccb answering interrupt was already pending or in flight.
+	 *    As the sccb value is not used we can simply set some more bits
+	 *    and make sure that we deliver something
+	 * b: an error sccb interrupt needs to be injected so we also inject
+	 *    something and let firmware do the right thing.
+	 * This makes sure, that both errors and real sccb returns will only
+	 * be delivered when we are unmasked.
+	 */
+	fi->srv_signal.ext_params |= 0x43000;
+	set_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs);
+	clear_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs);
+	spin_unlock(&fi->lock);
+	return 0;
+}
+
 static int handle_pv_not(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.sie_block->ipa == 0xb210)
 		return handle_pv_spx(vcpu);
 
+	if (vcpu->arch.sie_block->ipa == 0xb220)
+		return handle_pv_sclp(vcpu);
+
 	return handle_instruction(vcpu);
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6747cb6cf062..eddc9508c1b1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2189,6 +2189,8 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 		if (!r)
 			r = kvm_s390_pv_create_vm(kvm);
 		kvm_s390_vcpu_unblock_all(kvm);
+		/* we need to block service interrupts from now on */
+		set_bit(IRQ_PEND_EXT_SERVICE,&kvm->arch.float_int.masked_irqs);
 		mutex_unlock(&kvm->lock);
 		break;
 	}
-- 
2.20.1
