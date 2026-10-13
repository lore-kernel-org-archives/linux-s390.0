Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351724B8269
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931992; cv=none; b=sMEG3j264ip/02/jWgT/42OJ/0/zJIVh3prwOYFKDSWG9E1cOW6KrZrgebEa/b1y8VQ/+S82aSTz4eKYyseW+vSyPbzovs3Fc0ApDB6DyhPdJlyV5OYPT3qVwzO5182dgKj79Fi+O6j2NPCU3SaPFi0p3MUpXXkMTZl4c28tvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931992; c=relaxed/simple;
	bh=AorrHNLALy6BKAW92T08Hzwu0KF+cZRTBi7BCZIwWcI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MQlOe2oU4cNVLuf4Ym5DF0LwAw3vVAh82Io/xHofAhf4TDvjNodSrPvWRO2+Ui9sKBPX4StJw3ZZnYZJfVveVBOwpiXFlZ+ndmgfd/0aazjUGuVYsBEeGzTcysrMitSL4M0Sl40HnvrtsgedIhyhoI6n2I0WW6S08rdZQY9Ro9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PytgU6E3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PytgU6E3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F441F000FF;
	Tue, 13 Oct 2026 22:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931990;
	bh=AorrHNLALy6BKAW92T08Hzwu0KF+cZRTBi7BCZIwWcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PytgU6E3jQfinAui9It7jTEKiLASN7bpTgfw6UT99yhasNOfjP2YhMNRIWG0UbRYv
	 Lu/eZSVbbFZz+9h3m0iyWhW3Ny9Qg3ci3gYv9tnnF1047PVTWVxx3gsXXTuiXvEtqb
	 nnm/IDlyTSqM9QNDN+7hr5Iayl2lpONayRIEj1/flLqOlsvzIgnGSwsv9xBqs7V9hO
	 LAHFnAlo+ZjyVJ6ny5u/fECSMUR0+pZJMjw6bRBOHhJgJ/JiYVKjV4YOtimvGu+C8s
	 aHZPj2lkh+if6mIm7QFB//8peeXiv4JES8e3FqE6FzB+ToJVaEKwzi0DpBfLBu56Em
	 Yv9GQFk7WF14Q==
Message-ID: <sashiko-outbox-170606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013223946.1836757-4-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:53:10 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
> kzalloc_obj() and initialized with ktype_percpu_entry. When
> sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
> because ktype_percpu_entry lacks a .release callback.
>=20
> Provide a sq_kobj_release() callback that calls kfree(kobj).
>=20
> Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D3

