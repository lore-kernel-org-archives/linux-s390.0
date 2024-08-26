Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCE13D8A3
	for <linux-s390@vger.kernel.org>; Mon, 26 Aug 2024 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653960; cv=none; b=ZPZFo10uqQ0fUy3ubzs3vttSCEdAJbIMrR/a/dRJFg5vDBYg49W5DnB5I3mejIFzEkbJlYqF/GRkr0lmR+5FYdeYZ8Rp897ZBpzc+FIvoBW1N48vzIjWg1oIK1yrm+Z+vvhJYorwRxm71gCQUJR4y8V4qzh+Ucwqh6Jf+pZj3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653960; c=relaxed/simple;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXG/DkAsXpGS1BmoK3gYPqcyK2p4RzH4cSR1M0xPd+0xJ+ZFaxnfd6sOSLpfgTUMjA62+An9/ICJVOdqAX4eoO8+C79YQOvRiUhiovlbnsrCxRTQ9LVagDRX9CsqnNOlI8u0AO94Wp+nZicdKsmsG5VVDX2pn3LOl/jxnyjWzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVHJc79j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVHJc79j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	b=EVHJc79jBzCkyMFB0kapvJG/tRUmdqd8UyboY8OyiCRCx+xejxJGrkPrfakOt7i5+CdBoJ
	6Y8XVErTDiM1Gy2oXE2QGvaf7mqTEnHjhQqSOi/yAEpZtVn5kwNa/Z/etKs+uwc4RMKAbc
	374rqLcBoljq0nI4SGlXlMWzydCdSFI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-WNcb5pTQNmaeW0EYrJL0zQ-1; Mon, 26 Aug 2024 02:32:31 -0400
X-MC-Unique: WNcb5pTQNmaeW0EYrJL0zQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-498d9003facso1514187137.2
        for <linux-s390@vger.kernel.org>; Sun, 25 Aug 2024 23:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653951; x=1725258751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
        b=lutxbC0KeZEZBt6QegQLIDV23EYoqdxnRihol6Nbfo2aRRJwawO2vCy1snEAZIySmx
         YLl3CPCfcTjMpHZc103+4RlFu6am+wevrHtvSNCtWhcGiWJ8nfHrySrn7vIFEAIloZle
         Etq2FI9AELYxGVLObX3LQUR7arN00LMfqIHW6LZXKVT5MpWXsLGRefd3S/lmY9I5EoaS
         /BAw6lRnYZVLVyeOz0KuQBcNuB3x1lygDk+/SM8LQofWu9irUR3zY5YHPLXyAg7I5t+c
         mxLDE/Pi8IEhDm3fiBoneYV5RPq1410UqdB7s1X6B5uZz/Tm/mpc21pOz1wBMDpUNYrp
         Hx0w==
X-Forwarded-Encrypted: i=1; AJvYcCU9T2RZK0XLxL/4iAQ/106DW6pRv3d80zDmnRX+MwcjZxQhwEzGWwP5SZ9KixHq6dv4u72OGPF2qXBY@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJ4KotPnxMGyP112wyT5kKF2LyVRDH1P6jtbMI4oDWzmMxXIm
	TfDu+R58O6w6Fmf7MDWfzJcNRh1Ptb0GGR2jUfvrsieYWfTSCpg9plBjAX4M+9i2tqVzk7Thcyi
	93MPZi9JvNATUjtK8x6sFxcW8ye+39DbtkCqCm9Wxm+PIaC3Yr1zovyE16r6wyR5a27kCObubhO
	UDbkoQhCbfX+S9ObaOcCi9YE4RJXyddhEWsg==
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id ada2fe7eead31-498f4768d98mr6498542137.31.1724653950681;
        Sun, 25 Aug 2024 23:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwydcuFOVlgtFmwjWlxiF2u2xtiMO6UvY+/x7l/PEgUFs/udwBSaHF5gxdau0K58G8iWDDv631otNdoDoL8Rg=
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id
 ada2fe7eead31-498f4768d98mr6498530137.31.1724653950260; Sun, 25 Aug 2024
 23:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824035817.1163502-1-hch@lst.de> <CACGkMEsK8k=yX2ZytMJQhdZi4PS9-7KLUYmf2oGLu-UvNEYzug@mail.gmail.com>
 <CACGkMEu83MjTpkSS1mX02ar8RNDc5T4bsd4kkGHYhkH7LZY-wA@mail.gmail.com> <20240826063002.GA30266@lst.de>
In-Reply-To: <20240826063002.GA30266@lst.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:32:15 +0800
Message-ID: <CACGkMEvB20-iwNKepBdJBNAvxN-5+MduxnX6XDbPFsVA4hNz5A@mail.gmail.com>
Subject: Re: clearly mark DMA_OPS support as an architecture feasture
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-media@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 2:30=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Aug 26, 2024 at 02:27:27PM +0800, Jason Wang wrote:
> > Actually I meant, we can extend the virtio_config_ops to allow mapping
> > ops there, then simulator and VDUSE can hook the map ops there.
>
> From a quick glance that feels like the right layer of abstraction,
> although the config part of the name feels wrong at that point.

Right, or we could have a dedicated map_ops instead of trying to use
virtio_config_ops.

Thanks

>

