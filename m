Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0F1F12F8;
	Fri, 21 Aug 2026 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343018; cv=none; b=Kwui+L8P6CyFKXBuhHOenvfduFPCIdMG6PT+47gAaQolmoh1gfJCFjESZu49YzGe6Lf3pxkAdUllP7/U/jrhDyFstr4F6ufvh11XeINUs08hqrQraV9hwXDMo2CWwekM5sGAmgV6+vx662+eyb4G8KexPs/jfhpbjzgCiuPU+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343018; c=relaxed/simple;
	bh=b33wPO2chYZJO/x07NspEvI9jagXZVfNuCCqRS0SgV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g+Kgcp7/jVrz3ph2ZJjn1wntNJ9ZU0L5b+thKxj1OJpFJKnCugtV2pnK/BG5jObKjbZbDXkKtRfVk2GyeQiiqowHeYDAlDX+pKsXNlgaHjgKi+ZQxjPqClfQG0Rj9SUqKdHAcH3ZTaGOconuX7aZqKRh6nyB5TOEoyvQMVH4V6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqsKVyMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqsKVyMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855101F000E9;
	Fri, 21 Aug 2026 20:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343016;
	bh=jomoqjOROEaPQ5XD7x9TcW7pVtUwbDPCuAoO5I1ynps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oqsKVyMCw5B7elS4hlozppopRrz9trqmnkOXIfm4A9P9B4xdDx0M/ACyfzUd9R/bA
	 Wrbdlz8zrhYPzayBRjkfksAuUn5Lwb6uSBJCbhUN8vpu+CMVGPAOSs2GNBqeRqZ79v
	 E1DjGmDn6CcTaHrph9a98Tv7jOx6UdQWRygoN8C88kHaTrS+5FyKlbIMRj1RbUHcum
	 huJMNcs9QicFAgW2y9TwT4nteWB23LNHHt+mgXdlcKWtbVOBqxTm4CYCsja148T9e+
	 hBb//6Sr/6WK91lWOobmkYwJkI3rjDXTs97s7ijE2++68HqhTpgKdR8JdPB+38M35q
	 1bCJlBExG4dgQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 14/24] unwind_user/eh_frame: Add .eh_frame[_hdr]
 validation option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-15-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-15-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:10:16 +0000
Message-Id: <20260821201016.855101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Calling printk (via dbg_sec and dbg_sec_ehfh) while user access (U=
ACCESS) is enabled.
- [High] Missing cond_resched() in massive, unbounded .eh_frame validation =
loop.
- [High] Misuse of scoped_user_read_access_size completely bypasses pointer=
 masking mitigations.
--

--- Patch [14]: [RFC PATCH v2 14/24] unwind_user/eh_frame: Add .eh_frame[_h=
dr] validation option ---
commit e134b713f5753b4c2aa710bb7ce4a784930e6ccd
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Add .eh_frame[_hdr] validation option

Add a debug feature to validate all .eh_frame[_hdr] sections when first
loading the file rather than on demand.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index 96237a96d263e..b0be56e315080 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
[ ... ]
> @@ -1216,6 +1216,92 @@ int eh_frame_find(unsigned long ip, struct unwind_=
user_frame *frame)
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_EH_FRAME_VALIDATION
> +
> +static int eh_frame_validate_section(struct eh_frame_section *sec)
> +{
[ ... ]
> +	table_start_ptr =3D (void __user *)sec->binary_search_table_start;
> +	table_size =3D sec->binary_search_table_end - sec->binary_search_table_=
start;
> +
> +	for (i =3D 0; i < sec->fde_count; i++) {

[Severity: High]
Could this unbounded loop cause CPU stalls or trigger soft lockup warnings?

Since fde_count is controlled by the size of the mapped .eh_frame_hdr VMA,
it can be extremely large for maliciously crafted ELF files, potentially
stalling the CPU for seconds or minutes.

Because mmap_read_lock is released before this is called, would it be safer
to add a cond_resched() in this loop?

> +		struct eh_frame_fde fde;
> +		unsigned long cur;
> +		unsigned long func_addr, fde_addr;
> +		int ret;
> +
> +		cur =3D sec->binary_search_table_start + i * entry_size;
> +
> +		scoped_user_read_access_size(table_start_ptr, table_size, Efault) {
> +			/* Read function start address from table */
> +			ret =3D read_encoded_pointer(sec, &cur,
> +						   sec->binary_search_table_end,
> +						   table_enc, &func_addr);

[Severity: High]
Does this bypass the Spectre v1 mitigations provided by the scoped access
macro?

The scoped_user_read_access_size() macro shadows the table_start_ptr variab=
le
to enforce usage of a masked pointer. However, the code ignores that masked
pointer and instead uses the unmasked cur pointer derived outside the scope:

    cur =3D sec->binary_search_table_start + i * entry_size;

When read_encoded_pointer() uses this unmasked pointer inside
unsafe_get_user(), the masking mitigations are bypassed, allowing potential
arbitrary speculative reads.

> +			if (ret) {
> +				dbg_sec_ehfh(cur, "table[%lu]: failed to read function start address=
\n", i);

[Severity: High]
Is it safe to call printk wrappers like dbg_sec_ehfh() or dbg_sec() while u=
ser
access (UACCESS) is enabled?

Calling complex functions like printk inside a scoped_user_read_access_size=
()
block can lead to deadlocks or kernel panics. It does internal locking, can
sleep, and may clobber architecture-specific user access state like the SMAP
AC flag.

> +				return ret;
> +			}
> +			if (i && func_addr <=3D prev_func_addr) {
> +				dbg_sec(".eh_frame_hdr: table[%lu]: not sorted\n", i);
> +				return -EINVAL;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D14
