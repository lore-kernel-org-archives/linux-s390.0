Return-Path: <linux-kernel-owner+w=401wt.eu-S1752153AbYE2NCA@vger.kernel.org>
Message-Id: <20080529125501.196123527@de.ibm.com>
Date: Thu, 29 May 2008 14:55:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/11] s390 bug fixes for 2.6.26-rc4
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,
another batch of s390 patches for 2.6.26, all of them bug fixes.

The shortlog:

Christian Borntraeger (1):
      [S390] s390 types: make dma_addr_t 64 bit capable

Gerald Schaefer (1):
      [S390] appldata: prevent cpu hotplug when walking cpu_online_map.

Hans-Joachim Picht (1):
      [S390] fix sparsemem related compile error with allnoconfig on s390

Heiko Carstens (3):
      [S390] Fix section mismatch warnings.
      [S390] showmem: Only walk spanned pages.
      [S390] sclp_vt220: fix scheduling while atomic bug.

Martin Schwidefsky (3):
      [S390] 3270: fix race with stack local wait_queue_head_t.
      [S390] tape: fix race with stack local wait_queue_head_t.
      [S390] disassembler: fix idte instruction format.

Michael Holzheu (1):
      [S390] tape: Fix race condition in tape block device driver

Stefan Haberland (1):
      [S390] dasd: use a generic wait_queue for sleep_on

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
