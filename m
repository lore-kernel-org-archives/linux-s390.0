Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608C246762;
	Fri, 31 Jul 2026 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505047; cv=none; b=Qd+uZnsb0nOFbXMJgp4ctNaBES9QWbJbBPtyRIPfz4HArAen4wnPVjZLSBlZIw3lMSe8ZryGsV1D4t0D6PgmMYVKhzoO1WjO4W0BblsaAtKhpFlCiGJzdRhmgLvHAx83+waUNpcHPEnf9BX5v0yw7kn6iL4TMZ6P+2TgnOKUdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505047; c=relaxed/simple;
	bh=PTg1fDYnDVa3/9Th4mmBlLteill2zRmnWQ9v+7+UBEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjDsmr9pnaYq6TPsBEhyf5FlH4Ei7b56WkkchrHbE3l+wHRu6CdDvoNt8d0aPByd4zmtU1VAYKZNtdFqScSUccDDsinwg25XK4lbZZcWbmqfTxNQIFyocVH8nVfv1bAqmbhbdxhgjEsroM9+njIM6uQBxnNVXLNl4m3sE4DSf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuvIpcO8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuvIpcO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623761F000E9;
	Fri, 31 Jul 2026 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505042;
	bh=PTg1fDYnDVa3/9Th4mmBlLteill2zRmnWQ9v+7+UBEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GuvIpcO8yrdKCntcRXUw7vGZgiViqUjnX/7Ti9XuFOwDBgBsq+k9yhTVpvErvsWzz
	 ZKHqx27in1A1hv7izLwRld4bTJa7FvK4GG6KYpswZVii+0aiPklmETl4cIxOhqqNO6
	 52B/v0TPYOhfWIoqiocAb0qOmd2DM0z8GRZh/vts6z7gp48PPRhbPfCFU08IgQIsbE
	 /NbyWFU+OyvI5xYuJ1ShhWY/am8/zFPR7YAM0qNCZm/ERwwtn9L32vz7VJ+TQX5da2
	 lnWCqidY5Nl5EWqyhzzkZw3NcFAp6NaSbwARlu/14Q6awXUfLr42W7qwZBErSvAYUm
	 CmINUpk40AikA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/31] KVM: s390: Prepare moving KVM/s390 to
 arch/s390/kvm/s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260731130902.654679-14-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-14-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:37:21 +0000
Message-Id: <20260731133722.623761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Lay the groundwork for moving the native KVM/s390 to s390/kvm/s390 to
> allow for a second KVM module. Move all the kvm_host definitions to
> _s390 postfixed headers. Prepare local header include guards for a new
> location. Move gamp related tracing into a separate file. While at it,
> rename the main KVM/s390 files from s390-kvm.{c,h} to just s390.{c,h} to
> match the naming scheme of other architectures. Cleanup the KVM/s390
> makefile.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D13

