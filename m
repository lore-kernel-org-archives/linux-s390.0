Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8642ECE86;
	Fri, 24 Jul 2026 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915261; cv=none; b=ccmutWF+uOy2+xjysxGGi9pUI0I6FgHnF1PAIP6hQP8DclcZFRB7ntNB4AKNl13DSRAUGD3r5yj2ikL8YT9pv7pgmCLS3j3nh5ME6l64hNGPmZIXhO3wH4OkOL7+30OowOE6CgnTztDLeLA9vneM4ARUOG4AH9X+rOF6B2/Jr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915261; c=relaxed/simple;
	bh=7NA/V0Z1myItYQ8NwSLT1MABGx/3GDxxdXcPJVPm6Ag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nz/HsF+oQjXipC6C4ZSqW0LeaUs5tYFMuVOu3lwmEitvz/q1SHdYtth1LX0Y5hIHHnMSEPodUCXKV485fxRbtHk8gT325Auw37eGnGuw7UwA/qdeL72n7p2rm5CkQOYlJ7FPqj+ncCPTiZ7fI9QnAiiW0ymzvP1j/IKMIgA9s5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEBIslaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEBIslaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AB51F000E9;
	Fri, 24 Jul 2026 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784915260;
	bh=AG43otCxOgZQlb7Ladi2LklUk40LMgsaTqGi2SQcu70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GEBIslaDY9lyUWEZeWVkIvgrdaM8U9mfNCqsUoTzawHn63o0QEQi6hD+3StRCIaPR
	 w2INsppF+Mp188xW8wb0x3rCDnv7P/X8QUbKD5Q0OxfKBAhg3g3TcrC8gpoerTqhLB
	 FTJ7pKriYzZlnv+ZJeblQldANzcxl34U/gjU8HLMM25v5fI5w7V6HfmoSbE1fBRsUn
	 LKiOeab10Sb+cXU0E0eLDT3PlLo+Lwtm2WyircCrs6jNRmMyEjKNLSeAuoFypNcafS
	 RmBrraNIkZMxWMnu63A/bp2elAmT6hU6RjSuGU7BN5C/sLCnnpBWFN2AZyhMOZtxX5
	 3AtpvetIfiJGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/15] s390-vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260724161351.1802644-6-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:47:39 +0000
Message-Id: <20260724174739.A3AB51F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D5

