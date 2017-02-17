Return-Path: <mbenes@suse.cz>
Date: Fri, 17 Feb 2017 09:55:23 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v5 00/15] livepatch: hybrid consistency model
In-Reply-To: <cover.1487036215.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1702170953210.4107@pobox.suse.cz>
References: <cover.1487036215.git.jpoimboe@redhat.com>
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

On Mon, 13 Feb 2017, Josh Poimboeuf wrote:

> Here's v5 of the consistency model, targeted for 4.12.  Only a few minor
> changes this time.
> 
> v5:
> - return -EINVAL in __save_stack_trace_reliable()
> - only call show_stack() once
> - add save_stack_trace_tsk_reliable() define for !CONFIG_STACKTRACE
> - update kernel version and date in ABI doc
> - make suggested improvements to livepatch.txt
> - update barrier comments
> - remove klp_try_complete_transition() call from klp_start_transition()
> - move end of klp_try_complete_transition() into klp_complete_transition()
> - fix __klp_enable_patch() error path
> - check for transition in klp_module_going()

All the changes since v4 look good to me (except for module_put() in 
__klp_enable_patch() mentioned elsewhere).

Thanks,
Miroslav
