Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8322D1F44;
	Tue,  2 Jun 2026 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365150; cv=none; b=ktaWfLI4Rno9yanbM7uahloN7yXMAC11nsbM7nU7OdARx4yCthMqMQh7d76BCTNI3DZq3EeilIoICyiYUDMiYFKY0R/UD25EmOVAywDIYuleUAB1tHsqnqGbMea5genHDiplM+4Pdg4DsEtJcQW9Puw6Flc7UUGZKhoK551yKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365150; c=relaxed/simple;
	bh=UbeHIEb23qudY7Yu6sAEN6v7i5GXY37qr3IyEOTwhFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNNmAz2rl/sE4sFboFHII2gbFQTatUxmZ5CrBSmCL2lUXXvJpSesgLqeSjkTU/OfZ9A42V88TbDa6le4bzirdXR4dF+07Oo9gZmKal1vNi3nKLTTWD6c5HPRlb0l8Lt8uvg/G2rZ07O1HhZbI789cLC0m/x/uTe6WGhbaBOzacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bljXLWJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bljXLWJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0F81F00893;
	Tue,  2 Jun 2026 01:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365148;
	bh=UbeHIEb23qudY7Yu6sAEN6v7i5GXY37qr3IyEOTwhFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bljXLWJVhKCQzIrEQUgvjQKwoL4IAsNEvv+tFevNyZTEVXA2DKPgS5KgEWo5fOlfg
	 kAD4eMVM9s5FG0IoJ3iGq5nZ5b7S5s8/emYRBZYpJ3xw2Y7hFDGg6vkGbBaLM0THn/
	 Obdgn6fdZrlpoXoIN0jLB1Xs6+Io0zbcY04Iu+GLlO1m//ZqhDM4i/whYxfsJacxsc
	 zRXhZcHFlmhVQH04C4njokwHJ79ywP9pr+U3dxwqNmVudh9W5U7FI1/v/VW3xMjSAA
	 PDVQWfm8eCioNiqxuDfM4jShJ4n4uQwNUtrmrgSuMvcW4DJ9GFAHGwyoK4fmGHXRU3
	 oHC0gYTqR85Vw==
Date: Mon, 1 Jun 2026 18:52:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>, Wen Gu
 <guwen@linux.alibaba.com>, tglx@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jstultz@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, daniel.lezcano@kernel.org,
 sboyd@kernel.org, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
 imx@lists.linux.dev, linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
Message-ID: <20260601185226.7f43fa75@kernel.org>
In-Reply-To: <0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
	<20260407104802.34429-3-guwen@linux.alibaba.com>
	<20260412084704.743482ad@kernel.org>
	<4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
	<20260412095301.4fe1fe65@kernel.org>
	<ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
	<1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
	<ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
	<3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
	<ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
	<0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 01 Jun 2026 17:53:49 +0100 David Woodhouse wrote:
> On Mon, 2026-06-01 at 08:20 -0700, Richard Cochran wrote:
> > On Mon, Jun 01, 2026 at 08:03:26AM +0100, David Woodhouse wrote: =20
> > > If we move all the plain non-network PHC drivers (which, as noted,
> > > is
> > > basically *all* of them) into a drivers/ subdirectory, then perhaps
> > > we =20
> >=20
> > Sorry, just catching up here, so the idea is to have
> >=20
> > =C2=A0linux/drivers/ptp/drivers=C2=A0 ? =20
>=20
> That is my current suggestion.
>=20
> It stems from Jakub's response in
> https://lore.kernel.org/all/20250815113814.5e135318@kernel.org/ that "I
> really wish someone stepped up and created a separate subsystem for all
> these cloud / vm clocks. They have nothing to do with PTP."
>=20
> There was some further bikeshedding in
> https://lore.kernel.org/netdev/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux=
.alibaba.com/
> around how to split 'emulated' from other hardware drivers, but I don't
> much like that taxonomy. Some of these "virtual" clocks could just as
> easily exist in hardware with PTM too.

Not sure I fully understand what you mean. Practically the distinction
is very clear - the virt devices are implemented by a hypervisor and/or
IPU which may have some HW gadgets and PTM support but beyond that are
software-defined. We don't need help maintaining drivers for
fixed-ASIC (?) clocks, atomic clocks etc. Those are usually time
counter + misc. They are not "devices" which know the wall clock time
better than the host :\

IOW the "does it have a NIC" is not a great distinction.
A better oneliner would be "does it purport to know real time better=20
than the host"

> My observation is that with the sole exception of ptp_inet.c, *all* of
> the actual PHC drivers that live in drivers/ptp instead of drivers/net
> are "pure clock" drivers, so perhaps we split those all out into
> drivers/ptp/drivers/ and exclude them from the netdev maintenance?
>=20
> I'm reluctantly prepared to host and help maintain a drivers tree if
> it's necessary, but equally as happy to let you own it.=20

No strong feelings here, but atomic clocks will start spilling into
DPLL and SyncE pretty quickly.
