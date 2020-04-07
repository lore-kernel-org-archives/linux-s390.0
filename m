Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726399AbgDGLmq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 07:42:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037BZOqp003606
        for <linux-s390@vger.kernel.org>; Tue, 7 Apr 2020 07:42:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 306kuwecjd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2020 07:42:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 7 Apr 2020 12:42:31 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/3] KVM: s390: Fixes for vsie (nested hypervisors)
Date: Tue,  7 Apr 2020 13:42:37 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200407114240.156419-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>

Paolo,

some fixes for 5.7. The commits are new due to late additions of
Reviewed-by tags, but I have been testing these for a while now.
The following changes since commit 8c1b724ddb218f221612d4c649bc9c7819d8d7a6:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2020-04-02 15:13:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.7-1

for you to fetch changes up to 1493e0f944f3c319d11e067c185c904d01c17ae5:

  KVM: s390: vsie: Fix possible race when shadowing region 3 tables (2020-04-07 13:12:38 +0200)

----------------------------------------------------------------
KVM: s390: Fixes for vsie (nested hypervisors)

- Several fixes for corner cases of nesting. Still relevant as it might
  crash host or first level guest or temporarily leak memory.

----------------------------------------------------------------
David Hildenbrand (3):
      KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks
      KVM: s390: vsie: Fix delivery of addressing exceptions
      KVM: s390: vsie: Fix possible race when shadowing region 3 tables

 arch/s390/kvm/vsie.c | 1 +
 arch/s390/mm/gmap.c  | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)
