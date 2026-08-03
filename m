Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECF2F7EF2
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746544; cv=none; b=IaMZDbmfS/X0wSykQAKw0kY9gw+CCDF6HNP0PpYS8x6Hsru5QEJcjJija0mml/XzK+DFWlABNWtaqWVUvgHUx/VaJs/HGoLWdK7g/Zn+vIF3F9Up51vbiKarjPpo8Y2wwfMEaSQ6GuPyScNexNNnejq2jWo8NFXcAxbDhL8bsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746544; c=relaxed/simple;
	bh=g2zUQ0+7aLNT20Qi0OZv+r6HBXoUGqs+sh7xMDEtNhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rZUU9GJMqK3eKMoOTbqPNqq0BNz54lJkql1rpYOJD+OGABWW5ZHmHwsA/0ImerJsf95cqaovUhDJcAjeo3TZ4W8hAx0zVoaVp/aBVQWeLWQEbvQ1IOfJXAieWQ8Cmd/2d9vEkmRDorTozxWDvKAsO7tJmziLSgI9Qm6OH0LD6+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ7PZXHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ7PZXHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5FC1F000E9;
	Mon,  3 Aug 2026 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785746543;
	bh=21aUw3Etr0adSPziJgOb02na2TeQcD2kSug2leyqpa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZ7PZXHX8TQxWYPrMtUfGWiIeX/4h5Nvv3Vglj9MUW8FV6K37+4CoajKSCcO1yGui
	 KvEzdTG97GFqC0rCvKnlJXHTGXWlmjOOkFR2miwacKUFdV58OURF9TCULWO0tlBdMP
	 Pp3vAT8K0+FhIbIhGMsoEmNYE9381hL52JkTkzjHWhum24zUdlqoZ29lyecPNjXKyL
	 I9I8+VhguE8yAUpTNnHitXA4GO3LAybSpntT+bgvVEyl7REOKsLtuWpYDR+lrSTTLh
	 hOTozTkz6+lb2+vXrKZvTJR2DekqldSl9+mGj/0MIBo1+RMDzVUiMh1O6BBEYbDODM
	 yb3I4ylQImyvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/5] s390/zcrypt: Improve EP11 CPRB domain handling
 with ASN.1 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803083339.212885-5-freude@linux.ibm.com>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 08:42:22 +0000
Message-Id: <20260803084222.DE5FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The zcrypt_msgtype6_send_ep11_cprb() function uses fragile struct
> overlays to access and modify the domain field in the EP11 CPRB
> payload, creating maintainability and security concerns:
> 1. Struct overlay approach (pld_hdr) assumes fixed payload structure
>    and doesn't validate the actual ASN.1 encoding.
> 2. Complex length format detection logic is error-prone and doesn't
>    properly validate bounds at each parsing step.
> 3. Direct struct member access bypasses proper ASN.1 validation.
>=20
> Fix by replacing struct overlays with explicit ASN.1 parsing that
> validates each field (payload tag/length, function tag/length/value,
> optional domain tag/length/value) with proper bounds checking at every
> step. Add asn1_int_encode() helper function to safely write integer
> values with correct endianness conversion. This makes the code
> consistent with the validation pattern introduced with the rework of
> the xcrb_msg_to_type6_ep11cprb_msgx() function.
>=20
> Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within zcrypt=
 device driver")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803083339.2128=
85-1-freude@linux.ibm.com?part=3D4

