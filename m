Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAEA259C80;
	Fri, 21 Aug 2026 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317229; cv=none; b=PNIXbSeMA1IkE0uoL5/NITrt9EIZMdl1wl4SFPA9WjhTUiBeN5n2XGYxav/FnAEOjvepakGXQF6lj7+kg86Tjdwc7QJMH0XIm7mr9NZKpKTWqnFcMTmSpIkMCOPWC4ShEVaNAVo7kVW/2uDtVfYL89fL2BL9H7IRxT8SAQDgyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317229; c=relaxed/simple;
	bh=4or0CbwZUdsRICugoxoIB+iMkNMtFh+wmgg4sKdKlYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bmjfGnym3pyQSZX4n3jz+r4Z2Pxuoy2dLFqvupCwpU0dFJW7GvQhz5J2784HX6+/KT8f/yLI8TZSGJdCIoDzd1J958kqFzyXSroukm1TIRHYynsoEZjPuovKM+f6SkMOmR56OYxUNxDKB+3SCYifnBZAPpIUon7KV3sOU2NnFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPZqVSDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPZqVSDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A106C1F000E9;
	Fri, 21 Aug 2026 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787317228;
	bh=c6iQ/In1wiUPG7q6JZeCUrEPCWRDwwu9W90dTmMq50g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QPZqVSDKzPyrzuce5n/eYwwYfqiO43S9sQEiOqeeq4lX+pdplFwfurKKdtRGIqj7J
	 vi0v/ruwaNWMyOBvuhHmbHVOZXwZpbta73/p0j/5uZfpQl00iGqEpXAPvSbS41I2/8
	 G8ydMaBW5e9O/1egBRFRwjnr/hNtruF7qdsxPyWCE38jdxuUGaUiKmcAPqdO8Z2HjZ
	 LJYA6Jj68Buolj9flHRv/XmKGTMjsEQdDp/KtdqwYrX8eeNtyByKmgfOCtHwCyMpW1
	 kCWvu8/amB+eXKHtLQmdL84iG3IhXKysfzW/l1yU0q4JKfSty+ull3uyIiNHX8j/0C
	 BLKI4KbItFXdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf evsel: Improve callchain warning for s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821125538.3721169-1-jremus@linux.ibm.com>
References: <20260821125538.3721169-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 13:00:27 +0000
Message-Id: <20260821130027.A106C1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821125538.3721=
169-1-jremus@linux.ibm.com?part=3D1

