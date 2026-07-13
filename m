Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3029ACCD;
	Mon, 13 Jul 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926123; cv=none; b=BtxRvgojsWX43DbU7imxrT6hqe3NrUy6YPjb/Z+zEquZQqWf4d50wbtj2/bolXc9TLzA3c4fRODBIdHLgsuOOI1zf5jJhRovy+Vb8qYyA+WEyZH9G2w0RUr+vinbqteQGU3WdSoSyQqjjkpRnSpUx0TiJFJOeKdrdwuZcSPtXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926123; c=relaxed/simple;
	bh=7qgYWfsFyZ2RgA/27lsYmYQZTrcjl45mKP6ePkNwd3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTUWScNU7d33coXMdhoW7DR8U9M2IoV+TWsMnbdPhOqr077dqJMrDMWw8/wrfL8qFHxhHtSLFU56FFo1o4p69lEhpvrY+iy0z/66fwl93O/omJhlnvd0clBei39WhYyh081Q+zsO6fG2s1e0aWBFjkW5ztJQqgO/3WkNfjv7kYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xuFdla/6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cXVv1a5z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xuFdla/6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cXVv1a5z"
Date: Mon, 13 Jul 2026 09:01:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783926118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnmxNdHqKoh6xuYofsr73YiT+W94DI4jpIiM80uad1k=;
	b=xuFdla/6ifWVxs+wZ/ziKIXPwTG8sNl1CvOxpSkj7lA5470k6wTgjpeu7/nlRL+oihS2Qs
	JADuHCTtvX5KsRBE+2BwukLfzUJWDi3WmNcefXD07sqWlxw7cq54WE1/rhAb0H08RGTG54
	NKVh6zGp+juLKf0xn/ZZ/iHAUAMgZL1Gz+AEf4FCljbY9Gs2UrRNV9CQfA9ZnvX7iuY/CR
	+eH0hO+UwyFjJgLhe6cGdJg9VIHjkyqxDiQcyzD1kAE21gJQJA90gnhj4aClj+bpR70P1/
	PyuEkKpTBKkI7DGLCZkpzwWyVeBOFCXJejv6p2QBYbd8qAfd3VxT9OjpsNrVgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783926118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnmxNdHqKoh6xuYofsr73YiT+W94DI4jpIiM80uad1k=;
	b=cXVv1a5zXQlrcFC6I4GHPNC9QKNeWn00sP2uqrUVvBJohK68NTBxPt4JyPk2bcommOIhMi
	q3BAQe+PJhx4WPDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, nathan@kernel.org, kees@kernel.org, 
	xur@google.com, arnd@arndb.de, peterz@infradead.org, gourry@gourry.net, 
	lukas.bulwahn@redhat.com, ryan.roberts@arm.com, yangtiezhu@loongson.cn, 
	mchauras@linux.ibm.com, sshegde@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH RESEND] syscall_user_dispatch: Introduce
 ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
Message-ID: <20260713085930-c6e454ac-cb4d-4016-8971-49df521e1d8d@linutronix.de>
References: <20260713035422.582771-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713035422.582771-1-ruanjinjie@huawei.com>

On Mon, Jul 13, 2026 at 11:54:22AM +0800, Jinjie Ruan wrote:
> Currently, only x86 genuinely implements and supports Syscall User
> Dispatch (SUD). Multiple architectures provide a stub
> arch_syscall_is_vdso_sigreturn() returning 'false' simply to satisfy
> GENERIC_ENTRY compilation, which creates a false impression of feature
> support.
> 
> Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple this mechanism
> from GENERIC_ENTRY. Select it exclusively on x86 and remove the redundant
> stub functions from other architectures.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
> v1 -> RESEND
> - Define missing ARCH_SUPPORTS_SYSCALL_USER_DISPATCH.

If code is changed it is not a resend. Instead it should have been v2.

> ---
>  arch/Kconfig                         | 4 ++++
>  arch/loongarch/include/asm/syscall.h | 6 ------
>  arch/powerpc/include/asm/syscall.h   | 5 -----
>  arch/riscv/include/asm/syscall.h     | 5 -----
>  arch/s390/include/asm/syscall.h      | 5 -----
>  arch/x86/Kconfig                     | 1 +
>  6 files changed, 5 insertions(+), 21 deletions(-)

(...)
