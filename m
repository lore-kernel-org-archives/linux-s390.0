Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE1408035
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575401; cv=none; b=L4DilUllyOoowXT4nQAz7VtKEFDgA4p9ZpCrm67feo4nZM3VYQx4ER1Zm+Qb8yNp5/V9dPyOmDFMGDcJeIcIX9/CmhfwrHZOH4DbKNsoap7Q7C9XMkK3brnUWHjv6uofmQX7Oj0QhX/mE5YP2Cmx01kJSA6ZBUF0kuD/XONtJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575401; c=relaxed/simple;
	bh=fRjD6qHQkOeiDEzReF9wnZs2JruhEjCBZUkUUbcsZ4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HJ+Xh9sGCT0It5uWY9K70/XOFwoLV9MsaITqlF2gmwMSYTfQOqi9rGWY937WubW6GXwP2DR2ikbRu50q0iW7qpAdT/tBYv0IzhvaVfPdflngFa9qJWtGnnan65R2M4f5kgAb4FCdXimO7MamvNhqPNXxv9VF76Wlk4ZNA/mrE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ0KJ1x8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ0KJ1x8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7CA1F000E9;
	Mon, 24 Aug 2026 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787575399;
	bh=fRjD6qHQkOeiDEzReF9wnZs2JruhEjCBZUkUUbcsZ4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZ0KJ1x8ewjBg1LEJ6nGS69mh6Q+Wsn0BSTFunPrulpoU3W39U2cjFQSkJ5TrH7Gn
	 CNzd8Mqi+0jtRzvPgE0b765XfX65KcZms4UzqXG40s545l7HSz76R5/RbxtXjxCY0G
	 QUtPuPIA30bTHzCTHd9qZS9tTY+eM+72WjE9umot16s+iy1JzFGJsEubRjCCJlVWXs
	 bcL3kXZmO9AJsj3S4EGEyMFJ3X3QqdnIs5NxBeYgC3E2GT5B7Q1jCcFx1JRszH+562
	 xS+tbW0o2ve6F3SNgLb3Xot9u33i6LlL+6XL+uyn2xFOzKGpgIrkMOrrP+YDZkgAYx
	 WpAL2UjePO/TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/pai: Move locking to event init and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260824122307.86133-3-tmricht@linux.ibm.com>
References: <20260824122307.86133-1-tmricht@linux.ibm.com>
 <20260824122307.86133-3-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:43:19 +0000
Message-Id: <20260824124319.8E7CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move mutex locking from per CPU allocation to event allocation.
> No functional change.
>=20
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824122307.8613=
3-1-tmricht@linux.ibm.com?part=3D2

