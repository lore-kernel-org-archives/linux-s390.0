Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D533D6ED
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926936; cv=none; b=Ued9F67pi0TkbK7wh431b5B3cMd3WETxFTtQr3UtAF/XMIiYXTYgifQHqi7YgkyPHFawmC5TJhkvmSnSsnD5OvU846VAc17/Pj1qehYoDwGTFzltx4pWwyI0dL0u1nhWmc3lCWJFPickB6e7Gcdd54MTy4g+5V9GGP/C28k9zP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926936; c=relaxed/simple;
	bh=MQzwcf22RaSrsHNziA8y51Zffem0lBC0knidU3yllrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XxQF9O8dyh5H+VM4qWh6qFMojRhfh9kTuFrLh6as9zMfLMJI9wghXVu20pZthSbUZjmwS1QMwGaHjvnRm6eylyJUhzK/P1/r7CFTjHYAc3OLkxBfNUXnK6/RkFmdEYM0163pyE/HUKyoMrcbMW3Zg4SbK3oE2LAeeizhlbcetLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFVTTXDb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFVTTXDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95501F000E9;
	Fri, 28 Aug 2026 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787926935;
	bh=c/s5JIufFptbFQw/VgaJtmc3eVakSEGkC78sX85A0Gc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YFVTTXDbFQYWz7pAJklXYg242qyuzU+15j6ozvn2cO3Y7dlVnU52gspirLSJZ+na0
	 oPo1gWRMMddIPJ+2vVBW/L620MgI5e/fI7QgY5tpVSbsB42QsZnO7W+a3Fn7gVGi5X
	 bVSNyFGCXmHrm+39SLHDJSo3o/MbYq+jRC7lCRBAYqeKHW7Q0bNXAvouN5yR49+UmK
	 yZ7Hqh5U3WjZfd+ghLLjESVdFzvGBZcDOE+4hFPKB2xI4xIopzfjprB806PRRlGjQ9
	 D7JENqyoDvxugGUP55X94gxPf8SLzA38TyMo/RDnJ6ZOARHVqsGX3DUKiTwNeZhWlg
	 3OpBZgDaaQrTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] s390: Warn if kernel command line contains
 non-printable EBCDIC characters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260828140057.1728173-3-iii@linux.ibm.com>
References: <20260828140057.1728173-1-iii@linux.ibm.com>
 <20260828140057.1728173-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:22:14 +0000
Message-Id: <20260828142214.E95501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Users may accidentally add multi-byte UTF-8 characters to zipl.conf
> parmline, for example, by copying snippets containing non-breaking
> spaces (\xC2\xA0) from web pages.
>=20
> The kernel will then interpret the entire command line as EBCDIC,
> making it unusable. Distinguish this situation from the legitimate
> EBCDIC conversion by looking for non-printable characters and issue
> a warning.
>=20
> The current solution deliberately makes the following tradeoffs:
>=20
> * Do not make this a hard failure, there may be a very small number
>   of users who put characters with diacritics on their EBCDIC-encoded
>   command lines.
> * Do not use heuristics with arbitrary thresholds, these may fail
>   intermittently on, e.g., punctuation-heavy command lines, and having
>   to tune thresholds in subsequent patches is not desirable.
> * Use the invariant subset of EBCDIC to determine whether characters
>   are printable, the vast majority of command lines will contain
>   characters from this subset.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828140057.1728=
173-1-iii@linux.ibm.com?part=3D2

