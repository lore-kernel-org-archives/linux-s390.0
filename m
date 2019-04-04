Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 4 Apr 2019 09:53:16 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/6 v3] syscalls: Remove start and number from
 syscall_set_arguments() args
In-Reply-To: <20190401134421.442323029@goodmis.org>
Message-ID: <alpine.DEB.2.21.1904040953040.1833@nanos.tec.linutronix.de>
References: <20190401134104.676620247@goodmis.org> <20190401134421.442323029@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404075316.dyVflnYESn5sFbP3Zov9uX-I6EUZcHIn2QCAnzn_yRE@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>, Dave Martin <dave.martin@arm.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 1 Apr 2019, Steven Rostedt wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> After removing the start and count arguments of syscall_get_arguments() it
> seems reasonable to remove them from syscall_set_arguments(). Note, as of
> today, there are no users of syscall_set_arguments(). But we are told that
> there will be soon. But for now, at least make it consistent with
> syscall_get_arguments().
> 
> Link: http://lkml.kernel.org/r/20190327222014.GA32540@altlinux.org

For x86:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
