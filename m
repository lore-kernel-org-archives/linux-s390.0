Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F8399348;
	Mon, 13 Apr 2026 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117521; cv=none; b=asNoaATrCxk9nqYTEoGrfa181sILmb55d+AhHG2yG+sNVfo25BBZizh6FI/5ZpXW8jpCpSalOsiJWCRwim0LnUE0dr/qbLHoPZStKOrR+cty2rB4VEJZ7HcNgl+DnR9GloObNhrdtqe3sXGiCDMYZqqiugo11TE1vFifnfecv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117521; c=relaxed/simple;
	bh=2XYfBvfT+UEFna0kWORcHWLGNbscFLCwfHt1ltc/pCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhebfNKvMtw85RG4HXpUJJrerTk6WBCNITQzwg3dvE19hYXejqQSaAhZSMA3Wvdn/4TEZVYtf7kP+ZQEPcrFj9UoyCk0EZN/dqu+2czFTCqqmhHOtquamhqxDkF9hrgO4SAJCFPiefpQXHE1J9tM4Ewq+z5WEqHB/+sFjAvum1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ezkrbNAW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LuH2Xwn0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ezkrbNAW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LuH2Xwn0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 36676EC0516;
	Mon, 13 Apr 2026 17:58:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 17:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776117518;
	 x=1776203918; bh=oKY21MPppCmjWn+4vtpziBqU7RYeyA9kdQSFsUQQEYY=; b=
	ezkrbNAW928HESHLxUzyaYl2iUjwXhJUitgfcXn4G4WBuFOjWO/W3PqqF6squecv
	L0oxVtcm/zYSicWQape5PDLq2Rur7nM2Mih7oSgvD9TMskTmtnC2LrKNUcWcweeF
	hkWDmX2plXlVUj6jMkAIPS7ZP/s4BhNx9Ksocu1tD9udXmO7JujJDfWmEPt8rXem
	U8CYanmWqE45Lb5OSDX0188G0WSI8ZZ5hh0OzwPSLSe+Il/F48GEBfS6GClowWlj
	laezdnHikfFt9DoKZ1egVVvnCUlqi7E/2W55SvsF/yUAPb6o5WAfOe2dZ9TGm5FV
	d4kL4tdCmZz23NK2/ltxlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776117518; x=
	1776203918; bh=oKY21MPppCmjWn+4vtpziBqU7RYeyA9kdQSFsUQQEYY=; b=L
	uH2Xwn0fsyqNGec03jDXScLrOvjkiKd6WJ1QjPiQFXeDZ2AiwVPbbilj8PFkvxaD
	tMSuVpXkd7Z4hSn4JRiWuObsSd17WYHfWq7Z0miKBdxGEzorVJQCLemhPPL1aDkw
	E35fdyCgjUc7TKOBUwa/GdWgfuQ5tkzmtJzq41xityHMvQc2gbN96VqqTa6efOHX
	0405yqT4hR4vvaqxtMETH23mwi+W2ty+34QEVmLjI2aZKkJ5oQwwN0L/rZfnmsj1
	hXoMJ1RJk9hsSZUZAtm2CcsHbtKg2B193e1pS3F1eJkI7F1YM5ch2erFe+xjiQ7p
	BZ/ZiWHBSDyImHXgFQUlg==
X-ME-Sender: <xms:DWfdaabNy25oZ3VtQdULWoeUdpzLgLQfsgE9cHGQRlCY4h-ex9ZHtQ>
    <xme:DWfdafq3X8-ryGA6AiqQYkRHJ9PRTmQnvrSGIrncrEeOxWaCaDehjCMObzLgR3zIh
    NC8PJZhX_EI3qUsCxRoiCt3XPoCrrILG59Wxsuo4m71zsGm-3nTMms>
X-ME-Received: <xmr:DWfdaXPNx5xQ_Fn1ROOcGe6bCVCVNuL6fwr0-4dwO68ZQWSKZPiqAhUTGPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkh
    hrohifihgrkheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhs
    feeltdesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrg
    iisghothdrohhrgh
X-ME-Proxy: <xmx:DWfdaSo6W_L_frs5t4vHiqfTl3sx1MVIIadYw47I0O4C4eSeW4lXTQ>
    <xmx:DWfdaUdUhnk_5ads610rO-L16UjJaXQG9BkBRWUifmH-BeOYZo7oTA>
    <xmx:DWfdaQQMqwN8caRRsIwtxDisOJbN0j6u6EVdwEEPE8QKom2VnE7VUQ>
    <xmx:DWfdaVYRKjzo8Cs5YuqzsJ3Tk9WJ8kuT14rwNi8RG-QYvOiizI65lw>
    <xmx:DmfdaRjZPTr-Ji--DxwuRwso2wEKucvkRvR1RwSGsAjRcDoFWoK0euE6>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 17:58:37 -0400 (EDT)
Date: Mon, 13 Apr 2026 15:58:36 -0600
From: Alex Williamson <alex@shazbot.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 akrowiak@linux.ibm.com, linux-s390@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] VFIO: remove dead notifier code
Message-ID: <20260413155836.124aae47@shazbot.org>
In-Reply-To: <20260407175934.1602711-1-pbonzini@redhat.com>
References: <20260407175934.1602711-1-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 19:59:34 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> group->notifier is dead code. VFIO initializes it and checks it for emptiness on
> teardown, but nobody ever registers on it or triggers it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Documentation/arch/s390/vfio-ap.rst | 18 ++++++------------
>  drivers/vfio/group.c                |  3 ---
>  drivers/vfio/vfio.h                 |  1 -
>  drivers/vfio/vfio_iommu_type1.c     |  1 -
>  4 files changed, 6 insertions(+), 17 deletions(-)

Applied to vfio next branch for v7.1.  Thanks,

Alex
