Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726883AbgKQPK3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 10:10:29 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] KVM: s390: memcg awareness
Date: Tue, 17 Nov 2020 16:10:21 +0100
Message-Id: <20201117151023.424575-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

This got somehow lost.  (so this is kind of a v2)
KVM does have memcg awareness. Lets implement this also for s390kvm
and gmap.

Christian Borntraeger (2):
  KVM: s390: Add memcg accounting to KVM allocations
  s390/gmap: make gmap memcg aware

 arch/s390/kvm/guestdbg.c  |  8 ++++----
 arch/s390/kvm/intercept.c |  2 +-
 arch/s390/kvm/interrupt.c | 10 +++++-----
 arch/s390/kvm/kvm-s390.c  | 20 ++++++++++----------
 arch/s390/kvm/priv.c      |  4 ++--
 arch/s390/kvm/pv.c        |  6 +++---
 arch/s390/kvm/vsie.c      |  4 ++--
 arch/s390/mm/gmap.c       | 30 +++++++++++++++---------------
 8 files changed, 42 insertions(+), 42 deletions(-)

-- 
2.28.0
