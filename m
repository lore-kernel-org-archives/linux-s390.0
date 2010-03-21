From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/4] panic: Allow taint flag for warnings to be changed from TAINT_WARN
Date: Sun, 21 Mar 2010 20:10:43 +0100
Message-ID: <87y6hlebik.fsf@basil.nowhere.org>
References: <1269126097.18314.111.camel@localhost>
	<1269126340.18314.115.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1269126340.18314.115.camel@localhost> (Ben Hutchings's message of "Sat, 20 Mar 2010 23:05:40 +0000")
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, David Woodhouse <dwmw2@infradead.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Ben Hutchings <ben@decadent.org.uk> writes:

> WARN() is used in some places to report firmware or hardware bugs that
> are then worked-around.  These bugs do not affect the stability of the
> kernel and should not set the usual TAINT_WARN flag.  To allow for
> this, add WARN_TAINT() and WARN_TAINT_ONCE() macros that take a taint
> flag as argument.
>
> Architectures that implement warnings using trap instructions instead
> of calls to warn_slowpath_*() must now implement __WARN_TAINT(taint)
> instead of __WARN().

I guess this should enforce that at least some taint flag is set?
(e.g. with a BUILD_BUG_ON)

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
