Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406628AbfIYN4g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 09:56:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8PDqGFG074554
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 09:56:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v8948s9hx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 09:56:34 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 25 Sep 2019 14:56:33 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/2] s390x: Quick fixes
Date: Wed, 25 Sep 2019 09:56:21 -0400
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190925135623.9740-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

Missing free and missing import.

Janosch Frank (2):
  s390x: Add missing include in smp.h
  s390x: Free allocated page in iep test

 lib/s390x/smp.h | 2 ++
 s390x/iep.c     | 1 +
 2 files changed, 3 insertions(+)

-- 
2.20.1
