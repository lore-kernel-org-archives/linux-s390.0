Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D4375F9C;
	Tue, 28 Jul 2026 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210754; cv=none; b=rgZv/paE6FgfHvi/w6ANsv3cWI3tTpVEvRqae574diF4k/FQGZ1hbGAyuseO0uLkfp4GxDXy3pXQxXWyjoBu3mYhyOiBCquo4ijYurPCyZjmzXER6941r+3HPLVZq4+ov0nYZkuVJNTyB6EjVjv+ylWiDFyg1fUO3hxC4utc0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210754; c=relaxed/simple;
	bh=4411BsY2moRINz6gOiravAT9UvPPXQE3JJaY8nOkqx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NIAhGVyZRnmQC9piUShVWzqdJyqzsva+TXwJM8tWCMobBLNws7cAk5qLYI2VN7YQz5zmWm7ONJPbkT22xctB+sTGu7aQK9+k7KW+MSHUwrgM06OTnnXIQhHY1lhFNl5TY6gOO+h37Br1Dd8gJ2pl8/xMaNhNNgbhPuxKjhQ66zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXAT2OWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXAT2OWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F631F000E9;
	Tue, 28 Jul 2026 03:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785210753;
	bh=4411BsY2moRINz6gOiravAT9UvPPXQE3JJaY8nOkqx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXAT2OWTqeEYnPLSsuMBP3LUPyX9VAx4U7iJFMKlt050ssk4cc1qm8p973fgz289d
	 FlUN/1HD0rOx08Kwr9xf8kx6lh1MUelf2xYq3U0Wje5Wl1tu0brVX8lVJTOprRg3KZ
	 R3C7N9ehDHFSld2w50ho9ML7FVIa7wydNgwggPkD63VRME3EJZtVV8PECu0pqXmrIr
	 tI7MfzwQIaRJqRS63euUk5bN7kTBHx9dl+BDu97C175+5gHPhTtxzEtopK6uz737vn
	 Z0l1PYI6RYVbn7wsLSQVdoIV6hDU3RnQ3rZv6IcDm77cKsEhiIlXoM/t117b/kjwNh
	 ADa+DXephVl1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/10] s390/vfio_ccw: limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728033022.2658232-3-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:52:32 +0000
Message-Id: <20260728035232.C4F631F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D2

