Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409740AbfJYRGn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 13:06:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PH4BtT018823
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 13:06:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv47qj144-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 13:06:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 25 Oct 2019 18:06:40 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 1/5] s390x: remove redundant defines
Date: Fri, 25 Oct 2019 19:06:30 +0200
In-Reply-To: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
Message-Id: <1572023194-14370-2-git-send-email-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 lib/s390x/sclp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 4e69845..f00c3df 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -27,8 +27,6 @@
 #define SCLP_ASSIGN_STORAGE                     0x000D0001
 #define SCLP_CMD_READ_EVENT_DATA                0x00770005
 #define SCLP_CMD_WRITE_EVENT_DATA               0x00760005
-#define SCLP_CMD_READ_EVENT_DATA                0x00770005
-#define SCLP_CMD_WRITE_EVENT_DATA               0x00760005
 #define SCLP_CMD_WRITE_EVENT_MASK               0x00780005
 
 /* SCLP Memory hotplug codes */
-- 
2.7.4
