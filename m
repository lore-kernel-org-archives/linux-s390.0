Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728542AbgDQP3p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 11:29:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HF5vGA075179
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 11:29:44 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30fejt12eq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 11:29:44 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 17 Apr 2020 16:29:37 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 1/1] MAINTAINERS: add a reviewer for KVM/s390
Date: Fri, 17 Apr 2020 17:29:36 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200417152936.772256-1-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: borntraeger@de.ibm.com, frankja@linux.ibm.com
Cc: pbonzini@redhat.com, cohuck@redhat.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6851ef7cf1bd..48e0147f9dd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9326,6 +9326,7 @@ M:	Christian Borntraeger <borntraeger@de.ibm.com>
 M:	Janosch Frank <frankja@linux.ibm.com>
 R:	David Hildenbrand <david@redhat.com>
 R:	Cornelia Huck <cohuck@redhat.com>
+R:	Claudio Imbrenda <imbrenda@linux.ibm.com>
 L:	kvm@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
-- 
2.25.2
