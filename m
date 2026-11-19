Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116603;
	b=h9QNB4iqE+VtccZKYbgz1JsXnXhtPLXcWYEF7zU7Mp1nFkIoM/LxPG8qlqUvje4nc5rd
	 jMvgbyImZxcO63KsFqaCxuUAN9TWSHjaaWa/RH9uBmQ6hPoQgH9ja4kUV+PyoCY3cTvOy
	 MdMAzlVGJLHedLqFycq2Sq4s0FNAS2RQmsCY4emZjymVjyHVtXOmf9fojCJLt4McjK+Wv
	 W4ygIxkgnS496HVhFjJSI6PmLONOwYjDFQfnCoZ3CQgU9xx0tzzHWxX8KR+7Xg0aw0sid
	 vWdm8FovWhaTC2eBMoCcJHorbwa63KF5/hPOdjUQuoySjL2hhgA6Gwyy4cRCragJt3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116603;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KohXkGtMapKVLarDx4X92KW2NkuD5LGa9a0KoaLipBE=;
	b=ZL1YoR0F5PwDt7eVpSkBhsV2qlCxMBmW0NWmjStKzIhX9cWmXRMP4rhcrapfxcw/tI5d
	 tagVyCgJYfc9vAuBaV4MPisNbZuHhlYBj5gN2uQAC5WUtjFaA8VGyDBu0aSr2w2a4G8IP
	 kWwPpwlOJWNkQT53qzQqOV6j5suuhaqVueCZXufM3MmiAbdYJ7Hsl29EaEyq5HDmvTObQ
	 ZXsH9hZjDMqKgRJqE6aqAJQmrxlr85PflSvrqbUeVQiTIl/0zb9SrREKKHPGDS2V+JQQD
	 4vcXM37dvRlt54D8KKi/LEARPiEOZ6ERAZtIQoiddCmg6JFvYJtk5wFCmwtaThiM0pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gsf/cjt/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130F606A320
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gsf/cjt/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C271F000C5;
	Thu, 19 Nov 2026 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116603;
	bh=KohXkGtMapKVLarDx4X92KW2NkuD5LGa9a0KoaLipBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gsf/cjt/9ReFhUbYu6kiSaFODkan0PED9w7stAmE+k0GmfEe+hMZwV6FuAhehcVS+
	 0CVjlAqYUGphojhWph8AkTczLIG0Z3eLUyf9Z2tIVXCLA0oyjN3r6adNqLnAj3fet5
	 /KCP2L/9U+g4LU+gbDWDNXHOGnSjzXjnq65lro9ss8KPnxuKvcMo/QT5j5W+Zl5xG6
	 0HvpU1Q4A0W2qME+C1v9DXArjr8EB/XGXgz8Qab7Ty5BwsiMaBjPGWpmmP12PJMptf
	 CCfBnM4BLqdBp8p8/OzfkpWnGcdMiyPzK8Gdqeh0qwbKcCP2WfsYzTyXa8glR2ygv8
	 CoXAPU4zi2VdQ==
Message-ID: <sashiko-outbox-223922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] xen/sys-hypervisor: Add release callback to
 hyp_sysfs_kobj_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119192520.1983406-7-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261119192520.1983406-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:30:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

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
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192520.1983=
406-1-irogers@google.com?part=3D6

