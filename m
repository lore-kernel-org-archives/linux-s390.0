Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgHaMFl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 Aug 2020 08:05:41 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 0/3] s390x: css: adapting the I/O tests for PV
Date: Mon, 31 Aug 2020 14:05:30 +0200
Message-Id: <1598875533-19947-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

To adapt the test for PV we need to share the I/O memory with the host.

To do so we:
- implement the share/unshare ultravisor code.
- implement dedicated allocation routine which make sure that
  - the I/O memory is on dedicated pages
  - the I/O memory is shared if the guest is run under PV
- replace the start_single_ccw() by ccw_alloc() and start the
  start_ccw1_chain() directly from the test function.
  This allows to correctly free the I/O memory after the interruption.

Best regards,
Pierre

Pierre Morel (3):
  s390x: pv: implement routine to share/unshare memory
  s390: define UV compatible I/O allocation
  s390x: css: pv: css test adaptation for PV

 lib/s390x/asm/uv.h    | 33 +++++++++++++++++++++++++++
 lib/s390x/css.h       |  3 +--
 lib/s390x/css_lib.c   | 28 +++++++----------------
 lib/s390x/malloc_io.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/malloc_io.h | 14 ++++++++++++
 s390x/Makefile        |  1 +
 s390x/css.c           | 35 +++++++++++++++++++---------
 7 files changed, 134 insertions(+), 33 deletions(-)
 create mode 100644 lib/s390x/malloc_io.c
 create mode 100644 lib/s390x/malloc_io.h

-- 
2.25.1
