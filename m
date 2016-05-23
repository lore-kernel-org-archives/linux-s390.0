Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 May 2016 17:33:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] x86: fix potential memleak in do_error_trap
Message-ID: <20160523153355.GA8449@redhat.com>
References: <20160523111630.GN2278@dhcp22.suse.cz>
 <20160523135428.GU2278@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160523135428.GU2278@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Aleksa Sarai <asarai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/23, Michal Hocko wrote:
>
> @@ -271,6 +271,7 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
>
>  	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
>  			NOTIFY_STOP) {
> +		memset(&info, 0, sizeof(info));
>  		cond_local_irq_enable(regs);
>  		do_trap(trapnr, signr, str, regs, error_code,
>  			fill_trap_info(regs, signr, trapnr, &info));

at first glance fill_trap_info() initializes everything we will copy
to user-space in copy_siginfo_to_user(__SI_FAULT).

But even if not, shuldn't we change fill_trap_info() instead ?

Oleg.
