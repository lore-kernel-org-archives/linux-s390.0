Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1A2E973C
	for <linux-s390@vger.kernel.org>; Sat, 13 Sep 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757752045; cv=none; b=Nr7/PDq5dYeSt5oGO+gnkQNeuBJnZ7oSzTuT8JxfKa8+m5DHpKAe4DogSQLtka4o5Ez7IV73LlHVZn0FxKWnES0RZZlbMsip27P73azqesZkcAhG7r10JaNPlRABs555QVA323t2Mxik1t/GyThv0lKfo34FBrpubRUF3OFFPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757752045; c=relaxed/simple;
	bh=KBdb34yjuqC8JNMb7MU0xophtAjSJbuqI+5/g2ts2wc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4E4GJW+zndzsyfhtW0QAy6LaWGdhOnxbe66QUYnanBxDAV7iOpZgL3QE01hSTqBxHctcj187GWA6OBRx6r2f/ozVhtonc+jf0eJr1E9SkVYjLzEfly83Z1rHz9ajXnkY49xgdsswbVhZDKnnlHHxc5V84AkOR3wXoYY6fuugmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQknkwkH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQknkwkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757752042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHz5EoPd+ylCkG4BgrRtBzTwz79VaTitLewrCZQ2PXY=;
	b=hQknkwkHk73COEC0woogVkG7DDTZHeQeSaxjuUDgEF10ycwHwa9pVMoIXe7Hi44LBhVHMS
	f78Opzy+/F3eY5yA10Cibdhh5B5JHp47Cc7cIOOQjOeWMbwVfsnqwj5ds5V4Lsm0mj9Zil
	o+1uNyKLU2eUAoygIVx0Z4M0gACFFsU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-IUkqluyTOeyz0q6bVslGYA-1; Sat, 13 Sep 2025 04:27:20 -0400
X-MC-Unique: IUkqluyTOeyz0q6bVslGYA-1
X-Mimecast-MFC-AGG-ID: IUkqluyTOeyz0q6bVslGYA_1757752040
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-423f9b3edb4so404315ab.0
        for <linux-s390@vger.kernel.org>; Sat, 13 Sep 2025 01:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757752039; x=1758356839;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHz5EoPd+ylCkG4BgrRtBzTwz79VaTitLewrCZQ2PXY=;
        b=fL1+jmms3WGyr26OOiPv7TIicCeOILNuODbU3BbQzA/YUHTujkwc/BaweupDGhPFX0
         bf5EDk+vk8MMni1Ii54Z7Po7YL+lnvSHl/YA9WFeAhduD9bFIhsMwBG6m0hIb6UhOPRq
         fZTrYidVlXb8d7IZJbSz+BRVakYGIZsE1Jt4+U/rUH8zEHTJr3575BVl4nnZCWyPffSQ
         t7k4TX7TlJuv/BYnRp2HpwqAE/ftMy8hxRTVxPcCyvMZrZyimr79KaX0PjKaZxHCRdTF
         rHBuKNRiOzUQVCg84BOgu/ZM9tQ7YG5Kp++JggHMgsnPRCOvKO1cL2kpsmU49otCZ3Bv
         bbmA==
X-Gm-Message-State: AOJu0Yz1cZAa7Jzsv/lrigg29iOasulUFQO/r3D7kOf6X0amGn5KiD9+
	MUIuaz6PgGyNeJ0poeD14Z5xU/Qe4DQwH6uXEHDdoVZJheJ3I25cyS7pZTF58sd0fD/mdmo6sDw
	FFTJJtbNw/emsMCsaQh3IBC3WdgBN+9jMKzu2EBpuGftWc4d71zIy7fiCTTadUjshjCsp7xJbRw
	==
X-Gm-Gg: ASbGncvXYgetcLOWffUgTT3LueTYmO99nj8Qa+dPP3PsIHSrxnfFTHMPOEuNBheiLcz
	Xki4ibPkKozzBIz/nVmixih/uSiw34UHJbTMGxuET9XOl5F6Hjt5Jz9wcJlWXPR60kr7Cf4tC0h
	jcsTuKkU7XvD6hdNF/jUx4JHm4gBWthU719xIndlDGuK4RKJOIy8WEUbQVJ/ZDTQVAtFouEQHiW
	goBSUoWnc+4lNAMGtihWvpUogMbcSqQTV37lrsdjceS/ZIjJg/kvuf4IoxcR75EZfq11PGcbPFO
	kHowzWr43Ygy1KMJK16+C1eSrBD0uVZkQn1BjkINxME=
X-Received: by 2002:a05:6e02:1489:b0:412:5782:c7c1 with SMTP id e9e14a558f8ab-4209fc549bamr26611035ab.5.1757752039132;
        Sat, 13 Sep 2025 01:27:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIW4jBz+RhyO9sjz/kQQ01borjLc8HZiyi2LaANGIQ/TGf19Rkd/3OlbjO/Xq+R2DLvjT7/A==
X-Received: by 2002:a05:6e02:1489:b0:412:5782:c7c1 with SMTP id e9e14a558f8ab-4209fc549bamr26610945ab.5.1757752038702;
        Sat, 13 Sep 2025 01:27:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41deede6de7sm30080015ab.10.2025.09.13.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 01:27:18 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:27:09 +0100
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 helgaas@kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v3 01/10] PCI: Avoid saving error values for config
 space
Message-ID: <20250913092709.2e58782d.alex.williamson@redhat.com>
In-Reply-To: <20250911183307.1910-2-alifm@linux.ibm.com>
References: <20250911183307.1910-1-alifm@linux.ibm.com>
	<20250911183307.1910-2-alifm@linux.ibm.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 11:32:58 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> The current reset process saves the device's config space state before
> reset and restores it afterward. However, when a device is in an error
> state before reset, config space reads may return error values instead of
> valid data. This results in saving corrupted values that get written back
> to the device during state restoration.
> 
> Avoid saving the state of the config space when the device is in error.
> While restoring we only restorei the state that can be restored through

s/restorei/restore/

> kernel data such as BARs or doesn't depend on the saved state.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/pci.c      | 29 ++++++++++++++++++++++++++---
>  drivers/pci/pcie/aer.c |  5 +++++
>  drivers/pci/pcie/dpc.c |  5 +++++
>  drivers/pci/pcie/ptm.c |  5 +++++
>  drivers/pci/tph.c      |  5 +++++
>  drivers/pci/vc.c       |  5 +++++
>  6 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..4b67d22faf0a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1720,6 +1720,11 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  	struct pci_cap_saved_state *save_state;
>  	u16 *cap;
>  
> +	if (!dev->state_saved) {
> +		pci_warn(dev, "Not restoring pcie state, no saved state");
> +		return;
> +	}
> +
>  	/*
>  	 * Restore max latencies (in the LTR capability) before enabling
>  	 * LTR itself in PCI_EXP_DEVCTL2.
> @@ -1775,6 +1780,11 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
>  	struct pci_cap_saved_state *save_state;
>  	u16 *cap;
>  
> +	if (!dev->state_saved) {
> +		pci_warn(dev, "Not restoring pcix state, no saved state");
> +		return;
> +	}
> +
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
>  	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
>  	if (!save_state || !pos)
> @@ -1792,6 +1802,14 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
>  int pci_save_state(struct pci_dev *dev)
>  {
>  	int i;
> +	u16 val;
> +
> +	pci_read_config_word(dev, PCI_DEVICE_ID, &val);
> +	if (PCI_POSSIBLE_ERROR(val)) {
> +		pci_warn(dev, "Device in error, not saving config space state\n");
> +		return -EIO;
> +	}
> +

I don't think this works with standard VFs, per the spec the device ID
register returns 0xFFFF.  Likely need to look for a CRS or error status
across both vendor and device ID registers.

We could be a little more formal and specific describing the skipped
states too, ex. "PCIe capability", "PCI-X capability", "PCI AER
capability", etc.  Thanks,

Alex

>  	/* XXX: 100% dword access ok here? */
>  	for (i = 0; i < 16; i++) {
>  		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> @@ -1854,6 +1872,14 @@ static void pci_restore_config_space_range(struct pci_dev *pdev,
>  
>  static void pci_restore_config_space(struct pci_dev *pdev)
>  {
> +	if (!pdev->state_saved) {
> +		pci_warn(pdev, "No saved config space, restoring BARs\n");
> +		pci_restore_bars(pdev);
> +		pci_write_config_word(pdev, PCI_COMMAND,
> +				PCI_COMMAND_MEMORY | PCI_COMMAND_IO);
> +		return;
> +	}
> +
>  	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
>  		pci_restore_config_space_range(pdev, 10, 15, 0, false);
>  		/* Restore BARs before the command register. */
> @@ -1906,9 +1932,6 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
>   */
>  void pci_restore_state(struct pci_dev *dev)
>  {
> -	if (!dev->state_saved)
> -		return;
> -
>  	pci_restore_pcie_state(dev);
>  	pci_restore_pasid_state(dev);
>  	pci_restore_pri_state(dev);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c197d716..dca3502ef669 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -361,6 +361,11 @@ void pci_restore_aer_state(struct pci_dev *dev)
>  	if (!aer)
>  		return;
>  
> +	if (!dev->state_saved) {
> +		pci_warn(dev, "Not restoring aer state, no saved state");
> +		return;
> +	}
> +
>  	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
>  	if (!save_state)
>  		return;
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fc18349614d7..62c520af71a7 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -67,6 +67,11 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return;
>  
> +	if (!dev->state_saved) {
> +		pci_warn(dev, "Not restoring dpc state, no saved state");
> +		return;
> +	}
> +
>  	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
>  	if (!save_state)
>  		return;
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 65e4b008be00..7b5bcc23000d 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -112,6 +112,11 @@ void pci_restore_ptm_state(struct pci_dev *dev)
>  	if (!ptm)
>  		return;
>  
> +	if (!dev->state_saved) {
> +		pci_warn(dev, "Not restoring ptm state, no saved state");
> +		return;
> +	}
> +
>  	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
>  	if (!save_state)
>  		return;
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index cc64f93709a4..f0f1bae46736 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -435,6 +435,11 @@ void pci_restore_tph_state(struct pci_dev *pdev)
>  	if (!pdev->tph_enabled)
>  		return;
>  
> +	if (!pdev->state_saved) {
> +		pci_warn(pdev, "Not restoring tph state, no saved state");
> +		return;
> +	}
> +
>  	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
>  	if (!save_state)
>  		return;
> diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
> index a4ff7f5f66dd..fda435cd49c1 100644
> --- a/drivers/pci/vc.c
> +++ b/drivers/pci/vc.c
> @@ -391,6 +391,11 @@ void pci_restore_vc_state(struct pci_dev *dev)
>  {
>  	int i;
>  
> +	if (!dev->state_saved) {
> +		pci_warn(dev, "Not restoring vc state, no saved state");
> +		return;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
>  		int pos;
>  		struct pci_cap_saved_state *save_state;

