Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0092F1C2324;
	Sun, 26 Jul 2026 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087136; cv=none; b=mcQdLER4R2v2n0pzM2IMkUY/bjITmTwQF5Kv2DM0pttjwzKxuaEX1/ky6JO56OfRToluFGLP7rDtRmb9QTnk67gAZA9ZY8xx7+OjxO9Zp2CjRsfhufwqw5uD6VC5LDo8eX4RAiLrLykPnkQ9EKQA4aSWaRijdcJBGXtDtCwQzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087136; c=relaxed/simple;
	bh=5ehIdUpqhnSYWE5Tj5YvgSNOb72MCY8L56xo0MJqPvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aNRAlwmplOnOR9c/4CekhigPWA00kZPplwMUzOX66UGDHoIOAXwCjxYXPrroEyE33z99v6ltvug7EoPR3TrCKOOYvgvylgmbbPpqTaxfvEC5UQ5mPpFShmtr0E5x+eaNO+Fbg9TuF51dvuCaYVKurC/P1xtE/Qw8VuNhpjYSpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVL749XI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVL749XI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DCF1F000E9;
	Sun, 26 Jul 2026 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087134;
	bh=5ehIdUpqhnSYWE5Tj5YvgSNOb72MCY8L56xo0MJqPvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVL749XItCOBIecWxgOBAbaR8RieJBQWd05WFI61EhlElsJS2fiNtl8sPI37lG+Om
	 lmvzH2yPZgc3Xo/YcNvBzNMtx5YWz/A5lkaJI8WKzEFRkBRpV1Qahh/3UwWXh6jWdV
	 TWF4OZBa9jGRDFV0rhbmmWqp9Do+gicH75dQso7vv6BEKDK2k+JsTJ8XSYYALn2j7H
	 2M2yfhsAwjXiIheP8k//DGcPqeV1WyeNM5+hhRy6efE5T5Gn0zatd5rtZc3F3WTU8H
	 3k3EpMWlq6v8lbFQ+gCMX5ovOAyTpMNAbpzpjmNfcQINbBJ58A8cHBchLlhyDO4Rjw
	 1cgEIJ9VPpL3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] s390/vfio_ccw: limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260726172153.1818056-3-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:32:13 +0000
Message-Id: <20260726173214.75DCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The processing of channel programs, and the CCWs within them, is done
> recursively. As such, there is an arbitrary (but not architectural)
> limit to the number of CCWs that can exist in a single channel program.
>=20
> The vfio-ccw logic breaks these channel programs into segments whenever
> it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
> of segments count towards the global limit. Impose an equivalent limit
> to the number of segments until such logic can be made non-recursive.
>=20
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D2

