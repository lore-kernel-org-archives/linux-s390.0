Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BAD3A5E64;
	Tue, 18 Aug 2026 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066249; cv=none; b=j4yOFbuv5tazlkLLXNdHBYawCypVFMbJzNl5MwdzIjMLc0hYlSvg0GOSmhVi83Bc8W8172obWyPdWt/j4f0Vr46TrJBGM5TJm19JTZA2pPSwhhOUTE3xUtWHINWHRTzYo6cBNEqtTC8DUx+bwLI68oKMThgekhTCG5Re+1zhpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066249; c=relaxed/simple;
	bh=IKg6OJyB0BWcGQigd2VjM4SWO5FbhNLGHRtbrkslX1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V21owgoPd1L9zr+gmRTOy5oBjQh58+Z6ylvsAWmkw1KbSgK2djSgkJ8sDmigIxNNfBZde5hews+mtVwWeDr2p6wOCj/tdUwxWXXs8yGftzFRgMdUB42pJo5SGJtrTTbqclzUHMIqvPEaF1HjxbfOZTx6DtsoVxdP61qqmTccZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPybfmYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPybfmYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4C51F000E9;
	Tue, 18 Aug 2026 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066247;
	bh=CvHrVjgWFEIUQKT5S4FlgUrBvP4UIf9ZgjvANuWzdGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iPybfmYIBZdfeVrdjUPO3t79h2wdO8eC7QVgEOy1DPXhmP35N1IOO897zH5W56gqE
	 pjvZ1H3aoIIAuCIxABFiiOh8FmYqpbrVxpsMfwxaq5lh2v2hUl05rUc+xG2+NZb7da
	 hp3R0U/ldJrOelPUhGGZPAeshXueHcdBBW/wXsfHZ0qfS5o8dNenDTcrBcVN4a/YZf
	 ghgXDXTY6EIJhTfUruy9E1wbgzbhHOSDKjvA+nHF8z2XD6t5s5I8hiUsCNCrqkrsxc
	 wpoHdVOYqkIVVkqfQKR+raeuLNOZsyjFMsQPhGwXa4Ft3qLHk9CfGzUIpf9zePy2mo
	 1qyVq7a69II3A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 25/25] unwind_user/eh_frame: Add prctl()
 interface for (un)registering .eh_frame_hdr sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260818144954.2320378-26-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-26-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:17:26 +0000
Message-Id: <20260818151727.1D4C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Race condition in `__eh_frame_remove_section()` leads to doubl=
e-free, memory leak, and SRCU list corruption.
- [Critical] Unwinder error path triggers hard deadlock and NMI-safety viol=
ations by calling `eh_frame_remove_section()`.
- [Medium] Strict size matching in prctl handlers rejects UAPI structure ex=
tensions, breaking forward compatibility.
- [Medium] Silent data truncation of 64-bit `eh_frame_hdr_start` in `eh_fra=
me_unregister()` on 32-bit platforms.
--

--- Patch [25]: [RFC PATCH v1 25/25] unwind_user/eh_frame: Add prctl() inte=
rface for (un)registering .eh_frame_hdr sections ---
commit 04469d758625968e94108e567fd1bac500c0f41d
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Add prctl() interface for (un)registering .eh_frame_h=
dr sections

This patch adds two new prctl options to allow dynamic linkers to register
and unregister .eh_frame_hdr sections with the kernel. It introduces the
eh_frame_setup structure to pass section bounds from userspace and adds the
corresponding handlers.

Link: https://lore.kernel.org/all/20260528151023.00f5ec4e@gandalf.local.hom=
e/

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index 49e8a3e8d794a..12279f02381d0 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c

[ ... ]

> @@ -1723,3 +1724,48 @@ void eh_frame_free_mm(struct mm_struct *mm)
> =20
>  	mtree_destroy(&mm->eh_frame_mt);
>  }
> +
> +int eh_frame_register(struct eh_frame_setup __user *user_data, __kernel_=
size_t size)
> +{
> +	struct eh_frame_setup data;
> +	unsigned long eh_frame_hdr_end, text_end;
> +
> +	if (!user_data && !size)
> +		return -EINVAL;
> +
> +	if (size !=3D sizeof(data))
> +		return -EINVAL;

[Severity: Medium]
Could this strict size check prevent future UAPI extensions from being hand=
led
properly by older kernels?

If a newer userspace binary passes a legitimately extended eh_frame_setup
struct to an older kernel, it looks like it will be rejected with -EINVAL.

Would it be better to use copy_struct_from_user() here to safely handle
zero-padded extensions?

> +
> +	if (copy_from_user(&data, user_data, sizeof(data)))
> +		return -EFAULT;

[ ... ]

> +int eh_frame_unregister(struct eh_frame_setup __user *user_data, __kerne=
l_size_t size)
> +{
> +	struct eh_frame_setup data;
> +
> +	if (!user_data && !size)
> +		return -EINVAL;
> +
> +	if (size !=3D sizeof(data))
> +		return -EINVAL;

[Severity: Medium]
As with eh_frame_register(), does this strict size comparison break forward
compatibility for future struct extensions?

> +
> +	if (copy_from_user(&data, user_data, sizeof(data)))
> +		return -EFAULT;
> +
> +	/* Unregister only uses eh_frame_hdr_start */
> +	if (data.eh_frame_hdr_size || data.text_start || data.text_size)
> +		return -EINVAL;
> +
> +	return eh_frame_remove_section(data.eh_frame_hdr_start);

[Severity: Medium]
Does this code silently truncate the 64-bit parameter on 32-bit platforms,
potentially causing the wrong section to be unregistered?

The data.eh_frame_hdr_start parameter is a __u64, but it is passed directly
into eh_frame_remove_section() which takes an unsigned long. If userspace
provides an out-of-bounds 64-bit value on a 32-bit system, it appears it
would be implicitly truncated to a valid 32-bit address rather than being
rejected.

Looking at the underlying implementation of eh_frame_remove_section() that =
is
exposed by this new prctl, is there a race condition in
__eh_frame_remove_section() that could lead to a double-free?

kernel/unwind/eh_frame.c:__eh_frame_remove_section() {
    ...
    if (!mtree_erase(&mm->eh_frame_mt, sec->text_start)) {
        dbg_sec("mtree_erase failed: text=3D%lx\n", sec->text_start);
        return -EINVAL;
    }
   =20
    call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);
    ...
}

[Severity: Critical]
If a thread unregisters the section and a third thread immediately registers
a new section at the exact same address, would mtree_erase() erase and retu=
rn
the new section instead?

Because the code evaluates the return value simply as non-NULL, it seems it
would proceed to call call_srcu() on the old section again, potentially
causing a double-free and SRCU list corruption.

Also, regarding the interaction with the unwinder fast path in eh_frame_fin=
d():

kernel/unwind/eh_frame.c:eh_frame_find() {
    ...
    if (ret && (ret !=3D -ENOENT && ret !=3D -EOPNOTSUPP)) {
        dbg_sec("removing bad .eh_frame[_hdr] section\n");
        if (eh_frame_remove_section(sec->eh_frame_hdr_start))
    ...
}

[Severity: Critical]
Can this sequence cause a hard deadlock or NMI-safety violation?

Stack unwinding is frequently invoked from NMI or IRQ contexts. If
eh_frame_find() encounters a parsing error, it unconditionally calls
eh_frame_remove_section(). This attempts to acquire the mtree_lock spinlock
and invokes call_srcu(), both of which are forbidden in NMI/IRQ contexts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D25
