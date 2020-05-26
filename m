Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728746AbgEZJdi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 05:33:38 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/3] KVM: s390: Cleanups for 5.8
Date: Tue, 26 May 2020 11:33:10 +0200
Message-Id: <20200526093313.77976-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

Paolo,

The following changes since commit 2a173ec993baa6a97e7b0fb89240200a88d90746:

  MAINTAINERS: add a reviewer for KVM/s390 (2020-04-20 11:24:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.8-1

for you to fetch changes up to 0b545fd17f84184f9536bde68c3521e36c488448:

  KVM: s390: remove unneeded semicolon in gisa_vcpu_kicker() (2020-04-20 11:33:32 +0200)

----------------------------------------------------------------
KVM: s390: Cleanups for 5.8

- vsie (nesting) cleanups
- remove unneeded semicolon

----------------------------------------------------------------
David Hildenbrand (2):
      KVM: s390: vsie: Move conditional reschedule
      KVM: s390: vsie: gmap_table_walk() simplifications

Jason Yan (1):
      KVM: s390: remove unneeded semicolon in gisa_vcpu_kicker()

 arch/s390/kvm/interrupt.c |  2 +-
 arch/s390/kvm/vsie.c      |  3 +--
 arch/s390/mm/gmap.c       | 10 +++++-----
 3 files changed, 7 insertions(+), 8 deletions(-)
