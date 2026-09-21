Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783449DB82
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997149; cv=none; b=ms0tFmeE9ERsnWCtvvIqzNjJ0P5KKx4AjuBgsMOvTw2qXaA6ltfX37quUjOkx7cgwHF0VePeLiOwiXeyxHjgttzuECIhjVwKub+NHm2hEelNPfj098RrZl4RTfYqdlvjwov4N15ODHB5oTxTif2afTEiSTZEW83jFES8Z7hcOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997149; c=relaxed/simple;
	bh=t/PrczEbQYStTXErK+gk00UTmp1EotMdOg7dp0Nh9us=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P3LrM7QvAbxqhCFdLSclFQ7Yh+DEMqL/lS9+ss/3kwe9/tdt0WN+hcbkrA/k67tfW3nrJtDqGX4xcr6PQnUkEPC6wYmDBTEgYH/f1E4yb0T2jn46ChwA5wYo/1+UsWfQjeB3HXUgMpmOLukdROlksAWzq8QoH4/CmhBuRwblFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIB/IA03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIB/IA03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC5F1F000FF;
	Mon, 21 Sep 2026 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789997148;
	bh=t/PrczEbQYStTXErK+gk00UTmp1EotMdOg7dp0Nh9us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PIB/IA031EJIBqkop/Win9bgr2iG46z0aqVeiezYRuLTmG7bXEMZl34rM6zAY70bQ
	 8b0jQI3IyTILhK5mhCaNh5juewWN9UvaA1WrqcwkSGTR1bEMgyYSVt9lJ0UvZHyro/
	 ieouBhd5/7ENuhCITgO4Kdj4V9LDxhLjlpRRfHnW28yzo3MKLNkRvDhtwjMQS8Bjje
	 GF6xMgAjgUjfqJjZSlk0aGQ7uf9VG2ZwEqAt+w3O+4IBcIRfP5c53rvFsuJVtwMnvU
	 WJNTHHSWVivF1et/BQSI+VrB6zd15n1xHd0KA6FDBEirLvxd9nzeoLeTcHCrsJQbaG
	 V31QPj+TXCs0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/cmf: Fix virtual vs physical address confusion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Oberparleiter" <oberpar@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260921131648.3636771-1-oberpar@linux.ibm.com>
References: <20260921131648.3636771-1-oberpar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:25:47 +0000
Message-Id: <20260921132547.DBC5F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The measurement block address is an absolute address. Define the
> associated schib_config and schib fields as dma64_t to enable automatic
> detection of incorrect assignments. Also add the missing virt_to_dma64()
> translation.
>=20
> Without this fix, a wrong address will be used by firmware when storing
> extended format channel measurement data on kernels built with
> CONFIG_RANDOMIZE_IDENTITY_BASE=3Dy.
>=20
> Fixes: 14edd0d73bfe ("s390/cmf: fix virtual vs physical address confusion=
")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921131648.3636=
771-1-oberpar@linux.ibm.com?part=3D1

