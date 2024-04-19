Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890B12CDBF
	for <linux-s390@vger.kernel.org>; Fri, 19 Apr 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535107; cv=none; b=TmPEJtfi+RKdL/gjzvMJyZa+c9xH+sCwGOwpCyY2c2zVZ08b7vbkWsonVjuZOaNlgYN2ClZuWE4RZJGJe3N24Q3oEqj61N+PdXF3pbXk4F6ukuXi2fYja1/2uZ4ZOrZoglN4oW2gjfcHJ9zKJddz2E5HoE48FMJiaA3uf5K0x9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535107; c=relaxed/simple;
	bh=UNW3QZV4+gJLU3id30uoS/EvPlzfwIriWW0qthqWIDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNf7KAXmlqfSjmgbTrth1GkkciLFZ1HPfNo5nuVXkW0L6/o00yjA6136nUdciKxipE3IHn6yE1qf3hUImq+ySvrT8MDi47U+vFqATZ3MFuv9ffDQ8+3kKcJavhFCF3MtE10ASkvHp0NBjWfds0qwik+SbGBwSNPpDBTAzoxtbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Rd+AGjnd; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rd+AGjnd"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa3af24775so1322716eaf.0
        for <linux-s390@vger.kernel.org>; Fri, 19 Apr 2024 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713535105; x=1714139905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIwb+Ip4VmhAzCakCe7bX4ZZtS5svATpWYgr8CM6tXM=;
        b=Rd+AGjnd3xrIUr5O7zNhi04vTQmYowFVxlp9HJJ1eUeBNLM/LGLUSDyDHV+fid2be5
         /jcW068jKmsGciyts9aWwcjDN50j0NPmAFNGhV0RjF5a1MUDnX+dlAUk+VDl53RrqEMo
         /AlY8Tm3TwLwKBbMTnudWhv1CeM7z36ZhC1uBznKfLBXTKwGJaTvjR/f99P/a8vRUHw4
         +RSqJTMHwsJJuaxgC7PLsL4GkaOqCRkBPhZRvqD479tZss2pediRaPw4plkf6neDc5ig
         DscOI0ATVN1rxzi+WUlHrmejwKb3w8z5hAHZW5mViiwX7ILrX7yD7I+X9xm2TcKttc9+
         9EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535105; x=1714139905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIwb+Ip4VmhAzCakCe7bX4ZZtS5svATpWYgr8CM6tXM=;
        b=fO+/SLlHcxCJ+Rm13BLqdEk+1Qmvmo7pNKrGBtxZfQZlVabx/mQ6U2yr8bFH++H7L1
         N/0hXu5IaLun8EKoOQss81iktbr6joaKi1YWZVelewfj5vh4s50+3aLWHl+0chBseLjz
         8ebKxP+CWfHOLJXdbEqGXqPOoQVlfPm1vPHT1ccedcs1G408pnLDb8GP5jIS3eE8byJU
         YbNSD05R2RQImm0r0NShFBg/4sO+1kRTgG4RP0bGpMmIgmtje0VVFx8Gqmdyqp9HlKS7
         Yg4A/q5wfV1GsvCPH08ucUu/wYGkyFkJsO3USqlOrJPKnE76s+nKzVLNDBhMe2LgaGxS
         bzxw==
X-Forwarded-Encrypted: i=1; AJvYcCVAFu0NLONrUxAI1asAIhzf+fsuFuxfUwpRNetl+s02sQ63oBvu19AUfkCGncCghkcFuqCHksWAQNcVjGljplHw16NEnqpiZ4Gbxw==
X-Gm-Message-State: AOJu0Yxdto5V1Aph1v/V9DFxBbfX03Y9Y4/zIjCqZMjdBYgnz9EEJpkS
	Bd8HCPiJu8veik6UDcj8OooJsp+kCx6KwFB9aJ21qceAV9DrkULu8Vphs2Gztfs=
X-Google-Smtp-Source: AGHT+IHOvq+gGQEh6mSTA+Vgr5DSOayWVdz/vb+zjSDQL4rbJiN/Dw6sDw9HEs4d8HUAav7a6oKDhA==
X-Received: by 2002:a4a:384:0:b0:5ac:bdbe:9cc8 with SMTP id 126-20020a4a0384000000b005acbdbe9cc8mr2404932ooi.4.1713535105273;
        Fri, 19 Apr 2024 06:58:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p6-20020a4aac06000000b005a4bcb155basm836308oon.23.2024.04.19.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 06:58:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rxokx-00FTTb-RV;
	Fri, 19 Apr 2024 10:58:23 -0300
Date: Fri, 19 Apr 2024 10:58:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Ben Segal <bpsegal@us.ibm.com>
Subject: Re: [PATCH] vfio/pci: Support 8-byte PCI loads and stores
Message-ID: <20240419135823.GE223006@ziepe.ca>
References: <20240419135323.1282064-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419135323.1282064-1-gbayer@linux.ibm.com>

On Fri, Apr 19, 2024 at 03:53:23PM +0200, Gerd Bayer wrote:
> From: Ben Segal <bpsegal@us.ibm.com>
> 
> Many PCI adapters can benefit or even require full 64bit read
> and write access to their registers. In order to enable work on
> user-space drivers for these devices add two new variations
> vfio_pci_core_io{read|write}64 of the existing access methods
> when the architecture supports 64-bit ioreads and iowrites.
> 
> Signed-off-by: Ben Segal <bpsegal@us.ibm.com>
> Co-developed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> 
> Hi all,
> 
> we've successfully used this patch with a user-mode driver for a PCI
> device that requires 64bit register read/writes on s390.

But why? S390 already has a system call for userspace to do the 64 bit
write, and newer S390 has a userspace instruction to do it.

Why would you want to use a VFIO system call on the mmio emulation
path?

mmap the registers and access them normally?

>   * Read or write from an __iomem region (MMIO or I/O port) with an excluded
> @@ -114,7 +117,41 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  		else
>  			fillable = 0;
>  
> -		if (fillable >= 4 && !(off % 4)) {
> +		if (fillable >= 8 && !(off % 8)) {
> +#if defined(ioread64) || defined(iowrite64)
> +			u64 val;
> +#endif
> +
> +			if (iswrite) {
> +#ifndef iowrite64
> +				pr_err_once("vfio does not support iowrite64 on this arch");
> +				return -EIO;

can't do that you have to go back to what the old stuff did and do the
4 byte copy.

Jason
