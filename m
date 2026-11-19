Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116801;
	b=PDxGbppxlv8xhbogo5GMA0xS7Ob3haJjOY1EYvpSL8AKMlWOZgYgt5TgQeHAIewK4n7l
	 f9wmyd3YkeUMKsawX6q1aUFCq7xPkFo985IPf3o0g2SMMX5dovYrMDQ7YKFdsTQ+lgSU7
	 xCfRvPmGEQvAOhuJG9dXlYxOekJkWOPg3vAOwSeKR00nMzlvmwe4T+EyFFRcB5Y+DGlOt
	 tBFccQ2H55pJ0RSUXxalK0fMZsr9x9MszqtjExEZjV1zNnM19e9X9/fJFkxXjzqVgAXl9
	 im5hFr9//vKqYTUesLWza2mdAC4yiz10CQMrcmmFxR06fem5uD6OaDqYh8vyIq706XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uvvMqZ3+D6IigSesG8/1qdoDRMFBxPgyKezwAT5gRCk=;
	b=0kEk6DykiWNLqxG1VBC1S37I920b3BzjXqvoxioTkujVWoOBvoTdLdg2y77yP5vT8c2N
	 JYN6uMT53H2mXhMfnVTZW/yK512CrZ85teAj+PCy01nClOlddkWWTiQW59Xjs8Cwud+fK
	 OUM95z0pv5eKO5N4AeDFh5IRB+I4SQWU10DhOsbvN6rx9AtlvZIrbYpoFAf8q3E0RTq5t
	 qEZwkUt4iWGhhfTMRlLcRPtoNH9rUFCgCXDxyG5ZvNK42TVBcDjYv7cbZNY+6I5g5CgpF
	 NMqwAM3q2AQOS8OKrDuU/1GMyLjXhEC9JkC4A6rPWv0/R19KTmY2OGjAHpkZ6uyhFHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCkMCoM9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06235606A324
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCkMCoM9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6561F000C6;
	Thu, 19 Nov 2026 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116800;
	bh=uvvMqZ3+D6IigSesG8/1qdoDRMFBxPgyKezwAT5gRCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bCkMCoM9Xr2uDCNON/phVbmbk6we1KLYF2t9+uDm39QV8z8ZIEanoYJqscD/RxDvb
	 4oEMJynr5s13NPtdZGDWP8uC7Iusp9+7bgG8LlayS4JWhBE2pgvsmfncnRuWC7kvJS
	 8WRHzf+Kx7MeLpYZcd41TwhcsI584vlpMlrYZJOkIygcTM4LjZrH4L2pbSKpCaN8Fa
	 cLw2m9aCmzYRfMx3OCS7AmLKkdMrmTc0jZW0QskaTKlFOOrZU8qlvl2d3kiUV+vlTV
	 zR4yMQSTWkeSd84bz6orWmwEUvUR9KmdNLhWmjRN0lo8eJd6lnHemFwkGbzHil9piA
	 5Sh8z/9PEWLmA==
Message-ID: <sashiko-outbox-223933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] drm/amdkfd: Free queue in procfs_queue_type
 kobject release callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119192520.1983406-9-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261119192520.1983406-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:33:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> struct queue embeds a struct kobject (q->kobj) for procfs entries, but
> procfs_queue_type had no .release callback and uninit_queue() freed q
> immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
> With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, this causes a use-after-free.
>=20
> Add kfd_procfs_queue_release() to free struct queue from the kobject
> release callback, change kfd_procfs_del_queue() to only remove the
> kobject from sysfs via kobject_del(), and drop the final reference in
> uninit_queue() via kobject_put(). Check q->kobj.state_in_sysfs before
> calling kobject_del() in kfd_procfs_del_queue() to avoid warnings if
> sysfs creation previously failed.
>=20
> Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192520.1983=
406-1-irogers@google.com?part=3D8

