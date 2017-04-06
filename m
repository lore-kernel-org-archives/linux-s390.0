Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] perf/s390: fix (and enhance) perf annotate
Date: Thu,  6 Apr 2017 09:51:50 +0200
Message-Id: <1491465112-45819-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Arnaldo, 
since 4.10 perf annotate fails with error -95 on s390.
This contains a fix for 4.11 (maybe CC stable for 4.10?) and
an extension to implement jump detection.

Christian Borntraeger (2):
  s390/perf: fix perf annotate error -95 (4.10 regression)
  perf/s390: implement jump types for perf annotate

 tools/perf/arch/s390/annotate/instructions.c | 30 ++++++++++++++++++++++++++++
 tools/perf/util/annotate.c                   |  8 ++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tools/perf/arch/s390/annotate/instructions.c

-- 
2.7.4
