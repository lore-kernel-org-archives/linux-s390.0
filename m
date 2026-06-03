Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457203D522C;
	Wed,  3 Jun 2026 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452241; cv=none; b=pQ4lkHi4ofGYp+0DiHWnEMeLPkScLQLfugK5jVWfODD20eulzspyFQoNOY+gRHfo94aGzmbzxTEV6XvOKrlO3fNxKfWK8CJLqLUgUGg48/jbcvI9plG7oPA5aXw4Y7rIq6h2kq1LWGIQnfyclYW++KRojE2sHCurzQu55be5/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452241; c=relaxed/simple;
	bh=KP0ZGB7IpUZSalJwnA0ZZrHf07C+8tXSGgbchJmuOm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3w3pWW72Qnv3e+AS12BrLpgSRtVc0aRNpyXSN3IgLnc2qxTfYZbsifyvu0TZ2L291N9DZxbLPMzPinSBV6DhvZZJMdSg6SN/nNLZti80H00CSOxkyGKurjJ9OTK8HxO918hSdFFblEnIYMwVetSgfJZ6IWVOxjqattkp3I1sRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow/HBt89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow/HBt89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413231F00893;
	Wed,  3 Jun 2026 02:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780452239;
	bh=JVD2HhSDAP4ZcZUXZdAlOPPcrhtlTrNE8QjoL+hv+8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ow/HBt893Avqrm8SmIushEptvkTiJjm6o/pfNjcbAc3QsIYCX0LUECTOoRwrzO3NE
	 kBVnOfQeH3tTCY6n33gse6/jh2nvYTdnqE4Us3yNfvAqfbt86xZqIr0BqGMNpZd7GP
	 Oaa9cTFdnKbV3xewQ6jRNxEQzPYhCW+FDtwf0ydrzmlxaQHQ2/6A1r5yF/sSRkMpbm
	 4G/KcIRTuz/nIRd+hSnS8iqA94OQTAaC40B/zlNdJbOItQTtm1IT1aaBeSWKDJJOq0
	 PlIqFfzVIUMZTuJfSxytuRXgmMpOdpk2ES+WdA9tnsIKzQm0NjxN/dfqEtiKxWspAw
	 1W4+2LWMmpQmA==
Date: Tue, 2 Jun 2026 19:03:57 -0700
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
Message-ID: <20260602190357.62c04d40@kernel.org>
In-Reply-To: <0b3f00bbfa6bcc3badb4d1bb7845326e2dbaa1d4.camel@infradead.org>
References: <20260412084704.743482ad@kernel.org>
	<4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
	<20260412095301.4fe1fe65@kernel.org>
	<ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
	<1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
	<ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
	<3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
	<ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
	<0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
	<20260601185226.7f43fa75@kernel.org>
	<ah5aGMIxA418sxoj@hoboy.vegasvil.org>
	<0b3f00bbfa6bcc3badb4d1bb7845326e2dbaa1d4.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 02 Jun 2026 09:04:27 +0100 David Woodhouse wrote:
> > Even though the "PTP" naming was an unfortunate choice way back when,
> > still I'm not a big fan of moving stuff around "just because".
> >=20
> > But moving forward, I would suggest starting a new area for pure
> > hardware clock devices.=C2=A0  =20
>=20
> I think that ties relatively well to Jakub's "does it purport to know
> real time better than the host" criterion?
>=20
> Although... ENA *both* purports to know real time better than the host
> *and* does packet timestamping, and it looks like GVE is attempting to
> do the same?

FWIW the ENA driver as it exists upstream does not currently support
packet timestamping. Or at least the usual terms for which I'm grepping
do not hit anything in this driver. Only skb_tx_timestamp() which is SW
timestamping

Given various Google projects related to use of time / latency for
networking I think you're right that GVE is likely the first driver
that will straddle the boundary. For those drivers which are both NIC
and virt we can stick to net-next, just always wait for your review?
