Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1F317150;
	Fri, 10 Apr 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849529; cv=none; b=Tu2rxHClmzQxPmmrtjNPJtvpKCRM2jm77VJszun0xtiAoKMqvHp8dxn3aqEywQmYrj0xJxwQeB6NQWM2K8PeqnMR9DEdX6rJpfbwuP1uHPR4XBdfKJfVLLDprx/sA/S7Ww1fGkd6W+stw01cvj0BIxKOtTSsjZLx8PU3FNCD/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849529; c=relaxed/simple;
	bh=pgp8mgrd+ZNMUB/UohEgTN/efHobm4seJjbSlnLex3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBOP7Va+qRlI2mbOyCr7ngZPEY5x+fmcFsiPY40iBdGARCwrSsD9B5K1Zc0xbgBIvvFm1eSxXsmgIuVoNpXL7Kg7MEfdKUu8PyiKPeYv9vB9oZM8o0SxytooAWYhuzr6TbQr9KFV+eakhsmDQATfnpmDu+4OEsDtPNNXaGquvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=rGMxSCqO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gnadNQyF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="rGMxSCqO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gnadNQyF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76FEF7A014A;
	Fri, 10 Apr 2026 15:32:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 15:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775849524;
	 x=1775935924; bh=XVC68HMX7Y/P9CImkugPNyRhCID76nQcrpXLDDdfJ30=; b=
	rGMxSCqO6oQtAFIVpw8SUiCqUYwGUUMOXwGbkiAjM6nlgng0a1mfcVPacSAhxq8B
	eNQXaiHtMrXwhsOM45FxYd69UgvMZWYyautI+NNvQco6+8NYjmFMGiyg0SwJ4HJy
	8fnAy3/DCBkvZUCLEZ5slAFCcVLSmC1vkZ6okAHOl50oTjm7+ToRm2xwjMirUoOu
	lXW14Nx1ptsAhIYZMtPCnvJnR16YMEl3wHe9xcfybB2sgG09ngAzPOgXzTKu/Ua3
	JOix5MgJQ9w9G4NN3Kb68Sx+25DDRrLm3qS9doFcvHhktLDgpeVLjY+bLFd5GL8C
	swWBEKq/cZPmhh6MitHhfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775849524; x=
	1775935924; bh=XVC68HMX7Y/P9CImkugPNyRhCID76nQcrpXLDDdfJ30=; b=g
	nadNQyFX29oXGjbeuBsJ0hSZ3nPA33ISGiU2smFJY69uSCBUxwyencYFrqRkhU4p
	b9t0smWzqweYwKgCiUjWJt7CJp8Ha1VGzUqgLLg1iM+nzN/8fxndkUi08ef0UWPJ
	BQN4G4YI5WI5PbvFEK011XIFxNeR6xKKd1fqR9xoOyEEZd0Td8fpPKlUyV3pbP4j
	1YbENzbZIBDBX6zW5F5c0cuVtZbaWQZIwD0rmvCqmVor3TlCpvJ2K+W+vAtfSgMt
	bRmZDr4a4bQ5ilxRgJ7k6ymZkDAQipLojXDzNK3datk5rXXs5qX8dx7YtDYP35BP
	bBxrsj3ZxdI0L1SyMEWHg==
X-ME-Sender: <xms:M1DZaeX4813aYOp3uBpMpdz6KrRF4YfNLtwMm2akdQbB0QplfH631A>
    <xme:M1DZaZqyA8oJvT5iLegzGy6vJ9w1XzVzuGuKis-XQ1J2aAOoI29U3lSRjNLbwK9Ks
    pDhRWvmzKLt8JCWpOX4YceDRieIeyjADNpIXWNeTPM2uAJ7qBSC9A>
X-ME-Received: <xmr:M1DZaYkljht4ffjut8OTuv2joTeaTET31gISYXUCQY26TKgWG5Lq35f2Thk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhopehpsg
    honhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhrohifihgrkheslhhinhhugidrihgs
    mhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsfeeltdesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:M1DZaR0vdE4Y3ZKUPThI9VFNv0ackEd5TJZCGA1ueaLaNoX0rNN9Bw>
    <xmx:M1DZadSrxoZ2tz9JjrR0idXavY4-YOhEz4ZW6aloRbeKw1vhwegEQw>
    <xmx:M1DZaSyfHwGnjfPFItrfp434VuRULnhaMhMScv6YvGa_ia9gGPLKzg>
    <xmx:M1DZaVCey0pP_nJ2GRndtFP6EtEj9gw53jDVEpS-Ms9H3tDNp1N1_g>
    <xmx:NFDZaVCw_V97rLVfaAInuHjXNqo_WsDXsqHHFQ94ig_zu7V9ksJyW2-h>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 15:32:03 -0400 (EDT)
Date: Fri, 10 Apr 2026 13:32:00 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, akrowiak@linux.ibm.com, linux-s390@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [PATCH] VFIO: remove dead notifier code
Message-ID: <20260410133200.7010cf27@shazbot.org>
In-Reply-To: <20260410181006.GF2551565@ziepe.ca>
References: <20260407175934.1602711-1-pbonzini@redhat.com>
	<20260410181006.GF2551565@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 15:10:06 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Apr 07, 2026 at 07:59:34PM +0200, Paolo Bonzini wrote:
> > group->notifier is dead code. VFIO initializes it and checks it for emptiness on
> > teardown, but nobody ever registers on it or triggers it.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  Documentation/arch/s390/vfio-ap.rst | 18 ++++++------------
> >  drivers/vfio/group.c                |  3 ---
> >  drivers/vfio/vfio.h                 |  1 -
> >  drivers/vfio/vfio_iommu_type1.c     |  1 -
> >  4 files changed, 6 insertions(+), 17 deletions(-)  
> 
>  Fixes: 421cfe6596f6 ("vfio: remove VFIO_GROUP_NOTIFY_SET_KVM")
> 
> ?

Technically yes, but is it really worth having stable pick this up?
Seems not.  Thanks,

Alex
