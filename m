Return-Path: <jpoimboe@redhat.com>
Date: Tue, 21 Feb 2017 15:21:10 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170221212110.y2pstgeluwrmxjie@treble>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <a999d965d598b23564355c24db0ed6799f105fa6.1487036215.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1702161504020.16310@pobox.suse.cz>
 <20170216203156.igvctdmyt6b6zcgg@treble>
 <alpine.LSU.2.20.1702170940420.4107@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LSU.2.20.1702170940420.4107@pobox.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 17, 2017 at 09:51:29AM +0100, Miroslav Benes wrote:
> On Thu, 16 Feb 2017, Josh Poimboeuf wrote:
> > What do you think about the following?  I tried to put the logic in
> > klp_complete_transition(), so the module_put()'s would be in one place.
> > But it was too messy, so I put it in klp_cancel_transition() instead.
> >
> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > index e96346e..bd1c1fd 100644
> > --- a/kernel/livepatch/transition.c
> > +++ b/kernel/livepatch/transition.c
> > @@ -121,8 +121,28 @@ static void klp_complete_transition(void)
> >   */
> >  void klp_cancel_transition(void)
> >  {
> > +	bool immediate_func = false;
> > +
> >  	klp_target_state = !klp_target_state;
> >  	klp_complete_transition();
> > +
> > +	if (klp_target_state == KLP_PATCHED)
> > +		return;
> 
> This is not needed, I think. We call klp_cancel_transition() in 
> __klp_enable_patch() only. klp_target_state is set to KLP_PATCHED there 
> (through klp_init_transition()) and negated here. We know it must be 
> KLP_UNPATCHED.

Yeah, I was trying to hedge against the possibility of future code
calling this function in the disable path.  But that probably won't
happen and it would probably be cleaner to just add a warning if
klp_target_state isn't KLP_PATCHED.

> Moreover, due to klp_complete_transition() klp_target_state is always 
> KLP_UNDEFINED after it.
> 
> > +
> > +	/*
> > +	 * In the enable error path, even immediate patches can be safely
> > +	 * removed because the transition hasn't been started yet.
> > +	 *
> > +	 * klp_complete_transition() doesn't have a module_put() for immediate
> > +	 * patches, so do it here.
> > +	 */
> > +	klp_for_each_object(klp_transition_patch, obj)
> > +		klp_for_each_func(obj, func)
> > +			if (func->immediate)
> > +				immediate_func = true;
> > +
> > +	if (klp_transition_patch->immediate || immediate_func)
> > +		module_put(klp_transition_patch->mod);
> 
> Almost correct. The only problem is that klp_transition_patch is NULL at 
> this point. klp_complete_transition() does that and it should stay there 
> in my opinion to keep it simple.
> 
> So we could either move all this to __klp_enable_patch(), where patch 
> variable is defined, or we could store klp_transition_patch to a local 
> variable here in klp_cancel_transition() before klp_complete_transition() 
> is called. That should be safe. I like the latter more, because it keeps 
> the code in klp_cancel_transition() where it belongs.

Good points.  Here's another try:

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index e96346e..a23c63c 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -121,8 +121,31 @@ static void klp_complete_transition(void)
  */
 void klp_cancel_transition(void)
 {
-	klp_target_state = !klp_target_state;
+	struct klp_patch *patch = klp_transition_patch;
+	struct klp_object *obj;
+	struct klp_func *func;
+	bool immediate_func = false;
+
+	if (WARN_ON_ONCE(klp_target_state != KLP_PATCHED))
+		return;
+
+	klp_target_state = KLP_UNPATCHED;
 	klp_complete_transition();
+
+	/*
+	 * In the enable error path, even immediate patches can be safely
+	 * removed because the transition hasn't been started yet.
+	 *
+	 * klp_complete_transition() doesn't have a module_put() for immediate
+	 * patches, so do it here.
+	 */
+	klp_for_each_object(patch, obj)
+		klp_for_each_func(obj, func)
+			if (func->immediate)
+				immediate_func = true;
+
+	if (patch->immediate || immediate_func)
+		module_put(patch->mod);
 }
 
 /*
