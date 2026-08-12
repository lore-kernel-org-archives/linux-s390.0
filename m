Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144639021C;
	Wed, 12 Aug 2026 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550812; cv=none; b=nAePcy9Y+jo8eamH9MDT3AhMFwv44XfqTXZVZYCj06JfCaAZ4DE4CyCXKCD/cUAw5t5RFZa63IH29mN+J1O8J43uzClNDgT+Nxa3Syv7OHOiX2QitaVMjEfLYB6z1I7B9UpL8BvMB1pBacl8PAnjchOT0TzZQA1kQsj+Ixp7KrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550812; c=relaxed/simple;
	bh=8MeG+tX06+/XAooirhIyVJKDnibvbNvJbY1t3qs6K8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YIyyZayTvI4e8X6pf3q+fbD3q1BI3zdRmuZ96y0YmnTbtLyMsECIuh57sX2xw1V68hlwmv4uZDrqYs4t8VjlLSvklklV1lsiuw5uyahq836dUJ83akz8mMp0BpAp3+lxQkjRi4lTJZBu2I8Xgu4BD0VGEYMdvrPkVliR7WHVlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvPCFA92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvPCFA92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069F81F000E9;
	Wed, 12 Aug 2026 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550811;
	bh=8MeG+tX06+/XAooirhIyVJKDnibvbNvJbY1t3qs6K8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PvPCFA92crNnexqbX3WchfYjMH5fB9P8+vlCa0V3uFoiqcPBcV2EgXcojTqrBvkGk
	 pP9yZy1HGstu+BXnVf20nlEXGy0EyagoLCaWiRKu1ifetJTYFLpNQl055J0xNw1a/S
	 4U0n+fm2Eicr7XMZ7Fdsk00We1BazLSFv5knu3SK5CT8L31JaNFR9O7H83LpoIz1jI
	 AtL4uvnlLTUoS0ebpFAZ+EqmOLskGNLd0pBIaZqnrOwo4dQ+aJ3G0HveFMaITjrgDw
	 66aeYWrNh7rQ/+448wkycMGvBjOZf+RanZHuW+EjUFXKrBeqXZVecLDecXHpaIi/Lm
	 MamIDSY1gWdfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/33] KVM: s390: gmap: Make storage keys optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812153631.3376090-20-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-20-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:06:50 +0000
Message-Id: <20260812160651.069F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Guard guest storage key handling behind `KVM_S390_MANAGES_S390_GUEST`.
> This enables other KVM implementations to use gmap without implementing
> storage key infrastructure. Define KVM_S390_MANAGES_S390_GUEST to 1 for
> KVM hosts managing s390 guests (in kvm_host_s390.h). A KVM
> implementation not implementing those features must define
> KVM_S390_MANAGES_S390_GUEST to 0 in its kvm_host_<guest_arch>.h.
>=20
> No functional changes besides the new guard.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D19

