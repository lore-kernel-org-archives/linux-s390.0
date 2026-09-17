Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C0399D0B
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673269; cv=none; b=O/AQ2qThuw/rQmaivbmWBlnwprb7tDl1e8Oe0cUi7KFP0RU3bH3HmrAwjQ44e+EZDMQTyDoOkxvJgwoSN8XOwKFCiO9h+TUHv4rfMnO0YTszXP53rEKOuQt67JoXEANLfhPucgXe/lLiOwrEEgEuU/jUMnjHkcHSy8E30kXYVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673269; c=relaxed/simple;
	bh=e3Kg6xUH4jbfHDeOxrpLtfXc/muWPk/9Vp6+daR1EUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qjbm24vHkmO2j5Dlw8xxGK41O2yFvq5t4yTGJaO7uwQn2718C4IXX52CGvTLylVdE/56FnRRg4+fsZiUzR45ahvEYeOkVFyqjszTD1v5plEDlqS1BcpWGaOBOq8xN0K19N0K9UE7FIYWkO8EC6G2MlVinb+FfAobnGZs7HojWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ke6XrNEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke6XrNEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF6A1F000FF;
	Thu, 17 Sep 2026 19:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673268;
	bh=e3Kg6xUH4jbfHDeOxrpLtfXc/muWPk/9Vp6+daR1EUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ke6XrNEj6XJN3KwPqTqv3wGZ3YXMEwoAb7yeQpKXZadwo5FOU0d+4tEalzOQ9S4+8
	 IGFOx2SI589xmS/bNhShVGqAFarKYY8heexpEY3OSS3XdrI/VVtToUCwQcVQXIp/+L
	 xVwxjPG2J0LkQBIatZDUr+HzfGgUY/K2werXs7xZuqVsvJ2QpkM7zmo3iJhPBAsBuz
	 vn8Xf5tM6QNul2DWoiJHW+3n95aXgJ6Tvt01U4m1N9BVxsyXlH9sTkp3+3QnAj1iQ2
	 12CibAkrrwvt/1W3x9A+dybbtDu29w8CIETfn5JQZSbr9oZh71opZWkSVeXDel3pZO
	 KeSV5dSBIFOhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] s390/percpu/lowcore: Add and use LC_PERCPU
 lowcore offset defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260917192237.638324-6-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:27:47 +0000
Message-Id: <20260917192747.BEF6A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Define LC_PERCPU_OFFSET and LC_PERCPU_REGISTER offset defines and use
> them in percpu code. This shortens the percpu inline assemblies and makes
> them a bit more readable.
>=20
> Note that because of header dependencies it is not possible to use
> asm-offsets. However to avoid adding more dependencies to asm-offsets
> it seems to be preferable to use the current approach in any way.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D5

