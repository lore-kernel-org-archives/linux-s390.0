Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42701 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgAQEQb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 23:16:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so11309426pfz.9
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 20:16:31 -0800 (PST)
Subject: Re: [PATCH RESEND v4] reboot: support offline CPUs before reboot
References: <20200114110620.164861-1-hsinyi@chromium.org>
From: Rob Landley <rob@landley.net>
Message-ID: <a701522f-73aa-2277-4a25-f84a27f38118@landley.net>
Date: Thu, 16 Jan 2020 22:20:28 -0600
MIME-Version: 1.0
In-Reply-To: <20200114110620.164861-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hsin-Yi Wang <hsinyi@chromium.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jkosina@suse.cz>, Pavankumar Kondeti <pkondeti@codeaurora.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Guenter Roeck <groeck@chromium.org>, Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-pm@vger.kernel.org

On 1/14/20 5:06 AM, Hsin-Yi Wang wrote:
> This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would offline cpus in
> migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> checking online cpus would be an empty loop. If architecture don't enable this
> config, or some cpus somehow fails to offline, it would fallback to ipi
> function.

I'm curious:

> +# Select to do a full offline on secondary CPUs before reboot.
> +config ARCH_OFFLINE_CPUS_ON_REBOOT
> +	bool "Support for offline CPUs before reboot"
> +	depends on HOTPLUG_CPU

The new symbol can't be selected without the other symbol.

> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU

And the other symbol automatically selects the new one.

Why are you adding a second symbol that means the same thing as the existing symbol?

> +#if defined(CONFIG_PM_SLEEP_SMP) || defined(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> +extern int freeze_secondary_cpus(int primary, bool reboot);
> +#endif

Couldn't that just test HOTPLUG_CPU? What's the second symbol for? (You can have
empty stub functions when architectures don't support a thing...)

Rob
