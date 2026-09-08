Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD949390613
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851044; cv=none; b=aWhbmDraukrWlUuWAIKiaSboHGjSp9qsuJ/NI/H8EV0TWvabxjifoDn5mKD3NHn9dAxNaOnoZMraehDgW80cEMaTsxaKYSm3zNemH4XEx+bPgXb0MzKmQXPNmEoAOUh4X6S8Z4W96DYYZO9LSEv+yZTmNsBrRr4bB4H5pAFBbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851044; c=relaxed/simple;
	bh=GjSuAy70bAkAglfu0KrZCeFp5j/NMsFE4BZ5cH0gvh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjChQ1dNTrTDO9u9h3ys4XZBT2tZ/H3Zn47e2A97kS05gZ5ZNtjKr6GWVA82PQFH3e5Bgcg9aJci98sMWAUQ1+v8nBoOpICh9Ze+wpzMZYUib5QTK30djfsbZbTd7Hj3XxS03pXYa7mgoEjUtv82irRpGepWGkV3ge8jm6QY0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm4EvYPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm4EvYPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B491F00A3A;
	Tue,  8 Sep 2026 07:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851042;
	bh=GjSuAy70bAkAglfu0KrZCeFp5j/NMsFE4BZ5cH0gvh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gm4EvYPtI5sOckaI435pwCYCJpVkLmnfikMVoad4AU8Eo6MHb1Gush+oJHegThJM3
	 AZdFEBqASvxdRnKyvYuzzsCM9OAvJJph2LNrPuQ+NP8g1xGVWa432JLCQacs9af6jK
	 ZG2t/YLblr8YybOXoFdp+TUwoe5qpTG8xFSQPxFVmLC8BwG4E1+LEWrl+mRi8znU/H
	 qY+zgIZe0+DAhBMrnlh1jfmriHwTY7FPfMjjT+2bm2ViITwhdypvtNsdGi5RG1MhBI
	 RC9amxxrj2XI19Y0wiS4pX0VxbTx8l3dz4pbxrnBywd13IkXdw37q+QMF1Lse9PQXV
	 HCorvZd4htteg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/24] riscv: vdso: Enable the vdsocheck tool
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, ojeda@kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-18-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-18-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:04:01 +0000
Message-Id: <20260908070402.09B491F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The vdsocheck tool validates the object files and final .so library.
> It can detect if the compiler created relocations which are incompatible
> with the vDSO which need to be worked around.
>=20
> Wire it up for the architecture.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D18

