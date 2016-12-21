Return-Path: <pmladek@suse.com>
Date: Wed, 21 Dec 2016 15:44:35 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 15/15] livepatch: allow removal of a disabled patch
Message-ID: <20161221144435.GF25166@pathway.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <21cb19ed5a44e876aeb830fdea1fad2c795a63f5.1481220077.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21cb19ed5a44e876aeb830fdea1fad2c795a63f5.1481220077.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2016-12-08 12:08:40, Josh Poimboeuf wrote:
> From: Miroslav Benes <mbenes@suse.cz>
> 
> Currently we do not allow patch module to unload since there is no
> method to determine if a task is still running in the patched code.
> 
> The consistency model gives us the way because when the unpatching
> finishes we know that all tasks were marked as safe to call an original
> function. Thus every new call to the function calls the original code
> and at the same time no task can be somewhere in the patched code,
> because it had to leave that code to be marked as safe.

[...]

> Also all kobject_put(&patch->kobj) calls are moved outside of klp_mutex
> lock protection to prevent a deadlock situation when
> klp_unregister_patch is called and sysfs directories are removed.
> is no need to do the same for other kobject_put() callsites as we
> currently do not have their sysfs counterparts.

Heh, we have spent huge amount of time on this. I think
that it deserves a more precise description ;-). What about?


Finally, we need to be very careful about possible races between
klp_unregister_patch(), kobject_put() functions and operations
on the related sysfs files.

kobject_put(&patch->kobj) must be called without klp_mutex. Otherwise,
it might be blocked by enabled_store() that needs the mutex as well.
In addition, enabled_store() must check if the patch was not
unregisted in the meantime.

There is no need to do the same for other kobject_put() callsites
at the moment. Their sysfs operations neiter take the lock nor
they access any data that might be freed in the meantime.

There was an attempt to use kobjects the right way and prevent these
races by design. But it made the patch definition more complicated
and opened another can of worms. See
https://lkml.kernel.org/r/1464018848-4303-1-git-send-email-pmladek@suse.com

> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Otherwise, it seems correct. We have already analyzed this to the death.
I do not see new problems with a fresh look.

With the above, or comparable, change in the commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
