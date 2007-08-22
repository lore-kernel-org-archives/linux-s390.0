Return-Path: <linux-kernel-owner+w=401wt.eu-S1761188AbXHVMdP@vger.kernel.org>
Message-Id: <20070822123603.501231302@de.ibm.com>
Date: Wed, 22 Aug 2007 14:36:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/10] s390 patches for 2.6.23-rc3
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

10 patches for s390. The new vmur driver still has some rough edges
but we are getting there. Patch #10 is our solution to the atomic_t
vs. volatile problem. As prediced by Linus adding a barrier to
atomic_read/atomic_set has close to zero impact to the generated
code and adding the barrier to atomic_read/atomic_set forces the
compiler to read/write the value to/from memory. This seems to be
the most convenient way to solve this problem.

--
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
