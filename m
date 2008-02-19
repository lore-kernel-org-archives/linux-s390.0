Return-Path: <linux-kernel-owner+w=401wt.eu-S1754483AbYBSOpd@vger.kernel.org>
Message-Id: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/13] s390 bux fixes for 2.6.25-rc2.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,
this and that for s390. The shortlog:

Cornelia Huck (2):
      [S390] cio: Remember to initialize recovery_lock.
      [S390] cio: Do timed recovery on workqueue.

Heiko Carstens (6):
      [S390] Let NR_CPUS default to 32/64 on s390/s390x.
      [S390] Make sure enabled wait psw is loaded in default_idle.
      [S390] Initialize per cpu lowcores on cpu hotplug.
      [S390] qdio: fix qdio_activate timeout handling.
      [S390] etr: fix compile error on !SMP
      [S390] Fix futex_atomic_cmpxchg_std inline assembly.

Martin Schwidefsky (1):
      [S390] find bit corner case.

Peter Oberparleiter (1):
      [S390] sclp: clean up send/receive naming scheme

Roel Kluin (1):
      [S390] dcss: Fix Unlikely(x) != y

Stefan Weinhuber (1):
      [S390] dasd: fix locking in __dasd_device_process_final_queue

Ursula Braun (1):
      [S390] qdio: FCP/SCSI write I/O stagnates on LPAR

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
