Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 28 Mar 2008 17:53:16 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/4] set_restore_sigmask TIF_SIGPENDING
In-Reply-To: <20080329001341.7F93826FA1D@magilla.localdomain>
Message-ID: <alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org>
References: <20080329001230.D013726FA1D@magilla.localdomain> <20080329001341.7F93826FA1D@magilla.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20080329005316.FapSdRlfxiEOILe9X-ybCNqewwR7MyPsFvuLZSZZHJU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On Fri, 28 Mar 2008, Roland McGrath wrote:
>
> Set TIF_SIGPENDING in set_restore_sigmask.  This lets arch code take
> TIF_RESTORE_SIGMASK out of the set of bits that will be noticed on
> return to user mode.  On some machines those bits are scarce, and we
> can free this unneeded one up for other uses.

Hmm. That probably means that TIF_RESTORE_SIGMASK shouldn't be a "TIF" 
flag at all, but a "TS" ("thread status") flag.

The TS flags are faster, because they are thread-synchronous and do not 
need atomic accesses (ie they are purely thread-local in setting, testing 
and clearing).

Of course, it may well not be worth it. Unlike the TIF flags, the TS flags 
have been architecture-specific and I don't think all architectures even 
do them (x86 uses them for FP state bits and stuff like that).

I guess TIF_RESTORE_SIGMASK is never *so* performance-critical that we'd 
care about the difference between a single cycle (approx) for a non-atomic 
"or" into memory and an atomic bitop (~50 cycles or so). 

			Linus
