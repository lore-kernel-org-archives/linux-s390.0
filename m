Return-Path: <jpoimboe@redhat.com>
Date: Fri, 16 Dec 2016 16:15:50 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 03/15] livepatch: temporary stubs for
 klp_patch_pending() and klp_update_patch_state()
Message-ID: <20161216221550.qp26jmhe3txpl6op@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <26bb2315093328bf31e94fdd6eec61c341a6e924.1481220077.git.jpoimboe@redhat.com>
 <20161216144159.GE393@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161216144159.GE393@pathway.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 16, 2016 at 03:41:59PM +0100, Petr Mladek wrote:
> On Thu 2016-12-08 12:08:28, Josh Poimboeuf wrote:
> > Create temporary stubs for klp_patch_pending() and
> > klp_update_patch_state() so we can add TIF_PATCH_PENDING to different
> > architectures in separate patches without breaking build bisectability.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  include/linux/livepatch.h | 7 ++++++-
> >  kernel/livepatch/core.c   | 3 +++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index 9072f04..60558d8 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -123,10 +123,15 @@ void arch_klp_init_object_loaded(struct klp_patch *patch,
> >  int klp_module_coming(struct module *mod);
> >  void klp_module_going(struct module *mod);
> >  
> > +static inline bool klp_patch_pending(struct task_struct *task) { return false; }
> 
> I was curious about this. It is implemented correctly in the 13th
> patch and it is never used until 13th patch.

Yep, I'll move it to patch 13.

> 
> > +void klp_update_patch_state(struct task_struct *task);
> 
> It seems that the stub for this function is enough.
> 
> Well, the extra function is just a cosmetic problem. If it could be
> fixed, it would be great. But the patch makes sense:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr
> 

-- 
Josh
