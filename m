Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729012AbgAaPC0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:02:26 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VF0kVJ125161
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:25 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvbeht2tj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:22 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:02:14 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 06/12] s390x: sclp: Report insufficient SCCB length
Date: Fri, 31 Jan 2020 16:02:01 +0100
In-Reply-To: <20200131150207.73127-1-borntraeger@de.ibm.com>
References: <20200131150207.73127-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131150207.73127-7-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Return the correct error code when the SCCB buffer is too small to
contain all of the output, for the Read SCP Information and
Read CPU Information commands.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Message-Id: <1569591203-15258-5-git-send-email-imbrenda@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/sclp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index abb6e5011f9c..f57ce7b73943 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -68,6 +68,12 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 
     read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
 
+    if (be16_to_cpu(sccb->h.length) <
+            (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
+        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        return;
+    }
+
     /* Configuration Characteristic (Extension) */
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR,
                          read_info->conf_char);
@@ -118,6 +124,12 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
     cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
     cpu_info->nr_standby = cpu_to_be16(0);
 
+    if (be16_to_cpu(sccb->h.length) <
+            (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
+        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        return;
+    }
+
     /* The standby offset is 16-byte for each CPU */
     cpu_info->offset_standby = cpu_to_be16(cpu_info->offset_configured
         + cpu_info->nr_configured*sizeof(CPUEntry));
-- 
2.21.0
