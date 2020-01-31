Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729161AbgAaPCT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:02:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VF0HgG143026
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xv7e2x7da-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:17 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:02:13 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 05/12] s390x: sclp: fix error handling for oversize control blocks
Date: Fri, 31 Jan 2020 16:02:00 +0100
In-Reply-To: <20200131150207.73127-1-borntraeger@de.ibm.com>
References: <20200131150207.73127-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131150207.73127-6-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

Requests over 4k are not a spec exception.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Message-Id: <1569591203-15258-4-git-send-email-imbrenda@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/sclp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 73244c938b10..abb6e5011f9c 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -213,8 +213,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
     cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
 
     /* Valid sccb sizes */
-    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader) ||
-        be16_to_cpu(work_sccb.h.length) > SCCB_SIZE) {
+    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
         r = -PGM_SPECIFICATION;
         goto out;
     }
-- 
2.21.0
