From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
Date: Wed, 10 Apr 2019 15:48:48 +1000
Message-ID: <87sguqwgu7.fsf@concordia.ellerman.id.au>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
 <20190405131211.GE23348@zn.tnic> <20190405142048.burthk2jnpcvi2om@treble>
 <20190405152059.GG23348@zn.tnic> <20190405160136.GI23348@zn.tnic>
 <20190405161852.nmpk22omgiety4df@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190405161852.nmpk22omgiety4df@treble>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>, Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

Josh Poimboeuf <jpoimboe@redhat.com> writes:

> On Fri, Apr 05, 2019 at 06:01:36PM +0200, Borislav Petkov wrote:
>> Thinking about this more, we can shave off the first 4 chars and have it
>> be:
>> 
>> spec_mitigations=
>> 
>> I think it is painfully clear which speculation mitigations we mean. And
>> the other switches don't have "cpu_" prefixes too so...
>
> Sure, I'm ok with renaming it to that, if there are no objections.

What about when we have a mitigation for a non-speculation related bug :)

mitigations=xxx

?

cheers
