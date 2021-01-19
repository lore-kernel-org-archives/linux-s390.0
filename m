Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729810AbhASTxM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 14:53:12 -0500
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v3 0/3] s390x: css: pv: css test adaptation for PV
Date: Tue, 19 Jan 2021 20:52:21 +0100
Message-Id: <1611085944-21609-1-git-send-email-pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

Hi all,

To adapt the CSS I/O tests to protected virtualisation we need
utilities to:

1- allocate the I/O buffers in a private page using (patch 2)
   It must be in a dedicated page to avoid exporting code or
   guest private data to the host.

2- share the I/O buffers with the host (patch 1)
   This patch uses the page allocator reworked by Claudio.

The 2 first patches are the implementation of the tools,
patch 3 is the modification of the css.c test for PV.

regards,
Pierre

Pierre Morel (3):
  s390x: pv: implement routine to share/unshare memory
  s390x: define UV compatible I/O allocation
  s390x: css: pv: css test adaptation for PV

 lib/s390x/asm/uv.h    | 38 ++++++++++++++++++++++++++++++++
 lib/s390x/css.h       |  3 +--
 lib/s390x/css_lib.c   | 28 +++++++-----------------
 lib/s390x/malloc_io.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/malloc_io.h | 18 ++++++++++++++++
 s390x/Makefile        |  1 +
 s390x/css.c           | 35 ++++++++++++++++++++----------
 7 files changed, 140 insertions(+), 33 deletions(-)
 create mode 100644 lib/s390x/malloc_io.c
 create mode 100644 lib/s390x/malloc_io.h

-- 
2.17.1

changelog:

from v2:

- use the page allocator reworked by Claudio

from v1:

- add the kvm-unit-test header

- correct checks for errors on Set/Remove Shared Access

- Add report for uv Set/Remove Shared Access

- zero the allocated I/O page before use

- free the page on error.
