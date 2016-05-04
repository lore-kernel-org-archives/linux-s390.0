Return-Path: <jpoimboe@redhat.com>
Date: Wed, 4 May 2016 12:02:36 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: barriers: was: [RFC PATCH v2 17/18] livepatch: change to a
 per-task consistency model
Message-ID: <20160504170236.mpncog3iudr3cvem@treble>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160504123940.GR2749@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160504123940.GR2749@pathway.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 04, 2016 at 02:39:40PM +0200, Petr Mladek wrote:
> On Thu 2016-04-28 15:44:48, Josh Poimboeuf wrote:
> > Change livepatch to use a basic per-task consistency model.  This is the
> > foundation which will eventually enable us to patch those ~10% of
> > security patches which change function or data semantics.  This is the
> > biggest remaining piece needed to make livepatch more generally useful.
> 
> I spent a lot of time with checking the memory barriers. It seems that
> they are basically correct.  Let me use my own words to show how
> I understand it. I hope that it will help others with review.

[...snip a ton of useful comments...]

Thanks, this will help a lot!  I'll try to incorporate your barrier
comments into the code.

I also agree that kpatch_patch_task() is poorly named.  I was trying to
make it clear to external callers that "hey, the task is getting patched
now!", but it's internally inconsistent with livepatch code because we
make a distinction between patching and unpatching.

Maybe I'll do:

  klp_update_task_patch_state()

-- 
Josh
