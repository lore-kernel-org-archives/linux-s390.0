Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116619;
	b=hFP5l1Yki7EsTzS5BwrN3xqj4zqP8SvdnjRZRd98uPKjtfc1gVAH56RmSqNpPWYEzuiE
	 tE+d2v9gOKosl9C19OJMBdzVMYRGLCqWMGgp/kCULouIAdPgFWa1xK1Lntph+IMDi4u61
	 0POf+R0VmLiNhP0ADft4rh7qW9R9TajpU2WjawJl30rzPIMZ2cDt7yNljYXstkh62RRB2
	 O571U3ste5MGFWaut6u6SQNPqZHMYsAFzpbDP/cIHxKnVTLPMOFUo0PqtG8fsqzrkrZH/
	 dVDnughvxG7yY2XKGakxTpauMeRVXPnq1kC3yb9pfugmHMLUv11SUMXzsgj+N1R0OHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116619;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TdKbeIMoO2nlMw6syndDKHjA166kBKiOeY6M1GrJiQI=;
	b=YsVjaU8AA200h9vaFGGrY57AVZvH5g3a6l6LONiHr0hO4Pj460R3ct+APxtRK/lRinvp
	 Z8CP9SUz8UvdkoDXXK15HgERghOYJE+I2xSueDqt59meXV2lJ4w6HxdWWha79Oq9ZvifB
	 lOjltKGIe0ZM8qOhdveAxRKIIbfpZ2Kp5uAjln+/Nh/RVCDEaY+CRLsNjp3esWmaCZuVd
	 jE65+RkLnZyrRe6xtjn6ChfAsAe9pY4HXay9XLLM3MLjFy1zLqJlWDP/GTGkI2WmVr25u
	 7dzYkxpok46cm9i1aorp+boK2cMC48xpaHSgMTg0mGIt2nymHN9AuYqeLLmLfR4GiVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6bDilFp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725B606A326
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6bDilFp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4401F000C4;
	Thu, 19 Nov 2026 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116619;
	bh=TdKbeIMoO2nlMw6syndDKHjA166kBKiOeY6M1GrJiQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b6bDilFps3opZbDrlwEcQs9TpZSsyNju9frSyvHvCGEyGXbE0mUg09DJbGkdT0QpI
	 m2AThevGawqQzA7SKQ3b3WDgnKZcOv+/kdtSfgHnUXr0Vet60zaJuLHrFxXTdtCx8P
	 DBZpOAbmWZSbap9ykfcBnUDwquK1eyROzMqaWCv4LTa4tQ1bMWixKRs8YHDc7LyfSj
	 OjNsisC6NbPqrnlruzRiHQxU+BOrhHsxnhAnq8QAJwIkgq4wB9/rXCpWR/aZFfJznQ
	 xRpdLVhgGdDzdECII5MLvZ0CB81JDbjEXIRw6q2jwW3p1XHyEAuC7HTF8J/t4NiKHo
	 i+QUJexWxrXpA==
Message-ID: <sashiko-outbox-223925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] powerpc/secvar: Add missing kobject release
 callback to secvar_ktype
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119192520.1983406-3-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261119192520.1983406-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:30:18 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

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
> Reviewed-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192520.1983=
406-1-irogers@google.com?part=3D2

