Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794179445;
	b=kppGAYfcQcf1PZ070t8EQVny4ricZ7GzZhmq145FKEgZzOh4ow5ZK+UZ6X/Af+X1/XJ5
	 RKIA0Un30CZCoSL4N/Js1LYC8PwNYl+vZEVIxnSUW0phAnbvHZYMmD8Lh5/eSrAEIVO7U
	 0UFceGze551YMSyTp4XeJmtRUtoQQII9q6x+i8bZBs5yX5ysa174ORhJsbRf9MOOs/830
	 OEuEouUmwvZ+LDJkJHSlCalJ+rsbqVCsKxBOeMFcJ5IFpu3qBuh32hJKN2vGcLdqCXDRr
	 OY1pOHrV7rUo9yS9rVNmNZJ3yppDbbjdMqXwkGx0kNSi9v+IdxjwotMklXc7gHVnvYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794179445;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SJrTRZvefBM+D9+/dd7LygrzgO1jMHec9WFWbzhuafs=;
	b=XLi6vQPENUwYIw4QXxeKze4XgSony1CVV9stnV4B1ZgCocjlf9WwyTX/eovT41lTjhwT
	 qM5Hd+gyMJomRaVJls+io3aiH33Tg2UZZ6cj8LBl602UmMWWYc3bwZH8smf1+qHriBHCz
	 3Duyrq07UegNtjpJOSp098baca1VQ/660b2nvqXeovKlRwXli9qG4TvoguO+2RSrqziz5
	 +gtjIQiMraD6YY7gFVSzcI5rk6QKrqNWTXNxBki7lBbl130kRyTz+bI3v7AHrRFgmRUJX
	 mV5VrRPRCeGKrOymPP4dOGf+l/TwAbFJxhF6TmUILDOSEEvVplbgpLKYRcQXfjlyUpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgbqD2XS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16F606A31C
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgbqD2XS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0561F0089F;
	Sun,  8 Nov 2026 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794179444;
	bh=SJrTRZvefBM+D9+/dd7LygrzgO1jMHec9WFWbzhuafs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UgbqD2XSdyGktVJEJhI8+QvVyWG+cq/0XfiKL6PYXQjacoO71WmQpzpgK3T9NEgyL
	 MCW+PU/nk2t29laNSG6YPzxo1waBrUXmR3iybjEjV7laQEBl1mK9n4vocFBccU1F8x
	 j5tfv+nVhTD9ayYbH3pP9d7ml5VNKgv86aTSnvuVPM24VoRdKG/Sh9EV2xMnMzesbI
	 Un8OivitWJrCoqvBYuaXCIeM+Q7+RExpdXNOupt3EphzCBK7sK1wOsnoAGf8P2Qkug
	 oTppSKhkwSZAregyJkTePZWKDOFT/ho+EHYl2EIR7zmYMenPpJddSOjHCFBoz2qAfD
	 McA00Yi8UNxNQ==
Message-ID: <sashiko-outbox-204152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] ubifs: sysfs: Use kset_create_and_add() for
 ubifs_kset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Kees Cook" <kees@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Nayna
 Jain" <nayna@linux.ibm.com>, "Srish Srinivasan" <ssrish@linux.ibm.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Juergen
 Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr
 Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Zhongqiu
 Han" <zhongqiu.han@oss.qualcomm.com>, "Alexander Aring" <aahringo@redhat.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Zhihao
 Cheng" <chengzhihao1@huawei.com>, "Sumanth Korikkar" <sumanthk@linux.ibm.com>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-8-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:10:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ubifs: sysfs: inaccurate Fixes trailer in commit message
--

commit 05ad573fa4719a7a6e36bb8dcf3c9060b5c194b0
Author: Ian Rogers <irogers@google.com>

> ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
>
> ubifs_kset was a static struct kset using a custom ubifs_ktype that
> had no default_groups and no .release callback. With
> CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, unloading the ubifs module while delayed
> kobject release is pending causes a use-after-free on the static kset.
>
> Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
> allocated kset via kset_create_and_add().
>
> Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

[Severity: Low]
203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()") only added
an error-path kset_put() when kset_register() fails.  The static
ubifs_kset, ubifs_ktype without a release callback, and kset_unregister()
on module exit were introduced in 2e3cbf425804 ("ubifs: Export filesystem
error counters").

Should the Fixes tag instead be:

  Fixes: 2e3cbf425804 ("ubifs: Export filesystem error counters")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D7
