Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbfLFQ0g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Dec 2019 11:26:36 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6GEoL7068992
        for <linux-s390@vger.kernel.org>; Fri, 6 Dec 2019 11:26:35 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9g6c8yv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 06 Dec 2019 11:26:35 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 6 Dec 2019 16:26:32 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 0/9] s390x: Testing the Channel Subsystem I/O
Date: Fri,  6 Dec 2019 17:26:19 +0100
Message-Id: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

Goal of the series is to have a framwork to test Channel-Subsystem I/O with
QEMU/KVM.
  
To be able to support interrupt for CSS I/O and for SCLP we need to modify
the interrupt framework to allow re-entrant interruptions.
  
We add a registration for IRQ callbacks to the test programm to define its own
interrupt handler. We need to do special work under interrupt like acknoledging
the interrupt.
  
Being working on PSW bits to allow I/O interrupt, we define new PSW bits
in arch_def.h and use __ASSEMBLER__ define to be able to include this header
in an assembler source file.
 
This series presents four major tests:
- Enumeration:
	The CSS is enumerated using the STSCH instruction recursively on all
	potentially existing channels.
	Keeping the first channel found as a reference for future use.
	Checks STSCH

- Enable:
	If the enumeration succeeded the tests enables the reference
	channel with MSCH and verifies with STSCH that the channel is
	effectively enabled
	Checks MSCH

- Sense:
	If the channel is enabled this test sends a SENSE_ID command
	to the reference channel, analysing the answer and expecting
	the Control unit type being 0xc0ca
	Checks SSCH(READ) and IO-IRQ

- ping-pong:
	If the reference channel leads to the PONG device (0xc0ca),
	the test exchanges a string containing a 9 digit number with
	the PONG device and expecting this number to be incremented
	by the PONG device.
	Checks SSCH(WRITE)


Pierre Morel (9):
  s390x: saving regs for interrupts
  s390x: Define the PSW bits
  s390: interrupt registration
  s390x: export the clock get_clock_ms() utility
  s390x: Library resources for CSS tests
  s390x: css: stsch, enumeration test
  s390x: css: msch, enable test
  s390x: css: ssch/tsch with sense and interrupt
  s390x: css: ping pong

 lib/s390x/asm/arch_def.h | 127 ++++++++-------
 lib/s390x/asm/time.h     |  27 ++++
 lib/s390x/css.h          | 273 +++++++++++++++++++++++++++++++
 lib/s390x/css_dump.c     | 156 ++++++++++++++++++
 lib/s390x/interrupt.c    |  23 ++-
 lib/s390x/interrupt.h    |   7 +
 s390x/Makefile           |   2 +
 s390x/css.c              | 335 +++++++++++++++++++++++++++++++++++++++
 s390x/cstart64.S         |  38 ++++-
 s390x/intercept.c        |  11 +-
 s390x/unittests.cfg      |   4 +
 11 files changed, 924 insertions(+), 79 deletions(-)
 create mode 100644 lib/s390x/asm/time.h
 create mode 100644 lib/s390x/css.h
 create mode 100644 lib/s390x/css_dump.c
 create mode 100644 lib/s390x/interrupt.h
 create mode 100644 s390x/css.c

-- 
2.17.0

Changelog:
from v2 to v3:
- Rework spelling
  (Connie)
- More descriptions
  (Connie)
- use __ASSEMBLER__ preprocessing to keep
  bits definitions and C structures in the same file
  (David)
- rename the new file clock.h as time.h
  (Janosch, David?)
- use registration for the IO interruption
  (David, Thomas)
- test the SCHIB to verify it has really be modified
  (Connie)
- Lot of simplifications in the tests
  (Connie)

from v1 to v2:
- saving floating point registers (David, Janosh)
- suppress unused PSW bits defintions (Janosh)
- added Thomas reviewed-by
- style and comments modifications (Connie, Janosh)
- moved get_clock_ms() into headers and use it (Thomas)
- separate header and library utility from tests
- Suppress traces, separate tests, make better usage of reports
