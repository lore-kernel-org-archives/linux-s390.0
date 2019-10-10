Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727900AbfJJLF1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 07:05:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9A9hq3h083005
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 07:05:26 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vj290jfdk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 07:05:25 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 10 Oct 2019 12:05:23 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 0/2] diag 9c improvements
Date: Thu, 10 Oct 2019 13:05:16 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191010110518.129256-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

Christian Borntraeger (2):
  KVM: s390: count invalid yields
  KVM: s390: Do not yield when target is already running

 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/diag.c             | 22 ++++++++++++++++++----
 arch/s390/kvm/kvm-s390.c         |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.21.0
