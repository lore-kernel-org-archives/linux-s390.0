Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050A47F3DA
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202453; cv=none; b=J7ESYGtg6COzw+Xsy8ire48n/OAKQCZWdmJdts5oLnL6qEJYjjqvMTCQ2P8Ym7ki/Njfj9wst+9jR/gvA72yZ9aI6naXtkiI3ieWJD7ybi1C1YJSPZeOMd4Am/AkxXguftfXd4JTiiyrJHG5DhVsQox6W00Iaf/q3G5diRzCsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202453; c=relaxed/simple;
	bh=Yi0F+iYQQ4vJDrd2VZ1rHEK4v0Wg/400O59RtVrk+Cg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MoWsdgfUu/gmbZzs1FVLPC2Auf5mH3mnK2T+41UPhfPPt16P0DFT3gEXJtsxihW1ww+/CsOMmMp1LMXiTmWKN5aVyKoGaqWx1w6MBlU8DVrjkGi7wXX96lFxyoSTFtLuHIxKcKQms//zqii/ciT7L+nfX71YRK6O7P1Q2dxLorM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4/F0iKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4/F0iKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866801F000FF;
	Mon,  5 Oct 2026 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202451;
	bh=Yi0F+iYQQ4vJDrd2VZ1rHEK4v0Wg/400O59RtVrk+Cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4/F0iKDhgB6Kyvo/yWhYB+MoGMSf7yKRv1ycvEd5ba/v2orJDy37FXyuF9Fnvsll
	 S2GMIlCAOi1nlIK40t8hJZJ9WRouA3cDeSUgCqe3NRstU1Pb0QHe0GoHTPfTYdmBhr
	 /tUylzyeU9DnfK06H2QyzcMIXoicnxaLhKSMmhPtwMz/g/idt5WsVFUakPq6Kv5KgZ
	 L782OGvi/fixOPG6xh5chM/axC+YBtmpde14SA1wlfiPHYxcsuGqu9vHkTqVG5e/hB
	 fx2amEXax3tYixciYz1pIjltqtSmt17F/ctwBpW1JOF4bI6hMEmKHB7AcDVfK23p4V
	 aR81OJFDZ0geQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] s390/pci: Fix use-after-free race in zpci
 floating interrupt cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-4-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-4-d45b824874c0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:14:11 +0000
Message-Id: <20261005121411.866801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> zpci_clear_irq() stops the adapter from raising new interrupts for the
> function, but a zpci_floating_irq_handler() already running on another CPU
> can still be scanning zdev->aibv when zpci_msi_teardown_floating() releas=
es
> it.
>=20
> Clear the zpci_ibv[] entry so no further handler picks the vector up, then
> wait for a grace period before releasing it. The handler runs inside the
> rcu_read_lock() section that do_airq_interrupt() holds across
> airq->handler(), so synchronize_rcu() drains any handler still in flight.
> Free the summary bit only after the grace period, so it cannot be handed =
to
> another device while a reader still holds the old pointer.
>=20
> zpci_ibv served both delivery modes, indexed by summary bit under
> FLOATING and by cpu under DIRECTED. Only the floating vectors are
> published to and torn down under the interrupt handler, so split the
> directed vectors out into zpci_dibv and annotate zpci_ibv __rcu, which
> lets sparse check the accessors above.
>=20
> Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-s390_irq_d=
omain_fixes-v2-0-d45b824874c0@linux.ibm.com?part=3D4

