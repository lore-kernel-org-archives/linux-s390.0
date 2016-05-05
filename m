Return-Path: <pmladek@suse.com>
Date: Thu, 5 May 2016 12:21:59 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: barriers: was: [RFC PATCH v2 17/18] livepatch: change to a
 per-task consistency model
Message-ID: <20160505102159.GW2749@pathway.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160504123940.GR2749@pathway.suse.cz>
 <20160504170236.mpncog3iudr3cvem@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160504170236.mpncog3iudr3cvem@treble>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed 2016-05-04 12:02:36, Josh Poimboeuf wrote:
> On Wed, May 04, 2016 at 02:39:40PM +0200, Petr Mladek wrote:
> > On Thu 2016-04-28 15:44:48, Josh Poimboeuf wrote:
> > > Change livepatch to use a basic per-task consistency model.  This is the
> > > foundation which will eventually enable us to patch those ~10% of
> > > security patches which change function or data semantics.  This is the
> > > biggest remaining piece needed to make livepatch more generally useful.
> > 
> > I spent a lot of time with checking the memory barriers. It seems that
> > they are basically correct.  Let me use my own words to show how
> > I understand it. I hope that it will help others with review.
> 
> [...snip a ton of useful comments...]
> 
> Thanks, this will help a lot!  I'll try to incorporate your barrier
> comments into the code.

Thanks a lot.

> I also agree that kpatch_patch_task() is poorly named.  I was trying to
> make it clear to external callers that "hey, the task is getting patched
> now!", but it's internally inconsistent with livepatch code because we
> make a distinction between patching and unpatching.
> 
> Maybe I'll do:
> 
>   klp_update_task_patch_state()

I like it. It is long but it well describes the purpose.

Livepatch is using many state variables:

  + global:                klp_transition_patch, klp_target_state
  + per task specific:     TIF_PENDING_PATCH, patch_state
  + per each new function: transition, patched
  + per old function:      func_stack
  + per object:            patched, loaded
  + per patch:             enabled

The dependency between them and the workflow is important to
create a mental picture about the Livepatching. Good names
help with it.

Best Regards,
Petr
