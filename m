Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9EB38837C;
	Fri, 21 Aug 2026 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343755; cv=none; b=SPh7pC6dGv0dXZNmE+MyzTgoUzhEEPhLw6IZjW4oaI+vDdfobNgqUXXgLTYvgJAr7Tujzev17c8EElmoSp/vt0bDkbV2oSLU3gvBYZDWRMLxRSH0XSRP6TAJQWg+svOYcrbzyhrRnwzmE73aFbCuzQTPcYKa62jO8zLXaeiWPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343755; c=relaxed/simple;
	bh=oIo3zJ//UsK89bMjv1EMj+4KEFTcgRwTTvA5D+ihX5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XfE+u5bl9M8FizAPCk6Y4VWxXxbRLeVlNg16XUGf0D3e4B9MnQkOsVFqnSE+JsGSPsUErj1hoVoODqGBdfZQ8kwt8DGg5ylryqSYxp9FboAyHF5gS2pAlqWhd+wTlFKwui0iSBbF7kJYs71+CZmwm4xe/h9i4vVXU4BDvOxHZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVcoiEDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVcoiEDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF04A1F00A3A;
	Fri, 21 Aug 2026 20:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343754;
	bh=02eUuBhKlD2TKLOHqlf8m8InkhYdRJs2+qasigko2P8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RVcoiEDsq7xhZ4i+UOz1uFthhGSNA3k0O3pyJULqq4hgzHWQw8uVg2rwTusqzRscC
	 q8GiKOOwcmAcy8DD36kp/pQCFNOyTjj2JSu7/VdFvvh2rouO2hJuiK2nIWwLFnnuTB
	 4bl3OkjSYcdmazQdumxUMGG4nEVqS5PI59ywIbQ9HHwzKftoFBMSPxEC/EntwGULFg
	 QAER6St0qeg4lz+IgpeZm7q+Grr2iXmkxR2d+bwAwON0wL6llIt72rgVs4+1V2U728
	 rSqPhbG8M33W7gOkttbu9C5KEKc6cJycPUeWDIW+qSh/pIZecJ7810atr8kDOCkcCp
	 i1/di6O9JMCxg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 24/24] unwind_user/eh_frame: Add prctl()
 interface for (un)registering .eh_frame_hdr sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-25-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-25-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:22:33 +0000
Message-Id: <20260821202233.CF04A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The strict `size !=3D sizeof(data)` check completely breaks UAPI b=
ackward and forward compatibility for extensible structs.
- [Medium] Silent truncation of the 64-bit `eh_frame_hdr_start` address to =
a 32-bit `unsigned long` during unregistration on 32-bit architectures.

Pre-existing issues:
- [High] If `mas_erase` fails due to an out-of-memory condition, it returns=
 the target entry but leaves it in the maple tree. `__eh_frame_remove_secti=
on` fails to check `mas_is_err(mas)`, freeing the entry while it remains ac=
cessible in the tree.
- [High] The unregister prctl triggers an unbounded iteration over the mapl=
e tree while holding a spinlock, allowing an unprivileged user to cause a C=
PU soft lockup.
--

--- Patch [24]: [RFC PATCH v2 24/24] unwind_user/eh_frame: Add prctl() inte=
rface for (un)registering .eh_frame_hdr sections ---
commit 51adfd3b1e2795e1bc35c760119a8842b4e76983
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Add prctl() interface for (un)registering .eh_frame_h=
dr sections

This commit adds prctl interfaces to register and unregister .eh_frame_hdr
sections. It allows dynamic linkers to notify the kernel about the location
of these sections using a new eh_frame_setup structure.

Link: https://lore.kernel.org/all/20260528151023.00f5ec4e@gandalf.local.hom=
e/

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c

[ ... ]

> @@ -1609,3 +1610,48 @@ void eh_frame_free_mm(struct mm_struct *mm)
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
> +	if (!user_data || !size)
> +		return -EINVAL;
> +
> +	if (size !=3D sizeof(data))
> +		return -EINVAL;

[Severity: High]
Does this strict size check prevent future UAPI extensions? Since this
is a new UAPI structure, rejecting sizes that do not exactly match the
kernel's structure size prevents extending the structure later without
breaking backward compatibility. Would it be better to use
copy_struct_from_user() here to handle size mismatches by verifying
trailing zeroes?

> +
> +	if (copy_from_user(&data, user_data, sizeof(data)))
> +		return -EFAULT;
> +
> +	if (check_add_overflow(data.eh_frame_hdr_start, data.eh_frame_hdr_size,
> +			       &eh_frame_hdr_end))
> +		return -EINVAL;
> +
> +	if (check_add_overflow(data.text_start, data.text_size, &text_end))
> +		return -EINVAL;
> +
> +	return eh_frame_add_section(data.eh_frame_hdr_start, eh_frame_hdr_end,
> +				    data.text_start, text_end);
> +}
> +
> +int eh_frame_unregister(struct eh_frame_setup __user *user_data, __kerne=
l_size_t size)
> +{
> +	struct eh_frame_setup data;
> +
> +	if (!user_data || !size)
> +		return -EINVAL;
> +
> +	if (size !=3D sizeof(data))
> +		return -EINVAL;

[Severity: High]
Is this strict size check similarly going to cause extensibility issues
for the unregister path? Like the register function, could this use
copy_struct_from_user() to safely allow future modifications?

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
Will data.eh_frame_hdr_start be silently truncated on 32-bit architectures?
The user provides a 64-bit __u64 address, but eh_frame_remove_section()
expects an unsigned long. If the upper 32 bits are set by userspace on a
32-bit architecture, this could truncate into a valid 32-bit address without
any bounds validation.


[Severity: High]
This isn't a bug introduced by this patch, but does exposing this function
to userspace via prctl allow an unprivileged user to cause a CPU soft locku=
p?

Looking at eh_frame_remove_section(), it performs an unbounded iteration ov=
er
the maple tree while holding a spinlock:

kernel/unwind/eh_frame.c:eh_frame_remove_section() {
    ...
    mtree_lock(&mm->eh_frame_mt);
    mas_for_each(&mas, sec, ULONG_MAX) {
        if (sec->eh_frame_hdr_start =3D=3D eh_frame_hdr_start) {
            found =3D true;
            ret |=3D __eh_frame_remove_section(&mas, sec);
        }
    }
    mtree_unlock(&mm->eh_frame_mt);
    ...
}

Could an attacker register a massive number of non-overlapping sections and
then trigger a long unbounded loop with preemption disabled?


[Severity: High]
This is also a pre-existing issue, but the new prctl makes it trivially
reachable by unprivileged userspace, which could lead to a use-after-free.

When __eh_frame_remove_section() attempts to remove a section:

kernel/unwind/eh_frame.c:__eh_frame_remove_section() {
    ...
    if (mas_erase(mas) !=3D sec) {
        dbg_sec("mas_erase failed: text=3D%lx\n", sec->text_start);
        return -EINVAL;
    }

    call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);
    ...
}

If mas_erase() fails due to an out-of-memory condition, it can set an error
state and return the target entry without removing it from the tree. Because
the code does not check mas_is_err(mas), it frees the entry while it remains
accessible in the maple tree. Should this verify mas_is_err() before freeing
the section?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D24
