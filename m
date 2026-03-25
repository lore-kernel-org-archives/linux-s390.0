Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C9402432;
	Wed, 25 Mar 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459831; cv=none; b=NBR9EtWPhDSf6S+Brve40QA/CKywlnQH3Z16HoZyxhTeiNmy9OpBaJUkUIbmA48Uukf60jAV8OybzdE8TYlljxKBIQ8uWcwb5AkY/Ca6qrBew6jxTj3oongciIINz2/7KTl13P4LHOfNohIJG9bG0TOGyNzIxh/KPoHIRyFDbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459831; c=relaxed/simple;
	bh=izqfmoSwYBgeVOxAlk5/UJZ8DKajtesLif8zJplb9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIAffUXHtJxvjhK+NstWjSgV3JtLMufkaAIKu+AlU7VV83BECkTk+Qw37dc6xgXVOizaiihQynIJqPYj2bUjTcpw6BHSmWozpH/ZJuq2t2eGpndCE8nCUh4FqlT4NZEZSqH8sRgLIdAkHAMfoie8e/V0Mc1vNgtd56HYxpyHaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=BnU4aM4b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWuSLIFB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="BnU4aM4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWuSLIFB"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 636CF1D003AD;
	Wed, 25 Mar 2026 13:30:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 25 Mar 2026 13:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774459828;
	 x=1774546228; bh=s4/26OD6gpC1yNS9mF36Fw6wxgIbJowbFVBArtAVxfA=; b=
	BnU4aM4bj1CgS/W8mRRM7XWX723JAq0Pih1v9JNaRAQJCAxZrhY1qydVZ5AttT2E
	UVToIKZqMVhgMKlc+xzcziBoVImyHEh7yErwEFHHwlfY/HPiRvz6Sc41Yn/Md8JB
	XOi8KZopQtZFKjtE4JinczKmUtnYShi3TaTLKPNM1Xj/3THKenvqWl+iSyczWw06
	ssbTZrqfPZ016uCq7akWzv22YXzIE972KoCHjfBV1+yh2d/j/fuM7GstaISmiXV+
	vBpMbW9h6CfSQvnCSphbRUlq27MQ+FKiahrvEC/mm1IxXWZ2326xxG42ianpY+rQ
	FXhl2vnMFSVIgTEeCTnw+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774459828; x=
	1774546228; bh=s4/26OD6gpC1yNS9mF36Fw6wxgIbJowbFVBArtAVxfA=; b=V
	WuSLIFB44iHwSNYYHeE1Tkd2eJU7k7K4bBji1VYyqeUvu21G1xpL03s83FZBbHii
	N9nRSDNKndhpa74qAfLEd2E9HBnP756jrgzE5ZG3MVf9ekhokyYfOVB4U7+iL/3n
	C8XsgUqseUcZ8yT5xzZDPb+kq/BkHnwio0AdQat4SRLnY9mr/M2kfdC4HqRigH6y
	TerjfDPp2Ae44pfxvfuTKviFDdmANuG+rHuJ5qx08ZmX19cRR9FcJfpNVd4bHfyW
	czzDkwfKt/YJ9F9TTpMD3ESdCUVghAfmhJbg+p2Gj3CgZ/kLmz45xsoxXaPVLuRm
	7Wy5FJN83IHe4vIaBUWTw==
X-ME-Sender: <xms:sxvEaVNCI6211RxsumM53HAKkylCKeTWpr9kLA7Vm_87U85BJ7MsCg>
    <xme:sxvEaSXkUgvqf_pUOOawE0YBrEiATVHHw8u1_YYKn5Wjfba0-A9JeFjfVaLJYsTBs
    Ooc2bs3HKba0hSAp8UlBhcEvBlXt3Jxul48cFdyPB0KFiYhfZSlRg>
X-ME-Received: <xmr:sxvEaaYBJ2BCUuvn7giHMk_Q94AGWduFTlTjhnf-KIHYV4EK1TMsOHP3OtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrlhhifhhmsehlihhnuhigrdhisghmrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrg
    hsseifuhhnnhgvrhdruggvpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsg
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sxvEac37hZBqD6uC_q7fuSrBv2J9Qf-05mMejkXG8DGoRVWyD6ZJvQ>
    <xmx:sxvEaWBpbWREnOoshHiOSSZHRSEdGpZ9k8hF_O-VPzR1A49dC-v4KQ>
    <xmx:sxvEaQ-RbKdOEbSILjYlETEk5-ARcj1kzzHArT_SiSJt6oRgDX6CvQ>
    <xmx:sxvEaZWtRPAVtnZSbwcuOp5UT77wqU8tryTcQGajuN2wliPy90yfSg>
    <xmx:tBvEadhhgAxg7nEilpsX3xEIqtqHAcbCvFTUzk8998z1BH5i0QMiTp7K>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 13:30:26 -0400 (EDT)
Date: Wed, 25 Mar 2026 11:30:25 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, Julian Ruess
 <julianr@linux.ibm.com>, alex@shazbot.org
Subject: Re: [PATCH v11 8/9] vfio: Add a reset_done callback for vfio-pci
 driver
Message-ID: <20260325113025.21cc082b@shazbot.org>
In-Reply-To: <20260316191544.2279-9-alifm@linux.ibm.com>
References: <20260316191544.2279-1-alifm@linux.ibm.com>
	<20260316191544.2279-9-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 12:15:43 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On error recovery for a PCI device bound to vfio-pci driver, we want to
> recover the state of the device to its last known saved state. The callback
> restores the state of the device to its initial saved state.
> 
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index bbdb625e35ef..f1bd1266b88f 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2257,6 +2257,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
>  
> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +
> +	if (!vdev->pci_saved_state)
> +		return;
> +
> +	pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	pci_restore_state(pdev);
> +}
> +
>  int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  				  int nr_virtfn)
>  {
> @@ -2321,6 +2332,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
>  
>  const struct pci_error_handlers vfio_pci_core_err_handlers = {
>  	.error_detected = vfio_pci_core_aer_err_detected,
> +	.reset_done = vfio_pci_core_aer_reset_done,
>  };
>  EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
>  

It gives me some anxiety to restore the open state of the device here,
but I can't identify any specific issues.  We'll try it and see how it
goes.

Acked-by: Alex Williamson <alex@shazbot.org>

Thanks,
Alex
