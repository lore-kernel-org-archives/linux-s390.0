Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116785;
	b=TUG3PjPZPM7V3ZwV6y2hUr599giNbvtQAbM05YrEwwckIrPOstTcW9BBSx9Cn+wdEqs9
	 qmcXmJw3Csk5Z7vcdrHQR/trCCy/+jrDm0cGdwfOMt3i1mEGcN6O0VDAuOk2BGTtd7Hry
	 rKZ4q8X4PIXLkBYDZFtrFXyfxXm1lECirb1vaHVqvdTHCoZsntOF1MAhJAO+WPxa5dy4I
	 GlRmVE8n+yUsSFYAVHBpkimBYyo2S1pDfUTN6VcoXMs5DieJ1rQoUnGaaeT2ukLWg6Hrs
	 rGV099B5WffAmDPdETOZR0MArIh2JpF+xmuh4lABKp1cQ1S5DrCJQqX8vEAxnwJLrQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116785;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/5/JW5JeGRLSEK5ZkFN/mc/qxXS5g3eWwxkLxoQkoAA=;
	b=ZYvkbvkEjdlGqm0Pa7MmV3XiezfjcbUMSUOXWFh/45xeOSJR4K5XuoWhcx39Bama06d3
	 0e+yHJe7+C8EIVy4KBspB3zJ1Q4dnT5QDHu8wbZ7b9XK4LGQyrL6WhEaJmCbLkTTo02Oi
	 /gFC1HuaGEKiKmnzd/B6FpWwzJe4o14k7cpwDAeWRcPWxzDxr+B4AjsgqIAoNK4ltDFqq
	 x9ptSecqdqpEU/dBf4jZB/d/kUAVjufaoZDyvP6B0BQSgF4ztKJ1yfM2FtQj9nunGpH7D
	 sxXUyx2hGk7etArwuOzcGrUCX0LXqDT6GHOe6JheTVWYfwFTHO+ieWhgB0KaPy+X3FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzXBXh9O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397CE606A324
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzXBXh9O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2771F000C4;
	Thu, 19 Nov 2026 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116784;
	bh=/5/JW5JeGRLSEK5ZkFN/mc/qxXS5g3eWwxkLxoQkoAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzXBXh9OyOEIbLKFBluUhS+ImUP/t20VTQi6O667kH00fBnSE4/uP9Pxym6oWeYOI
	 aP6foZnKo2O3Scgs4B4nsB67AdwqqHfZFKT3hNNIQEdAaPOZ69/lhYLTxePoK/bOCg
	 ziZj7O4RHImVeQNs684FhiX3ALB/VERtEirMIXVqE7HeNWXdPfZQk5pI6EuEz6xbby
	 i1wGUcBtui8vK5Noc7L5pE8dTt0bB3BYAWIi1PrGpS0vxcDZ4BM0n2s4Lh6ec6Lr9L
	 P/RUx1V3rG7gWWqNAlNJr6jh3HmhQaDIVHpuAyxujG+QT3xPtsRcDCcmziLYmf013C
	 bOnswCwp5N1FQ==
Message-ID: <sashiko-outbox-223931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119192520.1983406-4-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261119192520.1983406-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:33:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
> kzalloc_obj() and initialized with ktype_percpu_entry. When
> sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
> because ktype_percpu_entry lacks a .release callback.
>=20
> Provide a sq_kobj_release() callback that calls kfree(kobj).
>=20
> Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192520.1983=
406-1-irogers@google.com?part=3D3

