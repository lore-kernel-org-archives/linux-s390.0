Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AC84E1B
	for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408324; cv=none; b=VW/Dg5Spk5kDngfj3KoyEk95zX45N0FyuYdk4ZlVCOfDyON85X3Qk29PKO/Ub9q2gRUaZTKvzPNLn1kxyEmJqSYn09zVga8tLrcHCHHwc2dTzpJiazMTDFQjarWgZ2Vq0N+WtgLCHB72qqY92pkhXxsgnSzUPkeR4dHdevY3uIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408324; c=relaxed/simple;
	bh=SpeshAmi98dBcbV7325o4E6VAiG2EGqrc+62Du4gDRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeJSXbdYpthDQutxLPu+SSBe/u5GUXDcl3nR21U0e/yL/41gc36OOwwNc4ILOOPyz1KUNC2eXNCnUMAJ8kvNSmELKv2H+g+MOkvcK4Tsyl7Y3z5kgqAwVU8b13JRUGYCAdx+M0j+QrlUGCitPu/mHDCaJ8dr9Zm9UJNaCqvzEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5bZiCfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5bZiCfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714408319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VUOcdCYHg1vZaTRhcIVHvzHPzcMRX3lSm1goA8OZ2U=;
	b=c5bZiCfJuks08Xuojy49IThYtzGp96FodqdL5EXqxp6pxfO/fQXSp7D/YXY7t/cuedk38y
	fi/0Y0s2qgOIsn72qC+TTAN4TCuE3KW+Ezr3lNvSfJX1C6FOpitY9iKs9wv9Ep3n21QW5S
	jX9e62iTFuU7sZjMFfvZNpIcIydhpuk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-PO4zotTTNqudCcB6ZbzUfQ-1; Mon, 29 Apr 2024 12:31:58 -0400
X-MC-Unique: PO4zotTTNqudCcB6ZbzUfQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ddf0219685so518718939f.3
        for <linux-s390@vger.kernel.org>; Mon, 29 Apr 2024 09:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408318; x=1715013118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VUOcdCYHg1vZaTRhcIVHvzHPzcMRX3lSm1goA8OZ2U=;
        b=s8dJdVH8fnNAGxY5NRMuewWMylZ9KjItv2GRSDBQVftpo9YlhyyPcJiXeCviwREtVC
         9vFMRh/vOVvbCCzHDXREkTe0IK7R3lLv/f5RnxgL3OGwkB2FPYnfp+/ym9SLQkQ5mmVe
         ZXUAJNmEdCxnFAT9axc1j/v49P/QcsavynOyPk7EnHc6VLYc8NH7fYvev9ItcaUPmAQ/
         xu0d+nVMamVJAtJPbEyGzU0Y6K4CihqAMsEyCtTtRISMQUjrd4wr3O9csuLYCmL/urWk
         7zQZmK952YU7c3+dxSa5/iHDciOI3fjK6gTV2wBnE9Q6A8w0nfscjWXEgcELhn9kfilg
         YBBw==
X-Forwarded-Encrypted: i=1; AJvYcCUgAwwfN/6JNZG+ISrS9HTke9TbOi77bzrfXdcRQOlog/KPBeSTWnAP16yB8jBUV12cMuKFWuAlDWIGQM8zhI9JjosqcxIs+VBC6Q==
X-Gm-Message-State: AOJu0YzZx4q4AmvLj149WFbXqcl9c3KXgo3tP4r9X7rHMzvhloqLzYBo
	XQvPZw1MHUmdjOfpzpN9D3WGBe/8rPCAZbxm7esUHKopMlc0VeTESyhLoQIYysDzjRCtYl/Q7/h
	eZHvUmvwHzrQDV3Hwr3qyp+x89VcANaKZ4x96NLWs3oi++xSIH1drcbvMn9E=
X-Received: by 2002:a5e:da43:0:b0:7de:ca48:4fab with SMTP id o3-20020a5eda43000000b007deca484fabmr4571701iop.2.1714408317724;
        Mon, 29 Apr 2024 09:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY7MZRCb8QUzQbM63MCxVsid75E5bV/VH+WHEvPEtafrrxpxa9msmYaYzEBqEiNVPw81DjTw==
X-Received: by 2002:a5e:da43:0:b0:7de:ca48:4fab with SMTP id o3-20020a5eda43000000b007deca484fabmr4571683iop.2.1714408317455;
        Mon, 29 Apr 2024 09:31:57 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a02860b000000b00482bd47b861sm7383330jai.50.2024.04.29.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:31:57 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:31:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Niklas Schnelle
 <schnelle@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 Ankit Agrawal <ankita@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Halil
 Pasic <pasic@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>, Ben
 Segal <bpsegal@us.ibm.com>
Subject: Re: [PATCH v3 2/3] vfio/pci: Support 8-byte PCI loads and stores
Message-ID: <20240429103156.50793b98.alex.williamson@redhat.com>
In-Reply-To: <20240425165604.899447-3-gbayer@linux.ibm.com>
References: <20240425165604.899447-1-gbayer@linux.ibm.com>
	<20240425165604.899447-3-gbayer@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 18:56:03 +0200
Gerd Bayer <gbayer@linux.ibm.com> wrote:

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
>  drivers/vfio/pci/vfio_pci_rdwr.c | 16 ++++++++++++++++
>  include/linux/vfio_pci_core.h    |  3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 3335f1b868b1..8ed06edaee23 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -89,6 +89,9 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_ioread##size);
>  VFIO_IOREAD(8)
>  VFIO_IOREAD(16)
>  VFIO_IOREAD(32)
> +#ifdef ioread64
> +VFIO_IOREAD(64)
> +#endif
>  
>  #define VFIO_IORDWR(size)						\
>  static int vfio_pci_core_iordwr##size(struct vfio_pci_core_device *vdev,\
> @@ -124,6 +127,10 @@ static int vfio_pci_core_iordwr##size(struct vfio_pci_core_device *vdev,\
>  VFIO_IORDWR(8)
>  VFIO_IORDWR(16)
>  VFIO_IORDWR(32)
> +#if defined(ioread64) && defined(iowrite64)
> +VFIO_IORDWR(64)
> +#endif
> +
>  /*
>   * Read or write from an __iomem region (MMIO or I/O port) with an excluded
>   * range which is inaccessible.  The excluded range drops writes and fills
> @@ -148,6 +155,15 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  		else
>  			fillable = 0;
>  
> +#if defined(ioread64) && defined(iowrite64)

Nit, #ifdef vfio_pci_core_iordwr64

> +		if (fillable >= 8 && !(off % 8)) {
> +			ret = vfio_pci_core_iordwr64(vdev, iswrite, test_mem,
> +						     io, buf, off, &filled);
> +			if (ret)
> +				return ret;
> +
> +		} else
> +#endif /* defined(ioread64) && defined(iowrite64) */

AFAIK, the comment appended to the #endif is really only suggested when
the code block is too long to reasonable fit in a terminal.  That's no
longer the case with the new helper.  Thanks,

Alex

>  		if (fillable >= 4 && !(off % 4)) {
>  			ret = vfio_pci_core_iordwr32(vdev, iswrite, test_mem,
>  						     io, buf, off, &filled);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index a2c8b8bba711..f4cf5fd2350c 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -157,5 +157,8 @@ int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
>  VFIO_IOREAD_DECLATION(8)
>  VFIO_IOREAD_DECLATION(16)
>  VFIO_IOREAD_DECLATION(32)
> +#ifdef ioread64
> +VFIO_IOREAD_DECLATION(64)
> +#endif
>  
>  #endif /* VFIO_PCI_CORE_H */

