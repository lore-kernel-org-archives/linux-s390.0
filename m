Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727981AbfJaPT3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 11:19:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VFI04S028738
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 11:19:28 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w006pmys3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 11:19:27 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 31 Oct 2019 15:19:25 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] RFC: memcg support for KVM/s390
Date: Thu, 31 Oct 2019 16:19:20 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191031151921.31871-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

As a followup to my keynote where I talked about memcg support in
kvm/x86, here is the s390 equivalent.

I think all of those allocations can be really attributed to a specific
host process but a 2nd (or 3rd) pair of eyes is certainly welcome.

Christian Borntraeger (1):
  KVM: s390:  Add memcg accounting to KVM allocations

 arch/s390/kvm/guestdbg.c  |  8 ++++----
 arch/s390/kvm/intercept.c |  2 +-
 arch/s390/kvm/interrupt.c | 12 ++++++------
 arch/s390/kvm/kvm-s390.c  | 22 +++++++++++-----------
 arch/s390/kvm/priv.c      |  4 ++--
 arch/s390/kvm/vsie.c      |  4 ++--
 6 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.21.0
