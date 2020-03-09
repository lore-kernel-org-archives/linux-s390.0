Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726617AbgCIPAl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 11:00:41 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/4] KVM: s390: reset selftest and fixes
Date: Mon,  9 Mar 2020 11:00:22 -0400
Message-Id: <20200309150026.4329-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

By adding more testcases to the reset test, I even found a bug.

Christian Borntraeger (4):
  selftests: KVM: s390: fix early guest crash
  selftests: KVM: s390: test more register variants for the reset ioctl
  KVM: s390: Also reset registers in sync regs for initial cpu reset
  selftests: KVM: s390: check for registers to NOT change on reset

 arch/s390/kvm/kvm-s390.c                   |  18 ++-
 tools/testing/selftests/kvm/s390x/resets.c | 130 +++++++++++++++++----
 2 files changed, 123 insertions(+), 25 deletions(-)

-- 
2.25.0
