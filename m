Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD893769EB;
	Sun, 26 Jul 2026 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039290; cv=none; b=ZbAqsqs9ssFB+ActnIqcraI/ITGS+771jRftF9CnQXJpmp0QlrdMk9wMhgfXpsG6/oWBBbqglkIQxMwFRQoLbqLNaHJCM6g/Ga++ijVHvteFbSheJ8/fIdy2yY2ASiEq6zI2bZC/h31VcPZB7e8EfX2NUeup3XIxlN8TctkQnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039290; c=relaxed/simple;
	bh=KlKHpW8ikZhEqzw/dZcztibwQHwI/f2eP1ZfKeEYUS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d0BdVVB56N5EVJggcUK6xTbICMQR7L+OKUJU266/PycndFWEFGTK2PkBs5YXsmlDbJro18+PsJ3hkdGUkU7t5luERGzeJ5P84VvsmNZNzYpc4VKJKwVAh6n1Xrd5Pd5ClD0UI/E4tABm4jt7Q6MVc092obcvFuRb+/CYQyuhi0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z66kg7n5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z66kg7n5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1961F000E9;
	Sun, 26 Jul 2026 04:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785039288;
	bh=lUlCIYW5x1z7Qr2q1E9dZswlWlAluLnyHGdKO4kJ7Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z66kg7n5Tl/aoC7wp2OUtM4EXAZK/b7MyFebQ2uximm2Hg42zj9yn9fokCDnUNHse
	 H64TbRlIeI5cig26fllqZzA/Id95sIw5OohgDYMYR9vQnb/5Z2ZW2SnWe+HID4YsQ1
	 8jVOkOjha8LFrddErs7+4dXAALqXP9SnvLhmyF8sE1W725Mx/UD/pwNJtSXdPlN0uj
	 meEureOyQd/3uZ74uRfzGGrTnbljGes4miRWRr+Ope/ZlIn4FcjHzZqV6HHzBHmwiB
	 8tafE12ofQeMEm2aOX2h6Fw7e3SZF+MKomiIXi0UNY+Y6VRzRL/2fUQwncMgXFU/H4
	 k3PPXzgSgOGqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/10] s390/vfio_ccw: calculate idal length based on
 idaw type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260726040129.2946151-6-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:14:47 +0000
Message-Id: <20260726041447.DD1961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest IOVAs are passed untranslated to the host channel subsystem =
for skipped I/O operations, allowing physical memory probing.
--

--- Patch [5]: [PATCH v5 05/10] s390/vfio_ccw: calculate idal length based =
on idaw type ---
commit 8013df87ffdce265ecd327b26da1e700483c050d
Author: Eric Farman <farman@linux.ibm.com>
Subject: s390/vfio_ccw: calculate idal length based on idaw type

The patch fixes the length calculation of IDAL in get_guest_idal() so it
doesn't unconditionally assume Format-2 IDAW sizes. Input IDALs can be
Format-1 (31-bit) or Format-2 (64-bit), requiring dynamic size calculation.

Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.org/

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 6275794751cb4..5ef082b8289af 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
[ ... ]
> @@ -524,7 +525,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
>  	u64 first_idaw;
> -	int idal_len =3D idaw_nr * sizeof(*idaws);
> +	int idal_len =3D idaw_nr * get_idaw_size(cp);

[Severity: High]
This is a pre-existing issue, but I have a question about how we handle
skipped I/O operations. Is it possible for untranslated guest IOVAs to
be leaked to the host hardware if the CCW has the SKIP flag set or if
count is 0?

When get_guest_idal() populates the idaws array, it copies the IDAL
directly from the guest. Later, if ccw_does_data_transfer() returns
false, ccwchain_fetch_ccw() skips pinning and sets pa->pa_nr =3D 0:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_fetch_ccw() {
	...
	if (ccw_does_data_transfer(ccw)) {
		ret =3D page_array_pin(pa, vdev, idal_is_2k(cp));
		if (ret < 0)
			goto out_unpin;
	} else {
		pa->pa_nr =3D 0;
	}
	...
}

This then causes page_array_idal_create_words() to perform zero iterations
because its loop is bounded by pa->pa_nr:

drivers/s390/cio/vfio_ccw_cp.c:page_array_idal_create_words() {
	...
	for (i =3D 0; i < pa->pa_nr; i++) {
		idaws[i] =3D virt_to_dma64(page_to_virt(pa->pa_page[i]));
	}
	...
}

Would this result in the guest IOVAs remaining in the idaws array,
leaving the untranslated guest addresses exposed to the host hardware?

Since the hardware still validates physical addresses even for skipped
operations, could a malicious guest use this to probe host physical
memory and bypass KASLR?

>  	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
>  	int idaw_mask =3D ~(idaw_size - 1);
>  	int i, ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D5
