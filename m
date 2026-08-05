Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F05385D61
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939822; cv=none; b=Sq+H/bPx89zCndFZ0dqi3dZYYpozZHghvukS+efJ4qtJX/M1FTIHjDglqWHsY6jmYwH+l52+7Q0LLhyKVnttEu+BsUYQp1Lesh/HnmN6bbBLP9enB7y0FCiYrC0b17DyprzKyLnKmsn8DGZUf+qZCyLLBbNqYHe7dt/9g+/z/EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939822; c=relaxed/simple;
	bh=OnGL6UKsciTkCsB2yWMegJ6MLpXRE/GSqH0SZZdyViY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XAMjoqzvKIC/n3wQ4UEb7q3XTEzrpyv6ON9qc22efS7KIvWnaikW+WTBpfBrBD3Q7ovkoJIvWpsLKEbYOb+KoofxUykkWZfXfp8EBmwHAk4S9gClEXRoCNyVq/eU2bXL15la8/Shna7ufhLMuY9jW4sNFU/4eYNXCOJyhzstrkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbbAVh8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbbAVh8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93451F000E9;
	Wed,  5 Aug 2026 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785939810;
	bh=1twpP0K4B/groqzg8NymNHNauEUoodkgSeb3RcC0S/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gbbAVh8l19DUpMwFAhruqmHcg/wZWMzqw9YkYAsVXnPY52Qp1SArKXzoHTvPWV3Lf
	 U4qnlwODAO1WlU2HwKeMv1GYcVJD2MnV3waEYOgBwqqomiIXeZsBvpaS+YSL1j+Kzi
	 F/nk6JegMFOCBOW/kZ4VD3oW1KOW0n+JZmBfhLH2TuV6hDn6/tCHt2yJpptPde6pKO
	 fKnPeIiMmYYcyMAjbZJWw+ucMXaZC8py7f70YMPElSEEWqvA9eFVBFXyzVHEtpTIxw
	 ktyAFYcZDlszlsrLlfUM2ZgsKeiuQoGybkYGofJAV7O4X69xVp+TMMzhRdTGGAruBn
	 EjWWaGfXtJTqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] s390/pci: Rework __zpci_event_availability() to
 remove conditional locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805133627.1216607-3-hca@linux.ibm.com>
References: <20260805133627.1216607-1-hca@linux.ibm.com>
 <20260805133627.1216607-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:23:29 +0000
Message-Id: <20260805142329.D93451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] zpci_remove_reserved_devices() leaves zdev linked to a stack-a=
llocated list, leading to Use-After-Scope stack memory corruption.
- [High] zpci_remove_reserved_devices() modifies device state without holdi=
ng state_lock, causing data races and lockdep panics.
--

--- Patch [2]: [PATCH v3 2/3] s390/pci: Rework __zpci_event_availability() =
to remove conditional locking ---
commit 75e2f03936eebee8914ba9e93f94ec0e2bac2ac9
Author: Heiko Carstens <hca@linux.ibm.com>

s390/pci: Rework __zpci_event_availability() to remove conditional locking
   =20
This patch reworks __zpci_event_availability() to avoid taking locks
conditionally, resolving a compiler warning from static context analysis.
The event handling is split into smaller, dedicated functions.

> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index bead4ed5d4abe..0a9eecb62bd1a 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
[ ... ]
> -static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
> +static bool zpci_event_avail_any_device(struct zpci_ccdf_avail *ccdf)
>  {
> -	struct zpci_dev *zdev =3D get_zdev_by_fid(ccdf->fid);
> -	bool existing_zdev =3D !!zdev;
> -	enum zpci_state state;
> -
> -	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
> -		 ccdf->fid, ccdf->fh, ccdf->pec);
> +	/* 0x0306 - No handle or fid stored */
> +	if (ccdf->pec !=3D 0x0306)
> +		return false;
> +	/* 0x308 or 0x302 for multiple devices */
> +	zpci_remove_reserved_devices();

[Severity: High]
This is a pre-existing issue, but does zpci_remove_reserved_devices() call
zpci_device_reserved() without holding the state_lock?

Looking at zpci_remove_reserved_devices() in arch/s390/pci/pci.c:

void zpci_remove_reserved_devices(void)
{
        ...
        list_for_each_entry_safe(zdev, tmp, &remove, entry)
                zpci_device_reserved(zdev);
}

And zpci_device_reserved() asserts this lock:

void zpci_device_reserved(struct zpci_dev *zdev)
{
        lockdep_assert_held(&zdev->state_lock);
        ...

Will this result in a lockdep warning and potential data races on the
device state during a 0x0306 PCI event?


[Severity: Critical]
This is also a pre-existing issue, but can this lead to memory corruption
if the device reference count doesn't drop to zero?

In arch/s390/pci/pci.c:zpci_remove_reserved_devices():

void zpci_remove_reserved_devices(void)
{
        ...
        LIST_HEAD(remove);

        spin_lock(&zpci_list_lock);
        list_for_each_entry_safe(zdev, tmp, &zpci_list, entry) {
                if (...)
                        list_move_tail(&zdev->entry, &remove);
        }
        ...
}

The devices are moved to a local stack-allocated list (remove).

When zpci_device_reserved(zdev) is called, it drops one reference. If
another thread currently holds a reference (for example, via
get_zdev_by_fid()), the device is not freed immediately. When
zpci_remove_reserved_devices() returns, the stack frame is destroyed, but
the device's entry remains linked to this destroyed stack memory.

Later, when the final reference is dropped, zpci_release_device() will call
list_del(&zdev->entry), writing to the invalid stack memory. Is there a
safe way to handle this list manipulation?

> +	zpci_scan_devices();
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133627.1216=
607-1-hca@linux.ibm.com?part=3D2
