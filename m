Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869B2BE7A5
	for <linux-s390@vger.kernel.org>; Wed, 13 Aug 2025 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117039; cv=none; b=STnrHAUAWhqhKdK/pzEMYPpqdMkeCtak4mEvXxI6PjK0q+/SXoqBzjTMCGPrri0m+vwY2uETE/zYy9apco1CTu+F5iRIUUNcJk+D6qTOc93fc+lCB4oU7N8fn9mBJC3He38ku7aXrlbRVh79sCt5MWR9BvTb2i6bEz/qYDGpvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117039; c=relaxed/simple;
	bh=TUWUvUZoTPLkbh4j8BITpAkVoVy6W3JXAa84nclCMwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V13cQLgecyqjGHWHgj3ImCpgKqbCV6c8M/1O+jaw02Omk38AH2dAemozZXZAUktm1mEiQAzog/5iRCvNeC6UIKf4wI5WNyVsaQVINpSZaZORX8IzmNHd8R7Rc3lkoCjBCjA8BSDAHTOViKygXX9S2PJum/bOv6wnvE62d9JPdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADIeVCv9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADIeVCv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755117034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybiuLaukfgYUnCV8dSXZqE5iKES2KXuJCfBdh1/Gwr8=;
	b=ADIeVCv9/hgSEbTpBi2UkaVnVRQX/APB/T3h1lHcFJ62Nav5d3i7c4Rkf74zggmkfHil2X
	u+yYIRC4JcQqyyown/7wHkXJ4bJi2oTIRxvRzcPWN5EQROcPK2Ylz1G3uUicL9ZOpTfj9U
	FBi00KiG+Bp8Co+0JXdlEBeM3IcFoac=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-YHGdl0Y5MMOF8loab45iUQ-1; Wed, 13 Aug 2025 16:30:33 -0400
X-MC-Unique: YHGdl0Y5MMOF8loab45iUQ-1
X-Mimecast-MFC-AGG-ID: YHGdl0Y5MMOF8loab45iUQ_1755117033
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e5700a5525so696205ab.3
        for <linux-s390@vger.kernel.org>; Wed, 13 Aug 2025 13:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755117032; x=1755721832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybiuLaukfgYUnCV8dSXZqE5iKES2KXuJCfBdh1/Gwr8=;
        b=W9KBN94iqEcrwOMAcnnY1qN9FNVqQ6cgrarkQgBKfUL231xW70yeEP9WaS8ZJdiLHx
         A+NEQs8k7/AMMRihtVtAqmqVYaqNMgcWkJsb7Mj1dHCX5xGrkJ3P3BGpDOctnhsvgU2w
         T2yI1lRA3/pVgcFU8E9ZVr+VW6ssE4iFBqvCSKT12KYAo9xkhHJmphW1eesPL1uDsJHa
         QyU1lEaR3jirLQG+zS5ZAhVPqnu5zu+cOwZPUcqnKXXJBvhz9dPFS+X8GsqfdPzpFEbb
         r++vFyOXH09v/hB0u5Qpcbc7M/YEwQGu39eGu4FIdkKrVH2Wzny1PfKH+HQiak7WNvDu
         q+LA==
X-Gm-Message-State: AOJu0YxzWe1Ja6BaxRNbfGvMhOBHytGh6QWcajgBDaAEuf2wYVGGjNG9
	yFrBT/XlIFFBpV/t/q6zHNMYnBAUlq6xO6ZT8qGfC92fZ3OUH0rj6wTO/ENLuNukIeAGijFA/oG
	BVBgCvkG3XVXHGW2FTj2P/vJTFjhWdn2R2jqDtexY52i46RaRxc7WncysGhfvZio=
X-Gm-Gg: ASbGncsw1xY4j1VE6/tqiuHST3tfCdKInym20d87sboLPwTaVy/3eNHgcny8/qVrtPR
	EEDkzx9tXsq/LJa+myET6OCHiNkbFg9e5PR0w5oqfHdokzkmq4AmPuaxnWqAEiEg81Uug2F4bfB
	S/jNhPyN+Axw0tlY/YrrcSNql9nEYd6qnctG3EWp1aIdbMQz2UOEU9/1a2wvrm2DHKe8Q//d07S
	R36Js5DcqSieH5pTRH5CeFxZyDakwZjHuavovLeyPx7uVtPXathtxa19ObSkizyZlhunUZ4RcNA
	BeSd+sKyWFPR5oyLFLroBmrntaoQ6WaMgs753q+Zc/A=
X-Received: by 2002:a05:6e02:4801:b0:3e5:6882:661e with SMTP id e9e14a558f8ab-3e568826ad7mr13160285ab.1.1755117032065;
        Wed, 13 Aug 2025 13:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcKo+ouYURgN6xzgrRL/vMnntYrb2krbn/TmGX1YtA8BbnW1ZDyxxp/DIRh8HDMtndTjAL+g==
X-Received: by 2002:a05:6e02:4801:b0:3e5:6882:661e with SMTP id e9e14a558f8ab-3e568826ad7mr13160095ab.1.1755117031676;
        Wed, 13 Aug 2025 13:30:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae99cff85sm4118311173.37.2025.08.13.13.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:30:30 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:30:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v1 4/6] vfio-pci/zdev: Setup a zpci memory region for
 error information
Message-ID: <20250813143028.1eb08bea.alex.williamson@redhat.com>
In-Reply-To: <20250813170821.1115-5-alifm@linux.ibm.com>
References: <20250813170821.1115-1-alifm@linux.ibm.com>
	<20250813170821.1115-5-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 10:08:18 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:
> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
> index 77f2aff1f27e..bcd06f334a42 100644
> --- a/include/uapi/linux/vfio_zdev.h
> +++ b/include/uapi/linux/vfio_zdev.h
> @@ -82,4 +82,9 @@ struct vfio_device_info_cap_zpci_pfip {
>  	__u8 pfip[];
>  };
>  
> +struct vfio_device_zpci_err_region {
> +	__u16 pec;
> +	int pending_errors;
> +};
> +
>  #endif

If this is uapi it would hopefully include some description, but if
this is the extent of what can be read from the device specific region,
why not just return it via a DEVICE_FEATURE ioctl?  Thanks,

Alex

