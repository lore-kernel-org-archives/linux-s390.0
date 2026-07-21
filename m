Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73F414A1C
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660454; cv=none; b=fCkg962eVAUObIJZVK/n4cOhet1uBpaqPD5+yXXI4pUb5gmC+a4LmctD2maPIP0HaVI0gw8g4C3n0vhyDETAcMCDM+P2PnKd86h+nd7K4dY1awknReWQSSvikhHC9DIjXPxbDtZqsz0UPhrCQBeHJxTF1w/yDtOYks+FvFnvdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660454; c=relaxed/simple;
	bh=I7Wt4Gvy0qdech83RugWXsA2sHU2twNcO9+SjFkTllk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cvmE1uFTIrMAgZWGcGtyyFa9wqbx1ym0N9HCyOe+1OP3Jmkc2kHPFua2rAFPia+teqcbpug9zUKrJaBGigRbirmNo8GODxd/uVq9fHs5gKBxrDj6hqSWkK7XBQ4sME4MTLhKh9vz3oLBs4KFv/gw/750pNQnv8i2HAC3AT7haSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYx35mn1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYx35mn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A7D1F00A3F;
	Tue, 21 Jul 2026 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660428;
	bh=I7Wt4Gvy0qdech83RugWXsA2sHU2twNcO9+SjFkTllk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYx35mn1nlVAbWzShO2AA5r4SRBVhtV89kjvve/CDrAKm6J+XiJj36kSA7/3mP3Dq
	 Ub01vmF8KzOCdskIM+1gW1VUvRsFqyblor+UWPu1eLAAIY7z4hk3zHz5xMXGymwNqg
	 RaM6irsB9IsPAN0nag646qU8tkf/o7jROkfU+DfHNkzef8bw6NMc6Srgps6hAeuFj1
	 bFSydVR89g1/ztWFIRS5gVkIaCKU/rwOLdmiRKkhIRo3ndEhqD+lfZOiwzeO91g7ju
	 nSUq2ikT7bCkMsUG7ZLmtrUiGtrpVvQGjs25qglsS7NU86EDFkLHykqWufETjDVki2
	 bWXeNj+j3hqpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] s390/ipl: Use ARRAY_SIZE macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260721-ipl_refactor-v1-1-4d5938de9a70@linux.ibm.com>
References: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
 <20260721-ipl_refactor-v1-1-4d5938de9a70@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:00:27 +0000
Message-Id: <20260721190028.35A7D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use ARRAY_SIZE macro instead of reimplementing it.
>=20
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-ipl_refact=
or-v1-0-4d5938de9a70@linux.ibm.com?part=3D1

