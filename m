Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428137;
	b=jRiQfKxauYVAHx0Zk56r+cfRMXluxjehrwcRgyxfzFGnjcBb2LvRy9mwBT+8A0nqwQMx
	 5bSK7xUp0Bsh/9OuDwAcmKrutj0pS90eV7tjargY05J+JD+MTuOdLWAfmzDJsHZ17RsBy
	 VCFBDUwI4DJUeplrxG1IWbAyazkdbh75OJ/h8kDreyyzQn1sOs1nYjsi0S8WKk+sXPxgx
	 KFxwBnVVNE+EnLNCROK6D0K/nKxlNi8LWKnEmgXl6CgyMBuc5DfktW9Hx6mn+IFQEsk/9
	 5Nv+7L5QiSluy1kgFync1DqTnepcklIxl64Gsnm/zSBWy5r3hmgLq6pDR1pOi7bt8IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428137;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JhjqMFr0uKH7XPVA4+locYNoMZLERn71G7g/ryNeZdc=;
	b=JJ+At+jIZxZzmWW2/8gU+eKLlgQzPhrc/OQGEn704tGq+y8wiRoxBphRSbFlvkuN2z8D
	 VRi1djmw1kw4jeT18krpXEY/a2Oqq9dGleQDsxz702R98neGA3oWEjaYbRCEyXTTjb0sP
	 zc34g092oIsLjaNuRUIs3S1+x7loTCAtyxrmENIUBH7uY//mOYrxmifLMRXhn+W1mgIIz
	 9LDkdJhySxO+yeJRl17f55Gbjz8UlDebfJSGWEp5iPrXp5KkSlx/IbHI65oCaWg3509D8
	 Kgyg57/yvHLsDaq40f2FNN2NSvIumVqJzZu/Ai3LkJej5T/1Nx+AjeJifN7wWvhxxyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCC3O685;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EB606A326
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCC3O685
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9016B1F00A05;
	Wed, 11 Nov 2026 20:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428136;
	bh=JhjqMFr0uKH7XPVA4+locYNoMZLERn71G7g/ryNeZdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCC3O685eVWgy2QaiDTUIThoIOdhuXGrmmGlk8RyeVILFMxys1geitd+AAC3H951A
	 2r6szXmeuKMZGYQ8VffAAWNMMl10pC4Q5XCNTYwTXpkbh/Y4oUrbK1O2z/Fowt7FfX
	 itE8LOvIsXQf2VoSJRL3vk5ifPecIavOjhk12eMsYWcgNFovtjLoLU1pQsWaouWlQy
	 +okqIHIfLd+JHIfAPWuvFnoM1H9KvezZQK28HLert2jBt5PZ5j1X+Rsk+vrBMJYDcG
	 FQ3O+9Pa4aBrQKqvmehO46hWDjJupJnuc7/rvSmFH4lHJnxKUz9S0EWp83SaVrozqP
	 VU3vlLdbkqcwA==
Message-ID: <sashiko-outbox-209626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/14] s390/vfio-ap: File ops called to save the
 vfio device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-8-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:15:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Implements the read callback function that was added to the
> file_operations structure for the file created to save the state of the
> vfio-ap device when the migration state transitioned from STOP to
> to the STOP_COPY state.
>=20
> This function copies the guest's AP configuration information to
> userspace. The information copied is comprised of the APQN of each queue
> device passed through to the guest along with its hardware information.
> This state data will be transferred to the vfio_ap device driver on the
> destination host when the state is transitioned to RESUMING.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D7

