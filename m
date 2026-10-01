Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157A23CC323
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851261; cv=none; b=Hf1iz3x7Cu9R1tUubbKb6dHyf8GC4VNGW88lInJw8I3QXx7uLjeJEhcWIJU19xMGlXqCfsj0FNEHwge4BfYDUMHXf8kRIonX1R417EklZfzSN9Yarn7vozKg20/Er3CJSvOCtbd1LIcv0PdrpmX/EsGNc9C4Ve5AV5eGAL5O8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851261; c=relaxed/simple;
	bh=+mL7lAV9DsAMpLdrgveO/aRYSpfx9E6lGYTPQtoOErg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VAoovJXc6o13hK/HKBzXC46biopkpW4soiS3Z72Hv+dMt1Z2Go2ANNplysQCIdpGlfcncLk3849dpj5bJQnfcywc+7H3VrBop+GSWFVi65J3eJgTFwih9/woZU2SB7eYVrkEARUx5iJfp8eEw8rN+eaI5s8WgKrNHLPFqU6XFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLiaLKVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLiaLKVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA34F1F00898;
	Thu,  1 Oct 2026 10:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851251;
	bh=+mL7lAV9DsAMpLdrgveO/aRYSpfx9E6lGYTPQtoOErg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLiaLKVH7Bvrl7B3ai/VYOSsoNeIJMeUZfPtzGIZeo/ewrH3Z8eVJpRZP57ulwDhn
	 4g7LEbPxmR4hcwTmVCskiK1gP9dpAHf5JxZQfe5knfJKkAQjUeVD8i1STAZ3/etGVI
	 sfnZJSOOwVuMxlu1JRUhjKWUHkVNoEhD7HNPbB+ZzbW66dCdObOb5D0EYRNxBurpeg
	 vf88b0Wwt2hVbbB15RJG6NSKVPkayu6j0FwnpP3pusOg/f7jMnf8a20O3xRWkp14Xe
	 GU7VvqXvBY4GsdTGeNSKLPOVmcC4ZnpMQ529uBnr8YMO5Ujk8YW2FZmo2xDdzx4MyX
	 TeRF9JnFCZZgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/32] s390/cpu_mf: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-17-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-17-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:40:50 +0000
Message-Id: <20261001104050.CA34F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all cpu_mf exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D16

