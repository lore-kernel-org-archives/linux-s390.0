Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409248AbfJXLmb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 07:42:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9OBbIHd098704
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vu95r529m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 07:42:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 24 Oct 2019 12:42:28 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC 23/37] KVM: s390: protvirt: Make sure prefix is always protected
Date: Thu, 24 Oct 2019 07:40:45 -0400
In-Reply-To: <20191024114059.102802-1-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191024114059.102802-24-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index eddc9508c1b1..17a78774c617 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3646,6 +3646,15 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 		rc = gmap_mprotect_notify(vcpu->arch.gmap,
 					  kvm_s390_get_prefix(vcpu),
 					  PAGE_SIZE * 2, PROT_WRITE);
+		if (!rc && kvm_s390_pv_is_protected(vcpu->kvm)) {
+			rc = uv_convert_to_secure(vcpu->arch.gmap,
+						  kvm_s390_get_prefix(vcpu));
+			WARN_ON_ONCE(rc && rc != -EEXIST);
+			rc = uv_convert_to_secure(vcpu->arch.gmap,
+						  kvm_s390_get_prefix(vcpu) + PAGE_SIZE);
+			WARN_ON_ONCE(rc && rc != -EEXIST);
+			rc = 0;
+		}
 		if (rc) {
 			kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
 			return rc;
-- 
2.20.1
