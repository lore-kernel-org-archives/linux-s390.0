Return-Path: <jpoimboe@redhat.com>
Date: Tue, 3 May 2016 08:48:58 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 13/18] livepatch: separate enabled and patched
 states
Message-ID: <20160503134858.n6fto6tasih2rzmi@treble>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <ae7e5e9a36abf70aedb6de131fcba5383aba3275.1461875890.git.jpoimboe@redhat.com>
 <20160503093012.GO2749@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160503093012.GO2749@pathway.suse.cz>
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

On Tue, May 03, 2016 at 11:30:12AM +0200, Petr Mladek wrote:
> On Thu 2016-04-28 15:44:44, Josh Poimboeuf wrote:
> > Once we have a consistency model, patches and their objects will be
> > enabled and disabled at different times.  For example, when a patch is
> > disabled, its loaded objects' funcs can remain registered with ftrace
> > indefinitely until the unpatching operation is complete and they're no
> > longer in use.
> > 
> > It's less confusing if we give them different names: patches can be
> > enabled or disabled; objects (and their funcs) can be patched or
> > unpatched:
> > 
> > - Enabled means that a patch is logically enabled (but not necessarily
> >   fully applied).
> > 
> > - Patched means that an object's funcs are registered with ftrace and
> >   added to the klp_ops func stack.
> > 
> > Also, since these states are binary, represent them with booleans
> > instead of ints.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  include/linux/livepatch.h | 17 ++++-------
> >  kernel/livepatch/core.c   | 72 +++++++++++++++++++++++------------------------
> >  2 files changed, 42 insertions(+), 47 deletions(-)
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 6ea6880..2b59230 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -622,20 +622,20 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
> >  	if (ret)
> >  		return -EINVAL;
> >  
> > -	if (val != KLP_DISABLED && val != KLP_ENABLED)
> > +	if (val > 1)
> >  		return -EINVAL;
> 
> It would be cleaner to get "val" via kstrtobool(). It guarantees that
> the value is true or false. Another nice win is that it accepts
> Y/y/1/N/n/0 as the input.
> 
> >  	patch = container_of(kobj, struct klp_patch, kobj);
> >  
> >  	mutex_lock(&klp_mutex);
> >  
> > -	if (val == patch->state) {
> > +	if (patch->enabled == val) {
> 
> Also this check will be cleaner if "val" is a boolean.

Good idea, thanks.

-- 
Josh
