Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729320AbgCKNLF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 09:11:05 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BD9OJo182726
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 09:11:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yq0hf0f2g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 09:11:03 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 11 Mar 2020 13:11:01 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] format string fixups for selftests
Date: Wed, 11 Mar 2020 14:10:54 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200311131056.140016-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>

found by Andrews recent changes so I attributed him as Reported by.

Christian Borntraeger (2):
  selftests: KVM: s390: fixup fprintf format error in reset.c
  selftests: KVM: s390: fix format strings for access reg test

 tools/testing/selftests/kvm/s390x/resets.c         |  2 +-
 tools/testing/selftests/kvm/s390x/sync_regs_test.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.24.1
