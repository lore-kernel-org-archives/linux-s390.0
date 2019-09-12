Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732025AbfILNja (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 09:39:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CDWEDI048391
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 09:39:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uyn5dvr6n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 09:39:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 12 Sep 2019 14:39:26 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Fixes for 5.3
Date: Thu, 12 Sep 2019 15:39:19 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190912133921.6886-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

Paolo, Radim,

the following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.3-1

for you to fetch changes up to 53936b5bf35e140ae27e4bbf0447a61063f400da:

  KVM: s390: Do not leak kernel stack data in the KVM_S390_INTERRUPT ioctl (2019-09-12 14:12:21 +0200)

----------------------------------------------------------------
KVM: s390: Fixes for 5.3

- prevent a user triggerable oops in the migration code
- do not leak kernel stack content

----------------------------------------------------------------
Igor Mammedov (1):
      KVM: s390: kvm_s390_vm_start_migration: check dirty_bitmap before using it as target for memset()

Thomas Huth (1):
      KVM: s390: Do not leak kernel stack data in the KVM_S390_INTERRUPT ioctl

 arch/s390/kvm/interrupt.c | 10 ++++++++++
 arch/s390/kvm/kvm-s390.c  |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)
