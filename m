Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com> <20180712000419.5165-7-pasha.tatashin@oracle.com>
In-Reply-To: <20180712000419.5165-7-pasha.tatashin@oracle.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 12 Jul 2018 21:57:39 -0400
Message-ID: <CAGM2reaBMEdf6E2JJno2vX70-Et80iv4-M26WVBOiKZsiBcq8A@mail.gmail.com>
Subject: Re: [PATCH v13 06/18] x86/xen/time: initialize pv xen time in init_hypervisor_platform
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

> -void __ref xen_init_time_ops(void)
> +void __init xen_init_time_ops(void)
>  {
>         pv_time_ops = xen_time_ops;
>
> @@ -542,17 +542,11 @@ void __init xen_hvm_init_time_ops(void)
>                 return;
>
>         if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
> -               printk(KERN_INFO "Xen doesn't support pvclock on HVM,"
> -                               "disable pv timer\n");
> +               pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
>                 return;
>         }
> -
> -       pv_time_ops = xen_time_ops;
> +       xen_init_time_ops();
>         x86_init.timers.setup_percpu_clockev = xen_time_init;
>         x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;

Boris reported a bug on HVM, which causes a panic in
x86_late_time_init(). It is introduced here: xen_init_time_ops() sets:
x86_init.timers.timer_init = xen_time_init; which was hpet_time_init()
in HVM. However, we might not even need hpet here. Thus, adding
x86_init.timers.timer_init = x86_init_noop; to the end of
xen_hvm_init_time_ops() should be sufficient.

Thank you,
Pavel
