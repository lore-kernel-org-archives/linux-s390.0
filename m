Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F766440A2C
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302676; cv=none; b=cEo/e2oZJjkY8edM1rT8M6fH2v/HSOSnqdtFGpvQyDcJs4RC7kmkeJXjQl87AvT3ImDZQyoxtp8soy0RXc4vUsou/tUPFQj89MUSjwFyVhKziV67nrp+1tdD3sdYTvC45Y35n2CkrJWp2MhiPD7bHbAdIve8mg6kMBHfSrcsNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302676; c=relaxed/simple;
	bh=sqt/v6FEy34fkqMZV3Fw29OFjrQhgyW4nurFRxYZuCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uqe8CUCzOWu0uefjvocB6d9dGu3fl9+Da0s0VnVuOASTP7juBEsZFYtSMGz+VTeBEZmu8gC45asJWVoWL4JSO54CCQPGXxANh/Ks3cqt3t/XQtQcJkDoFxLqczsq2w3Nk2EFBN9up8GRJ8M7wbithrEPt74ORA1Ph84X/O79q8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/w0MrC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/w0MrC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8278A1F00A3D;
	Fri, 21 Aug 2026 08:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302672;
	bh=sqt/v6FEy34fkqMZV3Fw29OFjrQhgyW4nurFRxYZuCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/w0MrC1/S9O1XjT9bJ1Qgu58rfdrzDqhdGx6IyEwfJjA9e7z6RD2bDsLj2aRGPgo
	 6V7q0iyOyCygvg43+g9jPRDW3Ru5ow8FJU9ptROpkdZDRqvUf8zD1UgK+3qW2isBiF
	 M7cDlrmliwtdBxUNzWm+41m+DuO+WTZ0tg7gBRBxhdp0sK4GHqNWlVlEz73vJQ4L+8
	 5iii8wziiX8pEIAp9ZPzWVXUGp0s4aQvCd7D2J6SOa95QGwzCtnt3xD7XSYrp2rCb+
	 g/nkbHXLCtx4NBE6YIuOk9tja4H1f3BdNpze5749opjizxZuhAdGoJXjPAcFTfS/Lp
	 WuXvG3nSJs0/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] s390/crypto: Fix return code handling at
 skcipher_walk_done in PAES algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821084648.23222-2-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:57:52 +0000
Message-Id: <20260821085752.8278A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All the 4 PAES cipher processing loops were not checking the return
> value of skcipher_walk_done() immediately after calling it. This could
> lead to error masking when both the walk operation failed and a
> subsequent key conversion was needed (k < n condition).
>=20
> Add immediate error checks after skcipher_walk_done() in all main
> processing loops (ECB, CBC, CTR, XTS modes) to ensure walk errors are
> properly propagated and not masked by subsequent operations.
>=20
> With that comes a slight rework around the skcipher_walk_done()
> invocation. It is now necessary to check if the walk has already been
> finalized (walk->nbytes is then 0) or not to avoid double
> de-allocation of resources held by the walk.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084648.2322=
2-1-freude@linux.ibm.com?part=3D1

