Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB553B3899;
	Mon, 10 Aug 2026 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405246; cv=none; b=RtG2TAXGz96mVfYiUfW9rQPiU0/VNYGkq5a/Z390tcl+LEcTrloPC4n/SBWHIRmIDwKabBIONNwS/QVxbnRFD4Knt7pMYim+E2FdRMkCNqie/U22/KJqiX+xWnXDtuZ5obN1Nqw89mIT4RciOwSSCcKsaJ7UPb1iL1Nl9+VaE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405246; c=relaxed/simple;
	bh=61i0Tj0rEYYqSEC5nfj1ndmvbU2GK4RVRd6AoQA6d8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6GxWsvxGOuwkCMp9FZfmvDYcqnp4OA795uvX61g3nGzs6AdvpvwFDubhZsx0mTJ7QSWT6OohYC4Js/UknFOMpQPdAeYlXBtAB7e7q1717TrbTRhQOe+q9OhYCXKQK+jWhOBRrRVnAU7brX87hFWJGkWfWmjTdGaMtpy0/GZ89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=1Z5LGVEg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kdQ/cxF9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="1Z5LGVEg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kdQ/cxF9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D49F1140017D;
	Mon, 10 Aug 2026 19:40:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 10 Aug 2026 19:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786405241;
	 x=1786491641; bh=GqC1G3ieoiRn883tbkElHwNaI4yAZdErJQZ6YzKtag8=; b=
	1Z5LGVEgG68QB+g72auqrX3Z4R5Z5d385SCykewUxy7t3tBzqwTHWit3xqqTeCc3
	vuo3bJOmwelWzd43STx3PNiPqbgJVxGNy1t9s8+6tdPPidrUzNBe9jLdF8Ennlto
	/Y4pm+VYFPQ01gAyx61NoE8Ulp2HC4RIKaR8s3AxzmJcA9TLgNFIkzgE0HGpfTMl
	yKw8DvWUiA7E3mi/NdJ7/HKkX7nV6Q8aUu4EOee9/v15LNmM8cidSP4S6HNVsO+m
	LD6eAv3A7TfIuTF6uKUnV4e24bBf9drbGEhxuqX1u7blWrVJQBz2q9cSGt2mKAOs
	Mkvdf84REw+ww+RofzyEFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786405241; x=
	1786491641; bh=GqC1G3ieoiRn883tbkElHwNaI4yAZdErJQZ6YzKtag8=; b=k
	dQ/cxF97oAxKDgSRdj3eOB1ZY+IhKySHfKg/Lyc3f6Xs+OFXS8BPDWHLKBIAvPzm
	RpPQOZ7Fwaclxxxsg4h3ZRnbLbBWY6ShYvbhCoP1rxlARqavoOycmCRTiV49mfPN
	UR8UYv30wN/x32CbUqlfxwf2Tb1jao9QMZijpWK+5O90ZC0g+qbLeO8MZoClQhe1
	+Jr5F/M0PucgaF3H7ux+USWzjKLK7k9AbN4qIjPnht86h4tZzVBbA2pTkdFokvVo
	+CPn51cmcFrLj5hhNSQLU5GnE/qZlSbmc6SYnK148m0H0DDv2kTpqTtL2INic3Wc
	dXnTYE6vPn6ohHy0HhOqA==
X-ME-Sender: <xms:eWF6alG8USHqM2D2xSkQvAsP9nQuFfXR8RH_ZvGK08vXUFn_zq7vmA>
    <xme:eWF6aigFHDpI-BZcMsG5ClPjoLEqeB8pgR1-2tVBDR9aGIX2NpPOcRuWyoBkL6qBJ
    hARH_Ao0HtXAQFEcLFkpPGHf77bSNAL034qbkOh-Pgq3FCnh2lO>
X-ME-Received: <xmr:eWF6aivk6uRCicbX4oJEY1TkOKkZeXOG06z_XHHTolqa_gixFxyNQdJfm45FMQ>
X-ME-Proxy-Cause: dmFkZTEFKj3tAxVGTQVweajQWmOYcwaM76wEBlyzx/blQIlubAzDhd421/au3fiSOUKUVr
    /yto4R9en7nCvrz86d6jfbaWc9upRsnUTRWaM3Chg48XiyLMv8HaJsO+8Nyc8/uJB2k9No
    clYd/vHVJsLgue69wUmqLB/K7UpE3041+ddz5OOcJeyahSi+sj+Z2T/z34R1Y2CWah4HhU
    E6d+zTpXqtWcIe5kdCCvzs6y2gPvhstyRFn66piZ5FvPMqwr9jb1xxPrM2xUgV71sa0xOi
    INQessOzONDqabGorf2v3eq3olGGlPT9g6Gl0cqr6uH6P+3AuL0i1Nbazsizw/vNmi4AkY
    xW3fIoUBqrwNa/UqEIK8dqVGq2mxv8R6fTFWy3DXz679doXt514G5fWXvxYJ5Q56Rt/Z6i
    kcpB61XZRSQHNYbON7Vjm5qBJjrr0QioHpPizywa1ORXnPtksoTcUTq5OprJuy6jf3BkE1
    y+cj3S3eK2m7cIr7W4vOY1AGDd8GZGQUuhYwZD0oniy8NNPDJKCCkufuqh3HaDdefJnlK+
    GiLHZx5KA5m5yfdbv+FuuLN7OhygeQKFANGUfP1HqqvhrS6ay9P+HUt2YKPNPa4BLI+c0X
    +3ZOEN/TcRvowTcksA0LE5jvsdH8u1EF1aJyULpx6IFZu3pCAOMNLdXFa8Ww
X-ME-Proxy: <xmx:eWF6altOHoW9dOuzUPDIYT69bHtK0CQWJJgS7TxXcwFmEH_TuCtBOA>
    <xmx:eWF6anFifwVzFIUOEQXOniPy899lqpilmO5ABMjCRw7mADfMjkZLPA>
    <xmx:eWF6agNDv37xbGMRM7-PHN4DD7lB6Dy4MALge_CWzKpacQH4ThEHDw>
    <xmx:eWF6amJVM_7qORBCqZPrFHCgrwtZHGDqcRqEQ0cmzTXa23wYqWzRbw>
    <xmx:eWF6arweJpaBDY0aQQ5vdKrBymIEFACCoJmLBznapdhTaOTAvZggD6YG>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 19:40:40 -0400 (EDT)
Date: Mon, 10 Aug 2026 17:40:39 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
 mattev@meta.com, schnelle@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
Message-ID: <20260810174039.12ca9c9c@shazbot.org>
In-Reply-To: <20260729181116.1373-1-alifm@linux.ibm.com>
References: <20260729181116.1373-1-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 11:11:16 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
> all devices support having their BARs mapped by the CPU. The
> non_mappable_bars flag indicates that a PCI device's BARs cannot be
> accessed by the CPU. The ISM device on s390 is one such device. The BAR
> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
> to warnings:
> 
> vmalloc_node_range for size 281474976714752 failed: Address range
> restricted to 0x2110bab00000 - 0x21903ab00000
> 
> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
> is set by the PCI core at enumeration time and already serves the same
> purpose in vfio_pci_probe_mmaps().
> 
> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f11a9624b9c..6a184588ff23 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>  
>  		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
>  
> +		if (pdev->non_mappable_bars)
> +			continue;
> +
>  		if (!pci_resource_len(pdev, i))
>  			continue;
>  

Applied to vfio next branch for v7.3.  Thanks,

Alex
