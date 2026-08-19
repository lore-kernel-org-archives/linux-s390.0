Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DF3B813A;
	Wed, 19 Aug 2026 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164421; cv=none; b=dupZVfyJvQ3myn2zt5EI+DwOsWV1EH3z+0q9E9PunCX5tUMWJH5ak6+DO8Bvm7CRa37lbxDNkkRjaTsovMqj1ajp7YUnh/oCx/w2h31UU7ryCypmP6edqvyDaTQCvqAUITFByaH0JahiyalOOEVSrZkOZTPayougfeGu4VrylzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164421; c=relaxed/simple;
	bh=/FZtXCT0cmbjDl2OnyA+g6TBVIzvyY7bDuxu4cAW3DE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HuydGMGIwUHtQZptxksv08qlw8sOB3Y9aMKctBad+4X0EGXn5dsv25JRR2kfximPm8uKiO7stZynIcFXq7ZTu/Rcres1lLANw/Ek9DxvuGYsAGt1oh1AxLWPbVFMcbtG1E/VBRrjwyoD3vFk59ECa7dpNdFD3kF1oQpTjNMht5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyUv5dn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyUv5dn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4861F000E9;
	Wed, 19 Aug 2026 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164420;
	bh=/FZtXCT0cmbjDl2OnyA+g6TBVIzvyY7bDuxu4cAW3DE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lyUv5dn3qHsl79ZDX+mTvrv86NHA0TfQ8l8pmY2cjvLdzbRV6jKLkOtUSPaZpNZI3
	 +8NeKooWINzQML/YTZ2ndknoIPIF5dfnpDe/UI7xDQ3jh2y9YbS0HZPd7pb4wqzMRK
	 c6C8quNAFydLzHyd9v8b5HtF88zkHa5RAQSWDWFky8atjEt+M1VndIEV0SIpUxL0D6
	 oSbR0aw7ZOLOX4icEjUCEo4vXtdaNFGxelb8UYqtyUbm25aJPGiE7t0W5uBcWMIKS1
	 CSLsFRU2IyMR8ATdRDumYn5q7Dn3Y+cWqr/Z+yIM8TyE2z7fNrTEu1HIVTOkFCZ/l0
	 BHnShqrhAczXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 07/13] sysctl, net: update
 register_net_sysctl{_sz}() callers with template arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, mptcp@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260819-sysctl-module-aliases-v3-7-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-7-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:33:40 +0000
Message-Id: <20260819183340.5E4861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Update most callers with dynamic table/path to use template arguments.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D7

