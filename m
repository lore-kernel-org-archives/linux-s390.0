Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392128AbhARNSh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 08:18:37 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] diag9c forwarding
Date: Mon, 18 Jan 2021 14:17:38 +0100
Message-Id: <20210118131739.7272-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Pierre Morel <pmorel@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

This patch will forward the yieldto hypercall (diag9c) if in the host
the target CPU is also not running. As we do not yet have performance
data (and recommendations) the default is turned off, but this can
be changed during runtime.

Pierre Morel (1):
  s390:kvm: diag9c forwarding

 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/include/asm/smp.h      |  1 +
 arch/s390/kernel/smp.c           |  1 +
 arch/s390/kvm/diag.c             | 31 ++++++++++++++++++++++++++++---
 arch/s390/kvm/kvm-s390.c         |  6 ++++++
 arch/s390/kvm/kvm-s390.h         |  8 ++++++++
 6 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.28.0
