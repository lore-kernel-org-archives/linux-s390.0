Return-Path: <linux-kernel-owner+w=401wt.eu-S2992966AbXDTLbr@vger.kernel.org>
Date: Fri, 20 Apr 2007 13:31:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 0/7] Kconfig: cleanup s390.
Message-ID: <20070420113157.GA3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

Greetings,
my last try to straighten then Kconfig for s390 failed, probably due
to the disable statement. I still want to get rid of the s390 specific
Kconfig file in drivers/s390/Kconfig. Too much duplication, too often
something that should have been added is forgotten..

So this is a new attempt, this time without the disable extension but
with lots of "depends on !S390" lines. The eight patches go on top of
2.6.21-rc6-mm1. Patches 1-4 fit (with hunks) on top of the current git
as well.

I noticed an oddity with the B44 option. It selects SSB which is a new
bus that sits on top of either PCI or PCMCIA. The trouble is that s390
does have neither PCI nor PCMCIA. Patch #7 adds a depends line to the 
SSB option. Now the SSB option is not available on s390 anymore but
the B44 option is. You can select it and by doing so the SSB option
gets selected as well(!). I solved this by replacing the "select SSB"
with a "depends on SSB", see patch #8. But then the B44 option is only
available if the SSB option is enabled. What we'd need is an additional
check if the options that are to be selected by a config option can be
selected as well and hide the original config option that does the
invalid select. Quite a nasty problem.

If nobody objects to the cleanup I'll add the patches to git390 for
a please-pull at the next merge window.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
