Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774E1C243A
	for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549730; cv=none; b=P8nySAAoD15G3ZaT7qE5WhDsGyTGEeYe+PMMEul+GFe66lfE7frREY0HQ57+pxHIhtbQjQbsoHbsf3DjvKF0oxyQmRu2iVtj3/J/JOggqC8lackofnnf1cesc/Ref3PLom2wTJBxlCEBAVYAAo1oWK1NkTNao5fWOp/FMu1J02A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549730; c=relaxed/simple;
	bh=XNFQsmvTwwgb+RxZBmoCe9zI1hjTKu1Y25+FWDQt5D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXZLPSWVIPJBXrjQTNDu21p5DwojT0lUKCZYaAbAQogzUIeKBQxeMXFmMVKyULGLp/Xv883javL8khxf9JH55F59X+shL/MlGQuHt4lnOV402D5A0afQbo4K2fJaFjEn/VtyNwjI/DxPCkfY70IvuSyk6Yf4CoxHKU++7TBrfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Li5ZbZBB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li5ZbZBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728549725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GM7DtQIpf+fPOvpsz2AGui1W1Ru1wkTcj4wDWnyHCaI=;
	b=Li5ZbZBBHgqbt+DdtMuqMVhMj4Lj62rF7c+JBIfzxohcKIoHPZ8cTqBLxTsOU0cEVqWa5x
	kqxQi7utjDvXY5ZQU8ujV2iQjZmSMZQOM/SyJ9NmbmU3K51+OrpQ7RlpKiDo3XSqn4Gja3
	p9UC3VKq17bQ33zz8DJ888bsnVSDkdc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-PXK_NkqjNSasR7UzTl9wxg-1; Thu, 10 Oct 2024 04:42:04 -0400
X-MC-Unique: PXK_NkqjNSasR7UzTl9wxg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fad3541583so4177261fa.2
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2024 01:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549723; x=1729154523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM7DtQIpf+fPOvpsz2AGui1W1Ru1wkTcj4wDWnyHCaI=;
        b=gduglS2uQd1pyTG3pFZVwINQVyUPqK13ed+GdTtemfi6s2LLxouGoEyiEbn+62LDsD
         5LaKbtg1tjTl9IDO5Ny4m6Dm75DWcHV00MUWVWhoY12lsayDNJQEjYrAl590A5bD6MmT
         SVH8+bWvFX6QkUr3V4aLMZUTZP0q8q9Kn95VdC75IvRR70wUDeZc4pETpOuckwqKbVlj
         +CvhEj95JFhZrJwbOnsH389LtMxm8WrfG3ipMxBJvZ0KoS206DkOMvuxEhS/e8dvTttC
         Vlo+kxUzylCDsbmyk83UK590tjTEf4pMHxKURHj2r5yjD2/Tvuh3HKIqXX2D5bniPmOO
         v6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXPHmtyVAAFfX4seDxtsYHx0QSan1XNjM5HUFoI09InbfEshfQYJ6tpUvFNE8qVZGgdwjzc0PJl8MC6@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvVTjCqqBpQP1cHR23wEEtb1zqafjyz+2lHRfom5KHC+LZByR
	OmT0PKwvpeIA0M45uuBo6sIQdu6dXM3ZwZSXxO02qmj16JmkD6/6SgmTGsVQcPQZG1/OEFXoYUf
	WbNa1ka0pO277+zwu0Q8sbRIRXrxjNaMmr8OsVYY8KMboQaKxQBTc1R0LYeESsNHluTNT6fZ4pe
	fjEZQ0YJ9FkQEs6BmoaxXClB/sbMJblwR0Mw==
X-Received: by 2002:a2e:be2c:0:b0:2f7:a759:72a7 with SMTP id 38308e7fff4ca-2fb1873820emr39055861fa.22.1728549722677;
        Thu, 10 Oct 2024 01:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtDPN01aoKhTb0Kx+hTbPzL0rIoqv3Q28dszjZ82sAqbT3YhpguNTUPjIwiNx0SHdAeK1nHIy6O5dnWKuZ35A=
X-Received: by 2002:a2e:be2c:0:b0:2f7:a759:72a7 with SMTP id
 38308e7fff4ca-2fb1873820emr39055571fa.22.1728549722212; Thu, 10 Oct 2024
 01:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910191541.2179655-1-david@redhat.com>
In-Reply-To: <20240910191541.2179655-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Thu, 10 Oct 2024 10:41:51 +0200
Message-ID: <CAMXpfWvRy_fpNUXeVO_-0O9WXDYY8f+cBEQQvsqZD2g2043LaA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] virtio-mem: s390x support
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
	Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series has been successfully tested along with the QEMU's series.
Virtio-mem devices could be resized, plugged and unplugged seamlessly.
The memory information displayed is correct and reboot doesn't cause
any issue.

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Tue, Sep 10, 2024 at 9:16=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> Let's finally add s390x support for virtio-mem; my last RFC was sent
> 4 years ago, and a lot changed in the meantime.
>
> This is based on mm/stable.
>
> I sent out the QEMU part earlier today [1], that contains some more detai=
ls
> and a usage example on s390x (last patch).
>
> There is not too much in here: The biggest part is querying a new diag(50=
0)
> STORAGE_LIMIT hypercall to obtain the proper "max_physmem_end". Once this
> and the QEMU part will go upstream, it will get documented in [2]
>
> The last two patches are not strictly required but certainly nice-to-have=
.
>
> Note that -- in contrast to standby memory -- virtio-mem memory must be
> configured to be automatically onlined as soon as hotplugged. The easiest
> approach is using the "memhp_default_state=3D" kernel parameter or by usi=
ng
> proper udev rules. More details can be found at [3].
>
> I have reviving+upstreaming a systemd service to handle configuring
> that on my todo list, but for some reason I keep getting distracted ...
>
> I tested various things, including:
>  * Various memory hotplug/hotunplug combinations
>  * Device hotplug/hotunplug
>  * /proc/iomem output
>  * reboot
>  * kexec
>  * kdump: make sure we don't hotplug memory
>
> One remaining work item is kdump support for virtio-mem memory. I
> am working on a prototype that will be fairly straight forward,
> because the virtio-mem driver already supports a special kdump mode and
> dracut will already include it in the initrd as default. With
> holiday and conferences coming up I rather sent this out now.
>
> [1] https://lkml.kernel.org/r/20240910175809.2135596-1-david@redhat.com
> [2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
> [3] https://virtio-mem.gitlab.io/user-guide/user-guide-linux.html
>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
>
> David Hildenbrand (5):
>   s390/kdump: implement is_kdump_kernel()
>   s390/physmem_info: query diag500(STORAGE_LIMIT) to support QEMU/KVM
>     memory devices
>   virtio-mem: s390x support
>   lib/Kconfig.debug: default STRICT_DEVMEM to "y" on s390x
>   s390/sparsemem: reduce section size to 128 MiB
>
>  arch/s390/boot/physmem_info.c        | 46 ++++++++++++++++++++++++++--
>  arch/s390/include/asm/kexec.h        |  4 +++
>  arch/s390/include/asm/physmem_info.h |  3 ++
>  arch/s390/include/asm/sparsemem.h    |  2 +-
>  arch/s390/kernel/crash_dump.c        |  6 ++++
>  drivers/virtio/Kconfig               | 12 ++++----
>  lib/Kconfig.debug                    |  2 +-
>  7 files changed, 64 insertions(+), 11 deletions(-)
>
> --
> 2.46.0
>
>

