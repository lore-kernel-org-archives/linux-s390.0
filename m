Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406803AbfIYN4g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 09:56:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8PDqBDN074202
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 09:56:35 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v8948s9je-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 09:56:35 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 25 Sep 2019 14:56:33 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 2/2] s390x: Free allocated page in iep test
Date: Wed, 25 Sep 2019 09:56:23 -0400
In-Reply-To: <20190925135623.9740-1-frankja@linux.ibm.com>
References: <20190925135623.9740-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190925135623.9740-3-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

Let's also clean up

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/iep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/s390x/iep.c b/s390x/iep.c
index 7da78a3..55c01ee 100644
--- a/s390x/iep.c
+++ b/s390x/iep.c
@@ -43,6 +43,7 @@ static void test_iep(void)
 	report_prefix_pop();
 	unprotect_page(iepbuf, PAGE_ENTRY_IEP);
 	ctl_clear_bit(0, 20);
+	free_page(iepbuf);
 }
 
 int main(void)
-- 
2.20.1
