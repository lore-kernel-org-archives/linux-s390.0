Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13976 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728781AbgACWdn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jan 2020 17:33:43 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003MHDRS029007
        for <linux-s390@vger.kernel.org>; Fri, 3 Jan 2020 17:33:42 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x62rc0721-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 03 Jan 2020 17:33:42 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Fri, 3 Jan 2020 22:33:40 -0000
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH v3 0/6] S390 hardware support for kernel zlib
Date: Fri,  3 Jan 2020 23:33:28 +0100
Message-Id: <20200103223334.20669-1-zaslonko@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

With IBM z15 mainframe the new DFLTCC instruction is available. It
implements deflate algorithm in hardware (Nest Acceleration Unit - NXU)
with estimated compression and decompression performance orders of
magnitude faster than the current zlib.

This patch-set adds s390 hardware compression support to kernel zlib.
The code is based on the userspace zlib implementation:
https://github.com/madler/zlib/pull/410
The coding style is also preserved for future maintainability.
There is only limited set of userspace zlib functions represented in
kernel. Apart from that, all the memory allocation should be performed
in advance. Thus, the workarea structures are extended with the parameter
lists required for the DEFLATE CONVENTION CALL instruction.
Since kernel zlib itself does not support gzip headers, only Adler-32
checksum is processed (also can be produced by DFLTCC facility).
Like it was implemented for userspace, kernel zlib will compress in
hardware on level 1, and in software on all other levels. Decompression
will always happen in hardware (when enabled).
Two DFLTCC compression calls produce the same results only when they
both are made on machines of the same generation, and when the
respective buffers have the same offset relative to the start of the
page. Therefore care should be taken when using hardware compression
when reproducible results are desired. However it does always produce
the standard conform output which can be inflated anyway.
The new kernel command line parameter 'dfltcc' is introduced to
configure s390 zlib hardware support:
    Format: { on | off | def_only | inf_only | always }
     on:       s390 zlib hardware support for compression on
               level 1 and decompression (default)
     off:      No s390 zlib hardware support
     def_only: s390 zlib hardware support for deflate
               only (compression on level 1)
     inf_only: s390 zlib hardware support for inflate
               only (decompression)
     always:   Same as 'on' but ignores the selected compression
               level always using hardware support (used for debugging)

The main purpose of the integration of the NXU support into the kernel zlib
is the use of hardware deflate in btrfs filesystem with on-the-fly
compression enabled. Apart from that, hardware support can also be used
during boot for decompressing the kernel or the ramdisk image 

With the patch for btrfs expanding zlib buffer from 1 to 4 pages (patch 6)
the following performance results have been achieved using the ramdisk
with btrfs. These are relative numbers based on throughput rate and
compression ratio for zlib level 1:

  Input data              Deflate rate   Inflate rate   Compression ratio
                          NXU/Software   NXU/Software   NXU/Software
  stream of zeroes        1.46           1.02           1.00
  random ASCII data       10.44          3.00           0.96
  ASCII text (dickens)    6,21           3.33           0.94
  binary data (vmlinux)   8,37           3.90           1.02

This means that s390 hardware deflate can provide up to 10 times faster
compression (on level 1) and up to 4 times faster decompression (refers to
all compression  levels) for btrfs zlib.

Disclaimer: Performance results are based on IBM internal tests using DD
command-line utility on btrfs on a Fedora 30 based internal driver in native
LPAR on a z15 system. Results may vary based on individual workload,
configuration and software levels.

Changelog:
v2 -> v3:
 - In btrfs zlib_compress_pages() do not copy input pages to the workspace
   buffer if no s390 hardware compression is enabled or the remaining
   input data fits in one page.
 - Leave just a single Kconfig option for s390 zlib hardware
   support (CONFIG_ZLIB_DFLTCC)
 - Fix the issues reported by kbuild test robot.
v1 -> v2:
 - Added new external zlib function to check if s390 Deflate-Conversion
   facility is installed and enabled (see patch 5).
 - The larger buffer for btrfs zlib workspace is allocated only if
   s390 hardware compression is enabled. In case of failure to allocate
   4-page buffer, we fall back to a PAGE_SIZE buffer, as proposed
   by Josef Bacik (see patch 6).



Mikhail Zaslonko (6):
  lib/zlib: Add s390 hardware support for kernel zlib_deflate
  s390/boot: Rename HEAP_SIZE due to name collision
  lib/zlib: Add s390 hardware support for kernel zlib_inflate
  s390/boot: Add dfltcc= kernel command line parameter
  lib/zlib: Add zlib_deflate_dfltcc_enabled() function
  btrfs: Use larger zlib buffer for s390 hardware compression

 .../admin-guide/kernel-parameters.txt         |  12 +
 arch/s390/boot/compressed/decompressor.c      |   8 +-
 arch/s390/boot/ipl_parm.c                     |  14 +
 arch/s390/include/asm/setup.h                 |   7 +
 arch/s390/kernel/setup.c                      |   2 +
 fs/btrfs/compression.c                        |   2 +-
 fs/btrfs/zlib.c                               | 128 +++++---
 include/linux/zlib.h                          |   6 +
 lib/Kconfig                                   |   7 +
 lib/Makefile                                  |   1 +
 lib/decompress_inflate.c                      |  13 +
 lib/zlib_deflate/deflate.c                    |  85 +++---
 lib/zlib_deflate/deflate_syms.c               |   1 +
 lib/zlib_deflate/deftree.c                    |  54 ----
 lib/zlib_deflate/defutil.h                    | 134 ++++++++-
 lib/zlib_dfltcc/Makefile                      |  11 +
 lib/zlib_dfltcc/dfltcc.c                      |  55 ++++
 lib/zlib_dfltcc/dfltcc.h                      | 155 ++++++++++
 lib/zlib_dfltcc/dfltcc_deflate.c              | 280 ++++++++++++++++++
 lib/zlib_dfltcc/dfltcc_inflate.c              | 149 ++++++++++
 lib/zlib_dfltcc/dfltcc_syms.c                 |  17 ++
 lib/zlib_dfltcc/dfltcc_util.h                 | 103 +++++++
 lib/zlib_inflate/inflate.c                    |  32 +-
 lib/zlib_inflate/inflate.h                    |   8 +
 lib/zlib_inflate/infutil.h                    |  18 +-
 25 files changed, 1150 insertions(+), 152 deletions(-)
 create mode 100644 lib/zlib_dfltcc/Makefile
 create mode 100644 lib/zlib_dfltcc/dfltcc.c
 create mode 100644 lib/zlib_dfltcc/dfltcc.h
 create mode 100644 lib/zlib_dfltcc/dfltcc_deflate.c
 create mode 100644 lib/zlib_dfltcc/dfltcc_inflate.c
 create mode 100644 lib/zlib_dfltcc/dfltcc_syms.c
 create mode 100644 lib/zlib_dfltcc/dfltcc_util.h

-- 
2.17.1
