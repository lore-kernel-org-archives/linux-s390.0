Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A24D8D93
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815122; cv=none; b=gJ/N1HXIbr8dHJMZ9yl1xgYTQEoLHApEsHmHU21A1ffT5J6Bx3Vo+P+/xDR+WTOyCmRZCmIgrMV3WkLXonE9AbCEnk/rq2FCqvNpC+3iJ4daR7sJEchq4+Pc653lCriH6Os9xeJp+y51esjcWfHBHVagotdXvyh9naBGHieYH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815122; c=relaxed/simple;
	bh=vPye3+wLdrrwYgKYlrbEfirAm3DsLRQuu+ivR0Hj5Hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZwUwklboMXXV8ED578lSDYnYX14wVyjwhBMnGa37o/juzx9n6vtkHt7s3xnXZlF04zGmD6SE/Bmq3gVoC61pN934/zEPYgk75t3D8rdG5aS2w8qEi6pl1ZHUFCYpxpK3eCa5Agjs0qX0Zr32bNlcN2mFObfMW8ZAqjNjNY0W1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3711F000E9;
	Thu, 23 Jul 2026 13:58:32 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/13] s390/dasd: Optimize max blocks per request for
 track alignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723134743.672413-2-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 13:58:31 +0000
Message-Id: <20260723135833.0C3711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With 4096-byte blocks a full ECKD track holds exactly 12 records. Lower
> DASD_ECKD_MAX_BLOCKS from 190 to 180 so requests align to track
> boundaries (15 full tracks); full-track I/O is more efficient than
> partial-track writes, and 190 had no alignment significance and could
> let a request cross a track boundary.
>=20
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D1

