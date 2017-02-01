Return-Path: <jikos@kernel.org>
Date: Wed, 1 Feb 2017 22:01:20 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 00/15] livepatch: hybrid consistency model
In-Reply-To: <20170201200243.zqxq6lmbjsr6in52@treble>
Message-ID: <alpine.LSU.2.20.1702012154240.4763@cbobk.fhfr.pm>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <20170201200243.zqxq6lmbjsr6in52@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 1 Feb 2017, Josh Poimboeuf wrote:

> If there are no more comments, it would be great to get these patches in 
> for the 4.11 merge window.  Any objections to that?

That'd mean that the exposure in -next would be really short, which I'd 
like to avoid. I'd love to tentatively target 4.12 though (I personally am 
still far from being done with reviewing the patchset myself, thanks a lot 
to Peter and Miroslav for doing all the heavy lifting on this front so 
far).

More importantly though, we're still missing quite some Acks from 
subsystem/arch maintainers. Namely, I'd really appreciate Acks for patches 
touching sched/idle.c and s390/x86/ppc arch specific bits from the 
respective maintainers.

Peter, Ingo, Heiko, Michael, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs
