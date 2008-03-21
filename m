Return-Path: <linux-kernel-owner+w=401wt.eu-S1755623AbYCUMaQ@vger.kernel.org>
Date: Fri, 21 Mar 2008 13:29:48 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 03/10] sched: add exported arch_reinit_sched_domains()
	to header file.
Message-ID: <20080321122948.GA26733@elte.hu>
References: <20080312173155.703966894@de.ibm.com> <20080312173216.861331041@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080312173216.861331041@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


* Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> Needed so it can be called from outside of sched.c.

thanks, applied.

> +#if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
> +extern int arch_reinit_sched_domains(void);
> +#endif

i removed the #ifdefs around this.

	Ingo
