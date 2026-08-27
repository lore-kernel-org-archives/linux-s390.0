Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED43ACA4A
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832401; cv=none; b=UxYI6tB3ATnkOgAVnAJvcBqqDi8hk/5FjBZB0mv5wTNJTKBBaPTpmno7IwRJIZ/1wkiOBuHOZFhjLXzyNFVda4OgxwI3CvIiQWp6nisHX202TSL7tMDnnlzpaVGB7IW/M+XszFo2f77rAbYtgXOclSh8y6lf+3haWPfN0sTz15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832401; c=relaxed/simple;
	bh=SUhr6wvexTHDFvluWu7nNaxfsJbB/mpZXwTbP8oAoog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kURNIdPSsoZ16mO1BxRbOQn8iqEb6i6IGx43USgalH+dzReZKHTks8J+q5ZdcySkGLDBuRENn77VXrTYR6m9wPvNMwcdT3CCsGi347wJhPw+xoxZRjowk86kztm5sRl/rekPqjKbbOSi5LdbRtiQYWX0TnonW8McLVdj5EQh29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXY7vqRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXY7vqRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DA01F000E9;
	Thu, 27 Aug 2026 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832400;
	bh=SUhr6wvexTHDFvluWu7nNaxfsJbB/mpZXwTbP8oAoog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXY7vqREZNzEqvlzzlG5RS6FJzswQoiWn3D+yQ3TvQeGzB22H+FCfyl7S+A4ZhrSQ
	 U2l2YBrND1kR0SKrIg1OQOd/Q6xrlROmeQSeKOZQ4FkWoXh/Gqsvo9qob0ZAUK5Zwm
	 Ent1/yPF1woAA9dEH0xiY5BzXxUpxYB2Na4mR1WcZmcsoaQ3ekCrlv+bYyajU1qXpC
	 S1ByL907EK9stajHl0PkumbWTS+47tDlBPxHhpJ1JIgkkxvv8Ppd/zDY8uCr6I5KO5
	 IfJWd1GAK3nWziXppyIMnZ1W3wBugOJnKaLih5rsNaPotldRTNYiQy98Zxd7r2h0Nl
	 GbEB5DCRaQIqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/boot: Avoid IPL parameter append past command
 line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasily Gorbik" <gor@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <p02-03.g5fb840964ae7.ttkffvj@ub.hpns>
References: <c00-03.ttkffvj@ub.hpns> <p02-03.g5fb840964ae7.ttkffvj@ub.hpns>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:06:39 +0000
Message-Id: <20260827120639.C6DA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> A command line may occupy all but the terminating byte of
> COMMAND_LINE_SIZE. In that case append_ipl_block_parm() passes a zero size
> to the IPL parameter conversion helpers and points the destination one
> byte past early_command_line. The helpers subtract one from the unsigned
> size and write the converted parameter outside the command line buffer.
>=20
> Convert the IPL parameter in the command line parsing buffer first. A
> parameter beginning with '=3D' can then replace the existing command line
> regardless of its length, while other parameters are appended only when
> space remains.
>=20
> Fixes: 5ecb2da660ab ("s390: support command lines longer than 896 bytes")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c00-03.ttkffvj@ub.h=
pns?part=3D2

