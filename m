Return-Path: <jpoimboe@redhat.com>
Date: Wed, 4 May 2016 11:51:50 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: barriers: was: [RFC PATCH v2 17/18] livepatch: change to a
 per-task consistency model
Message-ID: <20160504165150.m5sbdrcetk3wf45e@treble>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160504123940.GR2749@pathway.suse.cz>
 <20160504135329.GQ3430@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160504135329.GQ3430@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 04, 2016 at 03:53:29PM +0200, Peter Zijlstra wrote:
> On Wed, May 04, 2016 at 02:39:40PM +0200, Petr Mladek wrote:
> > > +	 * This barrier also ensures that if another CPU goes through the
> > > +	 * syscall barrier, sees the TIF_PATCH_PENDING writes in
> > > +	 * klp_start_transition(), and calls klp_patch_task(), it also sees the
> > > +	 * above write to the target state.  Otherwise it can put the task in
> > > +	 * the wrong universe.

(oops, missed a "universe" -> "patch state" rename)

> > > +	 */
> > 
> > By other words, it makes sure that klp_patch_task() will assign the
> > right patch_state. Where klp_patch_task() could not be called
> > before we set TIF_PATCH_PENDING in klp_start_transition().
> > 
> > > +	smp_wmb();
> > > +}
> 
> So I've not read the patch; but ending a function with an smp_wmb()
> feels wrong.
> 
> A wmb orders two stores, and I feel both stores should be well visible
> in the same function.

Yeah, I would agree with that.  And also, it's probably a red flag that
the barrier needs *three* paragraphs to describe the various cases its
needed for.

However, there are some complications:

1) The stores are in separate functions (which is a generally a good
   thing as it greatly helps the readability of the code).

2) Which stores are being ordered depends on whether the function is
   called in the enable path or the disable path.

3) Either way it actually orders *two* separate pairs of stores.

Anyway I'm thinking I should move that barrier out of
klp_init_transition() and into its callers.  The stores will still be in
separate functions but at least there will be better visibility of where
the stores are occurring, and the comments can be a little more focused.

-- 
Josh
