Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E13371CF8
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980103; cv=none; b=BjClkbV/2P5VvYTWCzSs5EVSDM5Lj2YyvA/w9yE3huZAAmBtMxEGNY5sjyHFr2Sn/6SVAZySDtov+lYCqyLJNrpvNDgQNwXT/YhbzcAHJNwEXY2Tid2iuzj2Oe7KUuu2y1p3HEkuMO9LmfVu727DIRQFeM3mPQdULfF/I3Dyq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980103; c=relaxed/simple;
	bh=1gZzWi1XOzFktpvZK4/rD1moccZbx5RuVNn3il11I8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o0e8jH+qFf/gsdorSKKrqwNnxSKwBlDchKmHSxpwVdURdPcy9u7LDCQPsnTfGTp7qoiOPk0pWK3mFOeSGhBMukcOwTlwn2RMM1TJxoEGC3ep7USBU1U8yN8S11wIdMJ6hr0dkGKIlatTx4aizVFkkflk82bKrnA/XkNjNtwhZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/F/L1yJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/F/L1yJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5591F000FF;
	Mon, 21 Sep 2026 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980101;
	bh=1gZzWi1XOzFktpvZK4/rD1moccZbx5RuVNn3il11I8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/F/L1yJOmT3vWckkpbzj6fx1n4TPBezXYmP63NmHmNJAxyE4kBu/mKQ75dS1f0lS
	 FXkhidBx2zXMzPsUU3JTupyMOV0x6LKvcWyFSNig6lS/XN7+Rc57jI/oTgfa2jTz5p
	 a6iPVLwe45v33XCLoz2eJKexrJ3i17L88cIOPl6Y1rIEEW/OxuvvPOr0dFLl59dulv
	 yz9RF8ck86y4wl4h+Sq61Mm5opnJSEnKYalGRda1MDUGLfWXwg8TBES8tq9UIn18ae
	 vf42myzk6lDvHYir8dL860aKEsDc9X9QI0khBzQiwM9zqzqK+krmQCo0AWA70uAzfi
	 bCeNJK+UT63mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/11] s390/percpu: Fix comment typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-2-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:41:40 +0000
Message-Id: <20260921084141.1B5591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> This is all preempt_disable() / preempt_enable() pairs and not
> preempt_disable() / preempt_disable() pairs.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D1

