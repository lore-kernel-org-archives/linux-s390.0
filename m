Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726582AbgDXKqA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 06:46:00 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v6 00/10] s390x: Testing the Channel Subsystem I/O
Date: Fri, 24 Apr 2020 12:45:42 +0200
Message-Id: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
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


Note:
- The following patches may be pulled first:
  s390x: saving regs for interrupts
  s390x: Use PSW bits definitions in cstart
  s390x: Move control register bit definitions and add AFP to them

- I think this one if it receives reviewed-by can also be pulled now:
  s390x: define wfi: wait for interrupt

- this patch has a comment from Janosch who asks change so... need opinion:
  but since I need reviews for the next patches I let it here unchanged.
  s390x: interrupt registration

- These 5 patches are really I/O oriented and need reviewed-by:
  s390x: Library resources for CSS tests
  s390x: css: stsch, enumeration test
  s390x: css: msch, enable test
  s390x: css: ssch/tsch with sense and interrupt
  s390x: css: ping pong

Pierre Morel (10):
  s390x: saving regs for interrupts
  s390x: Use PSW bits definitions in cstart
  s390x: Move control register bit definitions and add AFP to them
  s390x: interrupt registration
  s390x: Library resources for CSS tests
  s390x: css: stsch, enumeration test
  s390x: css: msch, enable test
  s390x: define wfi: wait for interrupt
  s390x: css: ssch/tsch with sense and interrupt
  s390x: css: ping pong

 lib/s390x/asm/arch_def.h |  31 +++-
 lib/s390x/css.h          | 277 +++++++++++++++++++++++++++++++
 lib/s390x/css_dump.c     | 157 ++++++++++++++++++
 lib/s390x/css_lib.c      |  55 +++++++
 lib/s390x/interrupt.c    |  23 ++-
 lib/s390x/interrupt.h    |   8 +
 s390x/Makefile           |   3 +
 s390x/css.c              | 343 +++++++++++++++++++++++++++++++++++++++
 s390x/cstart64.S         |  51 ++++--
 s390x/unittests.cfg      |   4 +
 10 files changed, 936 insertions(+), 16 deletions(-)
 create mode 100644 lib/s390x/css.h
 create mode 100644 lib/s390x/css_dump.c
 create mode 100644 lib/s390x/css_lib.c
 create mode 100644 lib/s390x/interrupt.h
 create mode 100644 s390x/css.c

-- 
2.25.1

Changelog:

from v5 to v6
- Added comments for IRQ handling in
  s390x: saving regs for interrupts
  (Janosch) 

- fixed BUG on reset_psw, added PSW_MASK_PSW_SHORT
  and PSW_RESET_MASK

- fixed several lines over 80 chars

- fixed licenses, use GPL V2 (no more LGPL)

- replacing delay() with wfi() (Wait For Interrupt)
  during the css tests
  (suggested by Connie's comments)

- suppressing delay() induces suppressing the patch
  "s390x: export the clock get_clock_ms() utility"
  which is already reviewed but can be picked from
  the v5 series.

- changed the logic of the tests, the 4 css tests
  are always run one after the other so no need to 
  re-run enumeration and enabling at the begining
  of each tests, it has alredy been done.
  This makes code simpler.

from v4 to v5
- add a patch to explicitely define the initial_cr0
  value
  (Janosch)
- add RB from Janosh on interrupt registration
- several formating, typo correction and removing
  unnecessary initialization in "linrary resources..."
  (Janosch)
- several formating and typo corrections on
  "stsch enumeration test"
  (Connie)
- reworking the msch test
  (Connie)
- reworking of ssch test, pack the sense-id structure
  (Connie)

from v3 to v4
- add RB from David and Thomas for patchs 
  (3) irq registration and (4) clock export
- rework the PSW bit definitions
  (Thomas)
- Suppress undef DEBUG from css_dump
  (Thomas)
- rework report() functions using new scheme
  (Thomas)
- suppress un-necessary report_info()
- more spelling corrections
- add a loop around enable bit testing
  (Connie)
- rework IRQ testing
  (Connie)
- Test data addresses to be under 2G
  (Connie)

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
