Return-Path: <mbenes@suse.cz>
Date: Fri, 3 Feb 2017 17:48:52 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v4 15/15] livepatch: allow removal of a disabled patch
In-Reply-To: <7b540d5a66243628eae1925e8871dc9678305973.1484839971.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1702031748010.28531@pobox.suse.cz>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <7b540d5a66243628eae1925e8871dc9678305973.1484839971.git.jpoimboe@redhat.com>
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

On Thu, 19 Jan 2017, Josh Poimboeuf wrote:

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
> at the moment. Their sysfs operations neiter take the lock nor

s/neiter/neither/

Thanks,
Miroslav
