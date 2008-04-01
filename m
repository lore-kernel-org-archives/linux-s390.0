Return-Path: <linux-kernel-owner+w=401wt.eu-S1760055AbYDAWbn@vger.kernel.org>
Date: Tue, 1 Apr 2008 15:31:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] hugetlbfs: cleanup and new primitives for s390
Message-Id: <20080401153102.09af4aca.akpm@linux-foundation.org>
In-Reply-To: <1207058485.5063.36.camel@localhost.localdomain>
References: <1207058485.5063.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, mingo@elte.hu, davem@davemloft.net, tony.luck@intel.com, paulus@samba.org, tglx@linutronix.de, lethal@linux-sh.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 01 Apr 2008 16:01:25 +0200
Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:

> this patchset cleans up hugetlbfs architecture headers and adds new
> primitives as preparation for the s390 large page support. Most notably
> we found that we need to add a new tlb flush for the copy-on-write of
> a large page (patch #2). We think that this is a bug, but obviously one
> that hasn't shown up so far on any of the other large page architectures.
> 
> As there were no objections so far, which would be the right tree for
> this to get it upstream?

-mm, I suppose.

But all the patcehs had the same title and I'd prefer to not have to
invent your patch titles for you.
