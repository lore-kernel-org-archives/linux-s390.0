Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 5 Apr 2019 09:20:48 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
Message-ID: <20190405142048.burthk2jnpcvi2om@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
 <20190405131211.GE23348@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405131211.GE23348@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190405142048.qJvWe7mR5XJIzpc5altU1UI3DVF6Fm9Yjvd8BKsNEy4@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 05, 2019 at 03:12:11PM +0200, Borislav Petkov wrote:
> On Thu, Apr 04, 2019 at 11:44:11AM -0500, Josh Poimboeuf wrote:
> > Keeping track of the number of mitigations for all the CPU speculation
> > bugs has become overwhelming for many users.  It's getting more and more
> > complicated to decide which mitigations are needed for a given
> > architecture.  Complicating matters is the fact that each arch tends to
> > their own custom way to mitigate the same vulnerability.
> 
> Yap, we definitely need something like that.
> 
> > Most users fall into a few basic categories:
> > 
> > a) they want all mitigations off;
> > 
> > b) they want all reasonable mitigations on, with SMT enabled even if
> >    it's vulnerable; or
> 
> Uff, "reasonable" - there's the bikeshed waiting to happen.

Luckily the defaults have already been chosen.  So "reasonable" just
means to use the defaults.

> > c) they want all reasonable mitigations on, with SMT disabled if
> >    vulnerable.
> > 
> > Define a set of curated, arch-independent options, each of which is an
> > aggregation of existing options:
> > 
> > - cpu_spec_mitigations=off: Disable all mitigations.
> 
> "cpu_spec_mitigations" is too long, TBH.
> 
> Imagine yourself in a loud, noisy data center - you basically can't wait
> to leave - crouched over a keyboard in an impossible position, having
> to type that thing and then making a typo. Whoops, too late, already
> pressed Enter. Shiiiit!

Sure, it's a bit long.  But it's also easier to remember and more
self-documenting than any shortened option I could come up with.

In your scenario, the fact that it's so easy to remember would save the
day, since you wouldn't have to go look up some obscure shortened option
name in the documentation :-)

Suggestions are welcome but I couldn't come up with a reasonable shorter
option.

> Now you have to wait at least 15 mins for the damn single-threaded added
> value BIOS crap to noodle through all the cores just so you can try
> again, because you just rebooted the box.
> 
> And I know, my ideas for shorter cmdline options are crazy, like
> 
> cpu_spec_mtg=
> 
> which people would say, yuck, unreadable...

I agree with those people.  In my world "mtg" is short for meeting.

> Oh, I know! How about
> 
> cpu_vulns=
> 
> ?

No, because

a) We aren't enabling/disabling *vulnerabilities*, but rather
   mitigations;

b) We aren't enabling/disabling *all* CPU mitigations, only the
   speculative ones.

> We already have /sys/devices/system/cpu/vulnerabilities so it'll be the
> same as that. Less things to remember.

Except that it's not called "cpu_vulns"...

-- 
Josh
