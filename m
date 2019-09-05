Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731737AbfIEIkk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 04:40:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x858bchb051918
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 04:40:39 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utx8r27tf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 04:40:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 5 Sep 2019 09:40:37 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [GIT PULL 5/8] KVM: s390: improve documentation for S390_MEM_OP
Date: Thu,  5 Sep 2019 10:40:06 +0200
In-Reply-To: <20190905084009.26106-1-frankja@linux.ibm.com>
References: <20190905084009.26106-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190905084009.26106-6-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, thuth@redhat.com

From: Cornelia Huck <cohuck@redhat.com>

Explicitly specify the valid ranges for size and ar, and reword
buf requirements a bit.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lkml.kernel.org/r/20190829124746.28665-1-cohuck@redhat.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virt/kvm/api.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
index 2d067767b617..76c9d6fdbfdb 100644
--- a/Documentation/virt/kvm/api.txt
+++ b/Documentation/virt/kvm/api.txt
@@ -3079,12 +3079,14 @@ This exception is also raised directly at the corresponding VCPU if the
 flag KVM_S390_MEMOP_F_INJECT_EXCEPTION is set in the "flags" field.
 
 The start address of the memory region has to be specified in the "gaddr"
-field, and the length of the region in the "size" field. "buf" is the buffer
-supplied by the userspace application where the read data should be written
-to for KVM_S390_MEMOP_LOGICAL_READ, or where the data that should be written
-is stored for a KVM_S390_MEMOP_LOGICAL_WRITE. "buf" is unused and can be NULL
-when KVM_S390_MEMOP_F_CHECK_ONLY is specified. "ar" designates the access
-register number to be used.
+field, and the length of the region in the "size" field (which must not
+be 0). The maximum value for "size" can be obtained by checking the
+KVM_CAP_S390_MEM_OP capability. "buf" is the buffer supplied by the
+userspace application where the read data should be written to for
+KVM_S390_MEMOP_LOGICAL_READ, or where the data that should be written is
+stored for a KVM_S390_MEMOP_LOGICAL_WRITE. When KVM_S390_MEMOP_F_CHECK_ONLY
+is specified, "buf" is unused and can be NULL. "ar" designates the access
+register number to be used; the valid range is 0..15.
 
 The "reserved" field is meant for future extensions. It is not used by
 KVM with the currently defined set of flags.
-- 
2.20.1
