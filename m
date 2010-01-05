Return-Path: <linux-kernel-owner+w=401wt.eu-S1754940Ab0AEPre@vger.kernel.org>
Date: Tue, 5 Jan 2010 16:47:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
Message-ID: <20100105154725.GB9376@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <20100104155225.GA16650@redhat.com> <20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com> <20100104181412.GA21146@redhat.com> <20100104211147.4CC94D532@magilla.sf.frob.com> <20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com> <20100105153633.GA9376@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100105153633.GA9376@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 01/05, Oleg Nesterov wrote:
>
> Anyway. I modified the debugging patch a bit:
>
> --- K/arch/s390/kernel/traps.c~	2009-12-22 10:41:52.909174198 -0500
> +++ K/arch/s390/kernel/traps.c	2010-01-05 09:49:19.541792379 -0500
> @@ -384,6 +384,8 @@ void __kprobes do_single_step(struct pt_
>  	}
>  	if (tracehook_consider_fatal_signal(current, SIGTRAP))
>  		force_sig(SIGTRAP, current);
> +	else
> +		printk("XXX: %d %d\n", current->pid, test_thread_flag(TIF_SINGLE_STEP));
>  }
>
>  static void default_trap_handler(struct pt_regs * regs, long interruption_code)
> -------------------------------------------------------------------------------

Ah, please ignore. I guess TIF_SINGLE_STEP was already cleared by the caller
in entry.S

Oleg.
