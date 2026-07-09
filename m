Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38D3C81B4;
	Thu,  9 Jul 2026 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581457; cv=none; b=tk0U9j2XbKnWj3LYHkrFCjeB2HI8G68NlUrO+J5lz/0qpToCmZIp4uCGO0FE6BdjQCWICmFkslVdFuFOMLZ5KBXhnfPNcQTQ4TilEiZIpQUhl44xBE/5kQzl3bdYlIsz3IEdMzM8Cgg00NDyMeXova5Y4o+FWTTp+azuSGPkVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581457; c=relaxed/simple;
	bh=TahILYPvsU13MfNyaHijaONIUAff2IgRazuw9a6893c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERuGQgIxJ891qmI+EYnPRAd39krn4BtitSvk77XdKIWQvgT84NvQPIlIY21rAAFQd0X4Li8+HGLjTMJoIheBqwJH+9zJMzdHsFKghODFeQ3GzQxINvuvxRsnBFGjtHV5qemreoXb4mP7xxD2fGzBGNCUimvSnpgbqdZS57/1aL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PtIuOfMn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kRB50jqQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PtIuOfMn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kRB50jqQ"
Date: Thu, 9 Jul 2026 09:17:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783581454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9SKBxLhUcVP1yEBFgHPNey4vuoMv6f7r4rXayVZwUY=;
	b=PtIuOfMnH+4L6RK5zWDYM9QxZ7qFIDDANU9HKLo3euM2pysXCVMwAa7n0WM9qlO40a3voh
	DuJIKMU8fzWSzXZ9l491Z4XBQ0KTIpmeIuhHSzlg0CK5YvnKbZ7s/RIGLP21o2M9L0o7Rj
	zSwnXdwJoMA72KBAhb8rJmxHHKXCqXO6C0wmhoPJoAi3VMyrmMFTka6l8meEuom7fPLR+m
	ZKJ+2UBpVHoAgJDHaBFHf2d85mBPBBieEtIIpIP4KHv9WbVlPQOC6fsZp4ZIgta2kndNxF
	O5hotz+4KOFHBJCxuyk1T/BLRhXpjFxIvYbJmL/KCdibPRgi80mtnrAOWqSnIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783581454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9SKBxLhUcVP1yEBFgHPNey4vuoMv6f7r4rXayVZwUY=;
	b=kRB50jqQviKOML8rg86X/o/Q3HTiZaVrhqXPi05nX1mZw5SlYEe6ldifyk1fa0K1jn//2f
	uWSs1Y9MUuicx9Bg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	geert@linux-m68k.org, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, 
	glaubitz@physik.fu-berlin.de, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, luto@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	peterz@infradead.org, wad@chromium.org, thuth@redhat.com, mark.rutland@arm.com, 
	ada.coupriediaz@arm.com, kevin.brodsky@arm.com, linusw@kernel.org, yeoreum.yun@arm.com, 
	song@kernel.org, james.morse@arm.com, anshuman.khandual@arm.com, 
	broonie@kernel.org, liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com, 
	yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com, 
	austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de, sohil.mehta@intel.com, 
	andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-csky@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v16 18/18] arm64: vdso: Expose sigreturn address on vdso
 to the kernel
Message-ID: <20260709090525-b1e5ae06-1fb4-454e-919c-6503dcf3d073@linutronix.de>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-19-ruanjinjie@huawei.com>
 <20260630172619-6c78c2e2-c2d3-44be-88e6-6c82de12baf4@linutronix.de>
 <21875fb4-434b-480d-b68b-e2ffd5fff5ae@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21875fb4-434b-480d-b68b-e2ffd5fff5ae@huawei.com>

On Thu, Jul 09, 2026 at 02:37:05PM +0800, Jinjie Ruan wrote:
> On 6/30/2026 11:32 PM, Thomas Weißschuh wrote:
> > On Mon, Jun 29, 2026 at 09:06:16PM +0800, Jinjie Ruan wrote:
(..)

> >> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> >> index 592dd8668de4..5a0314a3c26e 100644
> >> --- a/arch/arm64/kernel/vdso.c
> >> +++ b/arch/arm64/kernel/vdso.c
> >> @@ -343,3 +343,19 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
> >>  
> >>  	return ret;
> >>  }
> >> +
> >> +bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> >> +{
> >> +	unsigned long sigtramp;
> >> +
> >> +#ifdef CONFIG_COMPAT
> >> +	if (is_compat_task()) {
> >> +		unsigned long sigpage = (unsigned long)current->mm->context.sigpage;
> >> +
> >> +		return regs->pc >= sigpage && regs->pc < (sigpage + PAGE_SIZE);
> >> +	}
> >> +#endif
> >> +	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
> >> +
> >> +	return regs->pc == (sigtramp + 8);
> > 
> > Instead of hardcoding 'sigtramp + 8' you could add a new label to the 'svc #0'
> > instruction and use that with VDSO_SYMBOL().
> 
> It seems that the modification of __kernel_rt_sigreturn() is not recommended

For the changes to the object code of the function this is obvious and
well explained in the comments.

Such a label however would not change the object code of the function.
In fact it would not change any bit whatsoever in the final vDSO,
save for a new build ID.


Thomas
