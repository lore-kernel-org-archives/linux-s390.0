Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12583822A9
	for <linux-s390@vger.kernel.org>; Fri,  3 Apr 2026 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209340; cv=none; b=gTidDqcCuBMsTIZNVDb2SxVukgYMXuIDE4/8r79TSH9lykMJPD1cur/rDMicmnvHizTFrQwhURLzByXn67QZ465BuBXM/+NVTm4J+WqZRG32saJiX8YLFVR7Y0aPQd/0OFg+/mvFvlslWgVatnaXsujNzvIXzabQz3A3KadHubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209340; c=relaxed/simple;
	bh=GdA5Glxo6eWa4W/ST2bpPz/cVuoZBhUidEmnv04LsNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRlpUJ1U9o6BnR2ZqVpBS8d3Py1SzgKBwmyg0ZjrHQl1uCcaJw793vTD2gvKpD1jl+G9LDu8vfeJuPhuhkivhdenzc/a2nurJ0V743taOzGjapiMYqIwlCYmldf35ECqWCh/o00Sm+msteAX21tBrwrCUi7fI3iv4CjMZRoiqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr5PK5c3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr5PK5c3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A59C2BCB0
	for <linux-s390@vger.kernel.org>; Fri,  3 Apr 2026 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775209340;
	bh=GdA5Glxo6eWa4W/ST2bpPz/cVuoZBhUidEmnv04LsNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sr5PK5c3V49Uy3VYwCD9vYigDLKR4gGc2AtzThKwNAfYfobhRzZIrB/5r8WmJwWkT
	 P89Js6i/LZQeljSwc7IprHEtqzVFHul50y3lde1GlIS/U++wLo7KEi9z930RS9aHeF
	 91xnhm2780BYhzNKVsATmZMERd5V6zrIFTMuI4ixwYaHjs8lOtHPCdC/6ijQ0osxUH
	 B5iTnHwYG8Oye9w9N/ITXuANXU5zSiPn7gqaFQKBhAkjZyIS3xb+lIlmSYK5AMqhKC
	 /RdWw6cCzD+axy4JLFVzNLJvJrCSED4ggnr7TK+IikoXn1xCxMEST8sO2hZXXUd5IX
	 nP6hq6G84PujA==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so13081685e9.0
        for <linux-s390@vger.kernel.org>; Fri, 03 Apr 2026 02:42:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZpiBrB5ZWzXNTwR+5vxOfjgamSq4QO99ZBbUc9THpAFpXyYW4qY/hMd0V/83k/9FGHnjLnRveKDtj@vger.kernel.org
X-Gm-Message-State: AOJu0YxAer2i5jlB1vHIMIyhYsV6cPwLDSB4Y5bBDYv1PYHVAjxpLuSL
	+p6JI8pw0RulW7F1h/OtrE/g8LQKo+PGcH6Ky5cg1Oezg5SKYUakkNC1/OiR3slxahA62tZebwY
	XTsudQp5la3ESasGZFhoJxMpIcblp//w=
X-Received: by 2002:a05:600d:1:b0:485:50ac:b8cf with SMTP id
 5b1f17b1804b1-488993be280mr33529815e9.0.1775209338532; Fri, 03 Apr 2026
 02:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402112250.2138-1-kprateek.nayak@amd.com> <20260402112250.2138-5-kprateek.nayak@amd.com>
In-Reply-To: <20260402112250.2138-5-kprateek.nayak@amd.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 3 Apr 2026 17:42:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSDg7JWHGS5E_OQWibFRTrY5bUuoOntmVE-MCt+FawLZw@mail.gmail.com>
X-Gm-Features: AQROBzAUeD-7TzkN4Yu-x7VvnBwCOKoW_8ACkDGIhwIZtFzQ_Q59qb4XpopnZvw
Message-ID: <CAJF2gTSDg7JWHGS5E_OQWibFRTrY5bUuoOntmVE-MCt+FawLZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] riscv/runtime-const: Introduce runtime_const_mask_32()
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, David Laight <david.laight.linux@gmail.com>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
	Charlie Jenkins <charlie@rivosinc.com>, Charles Mirabile <cmirabil@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 7:39=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd.=
com> wrote:
>
> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
>
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. GCC generates a:
>
>   lui   a0, 0x12346       # upper; +0x800 then >>12 for correct rounding
>   addi  a0, a0, 0x678     # lower 12 bits
>   and   a1, a1, a0        # a1 =3D a1 & a0
>
> pattern to tackle arbitrary 32-bit masks and the same was also suggested
> by Claude which is implemented here. The (__mask & val) operation is
> intentionally placed outside of asm block to allow compilers to further
> optimize it if possible.
>
> __runtime_fixup_ptr() already patches a "lui + addi" sequence which has
> been reused to patch the same sequence for __runtime_fixup_mask().
>
> Assisted-by: Claude:claude-sonnet-4-5
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Changelog v2..v3:
>
> o Moved the "&" operation outside the inline asm block to allow for
>   compilers to further optimize it if possible. (Based on David's
>   comment on ARM64 bits).
> ---
>  arch/riscv/include/asm/runtime-const.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/=
asm/runtime-const.h
> index d766e2b9e6df..85efba8ecf12 100644
> --- a/arch/riscv/include/asm/runtime-const.h
> +++ b/arch/riscv/include/asm/runtime-const.h
> @@ -153,6 +153,22 @@
>         __ret;                                                  \
>  })
>
> +#define runtime_const_mask_32(val, sym)                                \
> +({                                                             \
> +       u32 __mask;                                             \
> +       asm_inline(".option push\n\t"                           \
> +               ".option norvc\n\t"                             \
> +               "1:\t"                                          \
> +               "lui    %[__mask],0x89abd\n\t"                  \
> +               "addi   %[__mask],%[__mask],-0x211\n\t"         \
Ref include/uapi/linux/reboot.h:
#define LINUX_REBOOT_CMD_CAD_ON 0x89ABCDEF

#define RUNTIME_MAGIC 0x89ABCDEF

"lui %[__mask], %%hi(RUNTIME_MAGIC)\n\t"
"addi %[__mask], %[__mask], %%lo(RUNTIME_MAGIC)\n\t"


> +               ".option pop\n\t"                               \
> +               ".pushsection runtime_mask_" #sym ",\"a\"\n\t"  \
> +               ".long 1b - .\n\t"                              \
> +               ".popsection"                                   \
> +               : [__mask] "=3Dr" (__mask));                      \
> +       (__mask & val);                                         \
> +})
> +
>  #define runtime_const_init(type, sym) do {                     \
>         extern s32 __start_runtime_##type##_##sym[];            \
>         extern s32 __stop_runtime_##type##_##sym[];             \
> @@ -256,6 +272,12 @@ static inline void __runtime_fixup_shift(void *where=
, unsigned long val)
>         mutex_unlock(&text_mutex);
>  }
>
> +static inline void __runtime_fixup_mask(void *where, unsigned long val)
> +{
> +       __runtime_fixup_32(where, where + 4, val);
> +       __runtime_fixup_caches(where, 2);
> +}
> +
>  static inline void runtime_const_fixup(void (*fn)(void *, unsigned long)=
,
>                                        unsigned long val, s32 *start, s32=
 *end)
>  {
> --
> 2.34.1
>
>


--=20
Best Regards
 Guo Ren
