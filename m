Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D83914FF;
	Thu, 30 Jul 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430470; cv=none; b=oXnJ+D33XMvtE9+PR6fFd+jrwjvzXNMRKFk8SxG3fi3nJ0mtA7pUYBOU3xN1nrcTjVUYN/9dK99EiwGyLjjh+yhxbMGECiSD5Cm7j4psln4jZREHcaF5vI6k8aUzCmYCyZrhNP7+sNIJXIRsKC2Bp/+5F1dopxcVVNdwJIwuRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430470; c=relaxed/simple;
	bh=cFe/5IOhOjHU0WdvLov5NR5xG8iD4Sbs4os9iVIsRZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UDAZNpi+kmpMDVEEqgfH4AYlIRQ0EIvTaYjM9R5ePkukBJMYoBILyYhC/Lr2NofJlEYjx0tVsOpujLHRre6t0FVfttgpiM4ZGE1PsgHP6IIanKRWoTkcJxKPvB+S1++zbjnn7UlWnUnqBnaBLWYgfX7jLZWaqbr/IRVeQ8J9i3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WulQLtMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WulQLtMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E671F000E9;
	Thu, 30 Jul 2026 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430469;
	bh=cFe/5IOhOjHU0WdvLov5NR5xG8iD4Sbs4os9iVIsRZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WulQLtMn0J7/zfc9jy9kXrBkU1i0LdCyQZuHB5H4BmQRO2AqofJztQOwQShD612ul
	 ySDD+9/4/D6Q2HIdntiBW/oIwEnBgqCi7mzEhpMiGMW+a0Ky05hNlTo8lJ8qmrTFto
	 RKOELaUVqNiAlKZZym09cncCSZCXYzCzrdPs0zs6fKOxzLZYG1uInb91xwfxJPLTO5
	 fW/O5pac48vuv4MvCyxbn5K+SDP+P4o/UCDT3jozi2jF+ZtPAPFT4hIwbSDEt/suU0
	 ve9Nhwj5pxWNtnjABg8M3ZFQBWe5+O+p4THkY2I4nvc+mOzr382htcVqJtYzyODBTk
	 pddID770Fz58w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/14] KVM: s390: Fix ordering when adding to SCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260730162714.133327-12-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-12-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:54:28 +0000
Message-Id: <20260730165428.99E671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When adding a new vCPU to the SCA area, the validity bit in the MCN was
> set before the pointer to the state description, potentially allowing
> for a race.
>=20
> Fix by setting the pointer before setting the bit.
>=20
> Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D11

