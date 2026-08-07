Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EF3EEAF4;
	Fri,  7 Aug 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141950; cv=none; b=pPgYeRGuezVMflUMHSvW2Yria3sr5xyLJ3KRItgn99pJ/yfi+2H8i7I7sJ33l8brF7rak8ELay0cK28hw1PUm0FX3q901nEw0kNgjPdOZyuLk27md81oTSrn7YxC85aNMl/Fi75JOqD2x1Q69/2FEd5vV9ZPwq0YpTWEc86fTNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141950; c=relaxed/simple;
	bh=uwOsYtN37f24zGAOeTy4tHiSgtgxZ+ks0xAsk/kRiuE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SV131HDJVPZd2bX/jWmlEiDaCm/gnCvB3lBLylTbaOqk2sf2pB4kHKd+vddhi0cV61LRtHIbU9a4rZ5KDRUrrQu7W54y6Am+gAqvEYqh8YOML54KSuoUPU1GLbiWvFniNRNTwCWMUyBUIKpoDUrSPRcTKWiy2NyeaEtS/qP14a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du86UQ+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du86UQ+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B561F000E9;
	Fri,  7 Aug 2026 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786141948;
	bh=uwOsYtN37f24zGAOeTy4tHiSgtgxZ+ks0xAsk/kRiuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Du86UQ+KmD6+HADeaJ8qyuiW5PdfBVgQYXbF6vpb6aMZ9uNPAQL1i+DQSo6zkReMU
	 wpxelrS3zSiAoDmY8ZRzrmbpu2gLVYyf3YP2GCRyX80dU7vuAxuAXIJwPmfR3wjfLH
	 nJDvz6FGWR1XlOFHxkAkSJMSnPSCdjcDcJ+ohO1KV4a+sN7k66y0XnivNG0ctNuHEi
	 y8ho7rPHULyrYA+SC0yx7Shj/DlCyPKjP4yB7+9zLosE/aPl1mKtjRTivbT9ZO7yxi
	 vF+uhgI8BIOXN0o2Ua3M6zyvpvOBzNUfoRG0lZLNkdLnq6Y+82LEKjZBOzC/A9EYWM
	 FUS9P2iXn+6eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/15] s390/vfio-ap: Add live guest migration chapter
 to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807221834.562851-16-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-16-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:32:27 +0000
Message-Id: <20260807223228.82B561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a 'Live Guest Migration' chapter to the
> Documentation/arch/s390/vfio-ap.rst document to describe the details for
> initiating live guest migration for a guest to which AP adapters, domains
> and control domains have been passed through.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D15

