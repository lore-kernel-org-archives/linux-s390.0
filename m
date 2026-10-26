Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018407;
	b=hl69O8UZ892XONBr0VfzFkcpzIyQEXqvL4V03amtsDw7V/zvTfM5mz8t2kav7ZlQYOnD
	 3boocK3AdM7o7nHoaFS0e4qoEBaUA8Ki870Xoplhw0ZRQx8FACMBGhHer2H0r5ojMAqP5
	 gnyfTSJkg+qZH2gxL6bfgP82CCnnluKqvtzRReBbdx7K0UVGndsso7ZFvgL6qnqkOFwJ2
	 KAQuuYb26AeEVffKaCY3OUfmHatGy8N5xWO/gOvJcA5Zv3+96BBiQasZvh5Khay87yeJy
	 PKqfwiTkrxQabhSUJc9tEtDVWgXVCSSCFFCv2fXfJHDi2n9RgJW9hQlCRB5tn56ysNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018407;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VIEFGngQyijt07BNZwfUjbKDEWeiHR4ZvIox0eKctJY=;
	b=h5GediODRqf4BAloFbKNGpaRtwqxyPwHem3c1DCOTxivyPWu1eQ3kpUz0+4IpNwJaqVb
	 +SRz84xt34bNTkwek/PKHQhwjrsGWAV4cC4p5a3STgcwduxIT+Jmbja4Dz2SmjEPapL6L
	 ErEIMcEXtbdNKVqITbyzjqHJLufGHgqe34i350QH5h2dVEi1oYCEcqQhJ0kuGgT81U/GL
	 In6hj3EipH5VS9+jxTTrvzlgcBJ+lNTruM+1i9JzaP3SYAnr6ErJnj7R2rQJmttIXapvm
	 yI5dWdhCDrgMGofw5Qf0ohe/lFSoz1mpG1Ojd68ihN6HUT7WBiVgakyqP4fHtEFSrMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4PxjFDk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E8606A31A
	for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4PxjFDk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB261F01828;
	Mon, 26 Oct 2026 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793018407;
	bh=VIEFGngQyijt07BNZwfUjbKDEWeiHR4ZvIox0eKctJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i4PxjFDkaUV0gBhQXUBx6L8jvGfmWZETDVT7tee3FS/nlv/tOLrROvZ90ltBWJj4R
	 KeWJDc/XCTb0hVXzcjQ6FvuepM5LJxAflu/4sDOyNOdkrv1LhFnx8QrD+0Cfp+l3tN
	 THTbgw6IRreVpCimdsFj28p2B41JLSHmrXu2Xz5/m4xN/aUDu4IlAVmaewVUlx86DY
	 HV13BogAndUuQAYJ4lqDb5yI1KEK3iVkJvhm6NUJxKmid7kZzdcCl0u+Dp8NDq7/U2
	 9l+YdzUKtT8BHHdu7vPT5EJjLbwdhW3Nsox8IhykOvq/jmokLCSm95fXKIky1l/poQ
	 Iziah8g8ZftdA==
Message-ID: <sashiko-outbox-185225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] s390/maccess: Remove spinlock from
 __s390_kernel_write()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261026120329.1792436-5-hca@linux.ibm.com>
References: <20261026120329.1792436-1-hca@linux.ibm.com>
 <20261026120329.1792436-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:40:06 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/maccess: RMW race in __s390_kernel_write() via apply_relocate=
_add()
--

commit d0c62af80b12a6f9e8f6c9ffe62431d5b78a99bf
Author: Heiko Carstens <hca@linux.ibm.com>

s390/maccess: Remove spinlock from __s390_kernel_write()

This commit removes s390_kernel_write_lock from __s390_kernel_write() under
the assumption that all runtime callers hold text_mutex, and replaces the
spinlock with preempt_disable(), sync_core(), and preempt_enable().

> diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
> index f39968dd80638..cda3f81dfbc2f 100644
> --- a/arch/s390/mm/maccess.c
> +++ b/arch/s390/mm/maccess.c
[ ... ]
> @@ -60,22 +61,20 @@ static notrace long s390_kernel_write_odd(void *dst, =
const void *src, size_t siz
>   * bytes from destination at an eight byte boundary, modifies the bytes
>   * requested and writes the result back in a loop.
>   */
> -static DEFINE_SPINLOCK(s390_kernel_write_lock);
> -
>  notrace void *__s390_kernel_write(void *dst, const void *src, size_t siz=
e)
>  {
>  	void *tmp =3D dst;
> -	unsigned long flags;
>  	long copied;
> =20
> -	spin_lock_irqsave(&s390_kernel_write_lock, flags);
> +	preempt_disable();
>  	while (size) {
>  		copied =3D s390_kernel_write_odd(tmp, src, size);
>  		tmp +=3D copied;
>  		src +=3D copied;
>  		size -=3D copied;
>  	}
> -	spin_unlock_irqrestore(&s390_kernel_write_lock, flags);
> +	sync_core();
> +	preempt_enable();

[Severity: High]
Can removing s390_kernel_write_lock cause a read-modify-write race in
s390_kernel_write_odd() when apply_relocate_add() is called by livepatching?

In arch/s390/kernel/module.c:apply_relocate_add(), s390_kernel_write() is
used whenever the module is already formed, without taking text_mutex:

    int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
                           unsigned int symindex, unsigned int relsec,
                           struct module *me)
    {
        bool early =3D me->state =3D=3D MODULE_STATE_UNFORMED;
        void *(*write)(void *, const void *, size_t) =3D memcpy;

        if (!early)
            write =3D s390_kernel_write;

        return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me,
                                    write);
    }

At runtime, livepatching reaches this path via:

    klp_enable_patch() / klp_module_coming()
      -> klp_init_object_loaded()
        -> klp_apply_object_relocs()
          -> klp_write_object_relocs()
            -> klp_write_section_relocs()
              -> apply_relocate_add()

Commit 5b384f933590 ("x86/module: Use text_mutex in apply_relocate_add()")
removed mutex_lock(&text_mutex) from klp_init_object_loaded() in
kernel/livepatch/core.c and added text_mutex only to x86, relying on
s390_kernel_write_lock to serialize s390's apply_relocate_add().

Because s390_kernel_write_odd() performs a non-atomic 8-byte
read-modify-write cycle on (dst & ~7UL) using mvc, ex, and sturg, could a
concurrent caller holding text_mutex (such as ftrace, jump_label, kprobes, =
or
bpf_arch_text_poke) modifying an instruction in the same 8-byte doubleword =
of
the livepatch module have its write clobbered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026120329.1792=
436-1-hca@linux.ibm.com?part=3D4
