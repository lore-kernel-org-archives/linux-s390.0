Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52383A545E;
	Mon, 31 Aug 2026 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211861; cv=none; b=nwYfrw4zswRn4NSfVq7iKTvFouWgMN97Odow6jaEm1bDkYDJ4MC4181PE4ReaYbZfc/ws1qooNJLA/8UihGEWkDvd/6Oy9Q9Tmi4220xbueufq1yvvqrEHDEu4pY72vdz+LfZt8P8roRjpfLK21qtMz2IeO9W+EbwEdpKz2GMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211861; c=relaxed/simple;
	bh=lmjamPHhwvKHdURInP3gxxIO1PKbLGV5uj4LIdu2i08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IYQgNLXTpYzCukG/MmN2zm4L/tZC9e0JFN23xxq6w1IARTjwl3GNlWBMmQK1J2DmEvsanlL1nl34LlPm52w9LE70+TxUU01nhIL/89Y6cAZqQr4o4WmEJorb6RMEnScfZcIymMFRwlcgI+Pt3V6C2vnB63cJlHR0Nb9KFJkvzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJJUS/2V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJJUS/2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE341F000E9;
	Mon, 31 Aug 2026 21:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211855;
	bh=lmjamPHhwvKHdURInP3gxxIO1PKbLGV5uj4LIdu2i08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJJUS/2Vkh9ocbvv+dPN5kH/1E7qFvcGEZxhdjbN14cag81Sq8VgiPihG8SGU0hCv
	 z6xF1ZQEa8jY/N8GNcgZKiCXfvCjxZcYjDX4FPslt2yL5+LFHibN7eJNj0lwn51wYK
	 DLvSoBgw4rDqc4qjrMt12sV+JvgVbfHEsyJYOCIEON+PWAaUCAkEaBEx/UEXvTrz3c
	 +RFBEzK2Qg9n8Cp514S0wIyZ5pzmwcOxq76V4WTl8ctPTFsxzLm4/X2n8XPhPnkPC0
	 iFoOrBLrjh8xokoQ6ZUYo+X8zMNkriNqUmkr46mp4PwOASzqV7o8LSCtJxeMRi0c//
	 /ve41MbFk9Qhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 20/23] KVM: s390: arm64: Implement vm/vcpu create
 destroy.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev
In-Reply-To: <20260831144802.834315-21-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-21-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:30:54 +0000
Message-Id: <20260831213054.EFE341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement init and destroy IOCTLS for vcpu and vm.
> Implement arch vm IOCTL. Use s390 gmap and gmap plumbing.
> Implement function (stubs) required by gamp.
>=20
> Co-developed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D20

