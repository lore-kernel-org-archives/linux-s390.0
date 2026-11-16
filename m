Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828499;
	b=aVVojWvw9hNFt/xgpPMgCKp25P3XTN0PeXh3g+DVS3vOZOIVRe8N5F/OaVydYfrZ639U
	 Etqe3GtXK4n65QAuiuFwPBXFyP0sM7RWy8O0NC4k0tB26ZHWELoYdYxcgLvKCmg+Uj0Bv
	 0H+DIIz7N3QHhYghSw1i7PRQkKzkkJpk4FsbGiWC4samQAE3Sr36iHiYWauI34ps+LEqs
	 zj9t17w2S5nr4WTpZ8ywmgoYqB2qhpir40W+0pJth2Ct1dW0lftbtfVH22vbun4Cr62F3
	 EBj9SV3a01XEsJn3KyamVm3Pa3nsu3oo2DMXyfOa9xRN8S4viP2/G1OzQYZVeq8mD0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828499;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xPwIntOKVZ2Tob9wWh8LPKSRXPObLA56T6blWBWG12I=;
	b=dhAUJLcvGMTlr7X8CPaFqTyqrVXKgVa3cfNt0+dfkQM7rHZKn+xXT9dGl29GLOta1HYu
	 KP++81VOx73wsM21BBeY2G/48+ymzv3jFLO1nVjbUY0+Vcm7xRXnViTIdHrmPhnfSqcnl
	 CZAP+4L8Q7gkBapg/GwrLTEkwCT1I4HoxHT7Iq4EvD0Up0NBtptVnC4cymK62OR8YyKtY
	 EnR31yXdnFrOgs4/iDGVD95b/YkTU4nMRDknDOQCM2xFLjQtv2v/SAWHlLLU1l1DF23Aq
	 /iQq0dpUxLHgFxLlC4zEGXl/zRNTLEyaau0sXDAb1XsinFLjEpL0AQthY1sJy8Hd9Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddtQ8pzk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D4606A330;
	Mon, 16 Nov 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddtQ8pzk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459A71F000C4;
	Mon, 16 Nov 2026 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828499;
	bh=xPwIntOKVZ2Tob9wWh8LPKSRXPObLA56T6blWBWG12I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddtQ8pzkHp+cQzf1sOw02qdSuQfAnquU8SZSHiew752FavQ+H5bSAQb0GROTy5W0k
	 AaKPy+NzkwU0htaZ2jVgGbarO41sJ15UY4bBmHSqJ58Ymvml7IHHUHuY9R6pYvPxE2
	 pC3cM98l/b2qiUuiBN9Y4sP08Ll/0+Mnni6DR1mP9tmP+40j4r6UvYMifm4eHsRidY
	 balWjcbNmVFWvFSIgvnoQafqNEeJd6ELQCHCuIjSqjqzOQ4MnhtuHuHXwrkJqj8Ks7
	 NdJkIs7++DVRSHO9c/zXv8Y9oklxohQMs8a2ODjseraPDuerNQZAJ6emNZn5rPhlwe
	 gAx80/c423yig==
Message-ID: <sashiko-outbox-216925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 36/44] loop: refuse files on pseudo filesystems
 as backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-36-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-36-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:28:15 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Currently loop accepts any regular file that implements ->read_iter() as
> a backing file and any that also implements ->write_iter() as a writable
> one. That includes files on procfs, sysfs and other pseudo filesystems.
> For example, /proc/kcore attaches read-only as a loop device the size of
> the kernel's virtual address space, 64 PiB with 5-level paging. sysfs
> attributes attach read-write as 4096 byte loop devices. Writing a block
> to the loop device of /sys/kernel/mm/transparent_hugepage/enabled
> changes the THP setting.
>=20
> That's not just nonsensical, it can be abused. Loop calls ->read_iter()
> and ->write_iter() of the backing file directly from its worker which
> runs with kernel credentials. But pseudo files enforce part of their
> access rules at read and write time against current. Dozens of sysfs
> ->show() and ->store() methods call capable(). Behind a loop device all
> of these checks are done against the loop worker instead of the task
> [ ... ]
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D36

