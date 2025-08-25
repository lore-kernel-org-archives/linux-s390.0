Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732AC2367C9
	for <linux-s390@vger.kernel.org>; Mon, 25 Aug 2025 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158868; cv=none; b=Fe4d7lB2vv1uOeUKajhOy6mY9AmhoKVjBcCkLROIxtcGRkKL+SA2XKy4YfLmxONU4hG5ZG8c9XJzfEF59pgrBVRQ1dxmPiakPZlioQwYPrYj80CF2RBxLMWHR2DFwme+2is6XZIHd61Kkle+gPx1v2U0Md796LxTFP9qcrPjQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158868; c=relaxed/simple;
	bh=PUrALNKcazTqj1JOi1kUX/7GRlWlbsgpoo8wt8AGzQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVOlDZSWDNjyaBB3TFz3knB+ff/LM66LltCV73npKlRkfPSWKujS5QjmC2eBztVU+L9TWf+XJjzzgz/IEFIhkDaG/O1ty74okeOsiW2if2pti8xgvkXL1xfrqzEXIYd+czmud01DxHs3I7X6EFlxkmhUGjqd6O6zn2VXvuuKhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxSI5vp1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxSI5vp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756158865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktdRGsOdUoyTte4ICKWTNwEDxAMcLJUcCCRuCPiDxEI=;
	b=bxSI5vp17Kttun/uupcHs86jhJFTizzaPNpJKfIc9JDrlgxnB3vCMoNyrm2VJy1opCpQ+D
	8AqOGpnyAEZ0iYOMGI/5gxVL4dkLkC/DbBqER2ykqM6crnyQEfSuwfyGNcO7GY+JIYFJem
	Fg38QuI/QXBaPUzb9LCA6AbnVtuwjtU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-hOCsOkMpN7in1YoKC3OCaQ-1; Mon, 25 Aug 2025 17:54:23 -0400
X-MC-Unique: hOCsOkMpN7in1YoKC3OCaQ-1
X-Mimecast-MFC-AGG-ID: hOCsOkMpN7in1YoKC3OCaQ_1756158863
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8844e402794so8321139f.2
        for <linux-s390@vger.kernel.org>; Mon, 25 Aug 2025 14:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756158863; x=1756763663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktdRGsOdUoyTte4ICKWTNwEDxAMcLJUcCCRuCPiDxEI=;
        b=uwsTD50MYKlV8l+TJBXHwvsZTSLW/S6UxQRJMQoq5qquUYGfKcCo9D9kvpqIjdwqfj
         EXpgsUKxWgVr/4lQEL52ppkW1vZ2M2lquPfrw2SrTQGBm130ktE41B1qS0fvl35nPlOU
         7Tv8zVY9lL5zt+zM6WYiyUrVDpGbxHiXt+0jaV5kOBB/N7lf/QV7CFS8iWzFlniBnFht
         iUjz0udLWwv+J5gn5NOWdh6llFYemvRUkvD3XfZAxTDgQnSi0QFeJ6DPDCwQ8NqRcfdI
         Q8miGVyopEdWugNn7xps4vu/BZACMeAtU+5vGupVIBZ3YMVivlnp5tisPaRKCJuhkVtH
         ycwQ==
X-Gm-Message-State: AOJu0YwaN5zkyA2mzRio/XjD4CHMlHavjHeBuLUMLQg4DCtwWl254cTi
	d7K/uKQJJa/um5OT6u7Dj+DwrjLt8zDHT6ZeXSX1DTWOHJgBmTnQmFgGYI7//3GgAM9fONCsxgS
	wT9BeH6XKzLDt5ek2CBmoM795a6UfN/om4BuddCaOu3GEId/VJDGzCa+wHwJ/244=
X-Gm-Gg: ASbGncu0Ka30lShVpa/D4qqIzBd4s467cx7pbe7OCih44PUGXHoXLWQlu0Dwb0IBNBm
	7aQyKtAqpMB+vxN7Jvu4WQN8Xu0bp3gwEaMllWOF3GpjvsN2waNPkpCDrBLxKKIkRdCYljtqNki
	CmBi2k+15C0H1Ee5YqT/SXukb2CESq77tAxxeAuxXdij8oOYEN/l2V4eYQHzoRbqs353IZ1dfcg
	hiRUBxDbCNev6L+RN83pEdewptzPMNo/rxo9Hl0vzLceJdjVXyCgscJ6LbGmlr+tB9gPhHtqzAp
	XkWm1JDqpZmf8vNyilxVNiCG8oP7d77BCKTovygXrkw=
X-Received: by 2002:a05:6602:2c10:b0:87c:32d1:3b84 with SMTP id ca18e2360f4ac-886bd202301mr688403739f.3.1756158863114;
        Mon, 25 Aug 2025 14:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQEDzQ15G4rYzJDAIr+leDsCSs9V6r+VT1nFdg7y+XkefGZ8cay0aY5yb38za5ejvfkweA7g==
X-Received: by 2002:a05:6602:2c10:b0:87c:32d1:3b84 with SMTP id ca18e2360f4ac-886bd202301mr688402539f.3.1756158862694;
        Mon, 25 Aug 2025 14:54:22 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8fc6b0dsm540240839f.20.2025.08.25.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:54:21 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:54:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v2 2/9] PCI: Add additional checks for flr and pm reset
Message-ID: <20250825155420.2ace4847.alex.williamson@redhat.com>
In-Reply-To: <20250825171226.1602-3-alifm@linux.ibm.com>
References: <20250825171226.1602-1-alifm@linux.ibm.com>
	<20250825171226.1602-3-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 10:12:19 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> If a device is in an error state, then any reads of device registers can
> return error value. Add addtional checks to validate if a device is in an
> error state before doing an flr or pm reset.

I think the thing we see in practice for a device that's wedged and
returning -1 from config space is that the FLR will timeout waiting for
a pending transaction.  So this should fix that, but should we log
something?

I'm assuming AF FLR is not needed here because we don't cache the
offset and therefore won't find the capability when we search the chain
for it.

> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0dd95d782022..a07bdb287cf3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4560,12 +4560,17 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>   */
>  int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  {
> +	u32 reg;
> +
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return -ENOTTY;
>  
>  	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>  		return -ENOTTY;
>  
> +	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  
> @@ -4640,6 +4645,8 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  		return -ENOTTY;
>  
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
> +	if (PCI_POSSIBLE_ERROR(csr))
> +		return -ENOTTY;

Doesn't this turn out to be redundant to the test below?

>  	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
>  		return -ENOTTY;
>  

Thanks,
Alex

