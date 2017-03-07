Return-Path: <mingo.kernel.org@gmail.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 7 Mar 2017 09:53:56 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 00/15] livepatch: hybrid consistency model
Message-ID: <20170307085356.GA7038@gmail.com>
References: <cover.1487036215.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1487036215.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

>  arch/Kconfig                                     |   6 +
>  arch/powerpc/include/asm/thread_info.h           |   4 +-
>  arch/powerpc/kernel/signal.c                     |   4 +
>  arch/s390/include/asm/thread_info.h              |  24 +-
>  arch/s390/kernel/entry.S                         |  31 +-
>  arch/x86/Kconfig                                 |   1 +
>  arch/x86/entry/common.c                          |   9 +-
>  arch/x86/include/asm/thread_info.h               |  13 +-
>  arch/x86/include/asm/unwind.h                    |   6 +
>  arch/x86/kernel/stacktrace.c                     |  96 +++-
>  arch/x86/kernel/unwind_frame.c                   |   2 +

for the x86 and scheduler changes:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
