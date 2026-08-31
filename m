Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF553C7685
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170322; cv=none; b=TMhS4hkH2aQbcQWjGLbifNiaV/MqumoIW6j7UqC/vPGYI2WKAlTMlhwuqtiokTIcXjxRh6PM+6oVtJ6da2AXZyDIH+QcbhQpay4+TwnhxNop7lZtdX+VODpXafPJCNhSCzU/6TryARGKXlqwHzXu6Fu2tBwHmRFQxQ7+HoZ3fNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170322; c=relaxed/simple;
	bh=/ubktaWFn/ZdD7wZQzLVYDq4kqq7gZNXbdOThHWBuLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cU9KhroAoim+8s1CNukO16gpxcu1UkddmhJML7B+bo0wqANoxgIsUt3yvw5k5p3h0nJiz2TQMlBeMNhFLMNyP9r7LS13fTId/XHN+Mm20xs4FHz51kTO79RgTdFAsurcNCmmMntiGEphvhZLy+HekSs34DpG73yllthETaBs/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+HoTXN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+HoTXN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A261F000E9;
	Mon, 31 Aug 2026 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170321;
	bh=/ubktaWFn/ZdD7wZQzLVYDq4kqq7gZNXbdOThHWBuLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+HoTXN3kUYBMCTMtKM+q6TUoBKtxYDP0F9tRwK3p5gQgVzwszt2Dhil/qAFPuhwn
	 IlxYWkjXXu6ud7q3Gw5myPQ7vL0r1//xjU1I/kLd4lX1+nHOJhSTv2VpoEh4rHYeY3
	 x8dGrQxQHzhmzBvvAKBXuAv7YbwjbcSdAyQEF8HN4HCbeybi+PP3EvH85tsSbaBxdX
	 IaAfkj3Lw2qKPEae4o3MhjGifQa9aMvPdvx9LTe1ifoCOH7kY5MLqyRTnXw02OdwWo
	 9oo6/cSD+X1RbPO6hc6GT9Ip6rQxI1lhOvfooT3vvqcDw4Lt8R5L6j2cvo7h9dNLF9
	 +s8whXkScfDRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] s390/crypto: Fix handling of EBUSY in PHMAC when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831083838.3703-7-freude@linux.ibm.com>
References: <20260831083838.3703-1-freude@linux.ibm.com>
 <20260831083838.3703-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:58:40 +0000
Message-Id: <20260831095840.D6A261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When a request is transferred to the engine via
> crypto_transfer_hash_request_to_engine() there are two return codes
> signaling a successful transfer: EINPROGRESS and EBUSY. However the
> correct handling of EBUSY was missing and has been added as a return
> code indicating a successful transfer to the crypto engine.
>=20
> Fixes: cbbc675506cc ("crypto: s390 - New s390 specific protected key hash=
 phmac")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083838.3703=
-1-freude@linux.ibm.com?part=3D6

