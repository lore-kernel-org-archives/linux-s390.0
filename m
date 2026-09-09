Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835F47AF6F
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944456; cv=none; b=ot/2oEfblCK2cTsJZ2+hhKAL6ZiVETU4Xxmy2k3TWtYg+Tk/9oxXiyvwHAveIPDav/1NFWlVNO9rs25U1uYHt3wFYKty7Tqc+IG8PF1B8Sve1rguD0Ldzu9xudjasRvJzR+6x/NIs6TS0XJn4K0lf5pthVvbEI1JDu80d2dSDbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944456; c=relaxed/simple;
	bh=tVy5HQGQqr/4uSG8EuFAwbmCv7qXRpEnjKUl56oENAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tbi/8r7RZ4fyHSbWHh81ftBPx6PvnpwaZGs+yM+jOKm1HVzNdkd79gYYQ7Z448Ht5U3szixAx64K7hg0UmeCu1S5JcoVi3pOn4KoCLTjoDgHl/8jtwpEopGp79fPU1zssaAJflp4Glrhc34uf9uzJ4FTiTvTK2hEuXoooWADQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaCcHR4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaCcHR4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB201F00A3A;
	Wed,  9 Sep 2026 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944455;
	bh=tVy5HQGQqr/4uSG8EuFAwbmCv7qXRpEnjKUl56oENAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KaCcHR4wm9REx01gSnPq7GeVMLPEZn+l+x0BGsvoBnJd+/O/zCmc3yyWToVZG4/3P
	 fKYf5P2yBDBVpvU/j8paPxQGpAba9OQ8tEN2Mjur6uemrlGtvTDJYpPT2i26pzvJsT
	 Q1nFVbUR3B6l2piYNbc+MwsfQH+sKKPlKt6YlRJgEUepu6LyG6362ZjceoiGFOBJq2
	 KL9+JMDAFyoh2KqgGEz3uKagcs+ChwZmY/Meb3J3Z62ijzPMFokkvhKeNXDVXwJ9YX
	 zgUs167/BQArD9X4PRsnlMftXsDKgxairJX3aoBzQoVpO67ab1q6rE+Ppxd/vdy1ra
	 8NJmgXxacc+SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] x86/vdso: Move vDSO page definitions to
 asm/vdso.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-6-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-6-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:00:54 +0000
Message-Id: <20260909090054.DBB201F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Most architectures define the vDSO page macros in asm/vdso.h.
>=20
> Align the x86 headers.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D6

