Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069E3E8326
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935452; cv=none; b=pU4rvXWDRoPRjWogua+8CzB//fRKg6B1cY8bzckrZvED60AhiwrIbyKrHZF7rPYt2SHk+WMXJw91CJKAiVXbA7V3a2hECIBbnqUXAlX0QBBldYGahIN4KuU1A6PIMeJJLPO14dlhHJsAkT7EqEQ7howHcL33sDgqvtHCkVnIlWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935452; c=relaxed/simple;
	bh=6yHU2kBCkKEon2ju2KMBgUVqmUFk//l9VgqGW+SbckY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CpKvXcHIfiXWCi1bnpR5x7pqfgxbXqfIGHq4lUOsCy3jrF2+r2u75KWZuLSscGXTLFhwBNWCKObeUx9oMH69wGn92cyuNmNExY68/c2opsSL30VZyIvrYQY5crlzKENHLUPlFZcoRwWHnZwudu5eErvuABimM+kK0PO3LNoZWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Frm9kLUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frm9kLUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36291F000E9;
	Wed,  5 Aug 2026 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785935451;
	bh=6yHU2kBCkKEon2ju2KMBgUVqmUFk//l9VgqGW+SbckY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Frm9kLUz4LkAaLFwOf07TBkZo+kAzKiMYUF1NkUQ6JfO4unhNQIvYa/khwls8sQp4
	 OuHlfNDjZVD3LKRdZv+WjdLzZXeba3OmEjxeliygv6K+xAhu2Xkk9tHy4z9kwUdhAI
	 wtD0KDguRJIGcmbu/b5dTwrayOOR0HLzdqjF+EWVqunpxaU+I2udc3pdClIc4U9kRe
	 7FjTXu+EvSg9wGGjMM+nZKNnq8HgB2tVccQeRNjEfCVP9MFcCcrNidgbJTveyik2UO
	 eo9G5ys8uA1FIK+zqAFjxgVe9SbcHkmDosfjY489hhsp35vIcEvUVN8r0MiXle3uDt
	 CbXK+0U0q9N5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/19] s390/dasd: Optimize max blocks per request for
 track alignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-6-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-6-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 13:10:50 +0000
Message-Id: <20260805131050.D36291F000E9@smtp.kernel.org>
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
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D5

