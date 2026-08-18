Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCC378D6B;
	Tue, 18 Aug 2026 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083342; cv=none; b=K+djdtzTVSabejelWVnhUPBpwvE0So2HHJ85LUE7UbnC2cukskKiciAGhW0DWLaDJb1KT9oA9N+iXbpbeYtmLr16gQ0UfLCQgLNfRarP7z9/ZvkxybTonGlKW2Jrf2zJt06K5hr3UMuNDV83jHJ0lc+yB/K/rfYpYyNqYctwCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083342; c=relaxed/simple;
	bh=8jNRclZX1Z5UrtD6Ub6VMTQVYjx2E7WpF4x0abPxHn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GKhY9YuFQ0aQsEvbND+Cn2NbbpEoACEjLEDiZ8rByefs4uM90B+p5cZLx389xHhaDYD3jl7iErlWZT1xd1sv4KyKgKbGiArg8JOKI5OlATN7kLcSSZKPzQ9++y8AvUYIqZzLduddpyY8tXRxlE8Rpr9Bvjiyds31tlY0AroT2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZIVUZJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZIVUZJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5C01F00A3A;
	Tue, 18 Aug 2026 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787083341;
	bh=8jNRclZX1Z5UrtD6Ub6VMTQVYjx2E7WpF4x0abPxHn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KZIVUZJ5GGePxuzekJ97gBUuIfsLWrtDluYAk0RQkFiBaUMg0tO0JAun7Mk6trNPn
	 mJlml6VyAPe8UF1/TJ2kipQneFf7jj8nQPpVSlsVg8Y5I8HXURfOcILo3KCGQC4kOt
	 fGI0JTQqbiwTlWzNewgLxyPf62aKloVK9sD/4lUgbkcJyPY1Fj8K52bA1FplMrbDUH
	 Sw2lpYg+mgkFwsXV59EhVvxzK98t4vH78lvpuG8H/6TeidEnkyYieqLexnBZyjB6T1
	 lhFwBDD0hN2Z4wNWGq9s9bD8OoZz8QzyvsnISt/hKRl8BxrhQ97xtMBtiXPXB+mssj
	 lP97KvXe2Fk8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/1] s390/vfio-ap: fix KVM GISC and page leak when
 queue removed from host config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818193349.1877940-2-akrowiak@linux.ibm.com>
References: <20260818193349.1877940-1-akrowiak@linux.ibm.com>
 <20260818193349.1877940-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 20:02:20 +0000
Message-Id: <20260818200221.4E5C01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Three related problems exist in the handling of KVM interrupt and page
> resources when a queue is removed from the host's AP configuration
> while assigned to a mediated device (mdev).
>=20
> Problem 1:
> ~~~~~~~~~
> AP_RESPONSE_Q_NOT_AVAIL not handled in vfio_ap_mdev_reset_queue()
>=20
> When the AP bus removes a queue device whose adapter or domain has
> been removed from the host's AP configuration,
> vfio_ap_mdev_remove_queue() is called. If the queue is still in the
> host's AP configuration at that point, it calls
> vfio_ap_mdev_reset_queue(), which issues a PQAP(ZAPQ). Since the
> adapter is already gone from the host configuration, ap_zapq() returns
> AP_RESPONSE_Q_NOT_AVAIL (0x01). This response code is not handled in
> [ ... ]
> vfio_ap_mdev_unset_kvm().
>=20
> Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host=
 config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818193349.1877=
940-2-akrowiak@linux.ibm.com?part=3D1

