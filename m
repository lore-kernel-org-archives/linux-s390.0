Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466527E056;
	Tue,  7 Apr 2026 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586223; cv=none; b=lXU4Rr4/MPfYTg/E7X0vKJM5keN89cMll8sOdjzBb2z6dr1YpHb7pjuV3eqzeqKF8fJnRs152uqeScvqNIozBopaGH46ecF+EeDeP+dRVlVC0LNG1rYtUcmCl017KaKKrPtg+DxxbwK4wIQaOpqypnd+FcayLaUmm4cBrQqxvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586223; c=relaxed/simple;
	bh=N76D2R5eAwUh4tWjfHOYc9/1SbL1Ye348sNGcg6TEfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLYQXvanZXeQq1DqomRUyz0XXeVFt1h46qTmLdVLsYJEfw27h774JbVrEEk+cUHFkmJ7IU8hvMnlCjjpgdIoiUl930Aa6GOUpYCY9Wbz3KfTXPGB0b0E84RxMcEvtQigPZcvRJR+2GeKZIMZwuYcTvtcLtUWW9TiHkmASAWPKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=A9pZ5b7R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QGGYutQl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="A9pZ5b7R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QGGYutQl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C43FEC017E;
	Tue,  7 Apr 2026 14:23:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Apr 2026 14:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775586221;
	 x=1775672621; bh=8Iv26BED+JaSugKOZxH5xs5r9RbLVylG1Huh+x6ZaV0=; b=
	A9pZ5b7RldGvZNnTkI9V6QXMSTocMMV1qE3ykpgujNhRUPKsbCvkiLIMszfp/oAw
	xar+NO0xkZJoZtnLkGtfaTO0DGT8j7zMP45x+rVwJC9hi7b2gNw4KzxMEy7dXEbV
	Rdc4ugNv8Sdv0CImYzbR54AIwoc/qgN99mPomc7hkVoBNZDwkUb8JB64qkowm+ya
	6O2oNGiBBhby03xm6ERcEcdtRHnzIVBmFkN7oyg/D8hnhPhFSMXb3Kox/7TIw+n1
	LTSH+Q+bYMIbOcjfnYDZQHhSyKUIdLGltJKURnU55busQHUqdHlgMi2DE+tcLlQG
	b+TTxrPycL4vaOm02fLYKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775586221; x=
	1775672621; bh=8Iv26BED+JaSugKOZxH5xs5r9RbLVylG1Huh+x6ZaV0=; b=Q
	GGYutQlCEgc8dWWIh+CnR8pxt8+bYfzFCqE8VY6l83KMaCI1yYpzkjro6Mv235l2
	Zmawv0kmq3oejLdKgY56Ii3A2OlDcFqAzCkUzArv6AuI3mqmPTVhNY2a50GbQEtU
	+FSpnVrNg3S1GKqDVfBON7lqRr7ArxXDmjq062pbgdvmvza7nW3J45kB6DIdTNtF
	wi2/CNrBndcFWyZA0VTW///MzhRXuJ+qfw+mQm+l+OHTUL7TVKqO3ae0EoXWES25
	LTTFPRYlzMjTLolkodYFxeT+2xtW1Tx8IQXYhXYTMkiGhicW1TD+J3/fW06gSjNz
	nS/MygOFkn76YPq8t8M9w==
X-ME-Sender: <xms:rEvVacYjhUiL7l6dVNv3cSovcmminaHzdnn9GEB7UDvE9AK9j8kXAQ>
    <xme:rEvVaR0t9fYYx5-eLRdAXYY6J327a8Xsd1X4qp2jIyeJ9XqA4Hzfk9bUgir2m36hR
    ZTLFOTKXuh_bi7PtIV-NWtGMPERfgtUU6PwenUi8ORyivVD--rong>
X-ME-Received: <xmr:rEvVaefBEnxS1o9mapm2CguRkoCfAztTosGsgENlKkrJGd50rEgEZeHmXGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkjghfofggtgfgsehtjeeftd
    ertddvnecuhfhrohhmpeetlhgvgicuhghilhhlihgrmhhsohhnuceorghlvgigsehshhgr
    iigsohhtrdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejhedvtdelledvvdekuefgie
    elgeeuleevhffghffggffhjefhfeehueffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspg
    hrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhifhhm
    sehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugidqshefledtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoheptg
    hlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehstghhnhgvlhhlvgeslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:rEvVaeI6Fj6Exkn9UphXN7I5rwxHaxScTmmAQCW9Rf6heMu5UtxMnQ>
    <xmx:rUvVacq9IxIs_4LuaH3b3HpuiVbiUDc_M8DIM9Tr8NvH3nrPagb7Ng>
    <xmx:rUvVactV3ZAZODf7IKQxDRFe6QwLhGpsIeaS_BfHWtViG_y0SVyLaw>
    <xmx:rUvVaWI1ILhJ1f6ZGwAN9C2MeDDNJ2VGcc6G385D0gIgzJV_paA4Yg>
    <xmx:rUvVabOe7VBR2q50ugPsTg-diBzHnTIfEWkTHYaBt4KjD49Hy4cd7HR1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 14:23:40 -0400 (EDT)
Date: Tue, 7 Apr 2026 12:23:39 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v12 4/7] s390/pci: Store PCI error information for
 passthrough devices
Message-ID: <20260407122339.10846181@shazbot.org>
In-Reply-To: <5d8ba477-9a4c-4bac-b36f-a5c33de57850@linux.ibm.com>
References: <20260330174011.1161-1-alifm@linux.ibm.com>
	<20260330174011.1161-5-alifm@linux.ibm.com>
	<20260407093814.3d95263a@shazbot.org>
	<5d8ba477-9a4c-4bac-b36f-a5c33de57850@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Apr 2026 11:00:05 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:
> On 4/7/2026 8:38 AM, Alex Williamson wrote:
> > On Mon, 30 Mar 2026 10:40:08 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >> @@ -194,13 +214,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
> >>   	}
> >>   	pdev->error_state = pci_channel_io_frozen;
> >>   
> >> -	if (is_passed_through(pdev)) {
> >> -		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
> >> -			pci_name(pdev));
> >> -		status_str = "failed (pass-through)";
> >> -		goto out_unlock;
> >> -	}
> >> -
> >>   	driver = to_pci_driver(pdev->dev.driver);
> >>   	if (!is_driver_supported(driver)) {
> >>   		if (!driver) {
> >> @@ -216,12 +229,23 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
> >>   		goto out_unlock;
> >>   	}
> >>   
> >> +	if (needs_mediated_recovery(pdev))  
> > The test result is invalid here.  Why not call zpci_store_pci_error()
> > unconditionally here and wrap both in the same guard?
> > needs_mediated_recovery() should have a lockdep_assert.  
> 
> I think storing the error via zpci_store_pci_error() only made sense if 
> the error needed to be handled outside the kernel. Thinking more now I 
> think it makes sense to have separate locks, as the mediated_recovery 
> flag really provides information on if the vfio device is still opened 
> or closed.

I don't think separate locks help the situation, the might conflate it
further.  I think the problem here is that we're using the lock as if
it protects two separate things, the mediated_recovery flag vs the
pending_errs structure, but in fact they're related.  We only record
errors to the structure when we're in mediated_recovery and we clear
the structure when exiting mediated recovery.  One lock makes sense to
me, but it needs to protect both the state of the flag and the use of
the structure together, not independently.  Thanks,

Alex
