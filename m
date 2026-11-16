Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828021;
	b=eZr7nnx+fKpBuCPUgVYYHO2GaCVRoOPL79ZQnrd5m1DOdp9aVHKx4LzDvMy5VT2sFm8I
	 y5EvR6ydd9NXLqGD4mW+O1W0IBOyHiLg5yy4BZxLdncOgRH0QzEe29hEEdmCAniGGSA3u
	 nmJsluSam91JRMpIENUtj6z8YBDPoIJRU//A8yqiSS0fiMJUPwjJyq5VmYm7/9Y9tOpri
	 XqBhU/krKg29UXpg1SBPVvk37KhfbbUX+u6wk7GIaro4lNViJE5rccfYVspd66xaUT2oN
	 aT1q7qoa37MLyhFcKo5NQEYW4vcwPsJWU9I4/PSwjCdmYNjeiLMDD2xm/ZrYAtHIB0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828021;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+PTqnZyUIJYnGs3s4HAL/sxs8uEwycItUCg4wOnEHqI=;
	b=V2Hwqf7tXT1GG504dK08OaMqpIMoWhnrRzfvBBYy4YAhfwV6W01a281Orj/YunlfTOat
	 nK9KF2jDI8C53j3Xg8vIbTGVvc6jHexx3f0W8Rv1utlvGolECXBm70lzPiczj9v/nni/d
	 3jyC2XbOPMC5KoxxGw/aMPAlYwKw31lfuEiC5ZVIPLVMqhpBJkAeLR8+NPdL8HErOf293
	 sDUEf6LenAxM6bXqUNQcOCKwxRgxInaAFBoZwQ0neVJtNBCgLwT5wdD5q186qI+QhDLqQ
	 t745LnRG3QVLtxP9K+qSlrZpxAjAQZ6epJ6wZkMl54qBkagIpblsnodHuUPG0PEbpgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isnsMMnT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB756071008;
	Mon, 16 Nov 2026 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isnsMMnT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EBF1F000C4;
	Mon, 16 Nov 2026 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828021;
	bh=+PTqnZyUIJYnGs3s4HAL/sxs8uEwycItUCg4wOnEHqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=isnsMMnTnWkfzzQzasEe29WbSbO4R2ZJeqlu2/CHRVuxsFwWqK84DA+rG+fsGvlp0
	 cptCr5u5tZ8Hia+zLwAk0pU2ujGjuUTPD07lKmkFW4Q8NrYp2NcRcHGoC3/LL6SrCr
	 I4O36XQypWLQLMEROCL3jC+AHyoxkLnByYPxGmmVeE15jg6ZdYlRPan3E1eaNA1Bd9
	 5truarYzU8qLdrORykZ8CgJVpD4lLqBL8uaigwzxpWXfOLJGeimOeCo599rfAVUubm
	 mBnJZYq7Zxq3OU13f5dVm3s/uCwK1byRIkjU8+CU4r3DhAexXiKA6OySYI+hl0W5gv
	 qKgCzstp1jGfQ==
Message-ID: <sashiko-outbox-216892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 21/44] nfsd: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:20:20 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>=20
> Acked-by: Chuck Lever <cel@kernel.org>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D21

