Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728759AbgC3ItV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 04:49:21 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [kvm-unit-tests 0/2] s390x/smp fix and enhancement
Date: Mon, 30 Mar 2020 04:49:09 -0400
Message-Id: <20200330084911.34248-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

Christian Borntraeger (2):
  s390x/smp: fix detection of "running"
  s390x/smp: add minimal test for sigp sense running status

 lib/s390x/smp.c |  4 ++--
 lib/s390x/smp.h |  2 +-
 s390x/smp.c     | 11 +++++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.25.1
