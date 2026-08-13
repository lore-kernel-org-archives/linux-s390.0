Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56D31E847;
	Thu, 13 Aug 2026 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659961; cv=none; b=ucPAfkonnc+GyJ/XGI9eMUMi2khK+nc9HppLjbJoGXHu0PJBX95dgrbkgJv0kSt3WHS8GbOC46ojBc50lbtSLVw6OyXOoTd/506Tsdq8CEUxIwZbAWyaPbqvtwWRS+qN5L5nxwZV0aF7c7ZW1L6YIkofaubE77uMiP1jb+Ll6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659961; c=relaxed/simple;
	bh=k2qTDMYiT7M+1W/CgWNyFNxyYgj3wn0UyXyCdqHKUFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y8Blu1KiKVNocqFf37qWf8zrvO9YS3f+Q9XO9Un7Aaezn1X/RkGpuJCRdlcdtL3jWsQc7tuCTd1+R6JANS2RbuIBS6P/7HmSUrsf1tkVxALqNcKAoy1j2cZ8ArGU9H1V9XQF/8Yf9aWORBeXujGTItmBKrXDUs/iVEfOk3MFQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i31mWbmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i31mWbmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9C61F000E9;
	Thu, 13 Aug 2026 22:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786659959;
	bh=k2qTDMYiT7M+1W/CgWNyFNxyYgj3wn0UyXyCdqHKUFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i31mWbmScRnrnaA4/dEuYqwKDvU0+XhiQb9na/5iu6WtpreuO13MYFmeVCRrdqlSC
	 gfupHX8b5Mn2FlZMOLySnVufPh0Bguhhm/z3/JpcbdSpL/9GxXGwGffnb22n/pAVwQ
	 Ywee2SpxjGjnCPBqJiDkfIKENl8J6+TAlz6Fe8EiLqWqKSIYcwJPyMe4qElIdCC1JY
	 wAE+ozklWt647Hcf/PXGC1WDt89UjHAt1uHPeVspS05XUfCeqmrSrp9AXFQVc2qxet
	 1U8gU8wtnztQMuTuVTDUMNzBUv3y470BEMHGLlc7iG4tYG/JZ4fF/F9+1xj8zerIDe
	 wb0cXCG8qYEwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/26] xor: small cleanups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, yukuai@fygo.io, dsterba@suse.cz, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <20260324062211.3216301-6-hch@lst.de>
References: <20260324062211.3216301-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:25:55 +0000
Message-Id: <20260813222556.0C9C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Update the to of file comment to be correct and non-redundant, and drop
> the unused BH_TRACE define.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324062211.3216=
301-1-hch@lst.de?part=3D5

