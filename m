Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20181107042751.3b519062@akathisia> <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
In-Reply-To: <20181121004422.GA29053@altlinux.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 21 Nov 2018 07:15:15 -0800
Message-ID: <CALCETrV8AJPkZF7TzhXSte_wJgNXH+-s7-tPM-8xjcAfYgzdhg@mail.gmail.com>
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *" argument
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20181121151515.1_2W_k9-0pdreS-zjCwDGzdWtjOPFidrnQccjaPIyJU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Andrew Lutomirski <luto@kernel.org>, Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromiatnikov <esyr@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-audit@redhat.com, linux-alpha@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, linux-sh@vger.kernel.org, arcml <linux-snps-arc@lists.infradead.org>, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, X86 ML <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 20, 2018 at 4:44 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>

Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
