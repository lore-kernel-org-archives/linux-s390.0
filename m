Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75103F3272
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563904; cv=none; b=nFs9AJgRPv2awHTF679YG+8L0c0llfyHbouaKwXwbkcIUFHP9dKVVgt8JS42gOBvfDk9EojIF+i92WJP+F+bk9UDAhRO1WB+SjhkS4j+/hHvKfD2H/QGE/jerRUAEXaSHG73cDGA8O45nekW/rdNKXLnN0w8xPK7V4x8DMHRBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563904; c=relaxed/simple;
	bh=LLzOSb2OgLV6m+sPRHHnG3wo2Tab2LGYzv0Dhw9XabM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SLaHd0xsJF98M1kRxe2NuCbm5pE+RukuvbXXQQXCfxpiAQrwxrbR43s/Wj0F5d5PGG2LCJxggyWqizrfXZwNkp6kHV/Y5CcX3W4mDI+ZkbGdcfoLGomkliOhaWJcwmT7UTc6rWMBqyVhV8brZLz0MtjYXzEe9XyF47rAKl2vcec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxtylbdP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxtylbdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5301F000E9;
	Mon, 24 Aug 2026 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787563902;
	bh=LLzOSb2OgLV6m+sPRHHnG3wo2Tab2LGYzv0Dhw9XabM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RxtylbdPBbieC32pd3KxScETHMLdNv3NxfzY9cQq/1boetqMFZnffWLIGG2Ap/09x
	 ouoTejjecDQDoPPYvBua+R/nDTi+xfvx/iI4MestRqlfvKZn1DLG5m/T3JLY4863mR
	 Gl0NJhH2dTsgaUhtkuAwN+Kc4eBFZYT4A5EcZuyCMPjbj9iBUJ3pt42Xxfb6eK2+1I
	 kLhkdv9ocll5hm/0KAhSZ0ItvMxH8bBug7jTeylPSCOq97BvhJM22P7QMBoBeyLMbi
	 z6gF9v7p4f3BdtCH58hPWD6B7Q3XmxKCKBBfj93JOS1SmExAMr7HVWlRLhsjt7SeXa
	 poEqiEODAZjeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/pai: Move locking to event init and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260824092036.3075553-3-tmricht@linux.ibm.com>
References: <20260824092036.3075553-1-tmricht@linux.ibm.com>
 <20260824092036.3075553-3-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:31:41 +0000
Message-Id: <20260824093141.AC5301F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824092036.3075=
553-1-tmricht@linux.ibm.com?part=3D2

