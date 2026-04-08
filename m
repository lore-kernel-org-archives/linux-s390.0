Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD122836AF
	for <linux-s390@vger.kernel.org>; Wed,  8 Apr 2026 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685664; cv=pass; b=e5Ajww2F/Edurg+nUpsoL/Lg8i3oz3TvfcgbHOFKzVKLzbCmrWj7yd1jaKY2DKBT8FuQtBeoyDoVwxyYPzS9JDg5lXNAs6Frjbld1rIKzFiBZMJjBT53XtyT+48O45fO73GCKZNTZ7IIlp49TWfct+qK+7Weggp2z53dZeJJVn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685664; c=relaxed/simple;
	bh=j8imaKId0dRx7JPyCv4vSVVbP0IIoQNE2Omu9BO+pR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkwuE/dSvAPLlPMMvPOzzCfmNSL9Qs+dSKWcb0SBkhBE5qtTNzHvrt4B7h5G286FFyDk4XvIh6wmCdhOCN2uLPesnEMdGNeNxzgIP5AwclohJLgZxUJd8KIuEmarlrl4MCqddq1MT/94OPRLxAJpOa6H/kXHHwBWxqNfNNs/m1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TILjVhdf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVaPFrJA; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TILjVhdf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVaPFrJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775685662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37chEWD8E7J2il6Ld/rOd9Xr2zHalfFTJF1CJk2mB1E=;
	b=TILjVhdfzDchabIKRSklVx2FctsHOO5KAB9OZlywfWKTaBUS13OQAeX1TL82JCOrzlR1rK
	vkFCDiTr83sxQUeuA1yo6x4qLw6gYRqmvHGTDjCSycnhtU2+Ug7Np1ck57+6C2de+nvCgV
	Xe1PENos90tZ2cyXvJgd/5TaHK01Tuw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-zFQoJod7O8y-_efd4nr_Tg-1; Wed, 08 Apr 2026 18:01:00 -0400
X-MC-Unique: zFQoJod7O8y-_efd4nr_Tg-1
X-Mimecast-MFC-AGG-ID: zFQoJod7O8y-_efd4nr_Tg_1775685660
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d03db814eso177807f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 08 Apr 2026 15:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775685658; cv=none;
        d=google.com; s=arc-20240605;
        b=LsvsztX/hdGe9sWI+lq1oiqbh8Nc7bDXJKDc0VH3MWGL2/P/+av/kqp0K+xsqDwOTE
         3CZKl7H1euyUEspYdw5ozVicBvWp8UE7z89AHuUCQ0W99EDkAIvyGB2aoR41Co7UtlzR
         jSBDNF5uXc/NOcycelPKNpvcovovdtl6TCh3DZrR6AOjnzeWSaKva80SOFTMJj/RunZ0
         Dn1IR9UWBPloVxIwnuV99TgqKLEvQuC/7iPDBAmEpGuic/catA1Gios6uLiIWzzHpc1R
         /RTYOi6Si7HCsoFtUs8gmqUieNfFDvKN0xrIsiKDH5j2paPmrEgEjfgeqyvtGy3U+3EZ
         0G+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37chEWD8E7J2il6Ld/rOd9Xr2zHalfFTJF1CJk2mB1E=;
        fh=L8wRUg40b9p+ERmW1xr5XMMpL4giLTy9ebEZs2c9zqs=;
        b=kdKE3T+81ngt52/ZZcBY3DEgWRvA1M1bb1RJJNZwNnAhDM5YBQRxzZOxfj+++Z4wQn
         W+MWf0FzTl2JQUIJiEU1NvnaokfFq8iJI8gfRNwPHGVpaJm/EFLKm3h0HJtPZFmadOoI
         66uU4bdSQUYf13mif4gtmc0WpNeajKZT96Q+GLUls1TPW7nBgLZhRRq5jR/7XJnHO1mW
         IzkSzjxnl0JlF+wBLDmfURxM85CGcBWdwm8VFJYq5G8Tqnd/rh8W6VrlJfbGOTSPJO/9
         frZooEVP4TdBF2yHgxWyxCMc7Ih0NmxDWQhad3WpW83DoPG6hXENvQf6I4RTP7kuIaAh
         hFPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775685658; x=1776290458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37chEWD8E7J2il6Ld/rOd9Xr2zHalfFTJF1CJk2mB1E=;
        b=IVaPFrJAcNI8XtFGZNNs9qGRa9Uw+Vwq7RqyJ2gy1asfPd/JYdpUkklJe6rcA0/tqO
         NC+OiVJC3RJ6umQUKFpmLU2TNQS6q2G0EO9VQPoZkX5ufm7BiFjN8CYREy3AmJhuokVC
         KuGhnPMD5wEEi+n32CovhCrHrgZmsu+/zdXAWZ76z982iPKmAUMkYZqCxo1IGWyJx8ua
         3IIJMmTBdVeqLkGmj4hSndG1dHf3AStloQ4ny5vnhbbxU1ltc52UHRf7Q246iGUT6pZa
         1mYyfMGudt8BHkh0b2ZXJfLjytDaMK0IWProxjpycoaqV/qMvcFdu1g4dS02GmKLbYo1
         WJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775685658; x=1776290458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37chEWD8E7J2il6Ld/rOd9Xr2zHalfFTJF1CJk2mB1E=;
        b=Q04Ej+9k0vcrt6SJajXSuiqRK/JkWYiyo5nAnU6t0YPeh/mBIFQUZnpkpPV1Ljhij9
         nj/PDepNd6Eabvivz8A1I4NH0F+1Ncd3VyRsHt6Jhcv3ZOGT2FfopRvUx+RW7irlfBds
         HooIX/1uAtFrtSgRxTh9+8eG6V6cjWMOe9qGCiOLpA99BLHAHSd8jYSK1JN+8niKw9o+
         Q2Mz3JIXrnaad/ykwYoJeczytSu0HyM0CRNocetMoPZhoP85HDah6z+EM77pn6oEa+gT
         6kp9daBAEeCmPnHrSD6cg8LPnaKvuU4Y0lwP7XCdgdmZgMFTKpaJAGVl1BQjqvvZI1CQ
         biZA==
X-Forwarded-Encrypted: i=1; AJvYcCV3VzpkJrJhmA1ZLjKjf8N1hc7jBO74xUZoymQJLxvTEePPVHIHyqPZk325Hci2YwcjkYYlV4NIGjfz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DDV2fEqqLtBBGd+O9UWjGPG4O6BL+Ro6HX0ENvCSgZdaUSYV
	iGA1M8G/0fY7NWr3jm4kcy1DnQQOoMw1OSgy20vvOoQuTMSsQPMMiMP+/WVrluwfbQrSYeCmHRD
	ZJDd1sfdz7wlpKHxyZVGicwVVe4eXQ57+qPc9dnUBV70w42uwaSdauTVkAKWBdkPHVH3LySGFjK
	HTrNDmLEJVvnM+4NMZVg4Sf5/9uTTaGunsCJzdsdRMXl/kUTtF
X-Gm-Gg: AeBDiesw+hgB0forc6ZMNsGxO/J9vPf0X2luds6V5ZPBJb8f5/LU2c8VlZ/PGoXEzke
	SZpQbQRya7rdcqt9l+lRt+5k60Eg+mPkWv+xsWUKy0l1UQAC1NOP5l2jt96IedcTajowOFMMzNa
	xNVEOcXA4TmCRvWuutUNXAVLBiBo9qynyUpppId1Wi22GjjqXGDnmIKkZqKEme/uOYBowR3cy4Z
	CI80/4b0pHqoB428V1V7EWG+j2/2kQ1sAadHadxUtxT/yFVszBZUBLR6yayIjz1zNlRu+zeHEXe
	9tE8
X-Received: by 2002:a05:6000:4201:b0:43b:3d80:b0b9 with SMTP id ffacd0b85a97d-43d29295ed7mr34842339f8f.12.1775685658578;
        Wed, 08 Apr 2026 15:00:58 -0700 (PDT)
X-Received: by 2002:a05:6000:4201:b0:43b:3d80:b0b9 with SMTP id
 ffacd0b85a97d-43d29295ed7mr34842301f8f.12.1775685658178; Wed, 08 Apr 2026
 15:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407175934.1602711-1-pbonzini@redhat.com> <6569b8b8-7654-4dbe-a4a6-f1e565451672@linux.ibm.com>
 <CABgObfbiNRfNGvhDFO=h-E27KONh80fkB1y1rOGpazTB2Eigzw@mail.gmail.com>
In-Reply-To: <CABgObfbiNRfNGvhDFO=h-E27KONh80fkB1y1rOGpazTB2Eigzw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Apr 2026 00:00:46 +0200
X-Gm-Features: AQROBzDtkULtXuOIc6UktDacGB00r8lXLxRwmWhCPnmkbmrka56IuwUdIx-sODc
Message-ID: <CABgObfZg7HTX=N3cjHCeiZ2KuKSxnbr9Q7-5ciy8WgMPwBhU5g@mail.gmail.com>
Subject: Re: [PATCH] VFIO: remove dead notifier code
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, alex@shazbot.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 4:36=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On Wed, Apr 8, 2026 at 4:35=E2=80=AFPM Anthony Krowiak <akrowiak@linux.ib=
m.com> wrote:
> >
> >
> > >     open_device:
> > > -    The vfio_ap driver uses this callback to register a
> > > -    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the mat=
rix mdev
> > > -    devices. The open_device callback is invoked by userspace to con=
nect the
> > > -    VFIO iommu group for the matrix mdev device to the MDEV bus. Acc=
ess to the
> > > -    KVM structure used to configure the KVM guest is provided via th=
is callback.
> > > -    The KVM structure, is used to configure the guest's access to th=
e AP matrix
> > > -    defined via the vfio_ap mediated device's sysfs attribute files.
> > > +    the open_device callback is invoked by userspace to connect the
> >
> > Capitalization:
> > s/the open_device callback/The open device callback/
> >
> > Capitalization:
> > s/this callback/This callback/
>
> Heh, I had to pick one or the other (close_device previously used
> lowercase) and chose the wrong one. :)

I was going to make the change, but then noticed that lowercase is
more common in the file:

  create:
    allocates the ap_matrix_mdev structure used by the vfio_ap driver to:

  remove:
    deallocates the vfio_ap mediated device's ap_matrix_mdev structure.
    This will be allowed only if a running guest is not using the mdev.

  ioctl:
    this callback handles the VFIO_DEVICE_GET_INFO and VFIO_DEVICE_RESET
    ioctls defined by the vfio framework.

What do you think?

Paolo

