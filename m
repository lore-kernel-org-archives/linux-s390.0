Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA123C9890;
	Fri,  3 Jul 2026 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079048; cv=none; b=GuDybhXbVmVpDmVrxyu3Q4id6thY2oLgUJC/UWNK4RqGke43TshEKQPmRKg5pcXqMulU92dtXHb/seaACMmsTalPffcIQs3ZcLR5rTw8VGSWYtsg19fDTnKDGlnzmmlvbjCRaxIXjGn/SSzahJrJY9xaT+oDCafMxcd7MVwFurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079048; c=relaxed/simple;
	bh=GrslDCw/jAcNOwlB5p8nyDTpYshtAqIWlzis+qMG09I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLX4/Ads7qjdpH/i7zklm/HqD9KuutAZ+6wZ7X/D6rCHzrAF8cSDbIBOTIgMMUEzfwY/hOLBPVApTfUSMLrgqBPNHEGQ/qrEEbeS2a++8cn/d0HB7anrJemXl8mq2FWTPVdr7J6/2PnUh2pNetMQLs7jp6omwEGf8cJUJZUAu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tKakZnJ3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tKakZnJ3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D83C4637;
	Fri,  3 Jul 2026 04:44:01 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65D7D3F673;
	Fri,  3 Jul 2026 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783079045; bh=GrslDCw/jAcNOwlB5p8nyDTpYshtAqIWlzis+qMG09I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKakZnJ38IyGMrpp+FvNGCM4vGiYTEfyBni8Tcaswrg4QrDdEbNpUaICG78eSHmGQ
	 OGQV+KmXsh59rXzLS/pX0QGbIzhBmg5wD2mrtFlZMHliVzpGArzzl6pwF6bB5ekiJB
	 DUxWC4xjecD3+Ioa17sixIZ2uo+RdtMykGKWIz5Q=
Date: Fri, 3 Jul 2026 12:43:53 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com,
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
	will@kernel.org, kees@kernel.org, guoren@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	luto@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net,
	jcmvbkbc@gmail.com, peterz@infradead.org, wad@chromium.org,
	thuth@redhat.com, ada.coupriediaz@arm.com, kevin.brodsky@arm.com,
	linusw@kernel.org, yeoreum.yun@arm.com, song@kernel.org,
	james.morse@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
	liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com,
	yangtiezhu@loongson.cn, sshegde@linux.ibm.com,
	mchauras@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com,
	arnd@arndb.de, thomas.weissschuh@linutronix.de,
	sohil.mehta@intel.com, andrew.cooper3@citrix.com, jgross@suse.com,
	kas@kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v16 02/18] syscall_user_dispatch: Introduce a weak
 fallback for arch_syscall_is_vdso_sigreturn()
Message-ID: <akegeU59jSK9t7FX@J2N7QTR9R3>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629130616.642022-3-ruanjinjie@huawei.com>

On Mon, Jun 29, 2026 at 09:06:00PM +0800, Jinjie Ruan wrote:
> Currently, multiple architectures (LoongArch, RISC-V, S390, Powerpc)
> provide identical stubs for arch_syscall_is_vdso_sigreturn() that simply
> return false. This results in redundant boilerplate code across the tree.
> 
> Introduce a default __weak implementation of
> arch_syscall_is_vdso_sigreturn() directly in syscall_user_dispatch.c that
> returns false. This allows architectures that do not utilize a vDSO
> sigreturn to entirely drop their redundant inline definitions.
> 
> Architectures requiring a specialized check (such as x86) will continue to
> override this fallback with their strong symbol definitions.
> 
> Clean up the redundant implementations in loongarch, riscv, s390
> and powerpc.

> +bool __weak arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> +{
> +	return false;
> +}

If we need this, please make it:

#ifndef arch_syscall_is_vdso_sigreturn
static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
{
	return false;
}
#endif

... and require that architectures which need this provide a CPP
definition.

The use of __weak is generally problematic, as it prevents the compiler
form being able to elide code, and gets in the way of symbol resolution.
It's perfectly fine to require that architectures need to provide a CPP
definition alongside their own implementation of this function.

That said, as per my comment on v15, I'd prefer that for now we DO NOT
enable syscall user dispatch on arm64, and we first make it possible for
architecture to express whether or not they support that, even if they
use GENERIC_ENTRY. That might mean this patch isn't necessary right now.

[1] https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/

Mark.
