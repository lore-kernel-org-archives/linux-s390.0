Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgBXKQI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 05:16:08 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OA5TaJ001222
        for <linux-s390@vger.kernel.org>; Mon, 24 Feb 2020 05:16:06 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yaxt6x5md-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 24 Feb 2020 05:16:06 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 24 Feb 2020 10:16:04 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] KVM: s390: rstify new ioctls in api.rst
Date: Mon, 24 Feb 2020 11:15:59 +0100
In-Reply-To: <20200224101559.27405-1-borntraeger@de.ibm.com>
References: <20200224101559.27405-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200224101559.27405-2-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jonathan Corbet <corbet@lwn.net>

We also need to rstify the new ioctls that we added in parallel to the
rstification of the kvm docs.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 97a72a53fa4b..ebd383fba939 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4611,35 +4611,38 @@ unpins the VPA pages and releases all the device pages that are used to
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
2.21.0
