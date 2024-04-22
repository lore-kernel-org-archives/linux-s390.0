Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F91401C
	for <linux-s390@vger.kernel.org>; Mon, 22 Apr 2024 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826091; cv=none; b=s9NB0C8Z5+8Q1Ys+60wDtvF1IICM+GJ2VWYs9wp46Ly0ts1gavavDUp0N+WnIWLLhCVnIeX+pKzu1lBiLLo8yhbU12SHXmzJ3ffnDbp4pEJ41+aNveElZacKdL5WrcoftjDVQv0pOp4Ci3SXdNOssqnvDNkCgknpWtLOW3eJG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826091; c=relaxed/simple;
	bh=gR5NJTY/l9WIhK6wCAFG6E7h3S5AmLnU+CncLwrKTdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtLrSSGsPcNZX5qFRFOxBcviofR5NxdQ46BQAafnbXLHGXwkmbBtkdFFFJfpWtolzWdFYdBVUovOAUB8loVp4KCD6B7LLr5ZaU7gA1IV32VzLoTkfddcyYQkK0ydWGqHaeQeTufLZqvbwMznO/ObD8mAqNbnvRb+Pxso21QlWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgAIUrdo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgAIUrdo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713826089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eknADUBQ3WBf5n83F401aG1TXkZvM6I2gRt6GxCcJZ4=;
	b=bgAIUrdoTPwX05+DpEahkncu+tOsd1nyIuAr4cGBDpNxETAJwTFLzf1p4J2OfAUhiaebY4
	+ZF/9lIqvVuorD3kxJCLflz4dLgakd1CFhgsY+Eey+yRUKnA2ogJeopyG86hHPMaPHmic9
	1M6iI5ahwN9vjZB5oIL7PpFTbwlBpB8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-istFg7OwOXmU7oa9Utxchw-1; Mon, 22 Apr 2024 18:48:07 -0400
X-MC-Unique: istFg7OwOXmU7oa9Utxchw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dc40011f18so72721439f.1
        for <linux-s390@vger.kernel.org>; Mon, 22 Apr 2024 15:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826086; x=1714430886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eknADUBQ3WBf5n83F401aG1TXkZvM6I2gRt6GxCcJZ4=;
        b=HcmSZUwKdmB4hFxcNwM2th9/JXj8S7son4cBxufaeoGo5xOld7YPJX9Tq/XMC0JCob
         pSsdeAKg2zYYD1NyL4X2uowM9BWcKyM4WkNiFYYcTSQD8NB9lJsuOaB2aSTuMyEQK5Ks
         uFAms9HtDaq4RBb/EoORO5vVviDyJm0jfRawtMKL+vcirvI+WXZw6+uQMzhucCSSaDFk
         W3wslZihRiY7Rg6cY4ZPlWTvdY1aFs0sNJd004UOsfHYd+bZoz9tMKaDSOBt8Jn4z9hH
         LXhXdlu2s3fVz2HZiR2qmGCgSgm248jP+h/10JxWsxuhD+1QNPiv4WJ/73ZnUhVkJ91k
         CVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgG5p0PC1tBY0DbW6pIKpGAS1eCVWdklBfQGZUDjXBJjZaCqJkrjJvSJynypaB01iXW5k+ywYEahqOr6lyuGAYpIKqnn8cHYDxtQ==
X-Gm-Message-State: AOJu0YyWEK8amdNnG+z7UV+Rja9DUEV+j0Az86UV6XNlOhpNiMrmhgua
	6cBnIgnz8RM3E18OjxSd/sZUQGS1bUKZpYmIbZM2jcNNDFMIgElBmIA/9etvEQ0thu93CAM4ERn
	L0yWIgQM7lUkj0ef5V657sAdU+0JBRxXkgZZVkUHiRKBVMDTQt54keLdtmXw=
X-Received: by 2002:a05:6602:14c5:b0:7da:996f:b54a with SMTP id b5-20020a05660214c500b007da996fb54amr1099933iow.8.1713826085832;
        Mon, 22 Apr 2024 15:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlz0VOgCdzXBEzoEr5ynN7VRhX30cpJMjqjZrke00cdIAk570djkpbzyhQ9VWBDgXBYxE8Ww==
X-Received: by 2002:a05:6602:14c5:b0:7da:996f:b54a with SMTP id b5-20020a05660214c500b007da996fb54amr1099922iow.8.1713826085536;
        Mon, 22 Apr 2024 15:48:05 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id is36-20020a056638852400b00485432e15efsm866451jab.97.2024.04.22.15.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:48:05 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:48:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 Ankit Agrawal <ankita@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Halil
 Pasic <pasic@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>, Ben
 Segal <bpsegal@us.ibm.com>
Subject: Re: [PATCH v2] vfio/pci: Support 8-byte PCI loads and stores
Message-ID: <20240422164804.7598735f.alex.williamson@redhat.com>
In-Reply-To: <20240422163353.24f937ce.alex.williamson@redhat.com>
References: <20240422153508.2355844-1-gbayer@linux.ibm.com>
	<20240422174305.GB231144@ziepe.ca>
	<20240422163353.24f937ce.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 16:33:53 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:
> [2]
..
> @@ -114,72 +155,33 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  		else
>  			fillable = 0;
>  
> +#if defined(ioread64) && defined(iowrite64)
> +		if (fillable >= 8 && !(off % 8)) {
> +			ret = vfio_pci_core_iordwr64(vdev, iswrite, test_mem,
> +						     io, buf, off, &filled);
> +			if (ret)
> +				return ret;
> +
> +		} else
> +#endif

This could also just be:

#ifdef vfio_pci_core_iordwr64

at this point.  BTW, all this is only compile tested.  Thanks,

Alex

