Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF23D5C0C
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643828; cv=none; b=tbF9slfB7BEkcLMtvAB5IG+0TX/xlz97H4QHk0V5/9VPE2i4H4M3KhWVL2gqEHvR1fI0oyy64cYsnKcJ7vTJ18oWPUjD4HTiRVMaLheuRSZJEWAOWNldnDjfaUVLLb3u10Y92OFcxylwqNoTrohj96HqKs6oAGIAJxBVUnRWaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643828; c=relaxed/simple;
	bh=hJvn7hZK5aWiK5uo046XUd0k+0Fddn8iy2z6ArbU/N4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F89nvoMp+bbZ+eZfLoNF90PnsLhFYB0yOXBVSUPgMHVkp3GmLGhm32rRe62aCr5tGIA9HJdun6IP3w0kaIIaLvHc2KWLzqg2YaY5pq9YFq1GQYc6rXDufTW85b/zmqUXcYk7Ao0ZrNXGuE2sx5c+PbBOVz1U2JX0dFOPQRBeC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS3VPT2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS3VPT2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5F31F00A3A;
	Tue, 25 Aug 2026 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787643826;
	bh=hJvn7hZK5aWiK5uo046XUd0k+0Fddn8iy2z6ArbU/N4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cS3VPT2FY/O0LukUpDCHT+C0WYWmPDmFnElPB8z31mpNgQJtWNH9U0LCYJH/rgNPz
	 TO4aTqbfJ4nd5Cynh7tamAnua8X8XoykT0LQHiqYpxsurT9N2GdB5GowsB7oRX29Ry
	 jLMBjTYDPX5srcTXfoDICQTB0tEcdEjE+4g1SZxOtH3YUEzd8EVboPCeB8tT8lcR4p
	 ElcAvNayXGqEsV9nlaoiJnXDMXNLZGaCROta3S6Ma+inFd3wiU94tet4AdfeYVCWlo
	 Tiyyj/oGC4R2MMWQmKkgPx3owz0ZfGTsRBf/8pDicPfV/Dz4nYZOx28b2Cjc8CH/X4
	 p7YqIE3oyI2Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/pai: Move locking to event init and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260825072931.3738180-3-tmricht@linux.ibm.com>
References: <20260825072931.3738180-1-tmricht@linux.ibm.com>
 <20260825072931.3738180-3-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 07:43:45 +0000
Message-Id: <20260825074346.0A5F31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move mutex locking from per CPU allocation to event allocation.
> No functional change.
>=20
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825072931.3738=
180-1-tmricht@linux.ibm.com?part=3D2

