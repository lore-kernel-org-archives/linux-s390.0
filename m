Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11726 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgINIWc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 04:22:32 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: add documentation for KVM_CAP_S390_DIAG318 (5.9)
Date: Mon, 14 Sep 2020 10:22:14 +0200
Message-Id: <20200914082215.6143-1-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>

Paolo,

one missing piece of documentation for the diag318 interface that was
added in 5.9-rc1.

The following changes since commit 37f66bbef0920429b8cb5eddba849ec4308a9f8e:

  KVM: emulator: more strict rsm checks. (2020-09-12 12:22:55 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.9-1

for you to fetch changes up to f20d4e924b4465822c4a35290b85aadf88ddf466:

  docs: kvm: add documentation for KVM_CAP_S390_DIAG318 (2020-09-14 09:08:10 +0200)

----------------------------------------------------------------
KVM: s390: add documentation for KVM_CAP_S390_DIAG318

diag318 code was merged in 5.9-rc1, let us add some
missing documentation

----------------------------------------------------------------
Collin Walling (1):
      docs: kvm: add documentation for KVM_CAP_S390_DIAG318

 Documentation/virt/kvm/api.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
