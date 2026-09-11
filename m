Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142A4746C9
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118413; cv=none; b=QCa163KncRBlWjCJDLRIbUOKinJCIvXqW1XLAMUHSBZGtvutONpdX3kYz0mgjs1rk7MAnLyLxQJYuPzlsjp1e7rmHtjC5VeR0UM4flBa4FWouv1VIMOjfD/qJmtVf1nlfZAP/kSDRD6dLXVLmeqjyrX409xBfQukT2FJVfCv/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118413; c=relaxed/simple;
	bh=kEsyUFW6UZu50Mq3lhqGLlE/H4pv+6hCowBDyd42Lj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eWQM1o1rrB6MtymzAj1BEGMC6ryCEBnBlO2040tyxMnt/MLami5g1fzYHgtv77Z4Bi+ZemtI3t833BNavvS6Uhe2p0oU1BTddmrTS7rXGUog0yo/2bfYQ+2QxQXm5V7rDdbmK/OH6cGbrWsspLIkK9A2gOm68grFurWjRZ2RLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU8VKRnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU8VKRnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7ED1F000FF;
	Fri, 11 Sep 2026 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789118411;
	bh=kEsyUFW6UZu50Mq3lhqGLlE/H4pv+6hCowBDyd42Lj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iU8VKRnOciFzFx5+6RKoX9CT4NsbzwMsxzlvQT2auwCSB6liukq5zs8R4xeOe4g0i
	 N3ZIqvCQEyD9o62y06SGkHMsVLFJzOQsdOS5SG326jIpK/Z09y9QQtIfPQuPXInyXG
	 ueB6xtx2H+M1jkS21Sci0GfoDpiaR5ZQnwXeM9mQzmE9eWRfZniIaloOspCeOXvbPH
	 xZkSSirR/xDEVwdHGO881Fuju1ao7gsdA3IbreNBM+YEIk6CwGZTDTkmcMXLEysJgm
	 WXMqOxQSRUjSEkyJI1dKEQ0E2txo8CjXhQp6id/JufP2rE1mjLpXhfRIYr8EKUaakA
	 Rf/9VtvDRuDsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/hiperdispatch: use system_dfl_wq to reschedule
 hd_capacity_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Euan Bourke" <euan@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260911091309.1238604-1-euan@linux.ibm.com>
References: <20260911091309.1238604-1-euan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:20:10 +0000
Message-Id: <20260911092011.2B7ED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In hd_enable_hiperdispatch(), hd_capacity_work is scheduled on
> system_dfl_wq, however the work function reschedules itself with
> schedule_delayed_work(), which uses system_percpu_wq.
>=20
> Hiperdispatch does not benefit from using the percpu workqueue. Use
> queue_delayed_work() with system_dfl_wq for consistency.
>=20
> Changing the workqueue from system_percpu_wq to system_dfl_wq causes no
> functional changes.
>=20
> Signed-off-by: Euan Bourke <euan@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911091309.1238=
604-1-euan@linux.ibm.com?part=3D1

