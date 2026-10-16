Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BF468C37
	for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2026 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144991; cv=none; b=rXStn4abgKGRoaunjOh+/aZ1gcKVGwHp+zTtXYtT6vGWDzULxATDaTlUIjBIqZAgqjocT95mu/HsgiCr12rSY+u/Pu3toD+C03gZ9KPJPGml8+HIJvGtr6ig8qbmnaUmwqn1cFoC10Ut9VVsy/dlbjMWY26W4U6MD2+xeXOKPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144991; c=relaxed/simple;
	bh=I6h+N6XX7B1TmTNtMY1xw/EgvIAKS9u41ibAv2RvPuc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b+EH+JKe70Zrzy0Ebfe+9U2mPHY8wAbpFVA0ujBRL/cpq41M6sdFf4zolhXgEu5DDH6mQgR6hADZgqnSXb4CwrI7YIEYlSJkr/3DMAgbMDWJeZCQRMddZCvoVxDkOK37/DdYd2+xy9pPA48btwAkZj9AdRxGnnP/BQYOLHZ2jeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgOsbviJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgOsbviJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9A21F000C5;
	Fri, 16 Oct 2026 10:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144989;
	bh=I6h+N6XX7B1TmTNtMY1xw/EgvIAKS9u41ibAv2RvPuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DgOsbviJomwLqMRn5xmGmtk0TLmJj3c5mKskgoP7xxeAvhzeOuTS32SuT+9yXt6Y+
	 oqLyQDDHHbL/iDqpDWP/qjyBELyekZ1zNBUsyH96ZnwoVLkhhSiwJ0KrULtkjO5uNm
	 7jnoq2aUPsSDNXcSazc7Fd/h7aKhgvqia78NeFeJXxQaV+WOMB6URHNiRTWD/U0peT
	 fiF/p8judXznpI10idctvZhLo17tpSDLGpaejuXSZRY05/ylWU6zbkIHnjt581ns7j
	 z4FVejd/ufg/R0lL7VnmlxnCq42/r3WTrE82l2OtkDJiNHfujJz/5Xzc3CjU5hSQQy
	 Y68/Fa373NpUw==
Message-ID: <sashiko-outbox-174118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched/hotplug: Remove unused idle_task_exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srikar Dronamraju" <srikar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261016095711.1364609-1-srikar@linux.ibm.com>
References: <20261016095711.1364609-1-srikar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:03:09 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit 21641bd9a7a7 ("lazy tlb: fix hotplug exit race with
> MMU_LAZY_TLB_SHOOTDOWN") moved the handling previously performed by
> idle_task_exit() into the scheduler CPU hotplug path using
> sched_force_init_mm().
>=20
> As a result, idle_task_exit() is now an empty stub and the remaining
> architecture call sites have no effect.
>=20
> Remove the calls to idle_task_exit() and the now unused stub.
>=20
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016095711.1364=
609-1-srikar@linux.ibm.com?part=3D1

