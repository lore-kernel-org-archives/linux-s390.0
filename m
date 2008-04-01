Return-Path: <linux-kernel-owner+w=401wt.eu-S1757737AbYDAOBh@vger.kernel.org>
Subject: [PATCH 0/3] hugetlbfs: cleanup and new primitives for s390
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Apr 2008 16:01:25 +0200
Message-Id: <1207058485.5063.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Paul Mundt <lethal@linux-sh.org>
List-ID: <linux-s390.vger.kernel.org>

Hello,

this patchset cleans up hugetlbfs architecture headers and adds new
primitives as preparation for the s390 large page support. Most notably
we found that we need to add a new tlb flush for the copy-on-write of
a large page (patch #2). We think that this is a bug, but obviously one
that hasn't shown up so far on any of the other large page architectures.

As there were no objections so far, which would be the right tree for
this to get it upstream?

--
Gerald Schaefer
