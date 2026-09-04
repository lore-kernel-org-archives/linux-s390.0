Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B977427F97;
	Fri,  4 Sep 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503239; cv=none; b=gXwIJLE+548OBdE8CYV/r1JXckXQxC4c/iwf19T+Vd9vghwNabQfNvzY5bMSoSaU0l+gYOyrcfRbY+wZj10e6fsgp2qBEpM8BXx2KRLB1EaScrxyCJSI4WJXONUejFeAVtmNm3pCbuaqoBx2Po1OgD6WLcSWNmcfVeeyImo+ydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503239; c=relaxed/simple;
	bh=8hNDKy7wUq6nIhC0n100TXEO/NOpUZDSZh2r+TdrrmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DNBN5lDPJyavCnCmP6FFwFR14T9eLY4WreCkbeDeod+bviobN2Kvy2WQ3/lhQ/k2D79SPA5uqNc1JmaAnKmDiuSH4J3Nf7zdnEVAF7Ia6PMcW6vQ3df+8x/75qgUMtZApePcg8Us/zI9/fLy1FNm0OkkR00AgykV10drENrL4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3SYEFVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3SYEFVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E361F00A3E;
	Fri,  4 Sep 2026 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788503237;
	bh=2a5qm/7jEChirkFmicbQt6at/NQOygr7k632MZ9jdO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3SYEFVjQHripRLlFoD1Rw0IZ66swrSZqMjG0UGerV/OyweGkK8T6aDESipQEY0DN
	 +oU+D7rFWsyFoUcSuMAlaechpUBlisCyCwowGAisaetjNC3PRR+/zSgJkiRPSpjDGV
	 Rd6lz6gbp7HAGluWl8fRRJzlRVdqSvy1FI7mVAqum03MAFr3fqRDaj1gy756fClu8d
	 pJI2gRIrhvGEDmFKPvNcJV8NRoDSvyXZqO4GeDuVYA8LaH2+TMq/rxAUN5oo+UNHXf
	 tK1lSrAU4KxzYLLEbhjdBnJAuGy0GpwbL34jYXE82lJLMPb7kHGfXgvTrEtDSP5qfW
	 qKPFRQtfns1Cg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 11/11] s390/uv: Prevent potential out-of-bounds
 read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904060647.562443-12-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-12-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:27:16 +0000
Message-Id: <20260904062717.52E361F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential infinite loop in `uvio_get_list` if UVC hardware returns=
 `UVC_RC_MORE_DATA` but fails to advance `next_secret_idx`.
- [High] Missing bounds check on `num_secr_stored` against array size 85, l=
eading to potential out-of-bounds reads and information leaks.
--

commit 3bddf93bb1450f001c28919a0ec81368564fe49c
Author: Steffen Eiden <seiden@linux.ibm.com>

s390/uv: Prevent potential out-of-bounds read

When the system has more than 85 secrets, the uv_secret_list struct array
only holds up to 85 items per page, resulting in an out of bounds read in
find_secret_in_page if the targeted secret is in the next page or not
stored at all. Fix this by looping over the per sub-list count of stored
secrets instead of the overall count.

> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 52003c463fad0..8ea9dd7704ffc 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -825,7 +825,7 @@ static int find_secret_in_page(const u8 secret_id[UV_=
SECRET_ID_LEN],
>  {
>  	u16 i;
> =20
> -	for (i =3D 0; i < list->total_num_secrets; i++) {
> +	for (i =3D 0; i < list->num_secr_stored; i++) {

[Severity: High]
This is a pre-existing issue, but does list->num_secr_stored need to be
bounds checked against the size of the secrets[] array (85) before being
used as a loop limit?

If the Ultravisor firmware returns a num_secr_stored value greater than 85,
could this still result in an out-of-bounds read in find_secret_in_page()?

This same missing bounds check appears in uvio_get_list():

drivers/s390/char/uvdevice.c:uvio_get_list() {
    ...
		copy_len =3D sizeof(list->secrets[0]) * list->num_secr_stored;
		if (copy_to_user(user_buf + user_off, list->secrets, copy_len))
			return -EFAULT;
    ...
}

Could an anomalously large num_secr_stored here cause copy_to_user() to copy
kernel memory beyond the allocated page out to user-space?

[Severity: High]
This is also a pre-existing issue, but looking at uvio_get_list() in
drivers/s390/char/uvdevice.c, is there a potential infinite loop?

drivers/s390/char/uvdevice.c:uvio_get_list() {
    ...
	do {
		uv_list_secrets(list, list->next_secret_idx, &uv_ioctl->uv_rc,
				&uv_ioctl->uv_rrc);
		if (uv_ioctl->uv_rc !=3D UVC_RC_EXECUTED &&
		    uv_ioctl->uv_rc !=3D UVC_RC_MORE_DATA)
			break;

		copy_len =3D sizeof(list->secrets[0]) * list->num_secr_stored;
		...
		user_off +=3D copy_len;
		num_secrets_stored +=3D list->num_secr_stored;
	} while (uv_ioctl->uv_rc =3D=3D UVC_RC_MORE_DATA &&
		 user_off + sizeof(*list) <=3D uv_ioctl->argument_len);
    ...
}

If the hardware/firmware returns UVC_RC_MORE_DATA but yields
list->num_secr_stored =3D=3D 0, user_off does not increment. If
list->next_secret_idx is also not advanced by the hardware, could this loop
indefinitely and cause a CPU stall?

>  		if (memcmp(secret_id, list->secrets[i].id, UV_SECRET_ID_LEN) =3D=3D 0)=
 {
>  			*secret =3D list->secrets[i].hdr;
>  			return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D11
