Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1E3C76A2;
	Mon, 20 Jul 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539385; cv=none; b=lll0WYmwJX9UX6KZHBBLCdbJMW/iD4PuKtliotcZMjqet8eg0+KS7lw2pAuVKaRHDKZkPybZNFI3x18VaqhqDZB2Xmj/emSWpmNz5Rr/KRoKxDFR09KEgPIWDEf/pQGz6MjOtE+oeYwSWAcvS5FRaYaxtvl/mhzZEBCnZhAiUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539385; c=relaxed/simple;
	bh=uxTilCazAdsvHYjpVGETKxBjgtfpBJla7McqRYwl3tQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=reIvEfj7ctVasB6BCLgrO4yNCS+uYlQu2cgpG59zHR1NunBHKXoRLauyVnWPGrN9Ye+PUB/kkEcIdp/fVgml0cUH3WGSz2drhRhsolngeT91TDpaTvJHI8o5gzzPFwswA5sKC/ON9+rTA7EoyopHnbewS8eiwtPynY/1HmKC+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqjXgYib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqjXgYib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D791F000E9;
	Mon, 20 Jul 2026 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539383;
	bh=uxTilCazAdsvHYjpVGETKxBjgtfpBJla7McqRYwl3tQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EqjXgYib8VowkZK+qtfHjlQtBYskgMP29o7WcT6dmLjNs+cgb/cYzeYPshBPIJ1/2
	 +sM8WCzeh4K6cPyg5pkR5Xba5FvtkEjlf7AveJO7loxsTd0bXIgSaeEf0TPbJtP0Ds
	 NBGCNOEi5sgmPuKoLImRdgXabxf7viVSXb7LQIoTridCVePApaKsaR911mXXGiTPue
	 3+NBv0Ru5UFVzioUWgvBwpP91F0zfRQch/pjuMwdth/Kxueb2IKt0rHli3UffVEO0K
	 nWrPPzY0kwc9ofL9MIi70wfEti3+t/43KBwED3+Rh4qMkjnCi/7GfFdgJc+Ux7Jqd0
	 6NPmmgoWpI/hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/8] s390/mm: Fix handling of vmalloc area in
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260720085834.898025-5-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:23:03 +0000
Message-Id: <20260720092303.96D791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Secure storage access exceptions in vmalloc area need to be handled
> separately since folio_try_get() or virt_to_phys() do not work on such
> addresses. Given that there cannot be a valid access let such exceptions
> fail immediately. The kernel will either fixup or crash.
>=20
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085834.8980=
25-1-hca@linux.ibm.com?part=3D4

