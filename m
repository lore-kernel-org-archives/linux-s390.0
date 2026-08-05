Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EE415F39
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923782; cv=none; b=qRTDukY3ziUduz3Ne+XDXzB2UIzRO6sE99rWWL8B+a5u7xmqRgqU9mq9wfIyBgDnV+NCBbkea2sMM8bF5fsOPMfoIAxKRUW5ZA5xEnv00r2LuowqFvcxMU6Fgq9H0N4eTL3pC02yXXVMxgHHPRzG5864FIvhmkW3mrD1tk3I380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923782; c=relaxed/simple;
	bh=1AKHT1i6Mon1cE5JLEtdrgMZjc7Blcp2pVt31zAF89Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9akW7uwzsQ1RYTfGfW4r2SjY4t3E1rGGClCWtMXVor9h5ppOfTFLufUD+8zmJXDZ5yEApiyuPfjkCTs3dLH4R52CzLSgAG/0O2KMVwi8T3cdnoA0kwEEZ8VWxEK15e1pVx1d+JCJFVcL+PnLHX3RTPZhXC80IGutcw40eCfd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRthJyTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRthJyTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E536C1F00A3A;
	Wed,  5 Aug 2026 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785923781;
	bh=1AKHT1i6Mon1cE5JLEtdrgMZjc7Blcp2pVt31zAF89Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRthJyTgqZBrtEyTagyHEVP5v0a/I2I+EPZ2A+pJxLhIdzPgBk5q9KKUbMWduY66t
	 h9h2RQDLA61YHWGa6vPkgr1qdx8xu4X8qe2uo5lpvUzOazbPqFNQj40dbUCw0HxtUf
	 9UJoI9E1McEZzItwK0QTdADRwVs8390Ogkkr5eCyqJThfX1KDklM6x1gthvtR2akGb
	 96KuxctnRdLZNxow7cf7RIUdTvjOaDUOppMPObQ6i4XQ0ZicdJJMrFv6kRpAMqBDrg
	 GErOb8//gOUl40O9DxpH9gIyZOwYVLWIOWkjJxlfoAH12Fk+/hH5sQi9VW96MnFWaD
	 9May2+04fTJ5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] s390: Implement arch_do_panic()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805-arch_do_panic-v4-2-af4a36f99414@linux.ibm.com>
References: <20260805-arch_do_panic-v4-0-af4a36f99414@linux.ibm.com>
 <20260805-arch_do_panic-v4-2-af4a36f99414@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:56:20 +0000
Message-Id: <20260805095620.E536C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement s390 specific arch_do_panic() instead of using s390 specific
> ifdef sections in vpanic() code.
> No functional changes.
>=20
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-arch_do_pa=
nic-v4-0-af4a36f99414@linux.ibm.com?part=3D2

