Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727318AbgCXMuj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:50:39 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OCnVrh061548
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 08:50:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yxw7d9ym8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 08:50:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 24 Mar 2020 12:50:33 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: changes for 5.7 part 2
Date: Tue, 24 Mar 2020 13:50:28 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200324125030.323689-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>

Paolo,

two more patches for 5.7.

The following changes since commit cc674ef252f4750bdcea1560ff491081bb960954:

  KVM: s390: introduce module parameter kvm.use_gisa (2020-02-27 19:47:13 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.7-2

for you to fetch changes up to f3dd18d444c757840920434e62809b6104081b06:

  KVM: s390: mark sie block as 512 byte aligned (2020-03-23 18:30:33 +0100)

----------------------------------------------------------------
KVM: s390: cleanups for 5.7

- mark sie control block as 512 byte aligned
- use fallthrough;

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: mark sie block as 512 byte aligned

Joe Perches (1):
      KVM: s390: Use fallthrough;

 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/gaccess.c          | 23 +++++++++++++----------
 arch/s390/kvm/interrupt.c        |  2 +-
 arch/s390/kvm/kvm-s390.c         |  4 ++--
 arch/s390/mm/gmap.c              |  6 +++---
 5 files changed, 20 insertions(+), 17 deletions(-)
