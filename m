Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgD2Ofb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 10:35:31 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v3 00/10] s390x: smp: Improve smp code part 2
Date: Wed, 29 Apr 2020 10:35:08 -0400
Message-Id: <20200429143518.1360468-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Let's continue cleaning up the smp test and smp related functions.

We add:
   * Test for external/emergency calls after reset
   * Test SIGP restart while running
   * SIGP stop and store status while running
   * CR testing on reset

We fix:
   * Proper check for sigp completion
   * smp_cpu_setup_state() loop and return address in r14

v3:
	* Added some rev-bys and acks
	* Add a workaround for stop and store status
	* Beautified cr checking with loop

v2:
	* Added some rev-bys and acks
	* Explicitly stop and start cpu before hot restart test

GIT: https://github.com/frankjaa/kvm-unit-tests/tree/smp_cleanup2

Janosch Frank (10):
  s390x: smp: Test all CRs on initial reset
  s390x: smp: Dirty fpc before initial reset test
  s390x: smp: Test stop and store status on a running and stopped cpu
  s390x: smp: Test local interrupts after cpu reset
  s390x: smp: Loop if secondary cpu returns into cpu setup again
  s390x: smp: Remove unneeded cpu loops
  s390x: smp: Use full PSW to bringup new cpu
  s390x: smp: Wait for sigp completion
  s390x: smp: Add restart when running test
  s390x: Fix library constant definitions

 lib/s390x/asm/arch_def.h |   8 ++--
 lib/s390x/smp.c          |  11 +++++
 lib/s390x/smp.h          |   1 +
 s390x/cstart64.S         |   5 +-
 s390x/smp.c              | 101 +++++++++++++++++++++++++++++++++++----
 5 files changed, 112 insertions(+), 14 deletions(-)

-- 
2.25.1
