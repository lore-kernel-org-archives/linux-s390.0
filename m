Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997A2931F1;
	Sun, 26 Jul 2026 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038939; cv=none; b=FHuurqfY2ENBvI6RJ5oiO34aIXzYflUl5q2TEIAIjcZDcx2pzX0OSJPk8dRj/s+xoRsV7LW2hfnbFjQ+svil2jpP4mzRuxfvP+8NJs2LFhBS6QpBFGAl/9aXmAb11Jq1andXRhr1OlgxxZUMAgNTzJ//AQ7Tp/ml/UHZBGLiIVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038939; c=relaxed/simple;
	bh=kfEJpB+taK8GeQD/48W6DgIQgHT7eyQdicqaL5YjitA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHtPIlqbbBsy+Cp1BdhWF2jIzg+7igaVwq6sHrzbOGf/qxZSrOcmXDbewVVqIdomXyCZ4MkCxhoftJKq97AldCXkwCAnRLeT3DUrsP6Yh0Dzx95Ylq2stqMwdqXKKivTWO+WM4B+/UacHdsaxvmgHwmPcw+XRxT4TQ2BZLsC/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5Ib76yw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5Ib76yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13DD1F000E9;
	Sun, 26 Jul 2026 04:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785038938;
	bh=kfEJpB+taK8GeQD/48W6DgIQgHT7eyQdicqaL5YjitA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5Ib76ywZTpZvP+1W4uFP4d1jydrH2sufKbMH569+PK1ZbvhhZeTD9vzmFKZvY9h4
	 3ZBePQbOiYs3cfflCs0IEA/jJ3S3PW47TtluxMdtFxLrAGqvi+5y+N4SsiQAs4kiUZ
	 apY4RrN0c8LWx3mUlKqrowUqMeSXxrAyGEuhMubJDnJU75rzN9K7iuX7+MwsXKBctG
	 Uw3O7itky9MiXyxGr6wxxL3w7OLkhmaYHYW4NDqPTLk7VKY2wIupw4im4oKjuXaiIq
	 MwzfBePQ+vvd2jX3T9X1S78Drq+fFikYuJgYWVhK2vu4Ye5bVO2yaxe9n2Dz57M2jE
	 F1FkK8Xn8DnDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] s390/vfio_ccw: limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260726040129.2946151-3-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:08:57 +0000
Message-Id: <20260726040857.F13DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The processing of channel programs, and the CCWs within them, is done
> recursively. As such, there is an arbitrary (but not architectural)
> limit to the number of CCWs that can exist in a single channel program.
>=20
> The vfio-ccw logic breaks these channel programs into segments whenever
> it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
> of segments count towards the global limit. Impose an equivalent limit
> to the number of segments until such logic can be made non-recursive.
>=20
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D2

