Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2946AA62
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517913; cv=none; b=ub8+OHEVMgb17vYdgsO9CojzlGyqU3Hw/qGkbk0t6phvWhBpOAjQ90BnX3F/4fshx8VUrd4UcRGwBY48ZqSd6QRMoYpZGrMM+ZIjlJOZO45xLCG4g0tT3kQlsTfvzru2C8myraW7E6WtHthsxgh/HMnZgqd8RpFCmbAkH3WBmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517913; c=relaxed/simple;
	bh=wRsBtWdhGN6Z0mpC4E0PYkbQ0frfFT8ePZpetNVOoQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jiy/G2w3s+82QrTIomTmZJSoLdiS0eSX73lVD6LdkZCTD7A3ujUmG/lyS/lITP95TxoqTJOPWdQzZQ3GE9EIMv3au+bvcjfk5P0sWElHhnKjASvdfU+Y0Iy7TAC/joj34gr+mHLAu6oCMocegn5wCIV83Z6EvvKzTUCN3wiGZ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M226hEQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M226hEQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C6B1F00A3D;
	Fri,  4 Sep 2026 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517911;
	bh=wRsBtWdhGN6Z0mpC4E0PYkbQ0frfFT8ePZpetNVOoQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M226hEQNN2KzcCAb+T6Dgor5qm4auCS08UdLpW/WTup6XSOsACUwncpqNuqyNFCJ1
	 NZtrxn8IAKgIpixEkzi/jkrYH7NsEia1bxbdYlToywBXkuXtLlaH370k2qlhRw09Jc
	 IKwSVnBnn6GIT0pXIEyyism7F6xd7h/6goLtmZur8+lQGuFF0CQf5XGX6Jgwe4YO4G
	 m46FSxxPT3+WmhGCsdsPN/W1mTA1TGzy+nMGZLaaqEUVuL1xy/2ftYqlcub6pcsKTE
	 ZkwJJ2uQUxMALUYfaNY4tR3tuPYiPZcoTGUEFfGkc0TwzM/X9fjxb6PFPhiPflDFlN
	 5MGZXnPqCLPBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] dma: swiotlb: Centralize minimal pool sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260904101810.1193505-3-aneesh.kumar@kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
 <20260904101810.1193505-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:31:50 +0000
Message-Id: <20260904103151.64C6B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> A default SWIOTLB pool used only for unaligned kmalloc bouncing can be
> smaller than one required for limited DMA addressing. Arm64 and RISC-V
> currently implement this sizing independently, using 1 MiB of SWIOTLB
> space per GiB of RAM.
>=20
> The SWIOTLB core now identifies this case with SWIOTLB_POOL_MINIMAL.
> Size that policy in swiotlb_adjust_pool_size() and remove the
> architecture-specific adjustments.
>=20
> Explicit swiotlb=3D sizing remains unchanged because swiotlb_adjust_size()
> preserves a user-configured size.
>=20
> NOTE: We lose the RISC-V SWIOTLB_ANY setting in this patch. It will be
> reinstated in a follow-up patch where we make SWIOTLB_ANY redundant.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904101810.1193=
505-1-aneesh.kumar@kernel.org?part=3D2

