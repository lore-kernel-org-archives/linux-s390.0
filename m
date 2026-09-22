Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030839E177;
	Tue, 22 Sep 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088440; cv=none; b=Ke1gynEUIURoC1icKyuzRzJcQyEPaexY6lN7QUs0qDwodCeRlkeg2LPGyhqoTue7JtYDJwKr5KH/ESbnF5ZIJNExhosAHmkhLnMIw6qblq2fbPm4uaFWflB+JJoZZZ8lQ81Bz57HjhwqfdSLDc8/vcNPbN+1ZbOwMVQRS2UYNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088440; c=relaxed/simple;
	bh=tK/tI5rJeD/lrqVOwfFYXbnXRiOqdKzoUS5lhOZtunc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u82uDUUMAbg4r2hXL6+qjP44dJ8qDnDwj46zPKLwK6mrIAYyllkm/vyKKHoDYnYKEtBWdS+Syg8rx79rHXqhpfFsLJxQpG3UHXKORxMhGSz07pcTgxKdcWbN3CBgxbztoy2pPGF7n/9ceFbFq9usTYzKJCQN0lbwHADgMaDCfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI+96IEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI+96IEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1B31F000FF;
	Tue, 22 Sep 2026 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088439;
	bh=HjNUm4GENBFnu3KRcdvkMEJ3vn8fo5NtRAr7/u7dj6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eI+96IErXyCWGyHJK/G1TCnj3xFwDweKw6IU4mQfazXHKl28NSvEVodrkGjd2UDFe
	 HGSjNAhxbZN+BS/fXUPQtOEzwy0RYNoSmOOkDYEMydtr+DeX0RUpLFBnEU9TI4PUtd
	 kJlgrci2cl/bSBzXvcOYPONWyVrsCWgQivWStIGd4bb1pDqzcGPGX2MAvOM0Gs493N
	 lcO8fHu5z5tYIhP4l53ATCYlmAVjgG+E5j5PU22CJlJg1Zcb74dxuc2nzhZ+OmwuJ7
	 ajmCBIJw2AWOvq/LEDhsgdgzwNVUTGVbbP6xi8ZRU65LxZZS5f4hblkIsf4U219adW
	 xpI1y5EQITViQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf evsel: Improve callchain warning for s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260922144300.1217524-1-jremus@linux.ibm.com>
References: <20260922144300.1217524-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:47:18 +0000
Message-Id: <20260922144718.DA1B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> On s390 the kernel uses s390 back chain instead of frame pointers for
> stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
> USER_STACKTRACE support").  This is because frame pointers on s390
> cannot be used for stack tracing. [1]
>=20
> This requires user space to maintain a s390 back chain.  For instance
> user space to be built with compiler option '-mbackchain' (instead of
> '-fno-omit-frame-pointer' used on other architectures, which should
> better not be used on s390 [1]).  Only few distributions and users build
> user space with '-mbackchain'.  Therefore '--call-graph fp' may in
> practice not produce the expected results.
>=20
> Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
> changed the default '-g' option to 'dwarf' on s390 and added a warning
> for s390 that wrongly claimed that "Framepointer unwinding lacks kernel
> [ ... ]
> [1]: s390: Stack tracing using Frame Pointer, Back Chain, and SFrame,
>      https://conf.gnu-tools-cauldron.org/opo25/talk/Y3CVHY/
>=20
> Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922144300.1217=
524-1-jremus@linux.ibm.com?part=3D1

