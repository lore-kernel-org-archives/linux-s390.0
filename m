Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbfK1MqQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Nov 2019 07:46:16 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASCgwLu060789
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2whmt0nm98-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:14 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Nov 2019 12:46:12 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 0/9] s390x: Testing the Channel Subsystem I/O
Date: Thu, 28 Nov 2019 13:45:58 +0100
Message-Id: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

Goal of the series is to have a framwork to test Channel-Subsystem I/O with
QEMU/KVM.

To be able to support interrupt for CSS I/O and for SCLP we need to modify
the interrupt framework to allow re-entrant interruptions.

Making the interrupt handler weak allows the test programm to define its own
interrupt handler. We need to do special work under interrupt like acknoledging
the interrupt.

Being working on PSW bits to allow I/O interrupt, we define all PSW bits in a
dedicated file.

The simple test tests the I/O reading by the SUB Channel. It needs QEMU to
be patched to have the pong device defined.
The pong device answers, for now, with a Hello World to the read request.


Pierre Morel (9):
  s390x: saving regs for interrupts
  s390x: Define the PSW bits
  s390x: irq: make IRQ handler weak
  s390x: export the clock get_clock_ms() utility
  s390x: Library resources for CSS tests
  s390x: css: stsch, enumeration test
  s390x: css: msch, enable test
  s390x: css: ssch/tsch with sense and interrupt
  s390x: css: ping pong

 lib/s390x/asm/arch_bits.h |  20 +++
 lib/s390x/asm/arch_def.h  |   6 +-
 lib/s390x/asm/clock.h     |  25 ++++
 lib/s390x/css.h           | 282 ++++++++++++++++++++++++++++++++++++
 lib/s390x/css_dump.c      | 147 +++++++++++++++++++
 lib/s390x/interrupt.c     |   2 +-
 s390x/Makefile            |   4 +-
 s390x/css.c               | 294 ++++++++++++++++++++++++++++++++++++++
 s390x/cstart64.S          |  38 +++--
 s390x/intercept.c         |  11 +-
 s390x/unittests.cfg       |   4 +
 11 files changed, 809 insertions(+), 24 deletions(-)
 create mode 100644 lib/s390x/asm/arch_bits.h
 create mode 100644 lib/s390x/asm/clock.h
 create mode 100644 lib/s390x/css.h
 create mode 100644 lib/s390x/css_dump.c
 create mode 100644 s390x/css.c

-- 
2.17.0

Changelog:
- saving floating point registers (David, Janosh)
- suppress unused PSW bits defintions (Janosh)
- added Thomas reviewed-by
- style and comments modifications (Connie, Janosh)
- moved get_clock_ms() into headers and use it (Thomas)
- separate header and library utility from tests
- Suppress traces, separate tests, make better usage of reports
