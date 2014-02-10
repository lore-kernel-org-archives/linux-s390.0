Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 10 Feb 2014 10:50:20 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH RFC/RFT v2 3/8] s390: move cacheinfo sysfs to generic
 cacheinfo infrastructure
Message-ID: <20140210095020.GB19013@osiris>
References: <1391791763-28518-1-git-send-email-sudeep.holla@arm.com>
 <1391791763-28518-4-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1391791763-28518-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 07, 2014 at 04:49:18PM +0000, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> This patch removes the redundant sysfs cacheinfo code by making use of
> the newly introduced generic cacheinfo infrastructure.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux390@de.ibm.com
> Cc: linux-s390@vger.kernel.org
> ---

[...]

> diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
> index 2461202..1f875db 100644
> --- a/arch/s390/kernel/processor.c
> +++ b/arch/s390/kernel/processor.c
> @@ -58,7 +58,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  			if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
>  				seq_printf(m, "%s ", hwcap_str[i]);
>  		seq_puts(m, "\n");
> -		show_cacheinfo(m);
>  	}
>  	get_online_cpus();
>  	if (cpu_online(n)) {

You can't remove that. It's a user space visible change.
