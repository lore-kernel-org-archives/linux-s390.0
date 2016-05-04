Return-Path: <jikos@kernel.org>
Date: Wed, 4 May 2016 16:56:34 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
Subject: Re: klp_task_patch: was: [RFC PATCH v2 17/18] livepatch: change to
 a per-task consistency model
In-Reply-To: <20160504144854.GT2749@pathway.suse.cz>
Message-ID: <alpine.LNX.2.00.1605041651500.27942@cbobk.fhfr.pm>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160504144854.GT2749@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 4 May 2016, Petr Mladek wrote:

> > +
> > +		if (unlikely(klp_patch_pending(current)))
> > +			klp_patch_task(current);
> >  	}
> 
> Some more ideas from the world of crazy races. I was shaking my head
> if this was safe or not.
> 
> The problem might be if the task get rescheduled between the check
> for the pending stuff 

The code in question is running with preemption disabled.

> or inside the klp_patch_task() function. 

We must make sure that this function doesn't go to sleep. It's only used 
to clear the task_struct flag anyway.

-- 
Jiri Kosina
SUSE Labs
