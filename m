Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2FD471245
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935972; cv=none; b=KtvcY2jWaRNZs57OerhxYA6CsLvmULhh4JpMHnnqDc4Ul5Fh8rTbaTFVaA5oXogaKbWOQdi23b7JBaQWbaQLL+3O/7fc1NX2LSidCa9DyE2bX4WXsuEH0p13+JCZovOoqutNAhR6GB0vG4amakiDa4+gIBgZpiBqc+7BcsCxFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935972; c=relaxed/simple;
	bh=R0QstHa2k1nq6ymh3fE6rlAIrAyEMj6j92VyJ8ODsvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KX6BIRNecjDdaeXF78WHUdK3iOINgNHyG9JeLFRYSGV89uF9NvJcUuAPDjcDmn64K+3dAD7MnDMeGSXccyz25OMZNhHbOirvhmBJLPY+TXgxR69NACpRuVtPG/Ki4bHb7SvHYyhYndMwrTmc4iQdntK4FtfU7lH1OCLO9t9Gpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYockBGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYockBGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F2A1F000E9;
	Wed,  5 Aug 2026 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785935970;
	bh=R0QstHa2k1nq6ymh3fE6rlAIrAyEMj6j92VyJ8ODsvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DYockBGJLdxqAA9utM29sC7nXh8YSeMS9ShI8fdN/CtYjZw8o9/Rjhlrf2l1eJPIF
	 +V6Bz4y5hBV84OYng/nf5ZQdPPF+2sIGQxeA5YGVnLcgP6q2Gs6l/mZGYuHmi/dWzR
	 OHv12DQMo7KE97LVa/5kVJahVOf2nwhYW5H+Nt/7ei7FBHgSCg4BqyPNx/ZDlwHn5H
	 MGJzIN/p7066/qSOlgCKtN+b36ORIttnPHUJibLvf2YiBhRrcdtKR9gKkW+UIxoWEL
	 DqPYPHR8mM43h+26jTKCoUxdDC17LNUz6CbIPWKhsylcj/dHd1ILZTe91Sg35MxeSJ
	 39+86DpDewTtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/19] s390/dasd: Add defines for the Extended Address
 Volume track address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-8-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-8-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 13:19:29 +0000
Message-Id: <20260805131930.59F2A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The track address of an Extended Address Volume (more than 65520
> cylinders) carries the high cylinder bits that do not fit the 16-bit cyl
> field in the upper part of the head field. set_ch_t() open-codes the
> corresponding shifts; name them so the encoding is explicit and can be
> reused.
>=20
> No functional change.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D7

