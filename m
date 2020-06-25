Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405309AbgFYPHk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 11:07:40 -0400
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v2 2/2] docs: kvm: fix rst formatting
Date: Thu, 25 Jun 2020 11:07:24 -0400
Message-Id: <20200625150724.10021-3-walling@linux.ibm.com>
In-Reply-To: <20200625150724.10021-1-walling@linux.ibm.com>
References: <20200625150724.10021-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

Add a little rst touch-up for docs introduced in:
 - commit 7de3f1423ff9 ("KVM: s390: Add new reset vcpu API") and
 - commit 04ed89dc4aeb ("KVM: s390: protvirt: Add KVM api documentation")

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 Documentation/virt/kvm/api.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e0b4f2088c46..19681e96eb33 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6134,16 +6134,17 @@ in CPUID and only exposes Hyper-V identification. In this case, guest
 thinks it's running on Hyper-V and only use Hyper-V hypercalls.
 
 8.22 KVM_CAP_S390_VCPU_RESETS
+-----------------------------
 
-Architectures: s390
+:Architectures: s390
 
 This capability indicates that the KVM_S390_NORMAL_RESET and
 KVM_S390_CLEAR_RESET ioctls are available.
 
 8.23 KVM_CAP_S390_PROTECTED
+---------------------------
 
-Architecture: s390
-
+:Architecture: s390
 
 This capability indicates that the Ultravisor has been initialized and
 KVM can therefore start protected VMs.
-- 
2.26.2
