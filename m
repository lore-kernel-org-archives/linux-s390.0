Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67A3AD522;
	Tue, 18 Aug 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065705; cv=none; b=VmxUirtaR2ecDIMNuNv+/f/yDMX/1U7PxL/QzH6pcsVIKViT1fdnClPcjEnm2rSdNHOqqZyO8WQAfL+bwFZz2OqjJBWvSF/zOh3Tg7SJjbbPqL67s/KRv80jkkiKIZPsYiFJBtwLqG8rHkVm7vylmm0h6qlk3owf/jjhSztB1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065705; c=relaxed/simple;
	bh=H/Znn6A5e4R4JVYrGZX6BMIQuMDdUsqWwGkfrBUj/uk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U//rV3RGXYGI87twZAZN4CQJSjcLdGOxcMzFEdfezCsLbYdeIxJeRL86GCoq35zkFEeIFts8D1hmCxaOho9bpzEOkLp/jZwmerV/0slqXk15vtNt4mzWHvtZOhVlrkliIhz1Cg+HmvTP+n31/SMq6ha+UZsxvpfUK7QFk6vDOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3go/tVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3go/tVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2422A1F000E9;
	Tue, 18 Aug 2026 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065703;
	bh=PVtyOtLACQrHmAmbl0/I9IotiCnJsXnPHN3JL1Y0SVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3go/tVDNivJwWSmkWWHEQ9FE2kd/0aNqffqOq6JKengyefudujn1olFELVv1d9kt
	 VO7M037kzVZHQNrt1KN29UEhwEhcdtl1F+C/DvJZVGhtmwaDC451sB5PX7+A3SQSc7
	 yNavfKVekgJkScRdtygXq7qFsdWiEfhhU+35ukrQ2/CPHtFEI9FJbDGd3Ywz5kJR4M
	 PPuejQ6hHLG/SrR41IyM5iT+TWJu3nZMQDa+z4g6SZAFMcRygpz5RWr4up1xG9xFxO
	 odowqXl+K6gHfJvTuhBXqHytlEkwC3SfMFk3/v92C8kmS9oE2VgBPtSOz4F+nol5Dw
	 0ErW8wT1WN4wQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 14/25] unwind_user/eh_frame: Add .eh_frame[_hdr]
 validation option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-15-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-15-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:08:22 +0000
Message-Id: <20260818150823.2422A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Calling printk() inside a scoped_user_read_access_size block cause=
s a UACCESS rule violation.
- [High] Infinite loop leading to local Denial of Service due to a 32-bit l=
oop counter overflowing against a 64-bit upper bound.
- [Medium] CPU soft lockup due to unbounded loop over potentially millions =
of user-controlled entries without yielding.
- [Low] Compilation failure due to referencing a non-existent struct member=
 `has_binary_search_table`.
- [Low] Spelling error in Kconfig help text ('entrire' instead of 'entire').

Pre-existing issues:
- [High] Information leak of uninitialized kernel stack memory to userspace=
 via the unwinder.
--

--- Patch [14]: [RFC PATCH v1 14/25] unwind_user/eh_frame: Add .eh_frame[_h=
dr] validation option ---
commit e7ce89dcff055122fac1a936bcef539a42d26943
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Add .eh_frame[_hdr] validation option

Add a debug feature to validate all .eh_frame[_hdr] sections when first
loading the file rather than on demand.

> diff --git a/arch/Kconfig b/arch/Kconfig
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -490,6 +490,28 @@ config HAVE_UNWIND_USER_EH_FRAME
>  	bool
>  	select UNWIND_USER
> =20
> +config EH_FRAME_VALIDATION
> +	bool "Enable .eh_frame[_hdr] section debugging"
> +	depends on HAVE_UNWIND_USER_EH_FRAME
> +	depends on DYNAMIC_DEBUG
> +	help
> +	  When adding an .eh_frame_hdr section for a test, validate the
> +	  entire section and its referenced entrire .eh_frame section

[Severity: Low]
Is there a typo here? (entrire -> entire)

> +	  immediately rather than on demand.

[ ... ]

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c

[ ... ]

> @@ -1107,11 +1107,11 @@
>  static __always_inline int __find_frame_row(struct eh_frame_section *sec,
>  					    struct eh_frame_fde *fde,
>  					    unsigned long ip,
>  					    struct unwind_user_frame *frame)
>  {
>  	struct eh_frame_cfi_context ctx;

[Severity: High]
This is a pre-existing issue, but can this leak uninitialized kernel stack
memory to userspace via the unwinder?

In __find_frame_row(), ctx is allocated on the kernel stack without
initialization. If an attacker provides a crafted .eh_frame starting with
DW_CFA_def_cfa_register, __do_cfi_program() sets cfa_rule =3D CFA_REG_OFFSE=
T but
leaves ctx.state.cfa_offset uninitialized. This uninitialized kernel stack
value is assigned to frame->cfa.offset and used by the unwinder to compute =
the
user stack pointer.

[ ... ]

> @@ -1163,6 +1163,95 @@ int eh_frame_find(unsigned long ip, struct unwind_=
user_frame *frame)
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_EH_FRAME_VALIDATION
> +
> +static int eh_frame_validate_section(struct eh_frame_section *sec)
> +{
> +	void __user *table_start_ptr;
> +	unsigned long table_size;
> +	u8 table_enc;
> +	int entry_size;
> +	unsigned long prev_func_addr;
> +	unsigned int i;
> +
> +	if (!sec->has_binary_search_table)

[Severity: Low]
Does this cause a build failure? It appears has_binary_search_table was nev=
er
added to struct eh_frame_section.

> +		return 0;
> +
> +	if (!sec->fde_count) {
> +		dbg_sec(".eh_frame_hdr: invalid FDE count\n");
> +		return -EINVAL;
> +	}
> +
> +	table_enc =3D sec->binary_search_table_enc;
> +	entry_size =3D 2 * encoded_pointer_size(table_enc);
> +	if (!entry_size) {
> +		dbg_sec(".eh_frame_hdr: invalid binary search table entry size\n");
> +		return -EINVAL;
> +	}
> +	table_start_ptr =3D (void __user *)sec->binary_search_table_start;
> +	table_size =3D sec->binary_search_table_end - sec->binary_search_table_=
start;
> +
> +	for (i =3D 0; i < sec->fde_count; i++) {

[Severity: High]
Can this loop become infinite and cause a hard lockup?

The loop counter i is a 32-bit unsigned int, while sec->fde_count is a 64-b=
it
unsigned long. If sec->fde_count exceeds UINT_MAX, i will wrap around to 0,=
 and
the condition i < sec->fde_count will always evaluate to true.

[Severity: Medium]
Additionally, can this unbounded loop over potentially millions of entries
cause a CPU soft lockup or RCU stall?=20

This loop executes entirely without a cond_resched() call, allowing a local
user to load a moderately large ELF file and hold the CPU uninterrupted for
seconds.

> +		struct eh_frame_fde fde;
> +		unsigned long cur;
> +		unsigned long func_addr, fde_addr;
> +		int ret;
> +
> +		cur =3D sec->binary_search_table_start + i * entry_size;
> +
> +		scoped_user_read_access_size(table_start_ptr, table_size, Efault) {
> +			/* Read function start address from table */
> +			ret =3D read_encoded_pointer(sec, NULL, &cur,
> +						   sec->binary_search_table_end,
> +						   table_enc, &func_addr);
> +			if (ret) {
> +				dbg_sec_ehfh(cur, "table[%u]: failed to read function start address\=
n", i);

[Severity: High]
Does calling dbg_sec_ehfh() inside scoped_user_read_access_size violate UAC=
CESS
rules?

The macro scoped_user_read_access_size enables UACCESS. dbg_sec_ehfh expand=
s to
pr_debug, which calls printk. Calling complex or sleepable functions like
printk with UACCESS enabled can trigger page faults, take locks, or schedul=
e,
potentially leading to kernel oopses or panics.

> +				return ret;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D14
