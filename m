Return-Path: <jpoimboe@redhat.com>
Date: Tue, 20 Dec 2016 15:21:36 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 01/15] stacktrace/x86: add function for detecting
 reliable stack traces
Message-ID: <20161220212136.gdy4zof4qlvi6vhi@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <0315b36c08c104d56a4b43537fb300d200418996.1481220077.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1612191712530.6638@pobox.suse.cz>
 <20161219172549.mjm4c2midvkumqxb@treble>
 <20161220093916.GA14894@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161220093916.GA14894@pathway.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Dec 20, 2016 at 10:39:16AM +0100, Petr Mladek wrote:
> On Mon 2016-12-19 11:25:49, Josh Poimboeuf wrote:
> > 3) probably some kind of runtime NMI stack checking feature to
> >    complement objtool, along with a lot of burn time to ensure there are
> >    no issues, particularly in entry code
> 
> Could you please provide more details about this NMI stack checking?
> What is it supposed to protect that objtool could not?
> Will it run regularly or will it be just a random check?

save_stack_trace_tsk_reliable(current) would be called periodically from
an NMI handler, and a warning would be printed if it ever doesn't reach
the "end" of the stack (i.e., user-mode pt_regs).  Due to the
performance impact it would probably only be a debug option.

It would verify the special hand-coded areas which objtool isn't smart
enough to understand, like entry code, ftrace, kprobes, bpf.  It would
also make sure that objtool itself didn't missing anything.

-- 
Josh
