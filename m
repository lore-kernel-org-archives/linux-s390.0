Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACF47F790;
	Thu, 27 Aug 2026 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846323; cv=none; b=jKYVZ5d1kbnRnCI19HY34KMjom2uD8Gn+xO1RiJYV6jVoR9NCkg35UybDlw+tPIZnEwhYQVno0BzgM7QwXrONXh4/fhxE+IKJABXV+x34bOAYwKI+Wu4580BMaHOKEzQCHSb37VCmpxpNnH8D1u127Q/I/b7p5ltZBw/6MFc4rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846323; c=relaxed/simple;
	bh=3YgRrSxhl4hSkgkebrur+sa1TMWB2i7Jq8EruI0GPxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bgCSXzhSyM/6f6XYzcaXyPlJI5EsxGLIE8KtF5QoCYYxU8q6y8l4JeRaujr0Q3136h2qRfG1Qg4ZiZbGc7xlxw6NnQWIXQX09nQUaCEVpNb3TSkmLbNXKNgxzpGygJDctQ14qg+8EqMB/gJcY3/5o7wJzMLnacwKSgBacf81rf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqEdEhfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqEdEhfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D7E1F000E9;
	Thu, 27 Aug 2026 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846321;
	bh=3YgRrSxhl4hSkgkebrur+sa1TMWB2i7Jq8EruI0GPxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqEdEhfHsCcxGWnGU/DW2ExDUIxFMV/a3KzUBuH9IJhOAcl0WYGl2QiV8zXpcc1rY
	 znj0zhlMoPI4xX3duwr2DVvjS5Ix0bVYg+o+RHN0bI4qigDaT+qtii9ynlimhDoE4F
	 K7WNgJYO9FonV5vkiVSPOlffs8dQajCRBaYZRQLe/49/l8jh7N8SFqU5D9kexfY/iH
	 qh2jytUyMAkqYL/xWA48y6y1kBLYrXZWBWNOFJYtq5KA0rspwTUq2E2uHdvzE0BGm0
	 ShvyIsUw0FgL5lkwh+TKkJFwJf43WatIMfy1LnMbGUIf7GPLNasjXTqOcgP8vGeLuE
	 2BL/bnC8AE3qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/21] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-4-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-4-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 15:58:41 +0000
Message-Id: <20260827155841.93D7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add the required guest-1 structures for the ssca to the SIE
> control block for use in later patches.
>=20
> The shadow SCA features the address of the original SCA as well as an
> entry for each original SIGP entry. The entries contain the addresses of
> the shadow state description and original SIGP entry.
>=20
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D4

