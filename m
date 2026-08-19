Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C6440639;
	Wed, 19 Aug 2026 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164006; cv=none; b=AAAzAOlV+xKHplEmURIYTCIT85wn1oBXaPdo8RZdDP1zhbkmUd9WW5jqvV+LfVutuS1I5Q3wFN9Cup3VLDnGVMfJ1pGgxG9cJnsGCzbVpbP/M8BzjX2XRwM1VPdSul88PIOAI1J+wFmqraBbBn5hS7bBCT8GnMdx7KiWosOqqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164006; c=relaxed/simple;
	bh=qdF6rMzMM9AMwjQBqdlsi423QGmb9dhhrnYhgWdquKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HsxIa3rMRkxuK1r2d8PGuoD0V+Xs6I0KR0IN9KdtkMvTuIV5UbQrz+kIxd9MyMYfmxS9EqXicuOJbl1739whVK7Wmh2eSIgORab2TJLuuVeGhqegtKrqv7RtkdeBr4YpK3kNqLRjcKNOEF+HOY3UygtprzHPTZwlyqbO/ABPIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNjZmBul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNjZmBul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A531F000E9;
	Wed, 19 Aug 2026 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164004;
	bh=qdF6rMzMM9AMwjQBqdlsi423QGmb9dhhrnYhgWdquKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WNjZmBulCGcKvXNG9ezSx/fk3gIH4FHuGNtqqEYRTK4CDyx0x7WVwnPRezdK4wAAf
	 Jcg4lg0NUFTpXxPFS/IrRGN+5xYS5/tzCw4APOaJ6d6SJSSCoqWduiMS9lvKQ0WnmC
	 42Xm42GlrQ0LOWiNj7Fl1eGAsMhXbY3YFUPwKC++oQMjEteu4Ktb9MOYD8ggiNybYF
	 ouhSVzUNPmyn2ch3q/OhOdw8hQd+wjJWakT0hS1OIzWSPHtJfCOFY2RdcjHAknP0dc
	 lvoLDD8c8g1+GYOiGcki9GSpK9LIdq0Bo3KSPZeRy4Hy+P5gcrH534wf4+5ePP84cE
	 9ISRKHMUj3Jow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 12/13] modpost: move addend_*_rel() calls into
 addend_rel()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, mptcp@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260819-sysctl-module-aliases-v3-12-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-12-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:26:44 +0000
Message-Id: <20260819182644.74A531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move the arch-based addend_*_rel() calls into addend_rel() to be reused.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D12

