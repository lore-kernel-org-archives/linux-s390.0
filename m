Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAA530E13
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906529; cv=none; b=Uz+DlBlIZQ7gG+iEFlYfiU3IwTLRE7/i1jjy3K87klIVlrvt13viB4Fq6wlfRkAR8AZyjkZRQ8foz2l9hYE+rPCFqNUxZJd0e8BoXUYW3Sv4lZDKl10lswaxxUAp14UccTg/607Mg4U7iwRG3RzLQl8iikFU+FfhTXk0wFChQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906529; c=relaxed/simple;
	bh=qZW6EHlErkj2K43c8yqEhOrQiwREfShYSiXfRXjr2n0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=F+PxpGcGcmJq5C+K5MtlWX9cspaSlWfnTnENGtb52Xhg3++Fp+jsBeuPBJMUK0SPD+08sGrFQZn0LL6+lw2ngLJX2PmBdXquWmsZ5lL0NVd+b3byeMU7q0sw2U3v7tJG5vw8cpS42jLC53hQl1sAbLQ4+Pokbx2t+0j9N9USI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp9CojlM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp9CojlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBCF1F000FF;
	Tue, 13 Oct 2026 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906527;
	bh=5Se4zwTcZQDDnRsxPhBzL+LnaLxJ8NZdve/uVMZxE5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mp9CojlMV0Tup/vzuKPgPgzwHfJVHxHkEZwu3OIunOXiEPnt2P/U7RaUWWQLflQsw
	 Nzq2Cs+H2NovGGlLtGyu5o8HiA52M8wqUgZ36GdWAHXXKG6Y62jc8mIGc9mttvpHmp
	 y83hRimB8G/Zl2LJgQqd57p6AEsgWtKW0CtkAAM2D0XqmvxzCD4Y9686lnewdJs5zW
	 BigxmyAn/+5exHsZ414n3DG7oOeY8pMO0aGxsXZuRLaq/vZbyiRoD3AJ1ihCdtwSOZ
	 ukcLUpW17dQNimfbpL7FPUJCaxaRtHR0KmCvJIx7Mv3Uow6PbG7UPrK3S1F8BYQif9
	 pdF47N/Y0Z69w==
Message-ID: <sashiko-outbox-170045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/15] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-6-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:48:46 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D5

