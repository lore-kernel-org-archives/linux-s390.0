From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 02 Jul 2015 12:50:07 +0000
Subject: Re: [PATCH RESEND] Update kernel math-emu code from current glibc soft-fp
Message-Id: <1435841407.6500.2.camel@ellerman.id.au>
References: <alpine.DEB.2.10.1505192206580.28384@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1506221321340.27145@digraph.polyomino.org.uk>
 <1435634913.24866.1.camel@ellerman.id.au>
 <alpine.DEB.2.10.1506301042250.2339@digraph.polyomino.org.uk>
 <1435702685.24693.3.camel@ellerman.id.au>
 <CAMuHMdV+t0OVYq=VFydRCq6+94E89Rt8AupZApZgCNqZ6mGJSw@mail.gmail.com>
In-Reply-To: <CAMuHMdV+t0OVYq=VFydRCq6+94E89Rt8AupZApZgCNqZ6mGJSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joseph Myers <joseph@codesourcery.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "David S.Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2015-07-01 at 09:34 +0200, Geert Uytterhoeven wrote:
> On Wed, Jul 1, 2015 at 12:18 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Tue, 2015-06-30 at 10:48 +0000, Joseph Myers wrote:
> >> On Tue, 30 Jun 2015, Michael Ellerman wrote:
> >>
> >> > Is there some way you can imagine of splitting this up into smaller chunks, so
> >> > that different arches can merge the pieces separately?
> >>
> >> Well, it could be split as:
> >>
> >> 1. Rename include/math-emu to math-emu-old and update architectures for
> >> the renaming (mechanically).
> >>
> >> 2. Add new include/math-emu.
> >>
> >> 3,4,5,6,7. Move each architecture from math-emu-old to math-emu.
> >>
> >> 8. Remove math-emu-old.
> >>
> >> You still have patch 1 affecting all five architectures, but with the
> >> per-architecture changes being much simpler.
> >
> > OK. That's obviously a bit more churn, but I think it's probably the best
> > approach. Unless someone else has a better idea?
> 
> Does it make that much of a difference?

Well yeah?

> You said:
> | However in it's current form it's not easily mergeable, because it
> touches five
> | architectures and has the potential to cause breakage on all of them.
> 
> Patch 1 still touches five architectures.

It does, but it would be mechanical, so in theory at least it should be a safe.

That patch could also go in a full release before the others, giving us the
maximum opportunity to test.

> Patches 3-7 still have the potential to break an architecture, but only one of
> them at a time.

Right. But each maintainer could take the patch for their arch and merge it as
they see fit.

The main advantage though would be if regressions are found we could revert
just the patch for a particular arch, rather than having to back out the whole
thing - which would be basically impossible.

> From a bisectability point of view there's no change.

Agreed.

The other problem if it's monolithic is who's tree does it go into? I guess
Andrews.

cheers
