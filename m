Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org> <20190401134421.442323029@goodmis.org>
In-Reply-To: <20190401134421.442323029@goodmis.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Apr 2019 11:55:29 -0700
Message-ID: <CAMo8BfLooVJgKCPQFDXUAfieH3XAF=Bhz2PmAb+3t7BhVBW5FQ@mail.gmail.com>
Subject: Re: [PATCH 6/6 v3] syscalls: Remove start and number from
 syscall_set_arguments() args
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404185529.nmkI6QLxmSxlBQH5reoN77_XbHmmO-dyh9WohNckddI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, Linux-Arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>, Dave Martin <dave.martin@arm.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 1, 2019 at 6:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> After removing the start and count arguments of syscall_get_arguments() it
> seems reasonable to remove them from syscall_set_arguments(). Note, as of
> today, there are no users of syscall_set_arguments(). But we are told that
> there will be soon. But for now, at least make it consistent with
> syscall_get_arguments().

[...]

>  arch/xtensa/include/asm/syscall.h     | 17 ++-----

For xtensa changes:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
