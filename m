Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA851AFE9
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907845; cv=none; b=UlNjs08AzgJfd9Deidhvkl/ThJIYgy5YOzgvvKt/dEJHH+oyWwpYfJgb8n939oFoH2U0Jo2tH97noUcEvVVJJCPgKNAq6paHl28yO0hdQeug7qVQTyTBuqfoX9Z0mGR0TKbbygsfeR7Yha+h26iN1HhqfHzO4H1BIrFgcZL5NdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907845; c=relaxed/simple;
	bh=c41ENiyZGMOhFZY6qI6l3TVoJ+PaxH/EU5cYfu63ELw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DNHpRU0nF2UBrh1SE3awKwSBupwAEAl6EXZIpeN3qA5tzN5MEH7uGametrwrbTH3Ztg6aIqf5mTSdqNEn62KW+ZofZ9pvgYbhyVR3p6OLZ14kAcInzl3ConUryd2gw3AWfwRBymgAUa1+D1X6i80zfXspORHfbyk/Ii4KOJsT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3VJoOmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3VJoOmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD17E1F000FF;
	Tue, 13 Oct 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907844;
	bh=c41ENiyZGMOhFZY6qI6l3TVoJ+PaxH/EU5cYfu63ELw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3VJoOmqrvqwChHvMOf4ZiNlDWJDXxmt8zhGo8mZ4nOxrlPqEqxZ4xmNcI+R4WPkR
	 dsk4e2fxgnSY6NdavcIj5EjIZOBhF1NQeps8pc2/yAo8twbk8gZXvTjfTrVg3w/CHk
	 4dYpAJrBLehEqdM5OD0QKQ5IWz5EQJrxq6ebTiYDi5KlwykUSSGaUL2ZavfHCiQkPj
	 lVEVHBhZ7Vt6nH4bNFwRhB16zGDNbl64KoC+qWxzZ7fY1sAakuofbflBtSJpY8p1bE
	 nfM3Fd17H0BmCQefU72eFwctOpiSkXXw1CrAaPzyKu7pPVc+JQZwz7bctHlMsqSOd3
	 89XodkBfHMcqw==
Message-ID: <sashiko-outbox-170094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 15/15] s390/vfio-ap: Add live guest migration chapter
 to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-16-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-16-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:10:43 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a 'Live Guest Migration' chapter to the
> Documentation/arch/s390/vfio-ap.rst document to describe the details for
> initiating live guest migration for a guest to which AP adapters, domains
> and control domains have been passed through.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D15

