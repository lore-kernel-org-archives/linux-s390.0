Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 26 Jan 2016 11:09:27 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160126110053.GA21553@arm.com>
References: <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com>
 <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com>
 <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com>
 <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
 <20160126103200.GI6375@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126103200.GI6375@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160126110927.2qq8qwUtuvsr4O7EUsiyIJBsTHt__4FyJd-ydl9yE3g@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com, james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 26, 2016 at 11:32:00AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 26, 2016 at 11:24:02AM +0100, Peter Zijlstra wrote:
> 
> > Yeah, this goes under the header: memory-barriers.txt is _NOT_ a
> > specification (I seem to keep repeating this).
> 
> Do we want this ?
> 
> ---
>  Documentation/memory-barriers.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index a61be39c7b51..433326ebdc26 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1,3 +1,4 @@
> +
>  			 ============================
>  			 LINUX KERNEL MEMORY BARRIERS
>  			 ============================
> @@ -5,6 +6,22 @@
>  By: David Howells <dhowells@redhat.com>
>      Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>  
> +==========
> +DISCLAIMER
> +==========
> +
> +This document is not a specification; it is intentionally (for the sake of
> +brevity) and unintentionally (due to being human) incomplete. This document is
> +meant as a guide to using the various memory barriers provided by Linux, but
> +in case of any doubt (and there are many) please ask.

It might be worth adding you and me to the top of the file, to save Paul
Cc'ing us on questions (get_maintainer.pl points at poor old Corbet for
this file).

But yes, it seems that something like this is required.

Will
