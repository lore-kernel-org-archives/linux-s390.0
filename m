Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2A34DB56;
	Mon, 22 Jun 2026 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160164; cv=none; b=B1flbg22miuvStwies+9ehHdwSGENyfWpbKpN6cO20JHNBjXZnetF6hT3UQF3M3Ws1QoCEeED361PKR41kh4STOM9+NmFIn1MCf+F8SDsOd05wdFbZL/0u6t53DV6r+Uxu2QLV7lcYMGSHQFrovmEtR+jAZL+9+c+1GaLzLZaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160164; c=relaxed/simple;
	bh=1UpYt39gL2CGu8eQhJRGQeqNuGREyFn8XumI7Buz0Ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=esbU3ra/+ZpxcO74Pc+H6WvVe/baV3JelIfve5aVlpcy/e42EgvJ0rYTWmYLKVDw35z8T6f+Lzn/24aNHIR/6ruW+H2eZcB72CEL2xX4MPsLwQ9293TVtrzJvKMEbEMGo+ZKnW5P0k22vrb158gROq8XKouyQmQvTRftSXDc5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtRc8//A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtRc8//A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C871F000E9;
	Mon, 22 Jun 2026 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782160163;
	bh=jGxREV0cO/b8wbT25QdJ9vSRQVB6ERQhzC73UEzuFoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XtRc8//ADuSYsmjuowJwwg5bmg0a4Ybrmnd1KL6xiWKQxUvbr7rHWTkzmNbeHGeYJ
	 bIv+74lJZA9GXkblaV7+zVPwuoz6jrAfC8+BCVDD2utIr+68GGayYfBqyEDKREuNcb
	 x+g6XNDqor6av+pta67fktSmRae1AKrYe4wemD0qt9TXlChNOCRFXYu4RsE9dpgkzA
	 W879jA2ZcuNvCYgD9XRvAamNjD/qxFeMN880f3zD4TPB3YueiXDL4vs+XOoktPjKvv
	 CO1gOXzbx5HlSxZsrG590Sahdvev4FrzsMhXkRmPrNemUyX/Y/damEkpmErALObyqv
	 jF5eBKOb0TMzA==
From: Thomas Gleixner <tglx@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v20 4/4] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
In-Reply-To: <20260622171840.1618-5-alifm@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-5-alifm@linux.ibm.com>
Date: Mon, 22 Jun 2026 22:29:20 +0200
Message-ID: <87ik7al3of.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 22 2026 at 10:18, Farhan Ali wrote:
> The current MSI-X restoration path assumes the Command register Memory bit
> is enabled when writing MSI-X messages. But its possible the last saved and
> restored state of device may not have the Memory bit enabled, even if a
> device driver later enables Memory bit and MSI-X. Attempting to access
> Memory space without Memory bit enabled can lead to Unsupported Request
> (UR) from the device. Fix this by enabling Memory bit and restore
> it afterwards.
>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/msi/msi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 81d24a270a79..46a0d9f68a57 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -874,6 +874,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  	bool write_msg;
> +	u16 cmd;
>  
>  	if (!dev->msix_enabled)
>  		return;
> @@ -882,6 +883,8 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  	pci_intx_for_msi(dev, 0);
>  	pci_msix_clear_and_set_ctrl(dev, 0,
>  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);

Can we please have a comment there which explains this? Three month down
the road this will results in head scratching otherwise.

I agree with Niklas that this wants a Fixes and a Cc:stable tag.

Other than that:

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

Thanks,

        tglx


