Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C425C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 08:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302A261353
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 08:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbhESIKE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 04:10:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236275AbhESIKD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 04:10:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J84wd6075432;
        Wed, 19 May 2021 04:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zpGtZL01x4yDcHLJjhNGLfaKG3fkyzEMKL400SkQQkU=;
 b=Sr494fCKq3fCZaG/zOmJHzyiJvVoTFdLfiEoREblaROYNaf78H0N/LYAjiDPYJWJimvd
 I3bcBsj9VdsrWbl6eYE72GDOVOKiPPlQ7M/1BYkAJGxiS3ssW3SPFiKVp8eQW4MNvqZd
 J7Ow7EwluDu4R5r2gU0aw5BMjh7NkYSXXRMJW2QudIPpGuTo6HZlZI8J09bJOMLkGfpe
 bN0RmXJ/h4dagSQ/KEPLcFRGu+9JRGa5FOSNyzRiRat6gQWzE1tbIfQ27kWN+56Req8b
 Iu2terXAMHh8DAaGuWvn4q529fbEpgNFOEixhoHj4BibI1ZaJF6a9m16Xx1KPsbubJxu uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38mxn48fjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 04:08:44 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14J8589J076526;
        Wed, 19 May 2021 04:08:43 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38mxn48fhd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 04:08:43 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14J7bhMS018508;
        Wed, 19 May 2021 07:40:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 38j5jgsxe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 07:40:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14J7edkC31982026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 07:40:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D8CFA4064;
        Wed, 19 May 2021 07:40:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ACE1A405C;
        Wed, 19 May 2021 07:40:38 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 May 2021 07:40:38 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 4/6] s390x: Test for share/unshare call support before using them
Date:   Wed, 19 May 2021 07:40:20 +0000
Message-Id: <20210519074022.7368-5-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519074022.7368-1-frankja@linux.ibm.com>
References: <20210519074022.7368-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 42XEBzLrLpmx90qNmMRrt7ODnzjxCdfl
X-Proofpoint-GUID: U8ixECp30DB29FZiTDslUPF0UlBGllwU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_02:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105190059
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Testing for facility only means the UV Call facility is available.
The UV will only indicate the share/unshare calls for a protected
guest 2, so let's also check that.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 lib/s390x/malloc_io.c | 5 +++--
 s390x/uv-guest.c      | 6 ++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/s390x/malloc_io.c b/lib/s390x/malloc_io.c
index 1dcf1691..78582eac 100644
--- a/lib/s390x/malloc_io.c
+++ b/lib/s390x/malloc_io.c
@@ -19,6 +19,7 @@
 #include <alloc_page.h>
 #include <asm/facility.h>
 #include <bitops.h>
+#include <uv.h>
 
 static int share_pages(void *p, int count)
 {
@@ -47,7 +48,7 @@ void *alloc_io_mem(int size, int flags)
 	assert(size);
 
 	p = alloc_pages_flags(order, AREA_DMA31 | flags);
-	if (!p || !test_facility(158))
+	if (!p || !uv_os_is_guest())
 		return p;
 
 	n = share_pages(p, 1 << order);
@@ -65,7 +66,7 @@ void free_io_mem(void *p, int size)
 
 	assert(IS_ALIGNED((uintptr_t)p, PAGE_SIZE));
 
-	if (test_facility(158))
+	if (uv_os_is_guest())
 		unshare_pages(p, 1 << order);
 	free_pages(p);
 }
diff --git a/s390x/uv-guest.c b/s390x/uv-guest.c
index 393d7f5c..e99029a7 100644
--- a/s390x/uv-guest.c
+++ b/s390x/uv-guest.c
@@ -16,6 +16,7 @@
 #include <asm/facility.h>
 #include <asm/uv.h>
 #include <sclp.h>
+#include <uv.h>
 
 static unsigned long page;
 
@@ -142,6 +143,11 @@ int main(void)
 		goto done;
 	}
 
+	if (!uv_os_is_guest()) {
+		report_skip("Not a protected guest");
+		goto done;
+	}
+
 	page = (unsigned long)alloc_page();
 	test_priv();
 	test_invalid();
-- 
2.30.2

