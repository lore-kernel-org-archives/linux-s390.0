Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727208AbgCLO2i (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 10:28:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CEMPJZ063261
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 10:28:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqksa85rb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 10:28:36 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 12 Mar 2020 14:27:55 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: Fix for 5.6
Date: Thu, 12 Mar 2020 15:27:49 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200312142750.3603-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>

Paolo,

one fix for the reset that was detected by some improved selftests:

The following changes since commit d718fdc3e752ba51ddb2b5554d3db98a09355cc2:

  KVM: x86: remove stale comment from struct x86_emulate_ctxt (2020-03-03 17:38:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.6-1

for you to fetch changes up to e93fc7b4544a5475cfdbc22f87e89f9829bf801c:

  KVM: s390: Also reset registers in sync regs for initial cpu reset (2020-03-11 08:25:26 +0100)

----------------------------------------------------------------
KVM: s390: Fully do the CPU resets as intended

With 7de3f1423ff9 ("KVM: s390: Add new reset vcpu API") we clarified
the meaning of the reset ioctl to fully reset the CPU and not only the
parts that can not be handled by userspace. Turns out that we missed
some parts.

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: Also reset registers in sync regs for initial cpu reset

 arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)
