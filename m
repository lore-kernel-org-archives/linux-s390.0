Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3944064F
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527113; cv=none; b=BW14UDA1Qy7+c0Sd5AzA+s3aDNPrsCU0mFbDtb/q+D4L/ho/fpU/StzU1ePnWT1pf0LIh7BaAEqSU8Ul98k/q2JTiE31tE14xvyeIGw/P0GFN/hK8SVUSpljUmc1l4jdVJtuLfiNmR3UwVbdPRSohlyQDjiDOHKkZMBMzVEng60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527113; c=relaxed/simple;
	bh=5GP+jSFJqdwRBjdOyGr+j0qigubTuJUxYozpOemcReg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ojAW1gMx+fr3P5IDWVVd1wuYumV/OmnGyXmXyz/RDpt2SSL0zZyAPR2nkJo04tVcpsItO6AjOjZH7ZmVwRX4i21YKEsEsGaJm+jf1hUTepAeORAB075+TNbfboGffDMqAxmZOn9GUxjehEUjr/32lGWx4bFfcSpP9+LtFEhbsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxwyLnU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxwyLnU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B151F000FF;
	Fri,  9 Oct 2026 06:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527112;
	bh=5GP+jSFJqdwRBjdOyGr+j0qigubTuJUxYozpOemcReg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxwyLnU1Kx5irvlYNZg3+mBu7DoL9EbTc+UXcXn0z7vnABlMLtRVE0hTm61wbZbIt
	 v8Uww04kAs750VuZkA888yNnl5tz9xmHqtotq1IxkUrUtPPUsl6yzhvGcDt3zunBew
	 XfRmLvJx6ioRWeFSVS1ClQLItN26pLaWos8LU0AU5YqAZ2UAQoP2TpccGGTpYf275z
	 61SOi5UQUF3j1/NkdJjRQVlEngOhSPlYOp7wZb+MERu9fwBrEHOWlMKU+0sK7Sj6LY
	 ZWTX9znJgm30mzfhCWO3UaY5Y1HeS6xz8uJW8eOJdxyMrH+QQwSJBQaEjhiG19gscD
	 HfKh+XQPTvELA==
Message-ID: <sashiko-outbox-164929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] s390/pci: Add error cleanup in
 zpci_directed_irq_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-5-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-5-ced19028da3c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:25:11 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If per-CPU airq_iv allocation fails in the loop, previously allocated
> vectors and arrays leak. Add proper error path to release all resources
> on failure.
>=20
> The error path frees zpci_sbv, but SIC_IRQ_MODE_DIRECT has already
> programmed its address into the hardware. Set the directed interrupt
> mode only after all allocations have succeeded, so a failed init leaves
> no freed memory registered with the hardware.
>=20
> Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrup=
ts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-s390_irq_d=
omain_fixes-v3-0-ced19028da3c@linux.ibm.com?part=3D5

