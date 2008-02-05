Return-Path: <linux-kernel-owner+w=401wt.eu-S1754762AbYBEPja@vger.kernel.org>
Message-Id: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/18] s390 bug fix patches.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The shortlog says is all:

Christian Borntraeger (1):
      [S390] sclp_tty/sclp_vt220: Fix scheduling while atomic

Cornelia Huck (3):
      [S390] cio: Clean up chsc response code handling.
      [S390] cio: Update documentation.
      [S390] cio: Add shutdown callback for ccwgroup.

Heiko Carstens (8):
      [S390] DEBUG_PAGEALLOC support for s390.
      [S390] Fix linker script.
      [S390] Fix smp_call_function_mask semantics.
      [S390] Fix couple of section mismatches.
      [S390] Implement ext2_find_next_bit.
      [S390] latencytop s390 support.
      [S390] Remove BUILD_BUG_ON() in vmem code.
      [S390] dcss: Initialize workqueue before using it.

Martin Schwidefsky (2):
      [S390] Define GENERIC_LOCKBREAK.
      [S390] Cleanup & optimize bitops.

Peter Oberparleiter (2):
      [S390] cio: make sense id procedure work with partial hardware response
      [S390] console: allow vt220 console to be the only console

Stefan Haberland (1):
      [S390] dasd: add ifcc handling

Stefan Weinhuber (1):
      [S390] dasd: fix panic caused by alias device offline


The only notable changes are the DEBUG_PAGEALLOC and the latencytop
support. Have fun.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
