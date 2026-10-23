Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779213;
	b=DrfScARWYcHmwWYbnpdIus5a1nCtkf+zHVEqazsLYFOwwI2lsPiL+0zZRDh84zVvMLUa
	 jmZbrvFIC20rNltmWfu/isF2nFu6xYSrps9akn/pBvz60xBT2E2i6hmdjMG8IYHDeDvwz
	 jm9TA4pyMV3qhpS0yfSWEEAxrJ9lAGdiND5XWzE98NgoNte8aTBbp9nhXqlibbKdXIt/n
	 e95Qa5ClZ285EtTXtXhcax3FgnLgo4zED7TsRDSYEjJmiN9A9oFCWDQxmWeE1KKIObyxi
	 8f2g3cCJlWkPB1INItGggDWtml+mhnAOAy/5kZg6M7NUFWHFVUmpWbqBUVR4W0Ks9bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QAs8r20D1y9UA/bfUJ7mdNPej26uyIMtMdVri/LvteM=;
	b=O+Aul5BYR3AlXXVilAW0G4kbZkMD4tXiK13HC3uOqtJhSthf+U8XTBJOEO34ZGqmrwWG
	 jjXjM7zZmRGdeVASzi00S6OHNK8Chq0YK/YcA82N+ePblTWw4BR87nZIVg5W2OqTEMOF2
	 275goYS3VACWlhE/aOEoX/+KLEMg1w2S+VAQeZyN5EpOiDyNZQaCGAthSOAbBY5soDyDn
	 DZGBVd3H7nVOnMHFX92z3+ZwGkVhdWmUqeL5CQXgL0SicPXZvykdNTc9EjTvtNTBBV++F
	 yRctiX9GaTAeIu3q3NhBGNbyiI73GBKVRCpObPm+idAVUyqZ0hWk/PuNPX0Ld64A8uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gp1gurF4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D637606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gp1gurF4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854871F01825;
	Fri, 23 Oct 2026 18:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779212;
	bh=QAs8r20D1y9UA/bfUJ7mdNPej26uyIMtMdVri/LvteM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gp1gurF4MmxBCXpgvk2ddrPTXStoeQJQgnlIiYDxvf1qGcPmNf1V1l4r+jFu0Y+gi
	 14dGHo65/VNvYHBzo77LTAispRoOTHiuegFimWbXY3nx+ZjIPwpuyVSDwRGChIT2O2
	 ukZVd0HN4ye9ivLdjia2ZQQ4/WdLGVgyW6NRvt5pv99MlqFEDLjt2CEjRCzjePJ6i7
	 gq+A2XLrmJb+LRNWwfwO8YWJglrVY/5ebb9mIYTa+XUjcXuYKAVhNLsiNAfChWbL8z
	 BF0djhQNpHDQmISNqR34Qnq5aFKl24PBvkSMdU/ng5nGoYD4Zo3SZjOsFvMTIAGetv
	 pIFwPtP5kwP+A==
Message-ID: <sashiko-outbox-183052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/15] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-6-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:13:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Implements two callbacks related to the current state of a vfio-ap device:
> * The callback that sets a new migration state of a vfio-ap device during
>   live migration of guests with pass-through access to AP devices. This
>   callback is mandatory for VFIO_DEVICE_FEATURE_MIGRATION support.
>=20
>   The function pointer for this callback is specified via the
>   'migration_set_state' field of the 'vfio_migration_ops' structure
>   which is stored with the VFIO device when the 'vfio_device'
>   structure representing the mediated device is initialized.
>=20
> * The callback that returns the current vfio device migration state during
>   live migration of guests with pass-through access to AP devices.
>=20
>   The function pointer for this callback is specified via the
>   'migration_get_state' field of the 'vfio_migration_ops' structure
>   which is stored with the VFIO device when the 'vfio_device'
>   structure representing the mediated device is initialized.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D5

