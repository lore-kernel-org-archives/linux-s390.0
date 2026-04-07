Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F13DBA0;
	Tue,  7 Apr 2026 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577529; cv=none; b=rXVJM3b5ZrFGt522c9Ye1FPiEWzTgyMUXL1RZHF28uRL19Gzt0XmiUDreCx5kWvHMb9/UBL0PMYcsmPRaf56/Hukll3QCsJG9NGSsbQzyLkj/Jc2eWhZn9Zv+XBiuyACykBZFpZitGtnPBSVODiJCl9I7gAjx92JCmMVa8iClEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577529; c=relaxed/simple;
	bh=EBFnxExK4VX2YswSoy+PzJvSVt/+6kITNov1zrMkHX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owJHLAOOd1MhH1qLQGx6dSNPe8sjmSuoKmNtHl0u1JY+X9Eze6T3tWxLoQW9q/vdmZUx9UBv143Qq6VXggFxiCYQjsCypVbNfRUHq0L5nPw+/kfyJTL7iVncNQLP6nn/BQg1/2TjCJBZTcNtI8Ge+S31/UBYrj2s/zn2m2bXYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=fuHKukx5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fk2G5NVw; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="fuHKukx5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fk2G5NVw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3715D1D00251;
	Tue,  7 Apr 2026 11:58:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Apr 2026 11:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775577518;
	 x=1775663918; bh=tK7NLpFbjwDadQoTc0iaAErmYavZBKRhAuqroi1ZxdI=; b=
	fuHKukx5ByeBZRP0NyAyOrRRoBwpZfzFMG9JUdZ8SGg7+t6rnfx9Ho6JDbAceliN
	y/KaGNL3+Um9Sx7zB7lwkT8g6gkl+yBYCtQA+9jXWJAMgaY+Ud8CB4S9Sw5US/j8
	EUE0hIMJGYlBW1qFl2KY0lSRTCR56YPKZEvJQymH1HFPKpf1D0qMMtQojtIkPHdW
	YY7roLh7shptbYHzTx0aHFf77NUZoCXYElQqRSxUgeFyoF5bdAVuSAEJ4HbAq3J5
	7W4Mz6f12oT5GQu3n2Wujt77lmrZkwxRykWwKpxu4wM/d5wVOIOvGaNXejeX7+L9
	K4mynKm4sLrEMtXBgaRPDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775577518; x=
	1775663918; bh=tK7NLpFbjwDadQoTc0iaAErmYavZBKRhAuqroi1ZxdI=; b=f
	k2G5NVw2HZYwORQcCkYyUaqFHMO3t73Fytx1y2uQkxW0as9MlfO7qKbmciIzAax7
	vqUytmCWtanwte4DzS9t1GCcCpT/KeXdl/HvevMzXxOmumE833AJh0eCsAtGmI8D
	ZZvAbKgdo6DoZClbaykAkY3oQviQTagGPFA+2rtH1WXF+rPW58NHjeJ4jVuHaJuh
	6d05LSohI9uS/1vPmMfMwI6osmgU4RUqv+myWwHvFr8Rn/O4CsZqeV2DZKnsa+u/
	/M+2d161LBG5HHj4DqhPuGpYXu2UiyYMDD801s2LCDFYjsKttaiXgaz3uR4qC5RP
	TmRQQXuVK9rt/7YkGzIKA==
X-ME-Sender: <xms:rSnVaRWR9Zk6IMIRx8mfp6nN-NdJs92Kcn_vM2W_0NjzaR9yts1HTQ>
    <xme:rSnVaVSXCcGPCNqPCnqedZZny9hb75jFyzShBds3eNq4KezIDcGWle6DkGlKnpb_e
    BZFaBYKtytfAWm-Qj5-5O7NXO6EJdS-SyQ4N8ixdYlo9jSVyOFB>
X-ME-Received: <xmr:rSnVaWA08u84AQqew-eRjGFeHFH0u5sONVB_tl5H6msys_EWZH_LccSgwdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvuddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghlihhfmheslhhinhhugidrihgsmhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhsfeeltdesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrsh
    esfihunhhnvghrrdguvgdprhgtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgthhhnvg
    hllhgvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:rinVaVvULn6gTZC7Scga_IIbm3bsYfRZwuPbKjuavFqAk0JAccWf-g>
    <xmx:rinVac-0CJrJcUyzr0AJpoNWxvtP9qPuv1_766RKzEw3REeYTfVmKg>
    <xmx:rinVaUQ1GTejdLlKUwzqVlFZSCVifltG_y1M5oBP8NNMNw0VTHAEtg>
    <xmx:rinVaWVZwhB6yTu9NW9ACeP8zN6lssBEPOOondwvul6AzfCUi7He0g>
    <xmx:rinVaTQoG2cI98FiGf_h_CuKls_Q7uM5tiRV7MMdPMgZfdT8a-Pr1sX8>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 11:58:37 -0400 (EDT)
Date: Tue, 7 Apr 2026 09:58:35 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, Julian Ruess <julianr@linux.ibm.com>,
 alex@shazbot.org
Subject: Re: [PATCH v12 7/7] vfio/pci: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
Message-ID: <20260407095835.7f42b66e@shazbot.org>
In-Reply-To: <20260330174011.1161-8-alifm@linux.ibm.com>
References: <20260330174011.1161-1-alifm@linux.ibm.com>
	<20260330174011.1161-8-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 10:40:11 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> The error signaling is configured for the vast majority of devices and it's
> extremely rare that it fires anyway. Removing the pcie check will allow
> userspace to be notified on errors for legacy PCI devices. The Internal
> Shared Memory (ISM) device on s390 is one such device. For PCI devices on
> IBM s390 error recovery involves platform firmware and notification to
> operating system is done by architecture specific way. So the ISM device
> can still be recovered when notified of an error.
> 
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
>  drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
>  2 files changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Alex Williamson <alex@shazbot.org>

> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f1bd1266b88f..cfd9a51cd194 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -786,8 +786,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
>  			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
>  		}
>  	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
> -		if (pci_is_pcie(vdev->pdev))
> -			return 1;
> +		return 1;
>  	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
>  		return 1;
>  	}
> @@ -1163,11 +1162,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
>  	switch (info.index) {
>  	case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
>  	case VFIO_PCI_REQ_IRQ_INDEX:
> -		break;
>  	case VFIO_PCI_ERR_IRQ_INDEX:
> -		if (pci_is_pcie(vdev->pdev))
> -			break;
> -		fallthrough;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 33944d4d9dc4..64f80f64ff57 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -859,8 +859,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
>  	case VFIO_PCI_ERR_IRQ_INDEX:
>  		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
>  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> -			if (pci_is_pcie(vdev->pdev))
> -				func = vfio_pci_set_err_trigger;
> +			func = vfio_pci_set_err_trigger;
>  			break;
>  		}
>  		break;

