Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3851005
	for <linux-s390@vger.kernel.org>; Tue, 19 Mar 2024 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831675; cv=none; b=SKYxmDVuJgrecqXKbygzK0TcpLUTinuUEzwVkGnSFwEcpy+gR8+iv5Drm4OhrdhdzZpaKFo+mScFd3u6lq29nMGNicwqc/bGA9Wf4Ko0M1U/HcQ4eErXmxsccEHv6e1+mNhEh5DCSZAVLGO2zo0XM28849CDf15px4fgq8VM9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831675; c=relaxed/simple;
	bh=+0yGzgO/uZDZuFmdyu9d+sc45NfVqM4uTrSkkmcuopU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlOMGYZKVINKaE079wGoUpUKTArlP85+L3WJ7nDhQik9qynsP7z4Widpn9BOoubErtUmQ1tbzmrqSMKzf1MWSkK5T2xESWupeMT/Yc2LhqcYj7UVRpffujvo1JsC4O32Pq+hMEimGRwzIGVF7XUf3dx8BuMu1Z3RStwTyfurGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxMcq8CB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxMcq8CB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710831672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=foUSQQGmYmOu8nLXi1AjlC9r9SGWzmdXWf6sigKcUWw=;
	b=AxMcq8CBcdA/gqIt5SOEw+883M4kzftWmVgOAaRzn1cSQD7heZANMPQNc8ib6ehaYCEuBZ
	gveaMwXy8u2SUQ5a1QLDrN5NBJTTntEPyf/2/1rqAbaskJ+mn3Yf0bAON0eOYv3eadOHtY
	9PW6OvOKYSIrZXohP3UoTuGRnl/Q0eg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-9D67RE5FMNChB7Vp-A4YDQ-1; Tue, 19 Mar 2024 03:01:10 -0400
X-MC-Unique: 9D67RE5FMNChB7Vp-A4YDQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412c7ee0c97so24778595e9.0
        for <linux-s390@vger.kernel.org>; Tue, 19 Mar 2024 00:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831669; x=1711436469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foUSQQGmYmOu8nLXi1AjlC9r9SGWzmdXWf6sigKcUWw=;
        b=dexxlceOKIizAp6s0NaU/y5YXQXSmPPrblsAXwxBlAZ/CmiwN/GqH/RFo4dWi5RDLX
         hEaM6KlMswDuBYtr2U0wiCG0s/6GLGaDY0RKyPqQAr4z84kxeZyn1xaw5Og5ypSd34AI
         ptX3M4lYEdw1s5SwOcOhk4Ci3eIrBX+XYHbdwp1klHD9c/ZKoRWGsjnyngb4akcCmG+m
         s7BP/BEkiryd4arGSLGqulUJXSsBWjKa5fT8OIhEExo9SUs4F3amjoYzxc5LBYXmBDoe
         0OorO2i+W12h0vdG+5owAK8RaKT91aLCCzEaUVXtJHR4UuDz85Flrl9lhBSHaF22htZz
         552A==
X-Forwarded-Encrypted: i=1; AJvYcCXNQVL2atKCOrl5uXPQK9psOG6a1qeJDQjGo+dC83OfN35hLKoWWekXudiOq6L5n2slUMWCyymz8NEPU6ikvFU6U+CIOh/yPYXMfQ==
X-Gm-Message-State: AOJu0Yx/OfczlZQZB8NPEUnYlFE7qTrhNidfSUlxV7Rld9DkBsLYB8aP
	G2Do7HuO84rDVqIvQxn3BzBxxq1c5yqyZvG5PTt0alAM06QoWuZ+RndSbcx8EcfQSyZZnN08yjT
	02vz93BfT4xoY2trZzgeiUgD0Xwu764+D+dzBpWOLTPGa96SL2Ol7by8fcD0=
X-Received: by 2002:a05:600c:4f0e:b0:413:ef8e:4cc with SMTP id l14-20020a05600c4f0e00b00413ef8e04ccmr1095511wmq.40.1710831669527;
        Tue, 19 Mar 2024 00:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzg6YzD09DcsuSp1mTE4kCrxMGUWI9Lm91o60NEdPSVsYEnPJ0jVjqFhsmb8yxRUdsUTgvyQ==
X-Received: by 2002:a05:600c:4f0e:b0:413:ef8e:4cc with SMTP id l14-20020a05600c4f0e00b00413ef8e04ccmr1095470wmq.40.1710831668946;
        Tue, 19 Mar 2024 00:01:08 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id fk10-20020a05600c0cca00b0041463334822sm1536373wmb.26.2024.03.19.00.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:01:08 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:01:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v3 0/4] refactor the params of find_vqs()
Message-ID: <20240319025933-mutt-send-email-mst@kernel.org>
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>

On Tue, Mar 12, 2024 at 10:10:09AM +0800, Xuan Zhuo wrote:
> This pathset is splited from the
> 
>      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com
> 
> That may needs some cycles to discuss. But that notifies too many people.
> 
> But just the four commits need to notify so many people.
> And four commits are independent. So I split that patch set,
> let us review these first.
> 
> The patch set try to  refactor the params of find_vqs().
> Then we can just change the structure, when introducing new
> features.
> 
> Thanks.
> 
> v3:
>   1. fix the bug: "assignment of read-only location '*cfg.names'"
> 
> v2:
>   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
> 
> v1:
>   1. fix some comments from ilpo.jarvinen@linux.intel.com
> 


As this came in after merge window was open I'm deferring this
to the next merge window.

Jason, can you pls try to complete the review meanwhile?

> 
> Xuan Zhuo (4):
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: simplify the parameters of the funcs related to
>     vring_create/new_virtqueue()
> 
>  arch/um/drivers/virtio_uml.c             |  31 ++--
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 ++--
>  drivers/remoteproc/remoteproc_virtio.c   |  31 ++--
>  drivers/s390/virtio/virtio_ccw.c         |  33 ++---
>  drivers/virtio/virtio_mmio.c             |  30 ++--
>  drivers/virtio/virtio_pci_common.c       |  60 ++++----
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       |  16 ++-
>  drivers/virtio/virtio_pci_modern.c       |  38 +++--
>  drivers/virtio/virtio_ring.c             | 173 ++++++++---------------
>  drivers/virtio/virtio_vdpa.c             |  45 +++---
>  include/linux/virtio_config.h            |  85 ++++++++---
>  include/linux/virtio_ring.h              |  93 +++++++-----
>  tools/virtio/virtio_test.c               |   4 +-
>  tools/virtio/vringh_test.c               |  28 ++--
>  15 files changed, 363 insertions(+), 337 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

