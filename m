Return-Path: <linux-kernel-owner+w=401wt.eu-S933523AbXKPOdm@vger.kernel.org>
Message-Id: <20071116142942.978412023@de.ibm.com>
Date: Fri, 16 Nov 2007 15:29:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/6] Pending patches in the s390 2.6.25 merge queue.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The current set of patches queue for the next merge window with more
to come. The shortlog:

Heiko Carstens (3):
      [S390] sclp: call sclp_init() from start_kernel().
      [S390] Standby cpu activation/deactivation.
      [S390] sclp: convert channel path configure code to use sync interface.

Michael Ernst (1):
      [S390] sclp: sysfs interface for SCLP cpi

Michael Holzheu (1):
      [S390] kernel: Shutdown Actions Interface

Peter Oberparleiter (1):
      [S390] cio: Extend adapter interrupt interface.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
