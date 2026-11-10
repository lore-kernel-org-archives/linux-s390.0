Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302787;
	b=nCTjsCqwSzCsB5XsRFNUBq7D06t733SG1NgfrceYG4W+Dk+/m/rcLy1mMzC9qy/YoRLb
	 lXHWd7arKOt7R0cfwiyi9Y1i8+T/KofMgqKThfzWbhJjaV8qfNy3MZkB02267t/f7ohfK
	 iYR6e7nHuxG1qUBLJxtX4cr3NJtnGhXmNhKIkl2lhP/5iQDWzvL1ke4XBgKwjNB+QXgPt
	 hnCGFrWRdYX6Z/IFMUOJg1YFC9QKlQW/WIJ2U5qBxu1Pnod7bXjQnjZ7+ZcpE//xVf9vn
	 6Ur8N/PQsgrR0h9OEz+HhBdmGUM+0lRE+PhLibHc6urL27E5gEOJCS6tHXVvPcFSdww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y2/0LMNp3xVe7Kfd1sjOozUB+5iyckFKphPt9ERnsNs=;
	b=krA6ZSfOUhk9J4V3TPrfIzPPZ27+AgBigvTJHNm79WPXral+77sOw30+EjoApa1tW3Za
	 mQVoglVMew2YsArt/+yPG2phEEdSaUo7JgEo6k785voEEM5cLbjlaRGF0ppLFoIeIJy8Y
	 sVEMslNHX0l9raiVJmmdCd9Oa3BpyXEmAjDkBayFeBpZplLCFllFNEa6PT0pIjgOkHrbo
	 mDBX3d7178U5La01CLh9IvnPNVEBBkpyIhibv6q38ueOZy699kuQucRFaIh0CqJlppReX
	 II2WJTxCkomOBqRlTHUCc5eA/ieGNUBhzedsmtMoJrKTn+6W2vUIonWPxzLtW5k8J+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsVCmfWo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23660742A3;
	Tue, 10 Nov 2026 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsVCmfWo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395FB1F008A1;
	Tue, 10 Nov 2026 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302787;
	bh=y2/0LMNp3xVe7Kfd1sjOozUB+5iyckFKphPt9ERnsNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XsVCmfWolvS7VhNib9GFFeLYjDTabQ6BdMflpAv0wexek44FNNiq9Vcz3RnnnJhaA
	 bcUUPbuT7kHSGzF2npNZb+ekobw0W9/nLBK+Urzs4USNOpIXDzKpJFOiN+FQ+YYNNq
	 e8ERGSq8605pcxR/KAerUl7MjExZhdVhP6Lj9seQidDARDHxJ8GT/QuoNCFmsUrjxi
	 yfPwZDs2Qq1G6yJKlo6OBZ8WsLgqgpsGpk/n2dFmGEdioALq9LL7vZEH9hCbpatk8m
	 UnlIXzyWPGtwnbTP8nUkqMdkfCEwyJd63T1cNhPZ7H6UwgQxXYieCm5ZYoo+RsRylV
	 ruxmszBJPU+RA==
Message-ID: <sashiko-outbox-206747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:26:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D20

