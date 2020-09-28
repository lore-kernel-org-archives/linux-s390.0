Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgI1OXp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Sep 2020 10:23:45 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 0/4] s390x: css: pv: css test adaptation for PV
Date: Mon, 28 Sep 2020 16:23:33 +0200
Message-Id: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com

Hi all,

I send a v2 even I got not a lot of answers for v1 because:
1 I forgot the kvm-unit-test header
2 the patch on uv.h was very bad
3 I saw some stupid errors I can correct myself like
  to zero the allocated page before use or free it on error.

That said, here what is done:

To adapt the CSS I/O tests to protected virtualisation we need
utilities to:

1- allocate the I/O buffers in a private page (patch 3)
   It must be in a dedicated page to avoid exporting code or
   guest private data to the host.

2- share  the I/O buffer with the host (patch 2)

3- be sure to allocate memory under 2Gb (patch 1)

The 3 first patches are the implementation of the tools,
patch 4 is the modification of the css.c test for PV.

regards,
Pierre

Pierre Morel (4):
  memory: allocation in low memory
  s390x: pv: implement routine to share/unshare memory
  s390x: define UV compatible I/O allocation
  s390x: css: pv: css test adaptation for PV

 lib/alloc_dma_page.c  | 57 +++++++++++++++++++++++++++++++++++++++++++
 lib/alloc_dma_page.h  | 24 ++++++++++++++++++
 lib/s390x/asm/uv.h    | 50 +++++++++++++++++++++++++++++++++++++
 lib/s390x/css.h       |  3 +--
 lib/s390x/css_lib.c   | 28 ++++++---------------
 lib/s390x/malloc_io.c | 49 +++++++++++++++++++++++++++++++++++++
 lib/s390x/malloc_io.h | 18 ++++++++++++++
 lib/s390x/sclp.c      |  2 ++
 s390x/Makefile        |  2 ++
 s390x/css.c           | 35 +++++++++++++++++---------
 10 files changed, 235 insertions(+), 33 deletions(-)
 create mode 100644 lib/alloc_dma_page.c
 create mode 100644 lib/alloc_dma_page.h
 create mode 100644 lib/s390x/malloc_io.c
 create mode 100644 lib/s390x/malloc_io.h

-- 
2.25.1

changelog:

from v1:

- add the kvm-unit-test header

- correct checks for errors on Set/Remove Shared Access

- Add report for uv Set/Remove Shared Access

- zero the allocated I/O page before use

- free the page on error.
