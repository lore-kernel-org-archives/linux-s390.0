Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbfKMMX1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 07:23:27 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADCIaJY108627
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:23:27 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w8gt5jjvd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:23:26 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Nov 2019 12:23:24 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 0/4] s390x: Testing the Subchannel I/O
Date: Wed, 13 Nov 2019 13:23:15 +0100
Message-Id: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

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


Pierre Morel (4):
  s390x: saving regs for interrupts
  s390x: Define the PSW bits
  s390x:irq: make IRQ handler weak
  s390x: Testing the Subchannel I/O read

 lib/s390x/asm/arch_bits.h |  32 ++++++
 lib/s390x/asm/arch_def.h  |   6 +-
 lib/s390x/asm/interrupt.h |  15 ++-
 lib/s390x/css.h           | 244 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/css_dump.c      | 141 +++++++++++++++++++++++++++
 lib/s390x/interrupt.c     |  16 +--
 s390x/Makefile            |   2 +
 s390x/css.c               | 222 +++++++++++++++++++++++++++++++++++++++++
 s390x/cstart64.S          |  30 ++++--
 s390x/unittests.cfg       |   4 +
 10 files changed, 686 insertions(+), 26 deletions(-)
 create mode 100644 lib/s390x/asm/arch_bits.h
 create mode 100644 lib/s390x/css.h
 create mode 100644 lib/s390x/css_dump.c
 create mode 100644 s390x/css.c

-- 
2.7.4
