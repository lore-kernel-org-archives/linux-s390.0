Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 4 Nov 2016 15:34:27 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 11/25] s390/smp: Convert to hotplug state machine
References: <20161103145021.28528-1-bigeasy@linutronix.de>
 <20161103145021.28528-12-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161103145021.28528-12-bigeasy@linutronix.de>
Message-Id: <20161104143427.GD4088@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 03, 2016 at 03:50:07PM +0100, Sebastian Andrzej Siewior wrote:
> @@ -1084,20 +1079,13 @@ static int smp_add_present_cpu(int cpu)
>  	rc = sysfs_create_group(&s->kobj, &cpu_common_attr_group);
>  	if (rc)
>  		goto out_cpu;
> -	if (cpu_online(cpu)) {
> -		rc = sysfs_create_group(&s->kobj, &cpu_online_attr_group);
> -		if (rc)
> -			goto out_online;
> -	}
> +
>  	rc = topology_cpu_init(c);

Please don't add whitespace :)

If you fix the minor nits both s390 related patches are
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks!
