From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] panic: Allow taint flag for warnings to be changed
 from TAINT_WARN
Date: Mon, 22 Mar 2010 22:47:33 -0400
Message-ID: <20100322224733.9cf93a0a.akpm@linux-foundation.org>
References: <1269126097.18314.111.camel@localhost>
	<1269126340.18314.115.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1269126340.18314.115.camel@localhost>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, David Woodhouse <dwmw2@infradead.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 20 Mar 2010 23:05:40 +0000 Ben Hutchings <ben@decadent.org.uk> wrote:

> WARN() is used in some places to report firmware or hardware bugs that
> are then worked-around.  These bugs do not affect the stability of the
> kernel and should not set the usual TAINT_WARN flag.  To allow for
> this, add WARN_TAINT() and WARN_TAINT_ONCE() macros that take a taint
> flag as argument.
> 
> Architectures that implement warnings using trap instructions instead
> of calls to warn_slowpath_*() must now implement __WARN_TAINT(taint)
> instead of __WARN().

When you say they "must now implement", I assume that you mean that
they _do_ now implement, and that no additional architecture work is
needed.

> The architecture-specific changes here are untested and need to be
> reviewed by architecture maintainers.

That would be nice.
