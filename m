Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166140DB5B
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778412; cv=none; b=l3/xyMAsalnbw2VXzQDcmMf5ULy4aGnDqUTT41r6CT1PA3CWpC/4Kp5Ec/h2E3/xVr6PHSH4NAJtY1dpcWjikWSeCSSf04XrudNHLTtAqd5jH8XBjDcWD+vt7YSUr6/uexkvEYFlITxpyd7TKjh/WqRXoidvZh2hjk4uB7y21f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778412; c=relaxed/simple;
	bh=dvEhX9R1lsDAv0dO41aNOO1bu/36hYMQvc8Z2clg09g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJOTzipwylw9qywOBM9GJIQxMSHJ54xepRoRJiYprIk/VDd+CepNxQ8GG1hmE3/QpeaXcvjaobO7yoo4nLPEoKqLY1lEZe9rkfvVx6oz6vUkP0yfT5Z5UPqyitbZQVE5/A/I61Pgr/idfNDI/Gjc78bL/ZCcDiVgmkVMvDDtJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTFXD7Q5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTFXD7Q5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7519D1F00A3A;
	Mon,  3 Aug 2026 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778410;
	bh=dvEhX9R1lsDAv0dO41aNOO1bu/36hYMQvc8Z2clg09g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hTFXD7Q5iHf9q1bJRJhIT6R3PfOzEpEQar7DQYcVXjrWay2yz9lBfw4x+ZlhRyKEs
	 Tdak0f1WPdYYoif7PKT1F/ZwWafeiiJSkrjlbEiRLooDUgnwK3A/W6dXQnoBtWj4K6
	 22TkV6OQJ91sabK6EzpqBcO4kSRQOBuWvNsKmMTJlk9yHtOOAcq3NWgzsGVYxDNG9P
	 A9PBBIECKm9Ov/dXqTl4cQlnwHGCbkJwzF+jhAVkTGCzd+/3zrSRkRamcqAqnCQxr+
	 ps1DvpfgEbvjl2OdI9HbJGSOb03ruddi/FyYzGcJEj2KUO72BE3LsGYOTOaFYF6hLK
	 WqF+LZLalolLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] s390/mm: Add __context_unsafe() attribute to gmap
 helper functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803172144.827049-4-hca@linux.ibm.com>
References: <20260803172144.827049-1-hca@linux.ibm.com>
 <20260803172144.827049-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:33:29 +0000
Message-Id: <20260803173330.7519D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Disable context analysis for various gmap helper functions to get rid
> of a few warnings:
>=20
> arch/s390/mm/gmap_helpers.c:80:1: warning: spinlock 'ptl' is not held on =
every path through here
> arch/s390/mm/gmap_helpers.c:116:2: warning: releasing spinlock 'ptl' that=
 was not held
> arch/s390/mm/gmap_helpers.c:186:2: warning: releasing spinlock 'ptl' that=
 was not held
>=20
> Use __context_unsafe() to give a short comment why for function context
> analysis is disabled.
>=20
> try_get_locked_pte() is disabled since it may return a nonull value
> regardless if it returns with a lock held or not.
>=20
> This cannot be reflected with the context analysis attributes. It is
> however possible to workaround this e.g. by adding a another `contended`
> function parameter, however this would lead to the next problem:
> pte_unmap_unlock() is a macro and therefore doesn't come with the
> required context analysis attribute to address this.
>=20
> For that reason also disable context analysis for
> gmap_helper_zap_one_page() and gmap_helper_try_set_pte_unused()
> until this has been addressed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803172144.8270=
49-1-hca@linux.ibm.com?part=3D3

