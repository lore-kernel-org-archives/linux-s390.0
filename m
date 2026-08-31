Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710582BE639;
	Mon, 31 Aug 2026 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204301; cv=none; b=R5Rq4tZaIZpn/9OAd8HLI/rckEFmVY+BTngkHep5Yt3AbFrakGhzjge2c1uQDKPcaNzUk4YM2sxgNlDUcaeurpRTTFowDpNzdLXUqhyjNU0456FWZy0gJXkqfW6XP/Lz9w86imRyTMs2yirGLS4kvRHFJgaiOUqe2JjdhUbkLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204301; c=relaxed/simple;
	bh=b+8S9nTqkLaybLGZ2YI9xp2zZjd50mvfOfDBRDyLR8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nUBCJGVQAM7VqDh0ZeNO7KHeTIz91SjG9y0G6z4SUOIImk3HAz2kMZpaqdzSFvUa2bpcgMLGabPszOlytbpM/AtX+taqjOAZCddZ4qfnzo1QxCnV3Gv3m3gSiPMlCgppKBIjqxFbBYrh5C2mGODy98LnfxLFoTwq8ixY6ccVgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBqHJHzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBqHJHzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FAA1F000E9;
	Mon, 31 Aug 2026 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788204300;
	bh=b+8S9nTqkLaybLGZ2YI9xp2zZjd50mvfOfDBRDyLR8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBqHJHzKhBpV51+LEEf66AZjbGydKMC2nL0Y2OJVmyOCpBG+fr8dyrAqnWwzPEXFD
	 2jhuUE28TxL6KbU8UY65zLQgfFVY3B1WRTEzoOh2bqcTXp+a5zd5u3dpBJSIStsPmY
	 WEx5anqEuWe6WzN4J04A++/SZ+w+ClhVShN7wPzm0L7sXlO4kcYoNC0ag+77l/3L5O
	 Stn8C5xdnhGQ+Gv9rOWRclqhadbk7Lf9GetgjwGopoBWggLINC+AKxjHG89zKU6mb9
	 Z55Dk1bvGoX/AVBeFJwCBK++JI3OjtXHg1HQFjrFivHE3cOOlfDVYMFZe5Nq+qq3cb
	 Tmc/Sx+AK6S9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/20] s390: Add functions to query arm guest time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831145536.913567-11-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-11-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:24:58 +0000
Message-Id: <20260831192458.F2FAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add functions to convert between ARM guest time (LSB0) and s390 host
> time (MSB0) using new ptff function codes.
>=20
> Co-developed-by: Nico Boehr <nrb@linux.ibm.com>
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D10

