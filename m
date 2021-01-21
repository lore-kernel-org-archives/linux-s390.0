Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728502AbhAUJOO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 04:14:14 -0500
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 0/3] s390x: css: pv: css test adaptation for PV
Date: Thu, 21 Jan 2021 10:13:09 +0100
Message-Id: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com

Hi all,

To adapt the CSS I/O tests to protected virtualisation we need
utilities to:

1- allocate the I/O buffers in a private page using (patch 2)
   It must be in a dedicated page to avoid exporting code or
   guest private data to the host.
   We accept a size in byte and flags and allocate page integral
   memory to handle the Protected Virtualization.

2- share the I/O buffers with the host (patch 1)
   This patch uses the page allocator reworked by Claudio.

The 2 first patches are the implementation of the tools,
patch 3 is the modification of the css.c test for PV.

The checkpatch always asked me to modify MAINTAINERS,
so I added me as reviewer to be in copy for CSS at least.
May be we could create a finer grain MAINTAINERS in the
future.

regards,
Pierre

Pierre Morel (3):
  s390x: pv: implement routine to share/unshare memory
  s390x: define UV compatible I/O allocation
  s390x: css: pv: css test adaptation for PV

 MAINTAINERS           |  1 +
 lib/s390x/asm/uv.h    | 38 +++++++++++++++++++++++
 lib/s390x/css.h       |  3 +-
 lib/s390x/css_lib.c   | 28 +++++------------
 lib/s390x/malloc_io.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/malloc_io.h | 45 ++++++++++++++++++++++++++++
 s390x/Makefile        |  1 +
 s390x/css.c           | 43 ++++++++++++++++++--------
 8 files changed, 195 insertions(+), 34 deletions(-)
 create mode 100644 lib/s390x/malloc_io.c
 create mode 100644 lib/s390x/malloc_io.h

-- 
2.17.1

changelog:

from v3:
- add failure report to the new allocations in css.c
  (Thomas)

- rework alloc_io_page and free_io_page
  (Thomas, Claudio)

- add SPDX licenses
  (Thomas)

- add comment for the functions declaration.

- add me as reviewer for the CSS

from v2:

- use the page allocator reworked by Claudio

from v1:

- add the kvm-unit-test header

- correct checks for errors on Set/Remove Shared Access

- Add report for uv Set/Remove Shared Access

- zero the allocated I/O page before use

- free the page on error.
