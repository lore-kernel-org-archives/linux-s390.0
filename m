Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3F3932D0
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657991; cv=none; b=NFxWIERgnandLUzphX9KS44KfY5+YXeKze6HwhWLShxCo312QNq8hr/o92MHmBl9ouCR1S0QMObZYRvj7SB5urxz1qvVh1FxatTPueDI5SZ+/RT+3otTxgGgf+JmOD3tqeqpc4sYYe44g4GCNa19hal9Fa2AdlhzEcOFKmgnQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657991; c=relaxed/simple;
	bh=QMZoHqX25c39boJnQtZskoi3mKNrB+PWBN8gNe0NXuI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gb7ME/OWCj2NATB2ZTb7QyNjmE1wZAiKZfaLK0PSHLXGO05P+wLxYZ90zzBro8xzR5gqRMOD0BKmINvRk45prq79jEvm0KupxrfUscB+UMHfx3cgne/hFvAPLjZNua2KJMphVd4wTVtbhSzT2l6Kmu7YNIkmqv+pVM2FQ0euUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL7//fSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL7//fSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEEE1F000E9;
	Thu, 13 Aug 2026 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786657989;
	bh=BWUbJsKryvexyGofq1m+zCapKyTLRPQGzA+9cuSo/zU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HL7//fSLFKpyrgQ7pe3uCbq4RaXajYhd5VS80/gJXUUeUiibmGC7umAZdXvVKJ7UM
	 Z7tzqUiZ8dOYfnLEKE/D98bU0xZYmjqenTBhMtmALOJjCyMROpLsbh48cANHhroaNd
	 UDsHCHpJdTIvE2Clj9Hm8gInBH97V75A2bLUJH21NC3jXbEXcPQc4M+qrXtOI3Ertx
	 eHgvTP97qYU0QqFiXSW7BumCSlgA/ZIO8VSq0YNHcksJktqZDW4XxrBaJPZeL/L9pW
	 XONLpmeDuiQsxPUd2O8k6ssWbRrr6MnnxqVyLLMVVOJw8GnhMe31zIEupDFy8Zjstz
	 xB3tEi9D8B0ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] s390/percpu: Provide arch_this_cpu_write()
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260317195436.2276810-9-hca@linux.ibm.com>
References: <20260317195436.2276810-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 21:53:09 +0000
Message-Id: <20260813215309.9AEEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Critical logic inversion in `percpu_exit()` migration fixup co=
rrupts percpu pointers.
- [Low] Unused output constraint `[old__]` in `arch_this_cpu_write` inline =
assembly.
--

--- Patch [8]: [PATCH 8/9] s390/percpu: Provide arch_this_cpu_write() imple=
mentation ---
commit 2a32543383d043fdfafc28f075daae72847d527d
Author: Heiko Carstens <hca@linux.ibm.com>
s390/percpu: Provide arch_this_cpu_write() implementation

This commit provides an s390 specific implementation of
arch_this_cpu_write() instead of using the generic variant. It aims to
reduce the overhead of raw_local_irq_save/restore pairs and reduces the
text size of the kernel image.

> diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percp=
u.h
> index 35e48d193d993..7a411b75bfa62 100644
> --- a/arch/s390/include/asm/percpu.h
> +++ b/arch/s390/include/asm/percpu.h
[ ... ]
> @@ -271,6 +271,38 @@
>  #define this_cpu_read_4(pcp) arch_this_cpu_read(pcp, "l")
>  #define this_cpu_read_8(pcp) arch_this_cpu_read(pcp, "lg")
> =20
> +#define arch_this_cpu_write(pcp, val, op)				\
> +{									\
> +	unsigned long lc_pcpr, lc_pcpo;					\
> +	typedef typeof(pcp) pcp_op_T__;					\
> +	pcp_op_T__ val__ =3D (val);					\
> +	pcp_op_T__ old__, *ptr__;					\
> +									\
> +	lc_pcpr =3D offsetof(struct lowcore, percpu_register);		\
> +	lc_pcpo =3D offsetof(struct lowcore, percpu_offset);		\
> +	ptr__ =3D &(pcp);							\
> +	asm_inline volatile(						\
> +		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
> +		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
> +		op "    %[val__],0(%[ptr__])\n"				\
> +		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
> +		: [old__] "=3D&d" (old__),				\

[Severity: Low]
Does this output constraint unnecessarily tie up a general-purpose register?
The compiler is forced to allocate a register for old__, but the inline
assembly string never references %[old__].

> +		  [ptr__] "+&a" (ptr__), "=3Dm" (*ptr__),			\
> +		  "=3Dm" (((struct lowcore *)0)->percpu_register)		\
> +		: [val__] "d" (val__),					\
[ ... ]

Looking at how these new percpu sections interact with migration fixups in
arch/s390/include/asm/entry-percpu.h, there might be a regression with the
instruction check:

arch/s390/include/asm/entry-percpu.h:percpu_exit() {
	...
	/*
	 * Within a percpu code section and process has been migrated to
	 * a different CPU. Check if the percpu base register needs to be
	 * updated. This is the case if the PSW does not point to the ADD
	 * instruction within the section
	 * - AG %rx,percpu_offset_in_lowcore(%r0,%r0)
	 * which adds the percpu offset to the percpu base register.
	 */
	if ((*(u16 *)psw_bits(regs->psw).ia & 0xff0f) !=3D 0xe300)
		return;
	...
}

[Severity: Critical]
Is the condition in this check inverted? The fixup skips updating the offset
if the instruction is not the AG instruction (0xe300).

If a task executing the new arch_this_cpu_write() is interrupted and migrat=
ed
to another CPU, it seems the correct logic would be to return if the
instruction is the AG instruction (meaning it hasn't executed yet and no
fixup is needed), and proceed with the fixup if it is not the AG instruction
(meaning the AG instruction has already executed and the offset needs
updating).

Could this inverted logic result in skipping the fixup when interrupted aft=
er
the AG instruction, or applying it incorrectly when interrupted before the =
AG
instruction, leading to corrupted pointers or updates to the wrong CPU's
percpu variable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260317195436.2276=
810-1-hca@linux.ibm.com?part=3D8
