Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A529ACC6;
	Thu, 23 Jul 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831000; cv=none; b=l4ujughoIiiTSIoQqqRFhw4UfbkSdxYR9OT4VsYWyds6YuY0LprRgwILisOva9yBHlRDUn2z7uIq7oJPFNCgMbFjQoZioAN3JL7Im9g7qHC2Ka26IEpIh3SsFLFpaNh/1F6Oj9lSQ0helRm14fTdolILGdTGKY0TySNp3CtQsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831000; c=relaxed/simple;
	bh=lpfh8tDtK4QDcgTSMrTLzHKqefE9gZk2ZpGo75KAlqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FKfO46anav+InUP1wgbB44xSXZalcC7YeLZxRL/jPCkmUO9+dKsnXVtrm8GN2uZ2og5crdfGg4kJiqdX9e6+46232lmJZ25gau8CWl1d+HIFBaUtH2+pUmdiMFCAxdNoincfvVaW+8P3MySt0OVNUha3nU8wb+gk0WhecxK6f84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzD6diWM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzD6diWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0A71F000E9;
	Thu, 23 Jul 2026 18:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784830989;
	bh=lpfh8tDtK4QDcgTSMrTLzHKqefE9gZk2ZpGo75KAlqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HzD6diWM1UVcN9ncZlFCid+wqsmw0JWOxMB3exfebKpaPHoUkmZ8jy+0j44aNB9sp
	 Fcr+PH+Gb14kTRA8BSFuuC1q+LQP2yC/3U/2VjSVSp8lvW8DyBC37U4J9daYTcoc7J
	 eADbTQjXxc/R2CXABChNdL3f5X+rpOJv6bl3KRbFXPv0vFmLH64INnZop+Zl6dgxhr
	 lHI68sKVaKkW27rrcjVa2IZ0fZs6T8bvozX5sUolY97jCuiqL9EjzdPa+a204FsOsJ
	 +r/MkWbpheStFpYGwh/u3eAWI0Z8AZyKHz6X8OIiLMV+Dc+txkQ7GXSzMMGowqhcyf
	 K55g5YXRiuYSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] s390/vfio_ccw: fix out of bounds check on CCW
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260723174751.1180334-4-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:22:59 +0000
Message-Id: <20260723182309.0F0A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The routine ccwchain_calc_length() counts the number of channel
> command words (CCWs) that are chained together in a single channel
> program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.
>=20
> The loop itself is "do..while (count < 257)", and while the logic in
> is_cpa_within_range() correctly adjusts between the 0-index array of
> CCWs and the count of CCWs starting at 1, this means it would look
> at a possible 257th CCW before ending the loop and (correctly)
> returning an error.
>=20
> Fix this by restructuring the loop to break as soon as 256 CCWs
> (thus indexes 0-255) are examined, without looking at memory
> outside the range.
>=20
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723174751.1180=
334-1-farman@linux.ibm.com?part=3D3

