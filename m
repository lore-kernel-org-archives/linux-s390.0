Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755F27FD4B;
	Thu, 18 Jun 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793695; cv=none; b=NWXD0CYjXMcov0O5YZ3Qj4Q2MWg1It2hKlu9EB1bjZBJERlf39Q10c7v5T9SCpIYAygVl0CLF95O/7gYJFcJM+UlXGevlCginSqUHjx3FLwbCX/fTQpbnP0p2T766x0LmTuHSqBXCxMiMEMOaErGbeF3Yd0ad/Sguu16IiIAurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793695; c=relaxed/simple;
	bh=dJdboC56oCUy/E+4f5UtaRFWyvaOyL5jgXpBYoRgvQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+fP8skHVSuGdaNCVlRoNhTBw+it1wj05GW8/7r0pT5ByIKTlQ6kmgTOGE7V+0aQHbnud7TdeoDLIciGyJ5vHL0zl8ZNh+CZKyVm6nWi+FKhSsYEKlxTca2ED0TCQOO/DIyWyoEGJtDEUjnDz/J8nnDLRhX2+Dq+lrYa3Lihni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JKCltnTT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JKCltnTT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA63432E2;
	Thu, 18 Jun 2026 07:41:28 -0700 (PDT)
Received: from [10.1.27.69] (e127648.arm.com [10.1.27.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EFAD3F62B;
	Thu, 18 Jun 2026 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781793693; bh=dJdboC56oCUy/E+4f5UtaRFWyvaOyL5jgXpBYoRgvQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JKCltnTTo6BftOBbIE43fkpF+celEv2+umJq60CAS10KqXsC6v9g1UZI/YKeBSiKo
	 RXspAMTggOLxdz3NV+x7gqIqnDJfFxkk70kVGYYAkgnckEi0Igw6/IgEjy8T94RShi
	 xCWZroBdbz3JNe5v6hDdkZSDOca4Frgu4kFtCerk=
Message-ID: <464e277c-40f8-4812-85f6-67b470436692@arm.com>
Date: Thu, 18 Jun 2026 15:41:27 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] s390/idle: Introduce cpuidle for s390
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <20260618-idledriver-v3-4-684061eecbcb@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260618-idledriver-v3-4-684061eecbcb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 13:00, Mete Durlu wrote:
> Introduce generic cpuidle driver on s390. Use a two stage approach to
> handle idle scenarios and use idle governor for idle stage selection.
> Two stages are, from shallow to deep, idle polling and enabled wait.
> 
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  MAINTAINERS                    |   8 +++
>  arch/s390/Kconfig              |   5 ++
>  drivers/cpuidle/Kconfig        |   5 ++
>  drivers/cpuidle/Kconfig.s390   |  11 ++++
>  drivers/cpuidle/Makefile       |   4 ++
>  drivers/cpuidle/cpuidle-s390.c | 115 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 148 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e035a3be797c..127e32c5fb4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6766,6 +6766,13 @@ L:	linux-riscv@lists.infradead.org
>  S:	Maintained
>  F:	drivers/cpuidle/cpuidle-riscv-sbi.c
>  
> +CPUIDLE DRIVER - S390
> +M:	Mete Durlu <meted@linux.ibm.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-s390@vger.kernel.org
> +S:	Maintained
> +F:	drivers/cpuidle/cpuidle-s390.c
> +
>  CPUMASK API [RUST]
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  R:	Yury Norov <yury.norov@gmail.com>
> @@ -23497,6 +23504,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
>  F:	Documentation/driver-api/s390-drivers.rst
>  F:	Documentation/arch/s390/
>  F:	arch/s390/
> +F:	drivers/cpuidle/cpuidle-s390.c
>  F:	drivers/s390/
>  F:	drivers/watchdog/diag288_wdt.c
>  
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ecbcbb781e40..8548f5b6b247 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -20,6 +20,9 @@ config ARCH_HAS_ILOG2_U64
>  config ARCH_PROC_KCORE_TEXT
>  	def_bool y
>  
> +config ARCH_HAS_CPU_RELAX
> +	def_bool y
> +
>  config GENERIC_HWEIGHT
>  	def_bool !HAVE_MARCH_Z196_FEATURES
>  
> @@ -708,6 +711,8 @@ config KERNEL_IMAGE_BASE
>  
>  endmenu
>  
> +source "drivers/cpuidle/Kconfig"
> +
>  menu "Memory setup"
>  
>  config ARCH_SPARSEMEM_ENABLE
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index d6d8386d3f02..00e2562041fd 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -71,6 +71,11 @@ depends on RISCV
>  source "drivers/cpuidle/Kconfig.riscv"
>  endmenu
>  
> +menu "S390 CPU Idle Drivers"
> +depends on S390
> +source "drivers/cpuidle/Kconfig.s390"
> +endmenu
> +
>  config HALTPOLL_CPUIDLE
>  	tristate "Halt poll cpuidle driver"
>  	depends on X86 && KVM_GUEST
> diff --git a/drivers/cpuidle/Kconfig.s390 b/drivers/cpuidle/Kconfig.s390
> new file mode 100644
> index 000000000000..0b170d9a190b
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.s390
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# S390 CPU Idle drivers
> +#
> +
> +config S390_CPUIDLE
> +	bool "S390 CPU idle driver"
> +	default y
> +	help
> +          Select this option to enable processor idle state management
> +          through cpuidle subsystem.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 1de9e92c5b0f..88cbc2a7aea8 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -42,3 +42,7 @@ obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
>  ###############################################################################
>  # RISC-V drivers
>  obj-$(CONFIG_RISCV_SBI_CPUIDLE)		+= cpuidle-riscv-sbi.o
> +
> +###############################################################################
> +# S390 drivers
> +obj-$(CONFIG_S390_CPUIDLE)		+= cpuidle-s390.o
> diff --git a/drivers/cpuidle/cpuidle-s390.c b/drivers/cpuidle/cpuidle-s390.c
> new file mode 100644
> index 000000000000..1d02a77ebce0
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-s390.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * s390 generic CPU idle driver.
> + *
> + * Copyright IBM Corp. 2026
> + */
> +
> +#define pr_fmt(fmt) "CPUidle s390: " fmt
> +
> +#include <linux/init.h>
> +#include <linux/cpuidle.h>
> +#include <linux/cpu.h>
> +#include <linux/sched/clock.h>
> +
> +static __cpuidle int s390_enter_idle(struct cpuidle_device *dev,
> +				     struct cpuidle_driver *drv,
> +				     int index)
> +{
> +	arch_cpu_idle();
> +	return index;
> +}
> +
> +static struct cpuidle_driver s390_cpuidle_driver = {
> +	.cpumask = (struct cpumask *)cpu_present_mask,
> +	.name = "s390-idle",
> +	.states = {
> +		{ /* entry 0 is for polling */},
> +		{
> +			.enter			= s390_enter_idle,
> +			.name			= "IDLE",
> +			.desc			= "ENABLED WAIT",
> +		},
> +	},
> +	.safe_state_index = 0,
> +	.state_count = 2,
> +};
> +
> +static int s390_cpuidle_cpu_online(unsigned int cpu)
> +{
> +	struct cpuidle_device *dev = &per_cpu(cpuidle_dev, cpu);
> +	int rc;
> +
> +	if (dev->registered) {
> +		cpuidle_pause_and_lock();
> +		rc = cpuidle_enable_device(dev);
> +		cpuidle_resume_and_unlock();
> +		if (rc)
> +			pr_err("Failed to enable cpuidle device on cpu %u\n", cpu);
> +	} else {
> +		dev->cpu = cpu;
> +		rc = cpuidle_register_device(dev);
> +		if (rc)
> +			pr_err("Failed to register cpuidle driver on cpu %u\n", cpu);
> +	}
> +	return rc;

Most other drivers allow for hotplug cpu_online to succeed even if cpuidle doesn't, is
this intentionally done otherwise here?

>[snip]
