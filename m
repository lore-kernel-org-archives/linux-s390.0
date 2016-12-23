Return-Path: <mbenes@suse.cz>
Date: Fri, 23 Dec 2016 13:54:50 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v3 08/15] livepatch: separate enabled and patched
 states
In-Reply-To: <de700cbd87b4157b0152c7293558a27deaf0a37b.1481220077.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1612231352200.5990@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <de700cbd87b4157b0152c7293558a27deaf0a37b.1481220077.git.jpoimboe@redhat.com>
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
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 8 Dec 2016, Josh Poimboeuf wrote:

> Once we have a consistency model, patches and their objects will be
> enabled and disabled at different times.  For example, when a patch is
> disabled, its loaded objects' funcs can remain registered with ftrace
> indefinitely until the unpatching operation is complete and they're no
> longer in use.
> 
> It's less confusing if we give them different names: patches can be
> enabled or disabled; objects (and their funcs) can be patched or
> unpatched:
> 
> - Enabled means that a patch is logically enabled (but not necessarily
>   fully applied).
> 
> - Patched means that an object's funcs are registered with ftrace and
>   added to the klp_ops func stack.
> 
> Also, since these states are binary, represent them with booleans
> instead of ints.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
