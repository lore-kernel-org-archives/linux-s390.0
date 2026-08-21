Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58502493651;
	Fri, 21 Aug 2026 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342779; cv=none; b=Qdbrr1PQv8mFYBg71z4U65aeISWNzP5VgXBDqc52HpHefgq4br71UmAFiq+ZCZ66pJ0xp6LiPiNxZS/9S3LD4AKxGNoXUPnqHut1/IwXgddJAWcNABvqBnFNQm6pF44r1SasYspG1WkspjkU1d584aPZJ+nO0wDNsKNd08XAo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342779; c=relaxed/simple;
	bh=qIrVhIfenvb+b0Am4QGwl8VfcXnwZd5roNrqh30m8Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lmK9nJrYV/bkA8UjWOmPDd2LvGMZ3yCYf9vvscYJythAsP2P/lBZecIhG0d/DHmqenyYEgftRmRvdEoZlpAxo6pyberxHKJwUP2C2wN3uH5kNagoUP99YBMI5sid9Ce48rFV1NSbfUKUqctpg4I/kph6VEGFcyU2BdJNnFKJits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTfouUNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTfouUNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E461F000E9;
	Fri, 21 Aug 2026 20:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342775;
	bh=klP/ny4kiRrG85HQTYIVSyMxFERBAVgSvWI0mF11am4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RTfouUNWlFmFgD4DHv8pPtKwb6XbS2njAE9Eag58eTLOk8r6ffblGKbJu50WVXpWi
	 7kd6XE5621DhLRigH5+o7ukrD9QdOkywq6Wjr0wIA5kbIW2AkA+sBieHuWw1S1OPm2
	 lADtE5TtKauPhPEA0EQkDM10Y9Re1x+RsYEh3iZTJosUMtHO/jlxGLbZ4nVtzqsQYU
	 Okvco+xxgE5BZU4ztXGqenVzIGVdvT6wMIoLCoL8YtM/tf/rBvJzxBSyTdDsIk3fCf
	 crpULS2OxQouLNS4HpbO1fBRgyU+f9WXx4QBZookzunB6P/cY2I5GrKki21OnkSHMl
	 /ljM1mTCzlbCA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/24] unwind_user/eh_frame: Add support for
 reading .eh_frame_hdr section
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-8-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-8-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:06:15 +0000
Message-Id: <20260821200615.85E461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect pointer size assumption for 32-bit compat tasks using DW=
_EH_PE_absptr encoding.
- [High] Bypassing speculative execution pointer masking by using an unmask=
ed pointer within a `scoped_user_read_access_size` block.
- [Low] Mixing goto-based cleanup labels and scoped_guard declarations in t=
he same function.
--

--- Patch [7]: [RFC PATCH v2 07/24] unwind_user/eh_frame: Add support for r=
eading .eh_frame_hdr section ---
commit d29ad7450daa52f7e2ed07991186d7ccf95beadb
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Add support for reading .eh_frame_hdr section
   =20
In preparation for unwinding user space stacks with .eh_frame, add
basic unwind user eh_frame infrastructure and support for reading the
.eh_frame_hdr section.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> new file mode 100644
> index 0000000000000..f25a0923e315b
> --- /dev/null
> +++ b/kernel/unwind/eh_frame.c
> @@ -0,0 +1,366 @@

[ ... ]

> +static __always_inline int encoded_pointer_size(u8 encoding)
> +{
> +	u8 format =3D DW_EH_PE_format(encoding);
> +
> +	switch (format) {
> +	case DW_EH_PE_absptr:
> +		return sizeof(unsigned long);

[Severity: High]
Does hardcoding sizeof(unsigned long) here cause issues for 32-bit compat
tasks?

If a 64-bit kernel is profiling a 32-bit application, DW_EH_PE_absptr is
expected to match the application's native 4-byte pointer size. Using
sizeof(unsigned long) means the kernel will read 8 bytes, which could
consume too much data and misalign the current pointer for the remainder
of the unwinding process.

> +	case DW_EH_PE_udata2:
> +	case DW_EH_PE_sdata2:
> +		return 2;

[ ... ]

> +static __always_inline int read_encoded_pointer(struct eh_frame_section =
*sec,
> +						unsigned long *addr,
> +						unsigned long end,
> +						u8 encoding,
> +						unsigned long *value)
> +{

[ ... ]

> +	/* Read value based on format */
> +	switch (format) {
> +	case DW_EH_PE_absptr: {
> +		unsigned long tmp;
> +		UNSAFE_GET_USER_INC(tmp, cur, end, Efault);
> +		result +=3D tmp;
> +		break;
> +	}

[Severity: High]
Will this also read 8 bytes instead of 4 for a 32-bit task?

Similar to encoded_pointer_size(), this reads a full unsigned long for an
absolute pointer. If this is a 64-bit kernel unwinding a 32-bit compat
application, it seems this might read past the intended data boundaries
and corrupt the address parsing.

> +	case DW_EH_PE_uleb128: {
> +		unsigned long tmp;

[ ... ]

> +static int eh_frame_read_header(struct eh_frame_section *sec)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	void __user *eh_frame_hdr =3D (void __user *)sec->eh_frame_hdr_start;
> +	unsigned long cur =3D sec->eh_frame_hdr_start, end =3D sec->eh_frame_hd=
r_end;

[ ... ]

> +	scoped_user_read_access_size(eh_frame_hdr, end - sec->eh_frame_hdr_star=
t,
> +				     Efault) {
> +		/* Read version */
> +		UNSAFE_GET_USER_INC(version, cur, end, Efault);

[Severity: High]
Does this bypass the speculative execution pointer masking provided by
scoped_user_read_access_size()?

The block masks the eh_frame_hdr pointer, but inside the block,
UNSAFE_GET_USER_INC() reads from the unmasked unsigned long cur variable:

#define UNSAFE_GET_USER_INC(to, from, end, label)
...
	unsafe_get_user(__to, (typeof(to) __user *)from, label);

Since cur is passed to unsafe_get_user() without being masked, it appears
this defeats the Spectre V1 mitigation for architectures relying on
can_do_masked_user_access().

> +		if (version !=3D 1)
> +			return -EINVAL;

[ ... ]

> +int eh_frame_add_section(unsigned long eh_frame_hdr_start,
> +			 unsigned long eh_frame_hdr_end,
> +			 unsigned long text_start,
> +			 unsigned long text_end)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	struct eh_frame_section *sec;
> +	int ret;

[ ... ]

> +	scoped_guard(mmap_read_lock, mm) {
> +		struct vm_area_struct *eh_frame_hdr_vma, *text_vma;
> +
> +		eh_frame_hdr_vma =3D vma_lookup(mm, eh_frame_hdr_start);

[ ... ]

> +	ret =3D eh_frame_read_header(sec);
> +	if (ret)
> +		goto err_free;
> +
> +	/* TODO nowhere to store it yet - just free it and return an error */
> +	ret =3D -ENOSYS;
> +
> +err_free:
> +	free_section(sec);
> +	return ret;
> +}

[Severity: Low]
This isn't a bug, but should this function avoid mixing scoped_guard() and
goto-based error handling?

The kernel cleanup guidelines recommend either fully converting to
scope-based cleanup (for example, using __free() for the sec allocation)
or strictly using goto-based cleanups without scoped_guard(). Mixing them
in the same function can create confusing ownership semantics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D7
