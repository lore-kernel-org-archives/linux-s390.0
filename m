Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728306AbgIYQht (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Sep 2020 12:37:49 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 0/4] s390x: css: pv: css test adaptation for PV
Date: Fri, 25 Sep 2020 18:02:40 +0200
Message-Id: <1601049764-11784-1-git-send-email-pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com

Hi all,

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
  s390: define UV compatible I/O allocation
  s390x: css: pv: css test adaptation for PV

 lib/alloc_dma_page.c  | 57 +++++++++++++++++++++++++++++++++++++++++++
 lib/alloc_dma_page.h  | 24 ++++++++++++++++++
 lib/s390x/asm/uv.h    | 33 +++++++++++++++++++++++++
 lib/s390x/css.h       |  3 +--
 lib/s390x/css_lib.c   | 28 ++++++---------------
 lib/s390x/malloc_io.c | 50 +++++++++++++++++++++++++++++++++++++
 lib/s390x/malloc_io.h | 18 ++++++++++++++
 lib/s390x/sclp.c      |  2 ++
 s390x/Makefile        |  2 ++
 s390x/css.c           | 35 +++++++++++++++++---------
 10 files changed, 219 insertions(+), 33 deletions(-)
 create mode 100644 lib/alloc_dma_page.c
 create mode 100644 lib/alloc_dma_page.h
 create mode 100644 lib/s390x/malloc_io.c
 create mode 100644 lib/s390x/malloc_io.h

-- 
2.25.1
