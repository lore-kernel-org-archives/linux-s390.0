Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E203AA4E8
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689184; cv=none; b=P+LSvVFMzeBdZf1s9nKYLzPTMQxXIPHgPGqUXk9p6vFONtm880agIltSqR1tgKiU3bUP/a96zidEmNPnMrejLIs0GscEnBhUIkDuYDctuGn7dPpgVuwy4w9fq3P1iqDVbslXCo2XNmSfhdWAL90IztdrjHpDKDZhbcTRbPqzgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689184; c=relaxed/simple;
	bh=jbkFdMhNW+t1Sb4p93g9mBTdSAz5xbAYgLXwR+/pRf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m5dqG0dlaXiZGwS3jMUsLvJ2/r9gtpcuQmf9q0C0ePzge1rudspTV+M3aov6EvrgeN1C+aDwqu5Va8F1ffR9SkzYiZNNPhnRSDEg2oAhTty9lkNt1WkW5Jgl/ZxMk+TtrXYqousoSDOopz9FBt7M1d89e31rTnLseaXaeFtlAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwdbRk4t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwdbRk4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE9E1F000FF;
	Thu, 17 Sep 2026 23:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689179;
	bh=0J/t3BC5k8IXFiaFsmpLs/8sPcCn2+QwEmOuDjiPNOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SwdbRk4tejYlg3NMX9ovs3D32oHFbKA1d0nX57wAVAvRbUFbx9h6BCZ+g2O03yciC
	 KO3Ky8rzlABMxlhd1PD2BIUTu/wGB0yImgxLa0uYWdg+MhvjuQlGef6hH3aOjzuJag
	 AhvYYfgxYyr03aKz6vbEUpztB3saJFknfKEgzaSYHvaLcHHVYyrfJwnI0r2tyvXZ+l
	 aNx8+iRbflWFP4Xkaj/lEYRWKZ8tiEe/hW4LvVnbL/W2yfxFfwviA+2GZHgtP2usj6
	 chV3paGsR1TBtYjlvzEig0trolUW4q78Jb3dqPboCITVrICNYbRSJM6pSsCq6f8WLK
	 VKkCr304GaUgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/13] syscalls: Make --abis parsing more robust
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-1-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-1-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:52:58 +0000
Message-Id: <20260917235258.BAE9E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Some archs Makefile have something like this as the rule for making the
> syscall files:
>=20
>   cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
>=20
> The $* symbol is evaluated to the variable found at $(uapi)/unistd-%.h,
> where % is 32 or 64, resulting in e.g. `--abis common,32`. Sometimes the
> rule for the file won't have a %, resulting in a trailing comma e.g.
> `--abis common,`.
>=20
> Currently this input is transformed into (common|). This is problematic
> because grep will then match any ABI because of the trailing `|`. Make the
> syscalls scripts more robust by removing any trailing comma.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D1

