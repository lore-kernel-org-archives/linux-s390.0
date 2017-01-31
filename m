Return-Path: <jpoimboe@redhat.com>
Date: Tue, 31 Jan 2017 08:56:54 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4 14/15] livepatch: add /proc/<pid>/patch_state
Message-ID: <20170131145654.hzbxahqr4rz6r5f2@treble>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <2c3b793fc23910f8fe15033b2b35e53b0b5dbaf3.1484839971.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1701311518290.3719@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LSU.2.20.1701311518290.3719@pobox.suse.cz>
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

On Tue, Jan 31, 2017 at 03:31:39PM +0100, Miroslav Benes wrote:
> On Thu, 19 Jan 2017, Josh Poimboeuf wrote:
> 
> > Expose the per-task patch state value so users can determine which tasks
> > are holding up completion of a patching operation.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> > ---
> >  Documentation/filesystems/proc.txt | 18 ++++++++++++++++++
> >  fs/proc/base.c                     | 15 +++++++++++++++
> >  2 files changed, 33 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> > index 72624a1..85c501b 100644
> > --- a/Documentation/filesystems/proc.txt
> > +++ b/Documentation/filesystems/proc.txt
> > @@ -44,6 +44,7 @@ Table of Contents
> >    3.8   /proc/<pid>/fdinfo/<fd> - Information about opened file
> >    3.9   /proc/<pid>/map_files - Information about memory mapped files
> >    3.10  /proc/<pid>/timerslack_ns - Task timerslack value
> > +  3.11	/proc/<pid>/patch_state - Livepatch patch operation state
> >  
> >    4	Configuring procfs
> >    4.1	Mount options
> > @@ -1886,6 +1887,23 @@ Valid values are from 0 - ULLONG_MAX
> >  An application setting the value must have PTRACE_MODE_ATTACH_FSCREDS level
> >  permissions on the task specified to change its timerslack_ns value.
> >  
> > +3.11	/proc/<pid>/patch_state - Livepatch patch operation state
> > +-----------------------------------------------------------------
> > +When CONFIG_LIVEPATCH is enabled, this file displays the value of the
> > +patch state for the task.
> > +
> > +A value of '-1' indicates that no patch is in transition.
> > +
> > +A value of '0' indicates that a patch is in transition and the task is
> > +unpatched.  If the patch is being enabled, then the task hasn't been
> > +patched yet.  If the patch is being disabled, then the task has already
> > +been unpatched.
> > +
> > +A value of '1' indicates that a patch is in transition and the task is
> > +patched.  If the patch is being enabled, then the task has already been
> > +patched.  If the patch is being disabled, then the task hasn't been
> > +unpatched yet.
> > +
> 
> Despite my review I thought about this some more. I think the logic make 
> sense internally but when exposed it can be confusing. We do not export 
> klp_target_state value, so users have to know if a patch is being enabled 
> or disabled. Of course, they should know that, but I guess they'd like to 
> use an userspace tool for this. Such tool needs to look at 
> /proc/<pid>/patch_state to find out which tasks are blocking the 
> completion and that is it. No more information anywhere.
> 
> We can either export klp_target_state, or change /proc/<pid>/patch_state 
> to show only two states - task is in transition (1), task is patched (0).
> 
> What do you think?

Isn't this information already available in
/sys/kernel/livepatch/<patch>/{enabled,transition}?

-- 
Josh
