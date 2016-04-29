Return-Path: <mnghuan@gmail.com>
Date: Fri, 29 Apr 2016 21:45:58 +0800
From: Minfei Huang <mnghuan@gmail.com>
Subject: Re: [RFC PATCH v2 06/18] x86: dump_trace() error handling
Message-ID: <20160429134558.GA17476@dhcp-128-44.nay.redhat.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <c2891af88397538e7e3bba34172924d783f37c53.1461875890.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c2891af88397538e7e3bba34172924d783f37c53.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 04/28/16 at 03:44P, Josh Poimboeuf wrote:
> In preparation for being able to determine whether a given stack trace
> is reliable, allow the stacktrace_ops functions to propagate errors to
> dump_trace().

Hi, Josh.

Have you considered to make walk_stack function as non-return function,
since there is no obvious error during detecting the frame points?

Thanks
Minfei
