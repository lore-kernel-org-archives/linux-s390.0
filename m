Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB23BBA09
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295698; cv=none; b=SS29o430oVlhkb9S9jRlDagyJ1dO3TIy4sqc24PHkZ/hJ2hj3V71JRmVE6tW3WCM4KBOGBLR/pffxD9RxfA5R/1GnM5cf9v/HSC6Qb9zteuat+ByBaKuYiz4tmYRU4YuaDL3z61jLzXvL0nCsRLhncA/vCX87xzKXEAEYWIwhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295698; c=relaxed/simple;
	bh=LLNDPUliqm5Ff2QqlNQp3purZQbhc8EYVS9I4rjZA6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Il0GYkx3J58s0uT5gh4XbdczVNzYttN98Cs2wDSW/sP3hrRJybkxXQBOl1mtB9vULFTKSWUgM6Tk+otbT+3pfeclE9XgeaypEYfIkTbyKMzSy8qacpFfnuAd3yy2+X7QgzZxwJ2CRkeZa4rPDd3xVTXeFDPI6ZIJenFV3w7uR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwFSZNae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwFSZNae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EA91F000FF;
	Tue,  6 Oct 2026 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791295691;
	bh=LLNDPUliqm5Ff2QqlNQp3purZQbhc8EYVS9I4rjZA6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwFSZNaeRUHR+PoVR+9seAQv6+hD7gVDZgPeNWx+LW5mcNO9mMBxNh8EA0bVRUUEG
	 23DQ0LHeFLqAi1Du9FDYlORwBpZ2i3hBb5onXlxcGnqU/EFH1eaYXYRNPeZyyprvg0
	 yQRY4xPD0ylH8h+r3MydoRvvt983yy9RR9PcIHHbBj4ophLquf7p7A9BUSmB6kThRf
	 lXzaKwldYAgmuvC/hTBgLZhVh8McRE+IPcrY9ZYm8XG4vnVGPwEjzv92gb9NhVNWQe
	 EmeCkjnXHYxG7pCX6EBYqWvduTkX7NKqU2J3JWmFr551B44oShp2NAwnliIi9fVhqt
	 ecHsDlO9wlLOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] s390/appldata: Emulate virtual timer with
 delayed work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261006140113.3128582-2-hca@linux.ibm.com>
References: <20261006140113.3128582-1-hca@linux.ibm.com>
 <20261006140113.3128582-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 14:08:10 +0000
Message-Id: <20261006140811.69EA91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Emulate the virtual timer in appldata using delayed work: the work is
> scheduled for the minimum possible wall-clock time until the
> configured CPU-time interval elapses (remaining CPU time / number of
> online CPUs), with a minimum delay of 100ms. The work then reads
> per-CPU statistics of all online CPUs to check whether enough CPU time
> has elapsed, and if so runs the registered callbacks.
>=20
> This is slightly more expensive, but allows to subsequently remove the
> entire vtimer infrastructure.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006140113.3128=
582-1-hca@linux.ibm.com?part=3D1

