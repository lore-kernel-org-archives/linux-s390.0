Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D538F250;
	Mon, 31 Aug 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209790; cv=none; b=oCJpgohSC5aRwlshof9Us+gAxv1+I9pSFyhx1iUVb87AUDmmOYxN5XdJSYrTB5oUCtVCDx/t8gK+6xDb9bRM344mjr6nbFwRpFJ/oH/TXulkWERbwKt+73kmAQSFglsfk5SxJC1tCLuasoD+ic7sJTmeBgSPZ8NALtK7J6QEKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209790; c=relaxed/simple;
	bh=Ax6enznvwZE9SsYI/FVHzIRZBf5NDPEVdUflJd18v74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DULvqTZyj8w0EbU/eEceJxfRjKAesKi92111k+6ZXXrqRMw1qO7OaVZVPvXdzIC5FDYh1623kYzeFL1H9OB7t1muifuqqwj35NX7vaR662AcsszGCfNSXYkgU7lVT6DRmzKsznrGAPwMUFZZkcCj8kUp8EtOmFNkA96vqeyAe+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGApCrdb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGApCrdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F1F1F000E9;
	Mon, 31 Aug 2026 20:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788209789;
	bh=Ax6enznvwZE9SsYI/FVHzIRZBf5NDPEVdUflJd18v74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PGApCrdb+LIDZcrt2+BZZBvaolEGUgHsZ/LGY46A5BNAWd5RJpdHkg6TnBorpTfXV
	 rbYOVRFbhBgsVYI2c0br4wiUKaZF7zhRSAqn/k4DnFGQOTAaQxIAj8bPHVjsTDjowq
	 V3ZUb1cHTtn3+NGHjpfeuR4dwyGOrZqLzUCinyUZ+hbtNCopsr9q6de639ZVpD40MB
	 eiUuEAUn/1k8c7AQ6y6FSc6XdtYmLZpUzJhEbyLauXBMNoTZIxGM7ly2IVH1ZzpsgZ
	 Y5VEHBGB62Y1BjxTKp+DC8qcK5mvfNt9bQY3Z+g9+NBBL01uvXEJsKP2C73qi/hiUR
	 OmEWSm5GVJNkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/23] KVM: s390: Add basic arm64 kvm module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260831144802.834315-19-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-19-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:56:28 +0000
Message-Id: <20260831205629.01F1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add basic code for the new arm64 on s390 KVM implementation.
> Add kernel module boilerplate code and trivial functions.
> Add tracing scaffolding.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D18

