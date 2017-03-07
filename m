Return-Path: <mbenes@suse.cz>
Date: Tue, 7 Mar 2017 15:50:11 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v5.1 15/15] livepatch: allow removal of a disabled
 patch
In-Reply-To: <20170306172029.vk4fk7kzlrh2ty4m@treble>
Message-ID: <alpine.LSU.2.20.1703071549030.29377@pobox.suse.cz>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <95fe68239fc91360093f84aea97418ae88cfc634.1487036215.git.jpoimboe@redhat.com>
 <20170306172029.vk4fk7kzlrh2ty4m@treble>
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

On Mon, 6 Mar 2017, Josh Poimboeuf wrote:

> 
> Currently we do not allow patch module to unload since there is no
> method to determine if a task is still running in the patched code.
> 
> The consistency model gives us the way because when the unpatching
> finishes we know that all tasks were marked as safe to call an original
> function. Thus every new call to the function calls the original code
> and at the same time no task can be somewhere in the patched code,
> because it had to leave that code to be marked as safe.
> 
> We can safely let the patch module go after that.
> 
> Completion is used for synchronization between module removal and sysfs
> infrastructure in a similar way to commit 942e443127e9 ("module: Fix
> mod->mkobj.kobj potentially freed too early").
> 
> Note that we still do not allow the removal for immediate model, that is
> no consistency model. The module refcount may increase in this case if
> somebody disables and enables the patch several times. This should not
> cause any harm.
> 
> With this change a call to try_module_get() is moved to
> __klp_enable_patch from klp_register_patch to make module reference
> counting symmetric (module_put() is in a patch disable path) and to
> allow to take a new reference to a disabled module when being enabled.
> 
> Finally, we need to be very careful about possible races between
> klp_unregister_patch(), kobject_put() functions and operations
> on the related sysfs files.
> 
> kobject_put(&patch->kobj) must be called without klp_mutex. Otherwise,
> it might be blocked by enabled_store() that needs the mutex as well.
> In addition, enabled_store() must check if the patch was not
> unregisted in the meantime.
> 
> There is no need to do the same for other kobject_put() callsites
> at the moment. Their sysfs operations neither take the lock nor
> they access any data that might be freed in the meantime.
> 
> There was an attempt to use kobjects the right way and prevent these
> races by design. But it made the patch definition more complicated
> and opened another can of worms. See
> https://lkml.kernel.org/r/1464018848-4303-1-git-send-email-pmladek@suse.com
> 
> [Thanks to Petr Mladek for improving the commit message.]
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
> v5.1: improve error handling in enable path -- call module_put() in
>       klp_cancel_transition()

Looks good.

Acked-by: Miroslav Benes <mbenes@suse.cz>

if it is needed for Josh's code.

Regards,
Miroslav
