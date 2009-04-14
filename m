Return-Path: <linux-kernel-owner+w=401wt.eu-S1756315AbZDNNyJ@vger.kernel.org>
Message-Id: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/14] s390 patches for 2.6.30-rc1
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
the usual bug fixes for an -rc release and some cpu time accouting
improvements. Nothing major, the shortlog:

Christian Ehrhardt (1):
      [S390] s390: move machine flags to lowcore

Cornelia Huck (1):
      [S390] dasd: Use the new async framework for autoonlining.

Gerald Schaefer (1):
      [S390] appldata: Use new mod_virt_timer_periodic() function.

Heiko Carstens (3):
      [S390] wire up preadv/pwritev system calls
      [S390] call nmi_enter/nmi_exit on machine checks
      [S390] smp: fix cpu_possible_map initialization

Jan Glauber (2):
      [S390] extend virtual timer interface by mod_virt_timer_periodic
      [S390] qdio: remove dead timeout handler

Martin Schwidefsky (5):
      [S390] stp synchronization retry timer
      [S390] fix idle time accounting
      [S390] cpu hotplug and accounting values
      [S390] add read_persistent_clock
      [S390] boot cputime accounting

Stefan Weinhuber (1):
      [S390] dasd: fix idaw boundary checking for track based ccw

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
