Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B6CA6B;
	Wed, 25 Mar 2026 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457204; cv=none; b=uqESRr9C3qMYIJcX1MQBV8KV4YUnj7qsbgkpX7LRjV6nWeiuBt4+4oB/yXO16ucVKO4oLZTOY8xCa1kF8rf/NuQ/pqJVjs7BUc2rfI4E2oL28FIV9D4iKXQgIX8KdvP1lo0bGL+iBSLyuAU4qX6uva9uBZ9/Om7DHxf9g0MPnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457204; c=relaxed/simple;
	bh=YFbwHRNpKBueCHssXgbNtvRYUpYW1nXj9noAYcjiu+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3Uex62hi+k9kY42vEU3R1fNaaDrlWBPjDan4WCBBAqTL9B9Ych7EiKZlBjFtN+cgUa+yOae6isecdXGQJflS6Vyfop+jLbwipZv97TZTDADfKtSt+kV+g7opP0cw7w2XpLIP7rkB+QfYtyoynFSNf2w4AwLCIoRY6yIAd163OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=seT1jc5e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zz7XmRu1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="seT1jc5e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zz7XmRu1"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A35DA7A0374;
	Wed, 25 Mar 2026 12:46:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 25 Mar 2026 12:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774457200;
	 x=1774543600; bh=pr1cSHVWO4FpdmucoQqTaCFYH5wIuRjjpebJmpC7530=; b=
	seT1jc5ek0yCxJjEKh7ySm1lzV3NpnMQqhS/XCitnDNUho6uyDC4+bRch7O4LJPG
	yARnwP0+Ne7uf90cdYutZLZWWbgD6I4cRY6nGPlYyzXL7Hs7G+i0WgeX3GgSvg+2
	AQkownI8V+768ZZuZEiJ0oJ3jie0tRSPRqhXvm4cZ++CJ9awUEuJKClycS4Vi1Tl
	3zku2wt5IVNQ016nWMEZTaD6Pctlk/XDK9dyhjOwwDFH/ZPe4hUDZdbfKAZqVkqz
	SCuFYOJCr+6n7f0XEFsJqeQipGwuIn/4zQ0fooKIQN/lI2b0wLMFQhdpaa2c/ScP
	u2E8zaMtrbhAnd4oc4/PKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774457200; x=
	1774543600; bh=pr1cSHVWO4FpdmucoQqTaCFYH5wIuRjjpebJmpC7530=; b=Z
	z7XmRu1cbHcfIZXqSEJKXg3yXbcmjYPy4HoYnvHxwFshVzksMJVzdIPKP4Xa95CF
	QXRSuX7/TTEVWOWD4p0grqlJzsF/QcU6hqLqcCgMnBjVl+HjjoZqhzKjtCHtwNBH
	4B+Y5+wCFuCUfN6SkxtLYcUyCb12daHkHhTHUbqxpQbYlyXi7Ae1JLI6ixykmVIK
	jJadJiR9EtphnVwyHnquBq+Nrp4YmRufjDk3/wKYy38v5l76KzXulfoyArDuZfOA
	fYKHfQwHNPsI7XJLQ/10/6c3ksEnf+RZGtleJlJ3SxmM0mhwfLtQAexdApK7F/Mb
	q78SjfRd3M/6GjaMQWPtg==
X-ME-Sender: <xms:cBHEaXQjJhEmOTikT_tNUGrBpXABMJ6jYHcsG7UMaqwNbmd4GiWZ8g>
    <xme:cBHEacdDzXU6cudTikLMX_VVDaXEm7zdNN1bsDmAa_hruRPr2bbvxFiOf59d0nLsl
    3gab1I0D-wCd7JDS5LHj2bt_IpNSIKzd-Foj9H2cHvURiGkQ-XwMA>
X-ME-Received: <xmr:cBHEaVfzNWi6WuKy7jnTVLIcYNkxoGEisQyjf7rSu2g5mnDXaS4kst8rhnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihhf
    mheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsfeeltdesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhope
    hksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghlghesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cBHEaYYNTc4j5qJwamm_Cas7zAi17_9DY15nSfD3S1snDQaLjvv_IQ>
    <xmx:cBHEaR6u59tgx-G9L9o_PhJPB9FEYWZzwEvNLZoapJZpToFvwzKjdQ>
    <xmx:cBHEaedV2u3mDSntap0T-fjNZcd64QemSjLdp03f9A39jQdvdE79KQ>
    <xmx:cBHEacywk9QpeFY_Xcr_DNeNuPmEJSdQTtffBnM4QX2aacYMrtam1g>
    <xmx:cBHEaRlvShCwl9ePu9v2VlxliG7gDgMLR7vZGtYnoGSZuvlHyv5EuIi3>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 12:46:39 -0400 (EDT)
Date: Wed, 25 Mar 2026 10:46:38 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v11 5/9] s390/pci: Update the logic for detecting
 passthrough device
Message-ID: <20260325104638.784130e0@shazbot.org>
In-Reply-To: <20260316191544.2279-6-alifm@linux.ibm.com>
References: <20260316191544.2279-1-alifm@linux.ibm.com>
	<20260316191544.2279-6-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 12:15:40 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> We can now have userspace drivers (vfio-pci based) on s390x. The userspace
> drivers will not have any KVM fd and so no kzdev associated with them. So
> we need to update the logic for detecting passthrough devices to not depend
> on struct kvm_zdev.
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h      |  1 +
>  arch/s390/pci/pci_event.c        | 14 ++++----------
>  drivers/vfio/pci/vfio_pci_zdev.c |  9 ++++++++-
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index c0ff19dab580..ec8a772bf526 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -171,6 +171,7 @@ struct zpci_dev {
>  
>  	char res_name[16];
>  	bool mio_capable;
> +	bool mediated_recovery;
>  	struct zpci_bar_struct bars[PCI_STD_NUM_BARS];
>  
>  	u64		start_dma;	/* Start of available DMA addresses */
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index 839bd91c056e..de504925f709 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -60,16 +60,10 @@ static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
>  	}
>  }
>  
> -static bool is_passed_through(struct pci_dev *pdev)
> +static bool needs_mediated_recovery(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(pdev);
> -	bool ret;
> -
> -	mutex_lock(&zdev->kzdev_lock);
> -	ret = !!zdev->kzdev;
> -	mutex_unlock(&zdev->kzdev_lock);
> -
> -	return ret;
> +	return zdev->mediated_recovery;

Looks like this was always a bit racy, it's not clear the mutex
provided anything except maybe memory ordering.  Maybe the expectation
is that errors don't occur in relation to open/close_device?  I wonder
if READ/WRITE_ONCE would at least provide some ordering assurances.
Otherwise:

Acked-by: Alex Williamson <alex@shazbot.org>

>  }
>  
>  static bool is_driver_supported(struct pci_driver *driver)
> @@ -194,7 +188,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>  	}
>  	pdev->error_state = pci_channel_io_frozen;
>  
> -	if (is_passed_through(pdev)) {
> +	if (needs_mediated_recovery(pdev)) {
>  		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
>  			pci_name(pdev));
>  		status_str = "failed (pass-through)";
> @@ -279,7 +273,7 @@ static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
>  	 * we will inject the error event and let the guest recover the device
>  	 * itself.
>  	 */
> -	if (is_passed_through(pdev))
> +	if (needs_mediated_recovery(pdev))
>  		goto out;
>  	driver = to_pci_driver(pdev->dev.driver);
>  	if (driver && driver->err_handler && driver->err_handler->error_detected)
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 0990fdb146b7..a7bc23ce8483 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -148,6 +148,8 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  	if (!zdev)
>  		return -ENODEV;
>  
> +	zdev->mediated_recovery = true;
> +
>  	if (!vdev->vdev.kvm)
>  		return 0;
>  
> @@ -161,7 +163,12 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
>  
> -	if (!zdev || !vdev->vdev.kvm)
> +	if (!zdev)
> +		return;
> +
> +	zdev->mediated_recovery = false;
> +
> +	if (!vdev->vdev.kvm)
>  		return;
>  
>  	if (zpci_kvm_hook.kvm_unregister)

