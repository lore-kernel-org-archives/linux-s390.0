Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbgEFL7x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 07:59:53 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: Fix for running nested under z/VM
Date: Wed,  6 May 2020 13:59:44 +0200
Message-Id: <20200506115945.13132-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>

Paolo,
a fix for kvm/master.

The following changes since commit 2a173ec993baa6a97e7b0fb89240200a88d90746:

  MAINTAINERS: add a reviewer for KVM/s390 (2020-04-20 11:24:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.7-3

for you to fetch changes up to 5615e74f48dcc982655543e979b6c3f3f877e6f6:

  KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction (2020-05-05 11:15:05 +0200)

----------------------------------------------------------------
KVM: s390: Fix for running nested uner z/VM

There are circumstances when running nested under z/VM that would trigger a
WARN_ON_ONCE. Remove the WARN_ON_ONCE. Long term we certainly want to make this
code more robust and flexible, but just returning instead of WARNING makes
guest bootable again.

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction

 arch/s390/kvm/priv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
