Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1118225A8
	for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999573; cv=none; b=UTcbFZJ5+BF0r7IMCCpIYqLS0uBHxM9SDNe6yLUQT6ccByLwcrXojysa+6CfxXuIyZdg0aQp54z1SF5WSfxS4S6Gnnt3rcqqjncUM7oE/UlDEByjLj/u65lWIatLnRwbe34IRBPkUgcNgkNs8oOi1I/cZo2VArc6pyQ7ISAM/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999573; c=relaxed/simple;
	bh=8CCuLYWdWTSFpLwKxbqHrDLHqq2DH1fE8m6jNkhdCNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNFEPux26n3YbUMLOWh0DHFAoBTW4thOluBEx7cjdrSf/3tj6h8wY7jHmFVUUaSWWTbiK4nET8NQPPTJAFmbR6TzjfQMnfC59zyOFOz0dJNt2qtpa6Oynr56jjYH4zDAsqktpfY/EYsQl71YfIPW7s5WQO1tEtDYsM9CByr3G7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAnOMtGg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAnOMtGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725999570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/Ek58qaXc13SAy2fWa0xfKNbuHUlKabbBtKkvuJifU=;
	b=fAnOMtGg/vKj8V5YBuo9kuAU+OPPZ4RGrSp+3DRy823hdp3gigiPWOHQJ4GCj4JhdL6N+8
	NHRAq46f1DZ3+1Nx8gbkziZpZoGMHn03mI0Al2ySBUoTNp7+2kqZCFXY4mZLYO5+ho5jh+
	b0fcqrn9xQNTxuTwrZSwQIiUnQwp1mY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-jqTMQVsjO2W-vBIJKzbEiA-1; Tue, 10 Sep 2024 16:19:29 -0400
X-MC-Unique: jqTMQVsjO2W-vBIJKzbEiA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d2ecdf414so198714766b.2
        for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 13:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725999568; x=1726604368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/Ek58qaXc13SAy2fWa0xfKNbuHUlKabbBtKkvuJifU=;
        b=noejWdyOv3OMMhe/QHNRSqKV8ZbQYFMBKbqjBvQIdHm/W1zb7zF62kutVFsbzZY3Lu
         qev5M3d8A9kuSpEWJmtC+FR62xTgOoRk5wz4vSm42ZVB/AkBcDHuT11PvnOyV32LJiYK
         7OuKeTgo8eufxzEq4QRdm3bnYTPWwhJToi9guYJce6dEuhqbneP/TGRm3Dr7Zxg6SP2V
         rDZPv3MAbuHYmyDfopHk1Qnb9GazUQAnS1CTyWfGAzPyjCcKAJgQuaxQ/120+m7u7QBw
         +oeBtWUTTP3M+1QvQKX2xJ7tHCU37dZSE1pR+zMmQUhVc+SSYeqL/Dc5KA9M9CdeBdfE
         g86w==
X-Forwarded-Encrypted: i=1; AJvYcCU7J1WaSvEXPhXz3+i3lqsi1YDctorKrqgqknCT2edn/JnrlxzcsZlmNHIcTEjNr3pCvDGpY+BeCIyS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0B/X/Kf2UhXEGMog6wKIsTf/VfpynPOmxVaxmV2b6nFeAiCC2
	DxK4zdY/4NQ/PFIoYxXxX/asdeUN3iI/bjwSWlgr26R4bbQC9qjueCcFGvgEO6D9AxN2KXeJEyP
	ykyQgSYsza/QPO6VArH/wkZv3CEOB1BUzvtBjI8JIj2HAwYrQLAhiLougpa4=
X-Received: by 2002:a17:907:9812:b0:a88:b90b:bd5e with SMTP id a640c23a62f3a-a8ffaaacfa1mr185691166b.3.1725999568235;
        Tue, 10 Sep 2024 13:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIpn+zlExuTE3yAX+xjiMRNjjie27yYDse9XLe2ciVUQSSxwhcmURZ5WywfpEvPrJPhC6Cgg==
X-Received: by 2002:a17:907:9812:b0:a88:b90b:bd5e with SMTP id a640c23a62f3a-a8ffaaacfa1mr185687666b.3.1725999567396;
        Tue, 10 Sep 2024 13:19:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:f5ce:2d9:5bfa:9916:aa0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c62485sm519926966b.104.2024.09.10.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:19:26 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:19:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 0/5] virtio-mem: s390x support
Message-ID: <20240910161847-mutt-send-email-mst@kernel.org>
References: <20240910191541.2179655-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910191541.2179655-1-david@redhat.com>

On Tue, Sep 10, 2024 at 09:15:34PM +0200, David Hildenbrand wrote:
> Let's finally add s390x support for virtio-mem; my last RFC was sent
> 4 years ago, and a lot changed in the meantime.
> 
> This is based on mm/stable.
> 
> I sent out the QEMU part earlier today [1], that contains some more details
> and a usage example on s390x (last patch).
> 
> There is not too much in here: The biggest part is querying a new diag(500)
> STORAGE_LIMIT hypercall to obtain the proper "max_physmem_end". Once this
> and the QEMU part will go upstream, it will get documented in [2]
> 
> The last two patches are not strictly required but certainly nice-to-have.
> 
> Note that -- in contrast to standby memory -- virtio-mem memory must be
> configured to be automatically onlined as soon as hotplugged. The easiest
> approach is using the "memhp_default_state=" kernel parameter or by using
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
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>


It's mostly s390 changes, so should be merged through that tree.
I acked the only virtio specific patch.

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

