Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681814E1C7D;
	Fri,  9 Oct 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546781; cv=none; b=T1jGFXNINv+lo+uevgM884GQfAnsSnZKm7tOcqAA3QJvScZ63CdYnMGvxiZMchWnaROHq2VJcQb2sd6Kqbvm4ALp4oUU6sN3TY2lUJDZCxaZ1nS/T0o1k7RLN5QQa71RyCVXYLoXg1969n1hXTIN75zfofGd2t8WknGh0SA7Ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546781; c=relaxed/simple;
	bh=SGQt18hAlXoMaB8s0f5uCP3Dj6HBE1GLo86qgKEKyyc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Q1e6/hfP7IppsuNPErXD729UFsYUSujMafM3bfxNhtYC8JI2fQVWdxxXPP/yVdn216Nyn7T5Jn7S4aU/aWZjcT8TPnAN1B8NMrfDAgeFYjEsdkSaCFgZsk4KJkZJFDy4sgVNDIsL59HXVFuLA7zhWkanVAC1yyj+NT3vFFdJ/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx5wYst3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx5wYst3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF701F00893;
	Fri,  9 Oct 2026 11:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546768;
	bh=kpaxW89xqJotHMKonaILvU8W1D90LezYPrUpoeJEnMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yx5wYst3acZBLlnUipGz3y8Ew5kfgk8uQ6ffz0wAh2Y0sLZqWIJgM/eQ8E7+cbh4e
	 WkkXq+Zvnt9HzPxlucT3C49bjVu65RWgUl6/3Fg3VwV1goJV/wRVg0eQ1OTGF/EPuM
	 qMDL+I4Vs/2zHjXGmyPpL1I8yVgF6xIrkRk9ofmnySShFHQdptH2jRRpxFY2doXu0U
	 jIGmXKik9QK3gAKiLARTrbHHeYfrJBRiPVzLt4ZyCjnlITZPwfxqJoH8m9GTevbt+R
	 vdS+iJNCFp8hssryAn3jKXDiEBrHPWsUjXOOEgmeJ54Pw2XA77Ihslg2QlXuKIWtuf
	 MP0xnOD1Jngqw==
Message-ID: <sashiko-outbox-165439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-4-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:52:47 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Provides the functions that initialize and release the data structures
> used during live guest migration:
>=20
> * vfio_ap_init_migration_capabilities
>=20
>   Sets the migration flags and vfio_migration_ops structure into the
>   vfio_device object when the mdev is probed.
>=20
> * vfio_ap_init_migration_data
>=20
>   Allocates and initializes the object used to maintain the state of the
>   VFIO migration. It is called when the VFIO device is opened.
>=20
> * vfio_ap_release_migration_data
>=20
> [ ... ]
>   and .migration_get_data_size function pointers). These are
>   implemented as stub functions here and each will be fully implemented
>   in a subsequent patch.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D3

