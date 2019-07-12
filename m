Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfGLRVM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 13:21:12 -0400
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 0/2] Add uncompressed Linux banner to s390 bzImage
Date: Fri, 12 Jul 2019 19:20:59 +0200
Message-Id: <cover.1562950641.git.ptesarik@suse.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laura Abbott <labbott@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

These patches make it easy to determine the kernel version from a
compressed binary by scanning for the Linux banner string in the
uncompressed portion of bzImage.

Petr Tesarik (2):
  init: Separate banner from init_uts_ns
  s390: add Linux banner to the compressed image

 arch/s390/boot/compressed/Makefile |  1 +
 init/Makefile                      |  2 +-
 init/banner.c                      | 21 +++++++++++++++++++++
 init/version.c                     | 10 ----------
 4 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 init/banner.c

-- 
2.16.4
