Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C74D6C55;
	Fri,  9 Oct 2026 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546709; cv=none; b=N+SpQQ08Dj3Dh+TexcjpwojkaLUF7i96NfAsrxMYEKo+HEen6Xhv+sZRirICi7my/UwW9j8sf1hd9nqjc98wEZ6LNV93WVB2cqKY3a8EfI4UsxP5ALaHYr8YHU9hYqTUhZS4wD/m+y/jux27bJi57iF71IuO4wMKBMEg+I5nAnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546709; c=relaxed/simple;
	bh=rwD+n6DtrAxtCnLWfz87NDY1nq05GiyyEkMhduDVBqg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NGHTGm2l7h590S9F8quv5uIQOGIkWgyyBOR4UeCZlcV+Vdm8Fu7q9z9Be6X4fCustq5E6CLwhNUWWE0/sSSwtmgieitfJkmPsQqCTzoKn1gbCqyAQE63IVSZaqbF5uUbNrBlyDeUPNSmuBkO5LGjfL+4rU8RYVJ0jkGo/jI0oeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3LJQF2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3LJQF2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463E31F000FF;
	Fri,  9 Oct 2026 11:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546701;
	bh=ZezcZ5MaJWUD9MenaBrKi8GAlRfTYLnBGpDPB/Ek+z4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3LJQF2+PuVtTOIVA9u1xLAc0fAbGebQZutvLh9kId7S/0BWMr2Y3jEuKxaAkNUoA
	 221PDETwrKh45OEpX2704GcjpG8tjB2ZHGazAy2pa81nYobozwaUi1u5OmQfyuNeB0
	 HjBjj/3YBdhEIsvvwQNRGiwq/DDX2hwecuUTF//4TETmtTj6hK29arzBZGq+Flh+mi
	 X4j/+N+U9eiMEQDbKz0WUhVdEbuut8hagtUcHiH+vOIHOxmgyJ0zEL8rLaxWp2MWKo
	 nwZXODxVPiiDOaZPoRVCKbtiF9MtxOwI2hAptaFXn7rhUUhWAymxrj0gEo3PyzaOGb
	 g0A9g5ye1bDPA==
Message-ID: <sashiko-outbox-165436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/15] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-6-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:51:40 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implements two callbacks related to the current state of a vfio-ap device:
> * The callback that sets a new migration state of a vfio-ap device during
>   live migration of guests with pass-through access to AP devices. This
>   callback is mandatory for VFIO_DEVICE_FEATURE_MIGRATION support.
>=20
>   The function pointer for this callback is specified via the
>   'migration_set_state' field of the 'vfio_migration_ops' structure
>   which is stored with the VFIO device when the 'vfio_device'
>   structure representing the mediated device is initialized.
>=20
> * The callback that returns the current vfio device migration state during
>   live migration of guests with pass-through access to AP devices.
>=20
>   The function pointer for this callback is specified via the
>   'migration_get_state' field of the 'vfio_migration_ops' structure
>   which is stored with the VFIO device when the 'vfio_device'
>   structure representing the mediated device is initialized.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D5

