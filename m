Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729233AbgIGMr3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 08:47:29 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 0/2] s390x: pv: Fixes and improvements
Date: Mon,  7 Sep 2020 08:46:58 -0400
Message-Id: <20200907124700.10374-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com, hca@linux.ibm.com

Using the destroy call instead of the export on a VM shutdown, we can
clear out a protected guest much faster.

The 3f exception can in fact be triggered by userspace and therefore
should not panic the whole system, but send a SIGSEGV to the culprit
process.

v2:
	* Removed whitespace damage
	* Directly access task struct for pid and comm
	* Removed NOKPROBE_SYMBOL

Janosch Frank (2):
  s390x: uv: Add destroy page call
  s390x: Add 3f program exception handler

 arch/s390/include/asm/uv.h   |  7 +++++++
 arch/s390/kernel/pgm_check.S |  2 +-
 arch/s390/kernel/uv.c        | 20 ++++++++++++++++++++
 arch/s390/mm/fault.c         | 20 ++++++++++++++++++++
 arch/s390/mm/gmap.c          |  2 +-
 5 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.25.1
