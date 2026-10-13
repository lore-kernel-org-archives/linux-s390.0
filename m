Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124C565115
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931957; cv=none; b=seUxzF5gtNJpXy29+vyeTJRH2jDP9usNQyhznh56X/3GTORoAAbLovAARfJnX9zGOMaEoetRJ+eUlUoQ5UIna/CgLX8NCmt5M/96T9zafFvbamH8Pl2UTHOnHZ/7JcSM7G9ahuR4Xn4KnIQ/V2kmXrGYhLIb+xMHclTvkAegZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931957; c=relaxed/simple;
	bh=+r7GGNNyVqg0VC7qumT8at3ukzlTvpSihITWaNFLITo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=L18muWypxK54AtoIS2n2KDKaMOCcLvUvh7Ixfsled73JTpizhhhxTD3m6sWt+ZAyI+c6Q1yd40yOwInAsb3GxnQqBVThzQas61EovHhEtP93dd1OQzCvQvVJmgu8VIRbRxv4cokR7tELJUnOChFHdnHkzBmHKXRgzf+yTMDBz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGJ1pKrh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGJ1pKrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E3B1F00893;
	Tue, 13 Oct 2026 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931953;
	bh=+r7GGNNyVqg0VC7qumT8at3ukzlTvpSihITWaNFLITo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aGJ1pKrhqzv0lJJVGCqhjW9gDQmmVoCu1E5KwlMofK8zUgtuCBCROKfSittnDpOol
	 Va/nFjTvZDphdwI7KLpMnZTuUYK/7chliwkhtmckYbfr1tp2eMPGgOODHdnqe+u/PY
	 zUzN+pHI/+/3XCKiAs8q0o2SOtAN+ROXrbZLbi/uWRO3zJv1vU8AQD4YfnOFHZT9nE
	 hbll461RWYZEhYi5dPaO00mNNo6KM7X3eAQ5ausVsKMTsdIyKjygpJ3aIkNlj5qS02
	 Yl23J3+BDesnlDf3n6pqK1aABz3ajkOBPL8SzkRPyWDQYDuD5tKvSh8OyerDG6PBP+
	 M7pfBWXaRJ/UQ==
Message-ID: <sashiko-outbox-170603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] xen/sys-hypervisor: Add release callback to
 hyp_sysfs_kobj_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013223946.1836757-8-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:52:33 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> with kobject_create_and_add() (which allocates a dynamic kobject using
> dynamic_kobj_ktype), and hypervisor_subsys_init() in
> drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
> &hyp_sysfs_kobj_type, which had no .release callback.
>=20
> Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> kobject release behavior.
>=20
> Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D7

