Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8621773D
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149025; cv=none; b=ZMNHwOq/5Ti2y/ksLXIB3tSBguy3HzoAyJ0R3sfeiLJqGQ6XNEAreOlRcJumKMvr5WGRYY8sMX2KFoVd8iMNxp7H1pNmnpnZt//eRsM2i7pOkzRDGQOJnHRGebEDbf5XFClzKWeXzCSKBwvc3Icbz82kFM/Icu4pwfYQsbjxzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149025; c=relaxed/simple;
	bh=iLzdiK7cgdLUEnUiR5nHP6P2n0+G/XCxLPe8DdwN7q4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OYyJ/F1jixfSCecXFWWOGpfsEtjjC9q3yKTwF6hNUkNMrVjelxBLSNsweuk5EU/hbnt+IKYT3P8jY/hjVJw6j/dZmFHxZi0E4gKaUosLWs1T1R1/VR9HC2aND3p2x2S+WdRDRgz7s+UGhQQh06vk9qdz343pDrN9ROw5hEj2g9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGZiwN0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGZiwN0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF551F000E9;
	Mon, 27 Jul 2026 10:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785149023;
	bh=iLzdiK7cgdLUEnUiR5nHP6P2n0+G/XCxLPe8DdwN7q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGZiwN0ZNcYntu1N0OmUhbkMg6WGAIREmARRE5zclxZTvWtMNrjPEcin0ns8fJJzH
	 Ru1VShZX1o5L+G4tiaEC8qlN9YdUUrBfKKLfFi9dpG2WB+nQ51mGN/kgrQaHWU4jzE
	 KR/vNYkOf1DxDgDN0HSB5KCrOht2gLvyfLnsR8Q9cD34xaj/VKnWcqBwqAayqjlif5
	 6Dz/q1Np4R0DM2roR/sj3B31mdOBreHyn1NzLVdMu1S+dN6Np73IjaazqvCRy4DDhT
	 C0kJM5POlx5s/Hj5ATAEup72TMNGa6t9qRcAwCQYEi5vAQ3nw567gFJ68Pl+popYqZ
	 IFailNX5GRi6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] panic: Introduce arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260727-arch_do_panic-v2-1-4e25ceb05075@linux.ibm.com>
References: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
 <20260727-arch_do_panic-v2-1-4e25ceb05075@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:43:41 +0000
Message-Id: <20260727104342.CAF551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a hook for architectures to put their specific panic handlers.
> s390 and sparc already has ifdef preprocessor checks to execute
> architecture specific code. Pave the way for vpanic() cleanup.
>=20
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-arch_do_pa=
nic-v2-0-4e25ceb05075@linux.ibm.com?part=3D1

