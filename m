Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726573AbgDUGfI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 02:35:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L6WHw3141278
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 02:35:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ggr2570b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 02:35:07 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 21 Apr 2020 07:34:14 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Fix for 5.7 and maintainer update
Date: Tue, 21 Apr 2020 08:34:45 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200421063447.6814-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

Paolo,

two things for kvm/master. One fix for the protected virtualization
feature where we have a too strong assert and Adding Claudio as a
reviewer.

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.7-2

for you to fetch changes up to 2a173ec993baa6a97e7b0fb89240200a88d90746:

  MAINTAINERS: add a reviewer for KVM/s390 (2020-04-20 11:24:00 +0200)

----------------------------------------------------------------
KVM: s390: Fix for 5.7 and maintainer update

- Silence false positive lockdep warning
- add Claudio as reviewer

----------------------------------------------------------------
Claudio Imbrenda (1):
      MAINTAINERS: add a reviewer for KVM/s390

Eric Farman (1):
      KVM: s390: Fix PV check in deliverable_irqs()

 MAINTAINERS               | 1 +
 arch/s390/kvm/interrupt.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
