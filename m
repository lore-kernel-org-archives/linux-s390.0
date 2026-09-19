Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220E3101D8
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778751; cv=none; b=J6t/akkapePiGLsUbFhMb7Vevl79yZZqLqdtMHxwTf25CU83Zw2JYKnUc8Syqksnu+csQ90ivzVg6bo7leiV38J8pOlzHrCcsfbEZX9/+fT3G1NJk5F4F4hG/mh5HyJuLx9//9s0REVXj2mWduQP2E/KqgObAMTGZN9j+Eya03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778751; c=relaxed/simple;
	bh=jjytwar8F3AE44QZF7w+20nglAET6uAL5YT0NFrAWcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NRdV5+ZTeMsO+li7araNfOh4H3gek04sO/8dh3adBivHM4AF/8f1Zo6aOOX0fsu1cU8q6XNEX0wPYhcG5xXH5gGxkNiQp+SbyT2uB0UjQ1h9jVpgGBNL6Db3C/C1A6+99gd1ZzI7cF9nuyxrXCj3aFDIF/eKcbFXlJCZM0YbDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahx6ROiW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahx6ROiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970641F000FF;
	Sat, 19 Sep 2026 00:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778750;
	bh=jjytwar8F3AE44QZF7w+20nglAET6uAL5YT0NFrAWcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ahx6ROiWRCsgI3eeB1cC8f7Gco0eueLE3Tk7GMnC9rd+37HV6NXAchZXuCFonUbLG
	 2fXdjbYBSlPR4u++Y0Y2VLkROy5ItjMAOWzNC2yei1EIMyqerE/Gpp3y6F3vAKdtzC
	 cXi1gcHO2nSpWnIySs1Web2HnYURvMWuuI+a3o4EAGRUxtSVOXnHFlu8omAgWKpekw
	 fJLX6+CTh2V/Ze2svn1UB+GOfwkM47S2oOShobrJLtga17iHzyEpoFGQMT+16lnKAG
	 ARWFfSPy6WYqvngSh7VMD3XXaeaM3zcbFLaoZ6vRfPodoNE1i1XYW0vR8Utpw6Zg2i
	 jHyYDwinVDkhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/12] mips: Remove duplicated syscallnr.sh
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-6-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-6-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:45:49 +0000
Message-Id: <20260919004549.970641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The common scripts/ already have a script for generating the numbers of
> syscalls file. Use it and drop the custom script.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D6

