Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2A2BEFFD
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021759; cv=none; b=iikNE3uVGoPmomxN/on+My5Xe0q5H38IalIlfbkaN7fZjl9Vii4vUwqcfCfJBMKlLosk7/AotmlNJ6NHYVq9ac+DOyG27iM6alrvQfUct840jMxNEtuGSgoq1EpAAKQSY1hvPmFWYl4QeHQK9TyJWmPrLJw8Zxt0kiL5KCnamIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021759; c=relaxed/simple;
	bh=sKgzBco+D4erS6Pu2Pqk6xzbV0bUK7fE/e7rj/5WgRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QFEmMTrs0osRApi7jSpJDh7/3yiRsB0zkPhoacK2te3rVfSZD3o9SSGXB6p+IOjuq2Q2eujRbgrRtSzUOSoAkWmQZzAErmEvnRl+icciKn4r/cZTicMZK6UizaMTMlfOAXtqzEn7CwvyOuWSQTqmyl4StiV3feJYghuqr42G/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdfKI30j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdfKI30j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD841F000E9;
	Thu,  6 Aug 2026 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021758;
	bh=4SKPP8UCrtYEZUsPGHMVL6BM2qEGXhQRcHDPYmQE6m0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GdfKI30jctF726bMzBoXIWTVAruWDmBcAXd4h98sQxl/+PDZrFEGaZmZPp7zfqiOS
	 ZQyHZQUOUMQSVzvGjBGaj6yv/HPDQKm55hnm/fxAhe6KUZYjYrIuX5oEHTTKrug2UE
	 FmGFsiOBJDZNCp8jzrdA/+tjDK0Awb2elequUw1IjPbAr4XSq4pSI1DcONSX+Zeyyg
	 zNPJEsISWNgLvIttG6zn9aeoRDqwhJaZZr8f9P3Ie8zIPsmesh2rGuaPuMslzZo7Gl
	 VyVP8coBouqzr+78fTpkTR2WA9l32qIeeLFYnzgjyvVtFMieaGFgR4txvf3tL2jhQ8
	 gmIG0cYVZz3SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] s390/dasd: Add __context_unsafe() attribute to
 various functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260806130050.2057443-2-hca@linux.ibm.com>
References: <20260806130050.2057443-1-hca@linux.ibm.com>
 <20260806130050.2057443-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:09:16 +0000
Message-Id: <20260806130917.3DD841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch uses `__context_unsafe` to silence a valid static analys=
is warning about a cross-thread mutex unlock in `do_pe_handler_work`, hidin=
g a severe locking API violation.
--

--- Patch [1]: [PATCH 1/2] s390/dasd: Add __context_unsafe() attribute to v=
arious functions ---
commit 0764dc821ba7e47d621de5b2696256130f3eee09
Author: Heiko Carstens <hca@linux.ibm.com>

s390/dasd: Add __context_unsafe() attribute to various functions

This patch disables context analysis for various functions to avoid compile
time warnings using clang caused by conditional locking. The __context_unsa=
fe()
attribute is used to provide a short comment on why it is disabled.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 74fe73b5738ab..e908e2f29919e 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -1432,6 +1432,7 @@ static void dasd_eckd_path_available_action(struct =
dasd_device *device,
>  }
> =20
>  static void do_pe_handler_work(struct work_struct *work)
> +__context_unsafe(/* Conditional locking */)
>  {
>  	struct pe_handler_work_data *data;
>  	struct dasd_device *device;

[ ... ]

> @@ -1465,6 +1466,7 @@ static void do_pe_handler_work(struct work_struct *=
work)
> =20
>  static int dasd_eckd_pe_handler(struct dasd_device *device,
>  				__u8 tbvpm, __u8 fcsecpm)
> +__context_unsafe(/* Conditional locking */)
>  {
>  	struct pe_handler_work_data *data;

[Severity: High]
This is a pre-existing issue, but does silencing this warning hide a
legitimate cross-thread mutex unlock?

When kzalloc fails in dasd_eckd_pe_handler(), it calls mutex_trylock(),
establishing the current interrupted task as the lock owner:

dasd_eckd_pe_handler() {
    ...
    data =3D kzalloc_obj(*data, GFP_ATOMIC | GFP_DMA);
    if (!data) {
        if (mutex_trylock(&dasd_pe_handler_mutex)) {
            data =3D pe_handler_worker;
            data->isglobal =3D 1;
    ...
    schedule_work(&data->worker);
}

The lock is then released from a different task (the workqueue worker threa=
d)
in do_pe_handler_work():

do_pe_handler_work() {
    ...
    if (data->isglobal)
        mutex_unlock(&dasd_pe_handler_mutex);
    ...
}

Unlocking a struct mutex from a task other than the one that acquired it
strictly violates mutex semantics, which could cause debug warnings or
panics.

Additionally, mutex_trylock() in atomic context (inferred from GFP_ATOMIC
usage) violates lockdep wait-context rules and PREEMPT_RT requirements.

Could this code be restructured to avoid the cross-thread unlock rather than
silencing the warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806130050.2057=
443-1-hca@linux.ibm.com?part=3D1
