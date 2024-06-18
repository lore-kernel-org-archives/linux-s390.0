Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19C22626
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731232; cv=none; b=s8QnQwYT8GLZBDiLpolMMIWgcwV/cWE1YBO0n6/xJVwG4oPcXgFVurewv68UvBjgfnX1QaWZuJaCFrmvq/sj1s/Y1ZSKh4q+qCWCnJelFC885DUoMHv5/YSKzk+2jG9cWRzlVwXrn3uFeIeM6Orvgt2bM3JXjxSfyXLJrWAcntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731232; c=relaxed/simple;
	bh=INqmVCBc8HU0+P42MTmf0zgLb2AXGhOwm1WL9RDPipU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ut3hnGBZQrrul74CG55/mIOG9+GaZ3B05Xzu7uV9D9VN75fSU09cHBpYNdCIzNPCS7uN50bfZExPAzLdlEJPoqp9YJmKXcuGpiCP5ES/wreHI8wUGFZjbXXTtp4rExnOPM+OWuOWwkaIj0eZoq0VJ36IpNi0vKcfjQd1092iu9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWtnzZAw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWtnzZAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718731228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwt23sAZ2WeiBvroMNMzIKHNDpn7DovDgGAmHCl/TIA=;
	b=UWtnzZAwrsYRDRafxxNHHx9A0oWy9wXU8P9h/gMNyYGcx8EB3zg8UPWqiIRPJ0Zlyx1k9A
	/bfABimpdbH0lmzx9ShhHfbXqu8Q2fybyf5ucS/hCe8IVKvN5VdjMompB8BZL1wGaTowtl
	KBrKE0R51GcSTSDXpveouZ1D3rmtdm0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-7qyFqUlROz6ClB-_1Nk-Tg-1; Tue, 18 Jun 2024 13:20:23 -0400
X-MC-Unique: 7qyFqUlROz6ClB-_1Nk-Tg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e20341b122so658010339f.1
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 10:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718731223; x=1719336023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwt23sAZ2WeiBvroMNMzIKHNDpn7DovDgGAmHCl/TIA=;
        b=mB9+FSTywI0uK3ScUGWtSbZLSFpyNZXMIc1pDPjm4FojMHgO3AeR+MF9Hz+b/PBYg/
         m8cnyG9hnQV32ky//gV9Ywt5ByaURFFb8qIR2glB7FIHMwFofIOuItanjQ+H8zHJoqlQ
         xFuz2PaOqkvFCEPqmIgq1c3coGgCXCH+HOiLZSwiUoq1VJVZAW6zXi0wnj99buKgS3Vp
         db6wfYmk/owYiXpm9bz9BMZ61eBhpRkPTZhZR0MpVhNvNADd2JtpnNdjFDKPEGyq0BB4
         vBV69N3b8ACbwi2z1MtA6rQZs+bBRUIvrkUa6bl2Ao7vZtMPE5AND1EQi7R32mNCHhsH
         lAig==
X-Forwarded-Encrypted: i=1; AJvYcCU/kDQIPQUZsC/5QsX12K+drDt+6BByBQBaByInvyidM53dCdvNcsswyjzr3TsjYc5Gox+6AntBGWmPy+bTHS2hxhYweeKGRIXxLQ==
X-Gm-Message-State: AOJu0YydU2mAjInUX6px70Rf0VMVIKdsZAYHstKy3kID8T69NruxF/tr
	maZYdwgBW/ndSjxtOoLavmCJmy5HXNf3Uy244tV2LcYJbowyn2kkJt/gelNg/6H289k8AAfpZtQ
	UV+xmCgmd9ZqwQ3QwhirKZ1ggNymeUJqfZXNyX3IPC1A5wHXrlSnihd5OaO0=
X-Received: by 2002:a05:6602:6405:b0:7eb:7887:a4a9 with SMTP id ca18e2360f4ac-7f13edb2716mr63374239f.4.1718731223059;
        Tue, 18 Jun 2024 10:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzXJQLdgF3B6icXL7Ah1nqLxdQK0SBjMksmtymW9ngK1rCZftPEsBb6BNRnVSGHJrEDcSKvg==
X-Received: by 2002:a05:6602:6405:b0:7eb:7887:a4a9 with SMTP id ca18e2360f4ac-7f13edb2716mr63372139f.4.1718731222724;
        Tue, 18 Jun 2024 10:20:22 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ebdba66726sm277082139f.27.2024.06.18.10.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:20:22 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:20:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Ramesh Thomas <ramesh.thomas@intel.com>,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, Ankit Agrawal
 <ankita@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>, Ben Segal <bpsegal@us.ibm.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] vfio/pci: Fix typo in macro to declare accessors
Message-ID: <20240618112020.3e348767.alex.williamson@redhat.com>
In-Reply-To: <20240605160112.925957-4-gbayer@linux.ibm.com>
References: <20240605160112.925957-1-gbayer@linux.ibm.com>
	<20240605160112.925957-4-gbayer@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 18:01:12 +0200
Gerd Bayer <gbayer@linux.ibm.com> wrote:

> Correct spelling of DECLA[RA]TION

But why did we also transfer the semicolon from the body of the macro
to the call site?  This doesn't match how we handle macros for
VFIO_IOWRITE, VFIO_IOREAD, or the new VFIO_IORDWR added in this series.
Thanks,

Alex

> Suggested-by: Ramesh Thomas <ramesh.thomas@intel.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  include/linux/vfio_pci_core.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index f4cf5fd2350c..fa59d40573f1 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -139,26 +139,26 @@ bool vfio_pci_core_range_intersect_range(loff_t buf_start, size_t buf_cnt,
>  					 loff_t *buf_offset,
>  					 size_t *intersect_count,
>  					 size_t *register_offset);
> -#define VFIO_IOWRITE_DECLATION(size) \
> +#define VFIO_IOWRITE_DECLARATION(size) \
>  int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
> -			bool test_mem, u##size val, void __iomem *io);
> +			bool test_mem, u##size val, void __iomem *io)
>  
> -VFIO_IOWRITE_DECLATION(8)
> -VFIO_IOWRITE_DECLATION(16)
> -VFIO_IOWRITE_DECLATION(32)
> +VFIO_IOWRITE_DECLARATION(8);
> +VFIO_IOWRITE_DECLARATION(16);
> +VFIO_IOWRITE_DECLARATION(32);
>  #ifdef iowrite64
> -VFIO_IOWRITE_DECLATION(64)
> +VFIO_IOWRITE_DECLARATION(64);
>  #endif
>  
> -#define VFIO_IOREAD_DECLATION(size) \
> +#define VFIO_IOREAD_DECLARATION(size) \
>  int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
> -			bool test_mem, u##size *val, void __iomem *io);
> +			bool test_mem, u##size *val, void __iomem *io)
>  
> -VFIO_IOREAD_DECLATION(8)
> -VFIO_IOREAD_DECLATION(16)
> -VFIO_IOREAD_DECLATION(32)
> +VFIO_IOREAD_DECLARATION(8);
> +VFIO_IOREAD_DECLARATION(16);
> +VFIO_IOREAD_DECLARATION(32);
>  #ifdef ioread64
> -VFIO_IOREAD_DECLATION(64)
> +VFIO_IOREAD_DECLARATION(64);
>  #endif
>  
>  #endif /* VFIO_PCI_CORE_H */

