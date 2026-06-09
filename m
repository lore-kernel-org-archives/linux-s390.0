Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026D39B498;
	Tue,  9 Jun 2026 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992383; cv=none; b=qRXeC1BJRpprdZuSOgiOZf+Mxo+fM9uaJW0RgI5MaSdfMXV9NscluuDQfvXm9VS/eHL52dPtpfQpmTba6wPI5CGYjNS+3rCloJmX+o57el/kAx9LsRgx5kGwo/eCrqf5tLTb2SxXYAHR9ph4pR+wqhkCs1lP22BiX/FJG34ZPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992383; c=relaxed/simple;
	bh=C0s5G7UxUrSQXdh5FZM7LtxTT3tjOPeqZSwFusMshw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIPTisdJTc7e89j181615fZbFuZDkhTlFMAAb7zHY3V11yZPStNUHMVn7diOn2170Zi5XOOxWXOK5Gqe4FaerJ5QCSUYjlR2UCrZbhrYqbCVqEmUK9YREggIK7t9jGyTH0SK+MtoraP6BFOYzmCuwo5DLUiSer+wKCdTFlqFz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=s2n7Goxn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="s2n7Goxn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22B61236D;
	Tue,  9 Jun 2026 01:06:15 -0700 (PDT)
Received: from [10.1.29.25] (e127648.arm.com [10.1.29.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D19BF3F93E;
	Tue,  9 Jun 2026 01:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780992379; bh=C0s5G7UxUrSQXdh5FZM7LtxTT3tjOPeqZSwFusMshw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s2n7GoxnHxvxNk04uVGSFSAJMzjcyE3eAVSA+3slwJss4Qo4gacs7LmPhNWOCCLHm
	 eIAb/vIYsT21i9/QDhwOFczd7ou2QMYJf/ME03cx09RhAuz0nTLv8LOOMIVPLInU+R
	 P3Iq97pKaV+RIfFGVjRWNwvlb04Tm7iC/Q30hKHk=
Message-ID: <6667f684-77d5-45a9-8fb6-4985cbc05bf1@arm.com>
Date: Tue, 9 Jun 2026 09:06:14 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] s390/idle: Introduce cpuidle for s390
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20260609075213.31094-1-meted@linux.ibm.com>
 <20260609075213.31094-5-meted@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260609075213.31094-5-meted@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 08:52, Mete Durlu wrote:
> Introduce generic cpuidle driver on s390. Use a two stage approach to
> handle idle scenarios and use TEO governor for idle stage selection.
> Two stages are, from shallow to deep, idle polling and enabled wait.
> 
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  arch/s390/Kconfig              |   5 ++
>  drivers/cpuidle/Kconfig        |   5 ++
>  drivers/cpuidle/Kconfig.s390   |  12 ++++
>  drivers/cpuidle/Makefile       |   4 ++
>  drivers/cpuidle/cpuidle-s390.c | 104 +++++++++++++++++++++++++++++++++
>  5 files changed, 130 insertions(+)
>  create mode 100644 drivers/cpuidle/Kconfig.s390
>  create mode 100644 drivers/cpuidle/cpuidle-s390.c
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
> index 000000000000..e51704a9304c
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.s390
> @@ -0,0 +1,12 @@
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
> +
NIT:
git complains about the trailing blank line here.
