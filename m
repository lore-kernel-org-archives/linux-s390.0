Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03B3FB7D5
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922440; cv=none; b=P03FZ0TYUZAyhmsv5e92DRzGZaxQgnDBx4vFcYzBGW05b6PlNgoyRcp7j5rcd07Y9x64I5UKnhpO4m6vJSjxu0ae32no2ZDKad+uNoz/q3k33oDgu+/yDnIPyv5V8fD9QfAeWYJPYp6ubQ6ZS5U3bsNhW8RvWmvytPXcrBeeJQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922440; c=relaxed/simple;
	bh=Y3YD0supgy0URE41K7AupOqlLJ246HK1NAg1Dm86g4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pcNqo5C0+gqOsIrc16eoomwUvGuUPTykNiUdFUGiQ+4IJJZtqu1ojfMI0DumO2gCvPXlIIzrc9hh3VWYzmaiPjO4UXg4U71sTrXAgClpFINl7cItQEu2G9MkM6T9iMZyJ42DIugp1OwO3RSAuPrxhx+NM/IdgKlFahewee4YoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPuiLc83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPuiLc83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3371F00A3D;
	Wed,  5 Aug 2026 09:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922439;
	bh=Y3YD0supgy0URE41K7AupOqlLJ246HK1NAg1Dm86g4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPuiLc83pDyUQ1DpORXCb7vwWdRI+qWuzyGrdRVZjLr/c2fEt8b390fzIGYuet0Zv
	 4vVt5cAl7MAq7awP84/01F9faOE5SFaMWNrmIvVlcxnkkMB5zMq7YDc8CQmN4jNoAL
	 2WQIhfIwYx9dM52sKfsmB6/S8buzjQ+bWzxvG6+HNq69hXGjvDiFpEeUbUxeNc0DjP
	 mDnqVn3Abx9rk7ijuBFc96ywm/J0In32zdHOKu3PQZQV5hpkoK55/DpoAh1Rj4+d7+
	 mSqpgrH6UrI+biFTCE1kQub6tFPJdtFxGQN73+tFiG9fI3VybXY33MExHnQ3fbU11C
	 AfNyOqFvlH/nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/sclp: Fix leak of uninitialized kernel data in
 SCLP report
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805-fix_pci_sclp_length_check-v1-1-d125cb415bc3@linux.ibm.com>
References: <20260805-fix_pci_sclp_length_check-v1-1-d125cb415bc3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:33:58 +0000
Message-Id: <20260805093358.EA3371F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> While report_error_write() checks that the provided buffer is at least
> as large as the header struct, it does not currently check that the
> buffer is large enough to contain the report with the length claimed by
> report->length. If user-space provides a short buffer, i.e. a larger
> report->length than the actually written payload, unininitialized kernel
> data from the page allocated in kernfs_fop_write_iter() will leak into
> the SCLP report.
>=20
> As the entity processing the SCLP is privileged and able to access at
> least the page including the report, this does not actually leak data
> that it would not already be able to access. Still, the sysfs write is
> malformed so reject it as invalid.
>=20
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-fix_pci_sc=
lp_length_check-v1-1-d125cb415bc3@linux.ibm.com?part=3D1

