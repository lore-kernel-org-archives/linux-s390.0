Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgKJJgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:36:31 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9WXcj109777
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qgyck29k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AA9WgXp110392
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:29 -0500
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 0/3] s390/vmem: minor cleanup
Date: Tue, 10 Nov 2020 10:36:20 +0100
Message-Id: <cover.1605000280.git.agordeev@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>

Hi David,

Nothing really fancy here, just couple of cleanups

Alexander Gordeev (3):
  s390/vmem: remove redundant check
  s390/vmem: fix possible memory overwrite
  s390/vmem: make variable and function names consistent

 arch/s390/mm/vmem.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

-- 
2.26.0
