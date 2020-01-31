Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729162AbgAaPCU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:02:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VExcfQ021513
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xv7deqsa2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:17 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:02:12 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 00/12] s390x qemu updates 20190930
Date: Fri, 31 Jan 2020 16:01:55 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131150207.73127-1-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

Peter,

The following changes since commit 786d36ad416c6c199b18b78cc31eddfb784fe15d:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190927' into staging (2019-09-30 11:02:22 +0100)

are available in the Git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20190930

for you to fetch changes up to c5b9ce518c0551d0198bcddadc82e03de9ac8de9:

  s390/kvm: split kvm mem slots at 4TB (2019-09-30 13:51:50 +0200)

----------------------------------------------------------------
- do not abuse memory_region_allocate_system_memory and split the memory
  according to KVM memslots in KVM code instead (Paolo, Igor)
- change splitting to split at 4TB (Christian)
- do not claim s390 (31bit) support in configure (Thomas)
- sclp error checking (Janosch, Claudio)
- new s390 pci maintainer (Matt, Collin)
- fix s390 pci (again) (Matt)

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/kvm: split kvm mem slots at 4TB

Claudio Imbrenda (1):
      s390x: sclp: Report insufficient SCCB length

Igor Mammedov (2):
      kvm: split too big memory section on several memslots
      s390: do not call memory_region_allocate_system_memory() multiple times

Janosch Frank (3):
      s390x: sclp: refactor invalid command check
      s390x: sclp: boundary check
      s390x: sclp: fix error handling for oversize control blocks

Matthew Rosato (2):
      MAINTAINERS: Update S390 PCI Maintainer
      s390: PCI: fix IOMMU region init

Paolo Bonzini (2):
      kvm: extract kvm_log_clear_one_slot
      kvm: clear dirty bitmaps from all overlapping memslots

Thomas Huth (1):
      configure: Remove s390 (31-bit mode) from the list of supported CPUs

 MAINTAINERS                |   2 +-
 accel/kvm/kvm-all.c        | 237 ++++++++++++++++++++++++++++-----------------
 configure                  |   2 +-
 hw/s390x/event-facility.c  |   3 -
 hw/s390x/s390-pci-bus.c    |   7 +-
 hw/s390x/s390-virtio-ccw.c |  30 +-----
 hw/s390x/sclp.c            |  37 ++++++-
 include/sysemu/kvm_int.h   |   1 +
 target/s390x/kvm.c         |  10 ++
 9 files changed, 202 insertions(+), 127 deletions(-)
