Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org> <20190401134421.278590567@goodmis.org>
In-Reply-To: <20190401134421.278590567@goodmis.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Apr 2019 11:56:23 -0700
Message-ID: <CAMo8BfK8gdgni3z3PKv1rd0KPFMXgDCpicQQ_obuoDAEz3PkZQ@mail.gmail.com>
Subject: Re: [PATCH 5/6 v3] syscalls: Remove start and number from
 syscall_get_arguments() args
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404185623.CjKMNA-r2x5dPTZDl3Yjg4w4sH0qiDrHKoSSbOb2hk8@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, Linux-Arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>, Dave Martin <dave.martin@arm.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 1, 2019 at 6:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>
> At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
> function call syscall_get_arguments() implemented in x86 was horribly
> written and not optimized for the standard case of passing in 0 and 6 for
> the starting index and the number of system calls to get. When looking at
> all the users of this function, I discovered that all instances pass in only
> 0 and 6 for these arguments. Instead of having this function handle
> different cases that are never used, simply rewrite it to return the first 6
> arguments of a system call.
>
> This should help out the performance of tracing system calls by ptrace,
> ftrace and perf.

[...]

>  arch/xtensa/include/asm/syscall.h     | 16 ++----

For xtensa changes:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
