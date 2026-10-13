Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06F3CFF65
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931646; cv=none; b=jLESD6zngNRMXb/iLUcDyt6FCZZNDJUCzZW6mPyv+p+1AfW1Hn3c1Ub1F9zCChl96KrTLmmDvmmPallAljfBY4Ju56kQ6HJnAe1/dTEjHnaJF3Rjb1spyYpZtq+wTKpwG8wjY6tIfm5iL2hClYDV1SC3EHnz2u2D0I6UkooQdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931646; c=relaxed/simple;
	bh=Sh/xT9fjvGG/HMgCuTvo8xcNE3j+1Fke3DErucXbyOA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BjrZVVx3UGZfX4so50RLebPIzr5VnKCGGMI0VqSD5BNUZomxLHc/j1yOtl/8B64QLbI9/KQY4j2M9eRDX/4IxHbDwatyuCHNAfs5ZePnhLhnDh3UvvQunLTGDDsUxhnYd2hpCDjtttIMJsPQCSyUjL0TNCKnETzRMQJXkdzQ2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px75vex2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px75vex2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8BE1F000FF;
	Tue, 13 Oct 2026 22:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931645;
	bh=Sh/xT9fjvGG/HMgCuTvo8xcNE3j+1Fke3DErucXbyOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Px75vex286ykMR8luneoM4IX/GVAKQjrb+aUh/RmhbvFnJI4tZ9oGCfef0Cvno9xq
	 tMHm01QozWKJWaYHS1zy4RdqutExO/eX/mzwiOazjgYCxggs2aG+tnTGW9uFLobopq
	 XXr2zY2gAl7U4e2zxDFSprJmMPhE9FAFbblrvdeWSqTz3NK8/CtBpouOFnH8HLoxwf
	 3q9GoM9cVZZq6VdJji41l7Zs1PvkDutYYyvlPpD6yzYNA1DWm3UFLYqAHdR8fK5O2N
	 IdVbS2XHbRA+E9j6sqGU8o0PiaNggN/u/1BRAjLw+7ZuE7IWbk1qP2tXOj9aZ73k5K
	 GCv9oMg8EVhGg==
Message-ID: <sashiko-outbox-170596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] powerpc/secvar: Add missing kobject release
 callback to secvar_ktype
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013223946.1836757-3-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:47:24 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In add_var(), a struct kobject is dynamically allocated with
> kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
> sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
> However, secvar_ktype does not define a .release callback, which results
> in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
> when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).
>=20
> Provide a secvar_release() callback that calls kfree(kobj).
>=20
> Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via s=
ysfs")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D2

