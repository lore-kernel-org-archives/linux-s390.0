From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar
 types
Date: Mon, 24 Nov 2014 12:46:14 -0800
Message-ID: <20141124204614.GU5050@linux.vnet.ibm.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
 <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
 <15567.1416835858@warthog.procyon.org.uk>
 <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
 <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
 <547381D7.2070404@de.ibm.com>
 <CA+55aFy+dunTcdgB4-BXsYiLDk9pf8b_L74ky-dMixpbX3JQQA@mail.gmail.com>
 <20141124194200.GR5050@linux.vnet.ibm.com>
 <CA+55aFwJEqMv00zkwHmp_LOg74RU3e30-oo6RaYb=yGjgGr2cg@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwJEqMv00zkwHmp_LOg74RU3e30-oo6RaYb=yGjgGr2cg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Howells <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, linux-x86_64@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 24, 2014 at 12:19:11PM -0800, Linus Torvalds wrote:
> On Mon, Nov 24, 2014 at 11:42 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > OK, how about the following?
> 
> Ugh. Disgusting.
> 
> Why the heck isn't it just "sizeof(*__vp) <= sizeof(long)"?
> 
> If the architecture has a 3-byte scalar type, then it probably has a
> 3-byte load.

Because I was allowing for the possibility of a 3-byte struct, which
as you point out below...

> > It complains if the variable is too large, for example, long long on
> > 32-bit systems or large structures.  It is OK loading from and storing
> > to small structures as well, which I am having a hard time thinking of
> > as a disadvantage.
> 
> .. but that's *exactly* the gcc bug in question. It's a word-sized
> struct that gcc loads twice.

...was a stupid thought anyway.

OK, how about the attempt below?  The initialization of __p complains
for structures and unions, but gets optimized out.

							Thanx, Paul

-------------------------------------------------------------------------

#define get_scalar_volatile_pointer(x) ({ \
	typeof(x) __maybe_unused __p = 0; \
	volatile typeof(x) *__vp = &(x); \
	BUILD_BUG_ON(sizeof(*__vp) > sizeof(long)); \
	__vp; })
#define ACCESS_ONCE(x) (*get_scalar_volatile_pointer(x))
