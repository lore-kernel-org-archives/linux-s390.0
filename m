Return-Path: <mbenes@suse.cz>
Date: Tue, 7 Feb 2017 09:21:49 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v4 13/15] livepatch: change to a per-task consistency model
In-Reply-To: <20170206155828.7mivuyzdtre4dato@treble>
Message-ID: <alpine.LSU.2.20.1702070920360.18051@pobox.suse.cz>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <62e96e43de6f09e16f36d3d51af766c8fcbbb05f.1484839971.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1702031724040.28531@pobox.suse.cz>
 <20170206155828.7mivuyzdtre4dato@treble>
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
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>


> > And finally, the section "Limitations" has this text under the first 
> > bullet:
> > 
> >   + The patch must not change the semantic of the patched functions.
> > 
> >     The current implementation guarantees only that either the old
> >     or the new function is called. The functions are patched one
> >     by one. It means that the patch must _not_ change the semantic
> >     of the function.
> > 
> > I think it is confusing. The consistency model allows us to change the 
> > semantic of a function. To certain degree. Of course, there are cases that 
> > cannot be patched, or have to be patched carefully. For example if a 
> > function takes a lock by calling foo_lock(), foo_lock() is not on a stack 
> > afterwards. Then the locking semantics may be changed with a livepatch. 
> > One has to make sure to patch also the caller foo_lock() to enforce the 
> > consistency. And so on... But I do not consider a limitation of livepatch. 
> > It is a feature of the consistency model, which is weaker than kGraft's or 
> > kpatch's (or stronger. It depends on your point of view.)
> > 
> > So, I propose to remove this text and better describe the properties of 
> > the consistency model above in the section 3. Maybe a quote from an old 
> > mail thread (Nov 2014) would be sufficient. I don't remember what was 
> > mentioned and what not.
> > 
> > What do you think?
> 
> I'll remove the above limitation.
> 
> I'm not sure how to improve the consistency model section.  It already
> has at least some mentions of changed function semantics and locking
> semantics.  I'll leave it alone for now, unless you have a specific
> suggestion.

Fair enough. Let's see if I can come up with something.
 
> > > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > > index 6602b34..ed90ad1 100644
> > > --- a/include/linux/livepatch.h
> > > +++ b/include/linux/livepatch.h
> > > @@ -68,7 +92,7 @@ struct klp_func {
> > >   * @funcs:	function entries for functions to be patched in the object
> > >   * @kobj:	kobject for sysfs resources
> > >   * @mod:	kernel module associated with the patched object
> > > - * 		(NULL for vmlinux)
> > > + *		(NULL for vmlinux)
> > 
> > This looks superfluous.
> 
> This is a minor whitespace fix -- remove a space before tab.  I figured
> I'd go ahead and fix it since I'm already changing some of the
> surrounding code.

Ok, no problem.

Thanks,
Miroslav
