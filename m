Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3412 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729160AbgAaPDT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:03:19 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VF2upR156283
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:03:18 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrvwb84hf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:03:17 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:02:14 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 03/12] s390x: sclp: refactor invalid command check
Date: Fri, 31 Jan 2020 16:01:58 +0100
In-Reply-To: <20200131150207.73127-1-borntraeger@de.ibm.com>
References: <20200131150207.73127-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131150207.73127-4-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

Invalid command checking has to be done before the boundary check,
refactoring it now allows to insert the boundary check at the correct
place later.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Message-Id: <1569591203-15258-2-git-send-email-imbrenda@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/event-facility.c |  3 ---
 hw/s390x/sclp.c           | 17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 797ecbb7a9c8..66205697ae75 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -377,9 +377,6 @@ static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
     case SCLP_CMD_WRITE_EVENT_MASK:
         write_event_mask(ef, sccb);
         break;
-    default:
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-        break;
     }
 }
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index fac7c3bb6c02..95ebfe7bd2f1 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -219,8 +219,23 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
         goto out;
     }
 
-    sclp_c->execute(sclp, &work_sccb, code);
+    switch (code & SCLP_CMD_CODE_MASK) {
+    case SCLP_CMDW_READ_SCP_INFO:
+    case SCLP_CMDW_READ_SCP_INFO_FORCED:
+    case SCLP_CMDW_READ_CPU_INFO:
+    case SCLP_CMDW_CONFIGURE_IOA:
+    case SCLP_CMDW_DECONFIGURE_IOA:
+    case SCLP_CMD_READ_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_MASK:
+        break;
+    default:
+        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        goto out_write;
+    }
 
+    sclp_c->execute(sclp, &work_sccb, code);
+out_write:
     cpu_physical_memory_write(sccb, &work_sccb,
                               be16_to_cpu(work_sccb.h.length));
 
-- 
2.21.0
