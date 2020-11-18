Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725814AbgKRJjt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 04:39:49 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] Fix and MAINTAINER update for 5.10
Date: Wed, 18 Nov 2020 10:39:40 +0100
Message-Id: <20201118093942.457191-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

Conny, David,

your chance for quick feedback. I plan to send a pull request for kvm
master soon.

I have agreed with Heiko to carry this via the KVM tree as
this is KVM s390 specific.

Christian Borntraeger (2):
  s390/uv: handle destroy page legacy interface
  MAINTAINERS: add uv.c also to KVM/s390

 MAINTAINERS           | 1 +
 arch/s390/kernel/uv.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.28.0
