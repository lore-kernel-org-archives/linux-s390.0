Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150904F85A9
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059877; cv=none; b=OwX5ieRjVDs35T6PCNaH4w1mLOqvf/2LCSZhU32aPDYKsrLl253EzI3idGeuOspuA2w9imBEDLJIC5Y18SlAHG8ghO3YnQSYrr2i8ZZjwA73k8qaslK85SmvpuZEUBBrGZsrbggNcZNreUHUWZ1tEc5Z87H7neawP+lpsiwBOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059877; c=relaxed/simple;
	bh=r1xt1JwEbhGiHg4nMpQfKPnrFGI39C5oEUbBTXpGG88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MIsYAKmSr82PMR2aU8+STHHZ56ZWH99Axx7J456uHWWp3iywZP7ahWWXPS5HAhnJMn4pbAjFv5rzPbhvNH9QAW7t7Mxux9xDJ+OeJe+I4zpzevEwkYx/THLOcOPHv+tieFSn4gL8mGkhnTxxFz6rj7Q1HjJ5N1LaRKrtLmCxlMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxiiitT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxiiitT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD591F0089A;
	Tue, 22 Sep 2026 06:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059875;
	bh=V6Qv75oVnm/LgNE9qWZHWfQu85N0ZcJoblj2WQYbhtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OxiiitT/EByCBCRwp9DTXApUnN0o6UPJV14TOsLiDjmyoYfaOqs8uV9Ace9Q3rXPh
	 ixlWFiG3RDAYPedGaI5XMcG3b7uFZSLs5tehQeGEErVhbZDlRFQvYpTWFBK4sUYAbm
	 YhPBVuoNmDruN+lXNLb1SM2JeFl11ncpTo+9HMuESaZz0TdC3h++hy1DjU/iT2KMWF
	 npQUGWmAcDXtdl8CHytkVf+UhqGmZ3hSx7J6UQjZiG71LZEk/BzeAT31oIOBWInNOV
	 8czIjkLE6lgXHXhN17NuNQd6KO9yFi2UJxQ14OkX/d8844OVsd2i4NUmAqjeweDQEO
	 VbL/k2/9KLCyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] s390/sclp: Make parsing of received event
 buffers more robust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260922064303.524293-2-egorenar@linux.ibm.com>
References: <20260922064303.524293-1-egorenar@linux.ibm.com>
 <20260922064303.524293-2-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 06:51:14 +0000
Message-Id: <20260922065115.4DD591F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Ensure that
> * an event buffer does not cross the end boundary of the SCCB buffer it is
>   part of
> * the total length of an event buffer is not smaller than the size of
>   its header
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922064303.5242=
93-1-egorenar@linux.ibm.com?part=3D1

