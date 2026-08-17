Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B88393DDB;
	Mon, 17 Aug 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988319; cv=none; b=IV9E7DDzse0z0Lz+n2ZU8I+SmlaPROSqPNZfZbj2FqptVpT0fcOtVfhuzCiP/BsrHmsQN/lj9xOfQ227PYaK4i+qWTwWQrnxL8IkV3foIE93rjQuSYz3Z4XGbbdEUJVEzkSsj1ZrtHQAhml4IvWkgo5oxYPOYttCjMbEfhJhXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988319; c=relaxed/simple;
	bh=Qbt1o0wMycTwJ1GL5oZ9HxzAVrSrIUG8nNgx5BoO0t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Stbor301F9b8JFWMn02kMIYvxlCFX9XfDHKXkGrjCjlSYESjx1gNhnOqq6Tzl80g9qJiU2Wy+Z9PKhV4wd40ElZVyKTOLwqvNUjbTriWwZm1hk/tAshs7MrlJFbjLHnq1KPsclEEaXnNFZOCqMbyek3SuZGFphTDu6iZVVPUP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=iEphzg4Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kI1hBIfM; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="iEphzg4Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kI1hBIfM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 263F71D000CA;
	Mon, 17 Aug 2026 13:38:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 13:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786988316;
	 x=1787074716; bh=3DAjjQb1sVBvzUBxcb++grv68IomJr+QSHNKRlV19VY=; b=
	iEphzg4ZhHOjAfOkGX3besjejUtPYhEcdTSSYQc8o6r/S4zqSL41LhJ2DBkvPfWP
	VW6OIqApINrx88BsBkaArkKLmvqdm83x8gxJNMKgp18InyRmxP4jn9Bt4ZnXb5vm
	zyN3xEDDKWjGb0hKyC5EhlF/Pa4DIie9DBSFKfRqWjO6gikPs8VWK589T23LG/uJ
	nju0S9uiwJcbwk3YDcJTgnOficw3b1HC7e2fGUAdHt8D1E7M3PLSYJMpZAmXoRp8
	dX2hJLEH0si3Fm0YCzZBpAnWfvQhgUao8S8DZzqyKrf91VCLX7QsLPlxkuOcbrgf
	KxqpahQKDQ6hbM0scLLHSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786988316; x=
	1787074716; bh=3DAjjQb1sVBvzUBxcb++grv68IomJr+QSHNKRlV19VY=; b=k
	I1hBIfMszWYGbpOJxXC83sKBBBASOFj9mzNC47IKgTDH2af7VZs7LvLtQTKUt+LV
	NrgjRwqiCUf5D2stuKmdTN9ZBd7Ls+yRfFLhiu5DW+N+bVKRJF/f+IbkIWwMhILZ
	okX0RRDbV0n7C0aEqp16cp0g6dG5/p+JIhhLfLaSHqBMdi0cL1PKypZlxPpsGRK3
	1gM2k0so7cZKMlcSpk9UBoLYZ2rjmp5XWDp789yr9AAPXFb0JzXqirqWqdcIx4HN
	sPC80Reup9l16KxzgF4JdZkZARfb/TNwIhdF9s7Xp5he8aAgm4MP7bU6FWA2B7XP
	LCzhgEdhNRwlTwuZCrC7A==
X-ME-Sender: <xms:G0eDai7U-iU-eMkm5ShwEVZ6fWEVoYzzXuSV4bEqpKDbI2eF1THJcg>
    <xme:G0eDaten3M1MG5IYK-c6dkAY_BDVNzUz4bopwgKYGhQQgUUG2zzqeCobub1tBbUg2
    N-osOkbi36vSc1Iv3Unaou8mENfWsb6okJ95ro2hhLPHg_NVaHPFJo>
X-ME-Received: <xmr:G0eDanyHvolmUdhPZCukHwCDSFbVDOyQ4XxrprT5nwAp5JLNKfSfMUoYQ-ZMGw>
X-ME-Proxy-Cause: dmFkZTEUs5+Z6RTwXDFwlRbeEZQpPZd7HyiQhBCpOcR+tKedYEs4GVWuJWvSyRCEqf1F5t
    WJcbK7jEqr/wPqbBbDl1SHLxk6Pm1ILnKBATdqim5tklQQRxc0oNBQH0YZWKrbmpCv5y1C
    Q4uibz6iB8sqDi1I2olnx9jo2jGTu5xL84HnLknbukoDhqpaaGROYxq4GgNOCbFbcZPNHs
    nnDRQhfxhE53ZPlbBSTOGQYoDpmazBn6EmWCvsU1zOfG0RMZnDX1t6ovfe8z9/eUzazIqS
    Cj9JMQGnP6VZyYUdR/pMVttqFD1SFX0SNsGkk10wIvNhaGm53nKr6FDTB08E6lVG8aOpNx
    to+FLRuHeNDzVKm8sDkt/T3kJ0hu/puyUg2jsgi5kS9exzVa7r7GJdQ79vj9ALCM5w+g0U
    0JlnsLyBdBQwTzYszRXloLu4XUAL6Gs49S8XlJs2XYpgdD7CGLBh92FZPleLUT2rQpanQE
    qkXDD4IP8JyHrKC8kwNaBGy5lHjWDWxBeifhWCKX0Q26NyOgoQQjQuOvawnuXAz2BVa1BB
    rN8qpGCEkkcQrDcyB0/yxfUEGzWmPeR0totLxfJFi5nedB2vFMEBj23lMiuVQo0KIpB1Ki
    T91V0olkJ2BLQRuhmkcLPxc4vsaNkcggaEmPbFH+a9E6NFi62vanD7CCse+A
X-ME-Proxy: <xmx:G0eDaq9Qz7VgFkNrL_GSjigoackTdzj1IvlE0nIyEJr389ASWvfiNw>
    <xmx:G0eDatyVi__Zlk-toGbzDY_1PI4kzQ6rzDPSAHPmksLOcf3h1JoHoQ>
    <xmx:G0eDaqpOAILo5vvInK6g-K7znk82ru00ezoPwTwpDfEvrLnJviDZBA>
    <xmx:G0eDauqxiGrq5_zms3T2Ho0xY5ZYd_vdvWKX93Rdq5f0wiKkEfY_qw>
    <xmx:HEeDakly2mybasK09Sn2wFjJBuNV_X7E9S0YTgI9XFs28IeIBjWUx6MG>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 13:38:35 -0400 (EDT)
Date: Mon, 17 Aug 2026 11:38:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v20 2/3] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260817113832.08878292@shazbot.org>
In-Reply-To: <ade2ea72-9491-4c03-8b67-08011c2c7328@linux.ibm.com>
References: <20260630165553.725-1-alifm@linux.ibm.com>
	<20260630165553.725-3-alifm@linux.ibm.com>
	<20260717152650.3cfc2d10@shazbot.org>
	<ade2ea72-9491-4c03-8b67-08011c2c7328@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 09:26:14 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:
> On 7/17/2026 2:26 PM, Alex Williamson wrote:
> >
> > Otherwise LGTM and I can drop the initialization on commit if there's
> > no other reason for respin.  I think we just need a branch from Bjorn
> > to base this on once he's happy with the PCI series.  Thanks,
> >
> > Alex  
> 
> Hi Alex,
> 
> Bjorn has accepted the PCI patches and merged it to his pci/slot 
> tree[1]. Would you be able to merge the vfio patches? I was able to 
> apply these patches on 7.2-rc7 and didn't have any conflicts. But let me 
> know if you need me to respin.

It wasn't clear that the pci/slot branch was going to get merged into
pci/next given the discussion last week, but that has finally occurred.
I merged Bjorn's branch, applied this, and pushed it out to the vfio
next branch as hopefully the last changes for v7.3.  Thanks,

Alex
