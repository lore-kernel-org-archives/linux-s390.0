Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390150AbfJWIk3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Oct 2019 04:40:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9N8asD4034911
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 04:40:29 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtk7r8tc6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 04:40:29 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 23 Oct 2019 09:40:26 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] s390x: Fix selftest malloc check
Date: Wed, 23 Oct 2019 04:40:17 -0400
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191023084017.13142-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Commit c09c54c ("lib: use an argument which doesn't require default
argument promotion") broke the selftest. Let's fix it by converting
the binary operations to bool.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/selftest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/s390x/selftest.c b/s390x/selftest.c
index f4acdc4..9cd6943 100644
--- a/s390x/selftest.c
+++ b/s390x/selftest.c
@@ -49,9 +49,9 @@ static void test_malloc(void)
 	*tmp2 = 123456789;
 	mb();
 
-	report("malloc: got vaddr", (uintptr_t)tmp & 0xf000000000000000ul);
+	report("malloc: got vaddr", !!((uintptr_t)tmp & 0xf000000000000000ul));
 	report("malloc: access works", *tmp == 123456789);
-	report("malloc: got 2nd vaddr", (uintptr_t)tmp2 & 0xf000000000000000ul);
+	report("malloc: got 2nd vaddr", !!((uintptr_t)tmp2 & 0xf000000000000000ul));
 	report("malloc: access works", (*tmp2 == 123456789));
 	report("malloc: addresses differ", tmp != tmp2);
 
-- 
2.20.1
