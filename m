Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8C46EC79;
	Tue,  6 Oct 2026 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303590; cv=none; b=ozWYl61fs6DLC7SaUhKZXIhgWU7xEndU3Y3moNqOl2JJ0wULYzGsK6ggEmGuaczVTWt3LM9cqu89iJTWwmRoxMeUpFbwV7odnVotWrYFcoB6yUH+0+pOZ50do/BBC3FUsNKtkJTHmJY9uv8goixD5YCKd05BH6PkCR9FbltotME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303590; c=relaxed/simple;
	bh=6T3UrqCKTyMk8vGIcdKDFu9QX2W56F6hPd5EKDz0GQU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ubnOWLYVYxwcKS6D0yx/FxOlowSwTBeWb/CXYyUnXD9hpAeANHwh7ogyF1aDajxW9ycq9l80vuN1yPi8oQr80gZGi9D6+2zsQlryK2six89862ImKKhsK50S6qzEFPt746ZSBV7OQIiAFVsWZlsz3n4UVaq1nL7xjBHaTW/AaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyPRUAKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyPRUAKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F52F1F0089B;
	Tue,  6 Oct 2026 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303589;
	bh=6T3UrqCKTyMk8vGIcdKDFu9QX2W56F6hPd5EKDz0GQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PyPRUAKn3bB3aCQ8LuNQREQRm0cybifenX3a8VhU4osbaCHzsCoJeuhHZm41MYY4I
	 MZsrKBSUii73YBnZC5lEEnFaVFe9mLO/rFgvCVNpj+CJmukHPbDsGSo67rUrpNhjAL
	 YLUcwUwZBl8zS3BgDQRgK6GhaxlXcyHAJmFAfB42uyAIETw40Ulgf/GaTLX+Wsy9bB
	 BmK1J8WMNwnGCRMCu0fwhwavlBogQVILXF0Vh3hhFg535ow92U7SmqWuXszqqSDXmn
	 j/oRIAtzUYCiMg8O0bbM/iIiDJL0xBUCbNhpXGLDUuXiJk+UwHwBnLWazy7xIlcQyw
	 Ov1dExz+ZDbRQ==
Message-ID: <sashiko-outbox-162240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] s390/pci: Fence FMB enable/disable via debugfs
 for passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261005154557.57801-4-oelghoul@linux.ibm.com>
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
 <20261005154557.57801-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:19:48 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
> device is associated with a KVM. This will prevent processes on the host
> from tampering with the FMB while the guest is still using it, which may
> cause partial counter resets and inconsistent reads which have no parallel
> in the architecture.
>=20
> For VFIO devices that are not associated with a KVM (i.e., for userspace
> drivers other than QEMU), this fence does not take effect.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005154557.5780=
1-1-oelghoul@linux.ibm.com?part=3D3

