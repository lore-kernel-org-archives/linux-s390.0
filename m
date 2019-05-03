From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Documentation: Add ARM64 to kernel-parameters.rst
Date: Fri, 3 May 2019 14:00:27 +0100
Message-ID: <20190503130027.GD32046@fuggles.cambridge.arm.com>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
 <25174c3c-0e39-0562-7d02-bb7d51cd2b43@infradead.org>
 <20190413035621.tohihjksatqushwf@treble>
 <20190503063756.09c74f6e@lwn.net>
 <20190503123940.GC32046@fuggles.cambridge.arm.com>
 <20190503064719.45d79af9@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190503064719.45d79af9@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.orgCa
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 03, 2019 at 06:47:19AM -0600, Jonathan Corbet wrote:
> On Fri, 3 May 2019 13:39:40 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > > It looks like nobody has picked this up...so I've applied it.  
> > 
> > It's queued and tagged in the arm64 tree, which should also be in next!
> 
> Just looked again, I still don't see it there.  Josh's mitigations= change
> is there, but not this one.  In any case, I've unapplied it, so it's all
> yours.

Weird... I see it in -next as 4ad499c94264:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=4ad499c94264a2ee05aacc518b9bde658318e510

Will
