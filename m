Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729212AbgICOOQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Sep 2020 10:14:16 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 0/2] s390x: pv: Fixes and improvements
Date: Thu,  3 Sep 2020 09:14:33 -0400
Message-Id: <20200903131435.2535-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com

Using the destroy call instead of the export on a VM shutdown, we can
clear out a protected guest much faster.

The 3f exception can in fact be triggered by userspace and therefore
should not panic the whole system, but send a SIGSEGV to the culprit
process.

Janosch Frank (2):
  s390x: uv: Add destroy page call
  s390x: Add 3f program exception handler

 arch/s390/include/asm/uv.h   |  7 +++++++
 arch/s390/kernel/pgm_check.S |  2 +-
 arch/s390/kernel/uv.c        | 21 +++++++++++++++++++++
 arch/s390/mm/fault.c         | 23 +++++++++++++++++++++++
 arch/s390/mm/gmap.c          |  2 +-
 5 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.25.1
