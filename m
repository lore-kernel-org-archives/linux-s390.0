Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D932B9BB;
	Mon, 27 Jul 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175199; cv=none; b=HVDY8VEkgxbYOZ7f1Ep+dC/UZusCfZKoptVRSDrXF9OhHVq9c+MOLU67QV0wpQHzymjEqYj0SWnahmgbz3sVJGE+IGhaEuy7OXRGb5OeP95xrhmJkhuSiefknsj7UVXSyZqCJwAlZ+Zjcwzx/NEfS3ioHz2q4xGCHA/Tcd1po50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175199; c=relaxed/simple;
	bh=0+y7+YrF4jrCdw1iQKomrnmWwnoT3zuVIOp4BJEqABw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N6wHf4SKn7iWPRk2+AYzSKN4frFh9U4KPue7a8MjBRbfQ6373quS7n21WX8aRMPdHU+zp99KjaMSkdixMRbuOpJNO97hpvVcMjI/bkmOIjPoSJuJuZYqABw9xwz6QdDY6txvptbkGNtMW8XIvz6RUYjxh3omo/lP9WIahoun5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMJSbgB1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMJSbgB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43611F000E9;
	Mon, 27 Jul 2026 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785175198;
	bh=4Na0/+VQQAibbeAmm7UA9UYZ2xHoNtnr2slt890CDiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMJSbgB1us1vdpt6k0V5WmHeTeAXZ2ZtjEBysZaPhhdwW9sIT6e8gVNIJmryqh9fo
	 oG8fzPvv5jDtIg3UKTZBrgx3tMhaBvrrjhTHKKSSibUlFkaUDeNn2iOo/ldxSLSCdi
	 IdDwCMr17PM4jDk7fDwQYCu4SbJuBziyqlyzEoNyMkDIVERsvzdK3sVqCDJV6IA7qC
	 f9x3kndklM235wMLLl/KpLlR5j5evEQHsXQLniARCqSJyHnxGc+pYmFfSlyFAn6oAO
	 9kKy15EXDl6uxP6FFejVdxPi3qpXMo7ag7iJDSs14kZwBXQ4LEzuPsjgu5KPhdec8q
	 sknwSMYrW1IOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/15] s390-vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260727173239.2420754-6-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:59:57 +0000
Message-Id: <20260727175957.B43611F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D5

