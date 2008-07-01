Return-Path: <linux-kernel-owner+w=401wt.eu-S1759076AbYGAOIZ@vger.kernel.org>
Message-Id: <20080701140551.168274793@de.ibm.com>
Date: Tue, 01 Jul 2008 16:05:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/5] [RFC] new qdio driver.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: jang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Greetings,
this patch set contains the new qdio driver Jan has been working on
for the last couple of months. 3878 insertions vs. 4937 deletions,
the numbers look good and the new driver is a major improvement over
the old one (and it looks nicer :-).
The last two patches are the adaptions of the qeth driver and the
zfcp driver. This qeth patch depends on the qeth patches that will
go upstream via Jeffs network tree and the zfcp patch depends on the
patches that are queued in James scsi tree. I plan to push the
qdio rework patches at the end of the merge window after the -net and
-scsi trees have been pulled.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
