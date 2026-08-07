Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943BE19F40B;
	Fri,  7 Aug 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100068; cv=none; b=tTBHTWDJc04cZAssXvHLgx+w2hKOkPo92AxvL8gt0ImyXEm6HgLle6RXpy9zM+Gf43jhrvC6Y554xzB33pDJ/fTgvJ4ziwsyVV0hNmGYTm0XnfNI7UvHxZi7WYmm7t9e+pBqO2ggAeusY27AjUXNvCTghaujUb0Llhx9zYUm9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100068; c=relaxed/simple;
	bh=dp9uSnLA1V71JIR7gUQ9tH62eSixAWcWfRQL2i9FZhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gp7BLpLrKQ5h/9PjtZAHZENQnWnffuwHPEEngoqH2/i8Lu26iZMDvz/4IOrqJlmmi68mj7+b1QI+dYsqoOHFki/DBUt1eO2veypCdHf1rBR6n7PV1uIMKvTq+77Xg+OZLu858pmV6zS6bNxPuh08gucv5mi/LJ7xLxdRUm/UYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnOWFxv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnOWFxv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37191F000E9;
	Fri,  7 Aug 2026 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786100067;
	bh=jrC3JRKanPJQ2wb2blb79sDc8qkVGp+fcRspEGIOK6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OnOWFxv1tMcYq+irZP3jBEPg3YO999d9Ecc7XDTcmDBhtBX2XYcoz5KHV7VMMEiSe
	 4Iwose+YTMOxgqR05ENRSCMX3okc7zXWsPceA3moW2qAyKECDJ+klxQ83zP1JqbP6s
	 dnACrUd/IKFDPOcHJAXSI0h/KRwjHQfcAWOLcxYffVLqP3YuaL2j4uSougiedt1oqT
	 AI7YLes5NQNkMXwiji/3KXafYb67DGv5YpFwlsxTqraOouvkqSg8VqVrUxFYdORIjF
	 CS17bjcmTXXIRUuwqpR9l+2ccYgZXg5aol8IUzKkE7cNqhwYV6V46afF9wSjUlg0TF
	 HENjAw2NgLafg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf evsel: Improve frame pointer unwinding warning for
 s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807104913.1784943-1-jremus@linux.ibm.com>
References: <20260807104913.1784943-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:54:26 +0000
Message-Id: <20260807105426.D37191F000E9@smtp.kernel.org>
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
> better not be used on s390 [1]).
>=20
> Only few distributions and users built user space with '-mbackchain'.
> Therefore '--call-graph fp' may not produce the expected results.
>=20
> Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
> added a warning for s390 that wrongly claimed that "Framepointer
> unwinding lacks kernel support".  Change the warning to hint at using
> '--call-graph dwarf' if user space does not maintain a s390 back chain.
>=20
> Note that '--call-graph fp' may also be useful for other applications,
> such as OpenJDK maintaining a s390 back chain (does not require JVM
> option '-XX:+PreserveFramePointer' on s390):
>=20
>   $ perf record --call-graph fp ... -- \
>     java -XX:+UnlockDiagnosticVMOptions -XX:+DumpPerfMapAtExit ...
>=20
> [1]: s390: Stack tracing using Frame Pointer, Back Chain, and SFrame,
>      https://conf.gnu-tools-cauldron.org/opo25/talk/Y3CVHY/
>=20
> Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807104913.1784=
943-1-jremus@linux.ibm.com?part=3D1

