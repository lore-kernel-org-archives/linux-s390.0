Return-Path: <linux-kernel-owner+w=401wt.eu-S935923AbXG0Lcm@vger.kernel.org>
Message-Id: <20070727113348.413110503@de.ibm.com>
Date: Fri, 27 Jul 2007 13:33:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/6] more s390 patches for 2.6.23-rc1
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Six additional patches for the 2.6.23-rc1 update for s390.
The shortlog:

Cornelia Huck (3):
      [S390] cio: Clean up messages.
      [S390] cio: Make CIO_* macros safe if dbfs are not available.
      [S390] cio: Reorganize initialization.

Frank Munzert (1):
      [S390] vmur: fix diag14_read.

Heiko Carstens (2):
      [S390] Fix IRQ tracing.
      [S390] Fix sclp_vt220 error handling.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
