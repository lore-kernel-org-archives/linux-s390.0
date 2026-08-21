Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E28299A82;
	Fri, 21 Aug 2026 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342991; cv=none; b=ODV59PZ7K4vkR0+lwG/IOMaK8DHghqec/kLLH9N50/vkV7o8irFFtkoJSegFDbc8u4mR4+1xZ0qAnbJp0m4KOulWFfa+GpXLGva7dNJEYEfqFJ0OukPr6tfu9ve/XqgZQLfdXOZhZ8zGJqovDk2sM1DyXl7TrS5bcbY9OHxtPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342991; c=relaxed/simple;
	bh=GgyYlE40cplwDhQ+qvspPQocd841Z63Z2rVC9SCZb7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bfG924NrhyVwptcSjNHUt43Bqt8FnJ9JdSuLqpaoqmvXj3nz8JtVzupnSvjkMWcnIqwJcgtv0NUGmAGvo+L+RI/eonKK7ZnqHn+yBCA8u3/TqrWyJ86xzop2AZTsb6I0ow+mUks2KxqhZXkuj37ofbMD7YxKlqEG4+FARBt6A8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4GfJtnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4GfJtnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22341F000E9;
	Fri, 21 Aug 2026 20:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342990;
	bh=bswN0lelfVYsDOwL+zh3gdZ47r1NOMnrsRa0sTpCQzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A4GfJtnRo3GbadkQ5E/RkEfiITyk6IB7aaPAZEtoDuGLLz5Vd9eJYJ5tMfJ9ghgjT
	 HaY3ZoasaNmKYi+eB4EKV0rKwSAbCahqh60ICXkvHR8v98zdJ349ALYFNvdaXKK0O1
	 pn9qVSNFLZeymGqHlO8FoKV3sNYq9YsG1DMOU6wJDwH+CukVi8tleL0SU1Kxaad/qN
	 EtGozAjhyHEkT4aoQav236DsaxodSeeaIUcct/Um1Y5p/RF+i8EDmVQSJMX9hgVcSy
	 4WskWMGWYc8KZvFyzxXBYEL7eIXKma7kgt+B36OaVumKE99Wr4MAViG/q/VXaaYs5Q
	 gfGdljjFiUJ1A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 15/24] unwind_user/eh_frame: Duplicate registered
 .eh_frame[_hdr] section data on clone/fork
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-16-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-16-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:09:49 +0000
Message-Id: <20260821200949.B22341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Blindly duplicating all eh_frame sections ignores VMA inheritance =
rules (e.g., VM_DONTCOPY), leading to stale unwinding data.
- [Medium] Mixing goto-based error handling with guard() cleanup in the sam=
e function.
--

--- Patch [15]: [RFC PATCH v2 15/24] unwind_user/eh_frame: Duplicate regist=
ered .eh_frame[_hdr] section data on clone/fork ---
commit cedc4c84b3351e03d89a9e7fc338f35818891c5a
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Duplicate registered .eh_frame[_hdr] section data on =
clone/fork

When duplicating a process' virtual memory mappings also duplicate all
of its registered .eh_frame_hdr sections stored in the per-mm maple tree
to enable stacktracing using eh_frame of the child process.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index b0be56e315080..1ac7308814a16 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
[ ... ]
> @@ -1501,6 +1501,54 @@ int eh_frame_remove_section(unsigned long eh_frame=
_hdr_start)
>  	return 0;
>  }
> =20
> +static void __eh_frame_dup_section(struct eh_frame_section *sec,
> +				   struct eh_frame_section *oldsec)
> +{
[ ... ]
> +}
> +
> +int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
> +{
> +	struct eh_frame_section *sec, *oldsec;
> +	unsigned long index =3D 0;
> +	int ret;
> +
> +	guard(srcu)(&eh_frame_srcu);

[Severity: Medium]
Is it acceptable to mix goto-based error handling with guard() in the same
function? The cleanup guidelines suggest converting all resources to
scope-based cleanup or none to avoid confusing ownership semantics.

> +
> +	mt_for_each(&oldmm->eh_frame_mt, oldsec, index, ULONG_MAX) {

[Severity: High]
Does this unconditionally duplicate all eh_frame sections from the parent
without checking if the underlying VMA was actually copied during the fork?

If a process sets a region to VM_DONTCOPY or VM_WIPEONFORK before forking,
the child won't inherit the VMA, but it appears it will still inherit
the eh_frame section here. If the child process later maps new executable
code at the same address, could the unwinder use the parent's stale rules?

> +		sec =3D kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
> +		if (!sec)
> +			return -ENOMEM;
> +
> +		__eh_frame_dup_section(sec, oldsec);
> +
> +		ret =3D mtree_insert_range(&mm->eh_frame_mt,
> +					 sec->text_start,
> +					 sec->text_end - 1,
> +					 sec, GFP_KERNEL_ACCOUNT);
> +		if (ret)
> +			goto err_free;
> +	}
> +
> +	return 0;
> +
> +err_free:
> +	free_section(sec);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D15
