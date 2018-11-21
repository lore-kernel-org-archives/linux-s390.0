Return-Path: <linux-arch-owner@vger.kernel.org>
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *"
 argument
Date: Wed, 21 Nov 2018 18:40:06 +0000
Message-ID: <20181121184004.jro532jopnbmru2m@pburton-laptop>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
In-Reply-To: <20181121004422.GA29053@altlinux.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F706FB6922E03E429949DE755647EBBE@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20181121184006.YBIP6rjdOuaXgRtr9WFXbWzacvh45-E5EXsyFX3zzsQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Andy Lutomirski <luto@kernel.org>, Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <esyr@redhat.com>, Oleg Nesterov <oleg@redhat.com>, "linux-audit@redhat.com" <linux-audit@redhat.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "uclinux-h8-devel@lists.sourceforge.jp" <uclinux-h8-devel@lists.sourceforge.jp>, "x86@kernel.org" <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Dmitry,

On Wed, Nov 21, 2018 at 03:44:22AM +0300, Dmitry V. Levin wrote:
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>=20
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>=20
>%
>=20
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/sysc=
all.h
> index 0170602a1e4e..52b633f20abd 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -73,7 +73,7 @@ static inline unsigned long mips_get_syscall_arg(unsign=
ed long *arg,
>  #ifdef CONFIG_64BIT
>  	case 4: case 5: case 6: case 7:
>  #ifdef CONFIG_MIPS32_O32
> -		if (test_thread_flag(TIF_32BIT_REGS))
> +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS))
>  			return get_user(*arg, (int *)usp + n);
>  		else
>  #endif

This ought to be test_tsk_thread_flag(task, TIF_32BIT_REGS) instead of
open-coding test_tsk_thread_flag.

More fundamentally though, this change doesn't seem to be (directly)
related to the change you describe in the commit message - it's not
syscall_get_arch being modified here. I suspect this should be a
separate commit, or if not please explain in the commit message why this
change is included.

Compounding the lack of clarity is the fact that I only received this
patch, not the whole series, so I can't view the change in the context
of the rest of the series.

> @@ -140,14 +140,14 @@ extern const unsigned long sys_call_table[];
>  extern const unsigned long sys32_call_table[];
>  extern const unsigned long sysn32_call_table[];
> =20
> -static inline int syscall_get_arch(void)
> +static inline int syscall_get_arch(struct task_struct *task)
>  {
>  	int arch =3D AUDIT_ARCH_MIPS;
>  #ifdef CONFIG_64BIT
> -	if (!test_thread_flag(TIF_32BIT_REGS)) {
> +	if (!test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS)) {
>  		arch |=3D __AUDIT_ARCH_64BIT;
>  		/* N32 sets only TIF_32BIT_ADDR */
> -		if (test_thread_flag(TIF_32BIT_ADDR))
> +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_ADDR))
>  			arch |=3D __AUDIT_ARCH_CONVENTION_MIPS64_N32;
>  	}
>  #endif

This does seem like the described change, but there are 2 more instances
of open-coding test_tsk_thread_flag which ought to be cleaned up.

Thanks,
    Paul
