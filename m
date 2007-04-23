Return-Path: <linux-kernel-owner+w=401wt.eu-S1753928AbXDWOLJ@vger.kernel.org>
Date: Mon, 23 Apr 2007 16:11:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-ID: <20070423141123.GA21174@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

Greetings,
I've added the results of the review to the Kconfig cleanup patches
for s390. Patch #2 has been split, one half has all the HAS_IOMEM
depends lines the other the remaining !S390 depends lines.

Andrew: I plan to add patches 1-5 to the for-andrew branch of the
git390 repository if that is fine with you. The only thing that will
be missing in the tree is the patch that disables wireless for s390.
The code does compile but without hardware it is mute to have the
config options. I'll wait until the git-wireless.patch is upstream.
Patches 7-9 depend on patches found in -mm.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
