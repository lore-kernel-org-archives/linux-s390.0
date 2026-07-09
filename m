Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024283E5592;
	Thu,  9 Jul 2026 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582595; cv=none; b=ukbkwDOfgs3d6qgzNGNWUzAdw9TOAJOpkLVdknuHwNX5OxTCg90RfrMFOROY+yK4wxLI5vw+AnFzY703PSp+7QmZaCraPNJ1AcadK9rW1+s6XSJoZN0ApOambkjj6kTWYZuNzYElnwJtxJTgVn2N9QgyA5H6KtF7G3LsJ0/sc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582595; c=relaxed/simple;
	bh=eU/u/CgRw+sq9smqx+I9v7uT77inA5QoZtyob4y7/PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S17Zx3/7WXEqY+FxRvbLZRtwWqIxR3Q+hXEygKWan2OGbZxGtOB3OCzJ+/8d0oA46lsRuWtBedcKVkhPe+jj91tX3OIA6qHP2pRPX2w/HotIKrT9MiywOK6ZhNPM/gJQSm/A8KvYQJLLtsk+3nlp+PgmuFSiS1ZUVfKtS8FW/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g2iecoGH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aPsm4KX2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g2iecoGH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aPsm4KX2"
Date: Thu, 9 Jul 2026 09:36:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783582589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpSVJy70b3xqWnZXpAlUFJdEu5JY/bMxQLCNfbP622U=;
	b=g2iecoGHP1Q35gwzozGqpuJ0N4IBF+7Mb6UtjI//sGz3GDw2QvbFIwzqQxpn8FGVErlS7s
	omQVYbjmgyDJmhF1MmCJlIHllgyUO01Sr/yBhSgxI73gtjpY4E1vXqhtHTENlpaAPa12sQ
	COfi9C4/Sj1r2xVrGyKnP9WxPszidYfKAY5LkVWbCCQrazun7IsY1JN+lXSdvSLidQy+zJ
	JM42AdQNLsIiZHirxAYPzrO+5JXzDJKtydCvmMQjV1j+RrDzi32PI8QdtKB5/Db1jOP9ap
	STdYW58tGV3g9BcaZaDXSYefwyq4ViT1/8sPNvUgcWKCHxRJXZjUOZPPxh01TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783582589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpSVJy70b3xqWnZXpAlUFJdEu5JY/bMxQLCNfbP622U=;
	b=aPsm4KX2JqjVkOTd9TekKMBY/H0/KYVBKvaYO+P4E5asdbyGTnkQwhT9fbb+nkBTJB3oUI
	nJc65qufMiJf3XAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, nathan@kernel.org, kees@kernel.org, 
	xur@google.com, peterz@infradead.org, gourry@gourry.net, 
	lukas.bulwahn@redhat.com, ryan.roberts@arm.com, yangtiezhu@loongson.cn, 
	sshegde@linux.ibm.com, mchauras@linux.ibm.com, austin.kim@lge.com, arnd@arndb.de, 
	jchrist@linux.ibm.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] syscall_user_dispatch: Introduce
 ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
Message-ID: <20260709093404-0b19988f-8d19-4fae-86d8-396aa747307d@linutronix.de>
References: <20260709072803.3843948-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709072803.3843948-1-ruanjinjie@huawei.com>

On Thu, Jul 09, 2026 at 03:28:03PM +0800, Jinjie Ruan wrote:
> Currently, only x86 genuinely implements and supports Syscall User
> Dispatch (SUD). Multiple architectures provide a stub
> arch_syscall_is_vdso_sigreturn() returning 'false' simply to satisfy
> GENERIC_ENTRY compilation, which creates a false impression of feature
> support.
> 
> Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple this mechanism
> from GENERIC_ENTRY. Select it exclusively on x86 and remove the redundant
> stub functions from other architectures.

Nice, this confused me before.

> Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/Kconfig                         | 1 +
>  arch/loongarch/include/asm/syscall.h | 6 ------
>  arch/powerpc/include/asm/syscall.h   | 5 -----
>  arch/riscv/include/asm/syscall.h     | 5 -----
>  arch/s390/include/asm/syscall.h      | 5 -----
>  arch/x86/Kconfig                     | 1 +
>  6 files changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 0c01521c2f3f..393d0fb75eac 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -116,6 +116,7 @@ config GENERIC_ENTRY
>  
>  config SYSCALL_USER_DISPATCH
>  	bool "Syscall User Dispatch"
> +	depends on ARCH_SUPPORTS_SYSCALL_USER_DISPATCH

ARCH_SUPPORTS_SYSCALL_USER_DISPATCH is not declared as a config option,
so the 'select' will not do anything. Needs this:

config ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
	bool

>  	depends on GENERIC_ENTRY
>  	default y
>  	help

(...)
