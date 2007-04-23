Return-Path: <linux-kernel-owner+w=401wt.eu-S1161152AbXDWRrO@vger.kernel.org>
Date: Mon, 23 Apr 2007 10:45:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-Id: <20070423104534.51bac974.akpm@linux-foundation.org>
In-Reply-To: <20070423141123.GA21174@skybase>
References: <20070423141123.GA21174@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Mon, 23 Apr 2007 16:11:23 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> Greetings,
> I've added the results of the review to the Kconfig cleanup patches
> for s390. Patch #2 has been split, one half has all the HAS_IOMEM
> depends lines the other the remaining !S390 depends lines.
> 
> Andrew: I plan to add patches 1-5 to the for-andrew branch of the
> git390 repository if that is fine with you. The only thing that will
> be missing in the tree is the patch that disables wireless for s390.
> The code does compile but without hardware it is mute to have the
> config options. I'll wait until the git-wireless.patch is upstream.
> Patches 7-9 depend on patches found in -mm.
> 

umm, OK.  If it's Ok I think I'll duck it for now: -mm is full.

Over-full, really: I've been working basically continuously since Friday
getting the current dungpile to compile and boot, and it's still miles away
from that.
