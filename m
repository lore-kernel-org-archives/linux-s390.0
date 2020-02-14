Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728158AbgBNW1q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:46 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 42/42] KVM: s390: rstify new ioctls in api.rst
Date: Fri, 14 Feb 2020 17:26:58 -0500
Message-Id: <20200214222658.12946-43-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

We also need to rstify the new ioctls that we added in parallel to the
rstification of the kvm docs.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a82166e5f7d9..89e9c34bc5d3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4613,35 +4613,38 @@ unpins the VPA pages and releases all the device pages that are used to
 track the secure pages by hypervisor.
 
 4.122 KVM_S390_NORMAL_RESET
+---------------------------
 
-Capability: KVM_CAP_S390_VCPU_RESETS
-Architectures: s390
-Type: vcpu ioctl
-Parameters: none
-Returns: 0
+:Capability: KVM_CAP_S390_VCPU_RESETS
+:Architectures: s390
+:Type: vcpu ioctl
+:Parameters: none
+:Returns: 0
 
 This ioctl resets VCPU registers and control structures according to
 the cpu reset definition in the POP (Principles Of Operation).
 
 4.123 KVM_S390_INITIAL_RESET
+----------------------------
 
-Capability: none
-Architectures: s390
-Type: vcpu ioctl
-Parameters: none
-Returns: 0
+:Capability: none
+:Architectures: s390
+:Type: vcpu ioctl
+:Parameters: none
+:Returns: 0
 
 This ioctl resets VCPU registers and control structures according to
 the initial cpu reset definition in the POP. However, the cpu is not
 put into ESA mode. This reset is a superset of the normal reset.
 
 4.124 KVM_S390_CLEAR_RESET
+--------------------------
 
-Capability: KVM_CAP_S390_VCPU_RESETS
-Architectures: s390
-Type: vcpu ioctl
-Parameters: none
-Returns: 0
+:Capability: KVM_CAP_S390_VCPU_RESETS
+:Architectures: s390
+:Type: vcpu ioctl
+:Parameters: none
+:Returns: 0
 
 This ioctl resets VCPU registers and control structures according to
 the clear cpu reset definition in the POP. However, the cpu is not put
-- 
2.25.0
