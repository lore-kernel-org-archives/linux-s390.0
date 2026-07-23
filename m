Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318F39D3FD;
	Thu, 23 Jul 2026 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831460; cv=none; b=SmDgJOe4MliBtleQm6K3afB9sO7BBPAxBfHN4n33KWQ1UU09Wd35IRwRBpLUn8RyVdTxbck/91NjOhRFJQnsNP8IV9FDX6RZy+OC7TAFhypICsmalQFp97+8QImqjMNcwRZyUlA+g3ZcRPdjHRt75EAH21I81Ap8PsBe+k9C/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831460; c=relaxed/simple;
	bh=O0yFa6Bh4TJoXfj5GfZTW4rplXUlVnu6KcMYgVLmM/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gYwL5+t/Z92Fl5Ca9pnDl3JqOEz3FNYNhZeV3pfXG7eOfhzzBH520WN8Zn7Sj8FvNZgnjaay+4LtrT/f4AXnqOO3JWpzb4pXc/RSlhotQlcB3A+IwlMihvcKQ8Rr5Foeprrn52k8x85Hqyl4UhORNL+WocA1h3mtBsCrmidyjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6JLYPPT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6JLYPPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B431F000E9;
	Thu, 23 Jul 2026 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784831453;
	bh=X1CrHTMQMACauvq21dsrbEJUBLZS5mW4rNxFDMuVZaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h6JLYPPTQdlIDKuoG3jiByViDkGeO9Ub+dfgBIYancSWkNMki14s7veg6dh4iHLvp
	 3wekYMb8xM3BFQzr459oMlApHATc59ctDWxp1uXAaQkqemQz0OFTdOMz8opMRUNn1I
	 6ibOAoV7IPXrNA9+sfithaCL3KKT5NiXBXOBzCJOyqND1AxB7IxV60QyhVPbku/2v/
	 zyR6Kxt6GXDXJ5yD+bnnwulnPqSrJGw4nXVobb0ilbZUsAp4GC9i7OLrtqpsfmsHl6
	 nyCqztMW7UL4yuxXbCX89xv9lJ8X9cy+bYOGyicdgDpwS0/y6gYXR0oKqxwY3/AZAe
	 YbkPMdGU76/Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] s390/vfio_ccw: ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-7-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:30:52 +0000
Message-Id: <20260723183052.96B431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent manipulation of the `private->crw` linked list with=
out locking.
--

--- Patch [6]: [PATCH v3 6/8] s390/vfio_ccw: ensure index for read/write re=
gions are within range ---
commit 53ce18d2d82864d2f220e720e9f85b015a5a665c
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure index for read/write regions are within range

This commit ensures that region indexes for existing read/write regions
are properly clamped to the range of the capabilities chain using
array_index_nospec().

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index 38c176cf62957..bf678270c4572 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
[ ... ]
> @@ -97,6 +100,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_cc=
w_private *private,
>  		list_del(&crw->next);
> =20
>  	mutex_lock(&private->io_mutex);
> +	i =3D array_index_nospec(i, private->num_regions);

[Severity: Critical]
This is a pre-existing issue, but is it possible for concurrent reads to
corrupt the private->crw linked list here?

Looking at vfio_ccw_crw_region_read(), it appears the crw list element is
retrieved and removed from the list before acquiring any locks:

vfio_ccw_chp.c:vfio_ccw_crw_region_read() {
    ...
    crw =3D list_first_entry_or_null(&private->crw, struct vfio_ccw_crw, ne=
xt);
    if (crw)
        list_del(&crw->next);
   =20
    mutex_lock(&private->io_mutex);
    ...
}

Could two concurrent pread() calls (e.g., from an untrusted QEMU guest)
enter this function simultaneously, fetch the exact same crw element, and
both execute list_del() and kfree()?

Additionally, could asynchronous hardware events from the CSS driver add
elements to the list simultaneously?

For example, vfio_ccw_queue_crw() calls:
    list_add_tail(&crw->next, &private->crw);

Could this unsynchronized addition run simultaneously with the VFS read path
list removals and lead to slab corruption?

>  	region =3D private->region[i].data;
> =20
>  	if (crw)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723174751.1180=
334-1-farman@linux.ibm.com?part=3D6
