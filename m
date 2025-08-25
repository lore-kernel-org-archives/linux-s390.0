Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636BADF58
	for <linux-s390@vger.kernel.org>; Mon, 25 Aug 2025 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157712; cv=none; b=Gr+OjPKtuNTTfKivJUTUe4xdR+MsrJJNdnmEQLBunZpRa8R92cU4+POKgU89un0BS/v9uYTD9q7XNOBaNicxy3/7FDUscynYt28mFx4snaxaC0mkTeit8Mg+LJybkQeBplARmTHnqZSXyNbqV7koRWJwikQN2cVUWWatHk9DR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157712; c=relaxed/simple;
	bh=Q9CPbQpH2d/T5EyyLjYG2kTFNAop20As96U/hmdEPUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYiEhfb6XueBZjFk+bT5RfRtwMPeH/P1KcKZjbMZHfER+ejLd79Gp6Cj5Y8xuk4CIGY+Fdc9eTRsNCVPXWFDI9EWz7OModYO78HBFxovjQfMU6Zym9P3wR8Izy5yx0qVKOc251oUN1SHqF3gX6BBA7JrQkXd1TkOtc265xSLx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVBij65p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVBij65p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756157709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuacPQu0sUaEe98IXzV5lAzTlLH7oY2OXfsQpZup1+Q=;
	b=AVBij65pmNfwJOXWbJPtok+69RkZPzIoKvWYOZAb0DfGsr70fG4c4gIuJIgFt3Ppnc/Vn7
	8ucfpZWlMWxnGqSxPeeRfHlpMCpZljGWGTAd4R1L20fjJ+UGa23XfjGcYzvTh0OKHO6uGh
	SPiZCkVGhtNFVtsId74ZjaO5CG1dLAg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-KRJ2TewiMyeCYKUEq5LnuQ-1; Mon, 25 Aug 2025 17:35:08 -0400
X-MC-Unique: KRJ2TewiMyeCYKUEq5LnuQ-1
X-Mimecast-MFC-AGG-ID: KRJ2TewiMyeCYKUEq5LnuQ_1756157707
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-886e8134e87so5317639f.3
        for <linux-s390@vger.kernel.org>; Mon, 25 Aug 2025 14:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157707; x=1756762507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuacPQu0sUaEe98IXzV5lAzTlLH7oY2OXfsQpZup1+Q=;
        b=nzIagHGUk9gM0OhIezFQhkOTX29Y8fcnTKEieedp/cicdetgHMceSRIEfZuGcgeU3E
         jSNtAGfHOtezrSSciVf0Uzql3bcv9J+M/Fl15szPkSd922JXSaYBJOiIly3PEP0jCs0/
         U5Ctc/M4ppHuymIglHKVQfmLcSGFWNpclnocERxXvWUQXo4Z6sGDg2skr2rKf9L5FOzM
         a72oQVQHzsKZ3tc3a1r/1/5aXaecn2FklLJQrprtB/Z6Foy/j1vCzlfmQUcrJUnjFR+B
         us/NK95zRPtMVnYX7cVlE5Dn8NZWR4WK5eLpqLl7TnlE5fehZfAqjL+0gPgzEuJLAH5g
         9q/g==
X-Gm-Message-State: AOJu0Yw3GImb4GSRWFvCRkk3LZkd6BpHEV0Y1yqZ5yOFbukTYtjmqKZL
	xNKe7/b55t1WXkY2QKy/DA/pB7HAH1Xse6PfeYX42yErAsRQZC1Icb033pCtASX+YE0oGn/D3pG
	9gvnF/dKqniu4fqua6WxJuLh36Ogxvi79WFp05cV2Hh9hr2tVWogVG/2xDUSM9wQ=
X-Gm-Gg: ASbGncs5ZxNuBKQ7+5ZcfxolGg4uDR/zBRQsNMnMhWzzKPl9441OLP4ojemB9LHS0Hc
	u/yQ+7nzM2t0tKFkYUp1QM20AOtY6cqcL/4VF4HYtwBRYsJ25DgKXudNQqmhq9ani3uqZrew799
	9OMGVKAqPPmUXlSE8mV2t1EICLo9/17fh88Sj6HxTZ8QBsNnb/tSsRy2SmAytoJ6BcfXQttgktA
	VH1Kbmx2mlSz4KgGAKtTor/wecwJpABQzT9AoF5Nl9dNh9Xgf0p60GxNMTMHtaN8YEzF+9lj39G
	nla/lL7i8sqXrTMENL9+klIf7xwCNHUFdC5BA0OHI8I=
X-Received: by 2002:a05:6e02:4414:10b0:3e9:9070:b0bd with SMTP id e9e14a558f8ab-3e99070b2a6mr42182175ab.2.1756157707161;
        Mon, 25 Aug 2025 14:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjadVuAgSDvfABUcZMm01Kysw1HDncV59yUGSUyp2hVa5KPH4rom30lUjRmGeYrcRiA010pQ==
X-Received: by 2002:a05:6e02:4414:10b0:3e9:9070:b0bd with SMTP id e9e14a558f8ab-3e99070b2a6mr42182075ab.2.1756157706803;
        Mon, 25 Aug 2025 14:35:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c761718sm56163575ab.23.2025.08.25.14.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:35:05 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:35:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v2 1/9] PCI: Avoid restoring error values in config
 space
Message-ID: <20250825153501.3a1d0f0c.alex.williamson@redhat.com>
In-Reply-To: <20250825171226.1602-2-alifm@linux.ibm.com>
References: <20250825171226.1602-1-alifm@linux.ibm.com>
	<20250825171226.1602-2-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 10:12:18 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> The current reset process saves the device's config space state before
> reset and restores it afterward. However, when a device is in an error
> state before reset, config space reads may return error values instead of
> valid data. This results in saving corrupted values that get written back
> to the device during state restoration. Add validation to prevent writing
> error values to the device when restoring the config space state after
> reset.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..0dd95d782022 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1825,6 +1825,9 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
>  	if (!force && val == saved_val)
>  		return;
>  
> +	if (PCI_POSSIBLE_ERROR(saved_val))
> +		return;
> +
>  	for (;;) {
>  		pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n",
>  			offset, val, saved_val);


The commit log makes this sound like more than it is.  We're really
only error checking the first 64 bytes of config space before restore,
the capabilities are not checked.  I suppose skipping the BARs and
whatnot is no worse than writing -1 to them, but this is only a
complete solution in the narrow case where we're relying on vfio-pci to
come in and restore the pre-open device state.

I had imagined that pci_save_state() might detect the error state of
the device, avoid setting state_saved, but we'd still perform the
restore callouts that only rely on internal kernel state, maybe adding a
fallback to restore the BARs from resource information.

This implementation serves a purpose, but the commit log should
describe the specific, narrow scenario this solves, and probably also
add a comment in the code about why we're not consistently checking the
saved state for errors.  Thanks,

Alex

