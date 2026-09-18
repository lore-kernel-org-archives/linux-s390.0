Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF647F773
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748403; cv=none; b=hMhUleJ3uBH5xGhnpvCSyQivYYv1mPMH224u2iyBxJr2H/m0Nf40J1453BLlC4HJ8WkNY0kAvmjBdkzXzuZbknSF/T0l4dIzeguptVkLi6HPwk7zJ6C1leVuTqAjtXEBN8ArkZs91U3y0WHJHt8wJm0CSzzmGSefgZTPxRiybR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748403; c=relaxed/simple;
	bh=m3SbDzmXfkLo7cAF6K1HVT8+0T9LG6gb6ftjBjniXYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AhcRyTixZPVap7fZ4f8lTyAjjHzaQ6JPrn2/FayWqHIk2mAMHjCEPpHng+LTkL+fTzBvbJjPc+VaXs7J//M7jsqrvHsr30t43fvXIvTDzDC7jAWh9A0iYsqk1X/vHRqu6YDAW9zrDL+AHcCi9uoZh5HAV4KsOhbiUStiUJrvlc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoGHHMjM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoGHHMjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2471F000FF;
	Fri, 18 Sep 2026 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748401;
	bh=m3SbDzmXfkLo7cAF6K1HVT8+0T9LG6gb6ftjBjniXYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FoGHHMjMWXogH0i7F/IUYlWuYDWjO2zQ2/oJJrYp8RWnw7Ul9cz89R5s3gru+qyhj
	 vjqzwrTo5XbBHryzf7meDZCZKcq+9iaWMYdHqANXfHH5MgoZekFWU78T0wAqbXnf5S
	 xu3XsIT/rtTkshVFiwBx7i4hYzSx/5axr+EYZ9G9AU8lJap7xnOrx8Ny2k95szvVKD
	 8XEg7vuUEQ/U1K3CXpes8qknjYiJ//azS29xl+hoRFCQjz/DyrYvNqKyPQT0C7Um6w
	 1d2ebuQZO6xJLuX7jbbVR5WO1TIuOuOS2V6qj0SLDprCeMpzOZ/jS542WCQHZDbw/2
	 s/lvGTM9Jotcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/cmf: Fix virtual vs physical address confusion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Oberparleiter" <oberpar@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918161207.1756809-1-oberpar@linux.ibm.com>
References: <20260918161207.1756809-1-oberpar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:20:00 +0000
Message-Id: <20260918162001.3F2471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The measurement block address is an absolute address; therefore add a
> missing virt_to_phys() translation.
>=20
> Without this fix, a wrong address will be used by firmware when storing
> extended format channel measurement data on kernels built with
> CONFIG_RANDOMIZE_IDENTITY_BASE=3Dy.
>=20
> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918161207.1756=
809-1-oberpar@linux.ibm.com?part=3D1

