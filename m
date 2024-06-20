Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100C19EED0
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874081; cv=none; b=EYiY6rS7W6w+1YCCIxnc0FKWjJrbdgwJl/m/3rCPT6DkSldpgbJPqOqj659Xm4oM4hOLNpdaGVPy6Hk2+WpFMnjQRxJwH8vPfm02b5QBBk1MxJfFwdflZQ3HWoLswgHq8T3WfpcuqyTIJqIVw3AEwD6A4lJmh6lmwggxru3O6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874081; c=relaxed/simple;
	bh=2nMCQx2fyhNhl3V6Bsvj0nvtFHLSOUGt0buGaTs+hAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVL2r84gI4+pB51YrtI4EAp4CV5ONfCO4DVlvK+uS+Ab72ior9OSeExy/GCWGvgSWtQqBnilsd5KAT3Yp3xJVsaemxtryHtzzA+S1djdtAD0niuIqjLZfACSmc8rxI4AkJnrbvLGG8Qi5y75lZLa1boe3T4nO8N/18DiC6Ti4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SR6WBTF4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SR6WBTF4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718874079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XR61vx35OTZX9XFWt8YdyvsDaIUHY+xQKab0QtNP4Qc=;
	b=SR6WBTF4zh3aZRG1XLePLbTnMStpDw/t1Trbd4eLbGLuWtnSL23ee83scsGtEydvQnQfoG
	iQ7puFwYVAXSJ3Hn6obiNwlhG6VOq6VClgjlzt9l+tRVAwCq5THmxV1aq+Nvtv8cjSDjaM
	Dqm8Yo4MG82MV7P6WUxDQeI+HUWnJFA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-T80nMeooOPO_SuuZjoZZ5Q-1; Thu, 20 Jun 2024 05:01:17 -0400
X-MC-Unique: T80nMeooOPO_SuuZjoZZ5Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6f1db7e425so36165366b.1
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 02:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874076; x=1719478876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR61vx35OTZX9XFWt8YdyvsDaIUHY+xQKab0QtNP4Qc=;
        b=TQy2YBIffYAaEk4qHdRLTTq32Z0Es8bcXrinKW4n9bfsBPlhHWwhX0EA04fFESP5P0
         EALspNXrx+MsGhfr0Yfz08ZPy01fSBfoQdQLCAzQpKQKx8enLlgOj9H1BGzgQkL2Y8xW
         X7eRysc51R9fCfWI44uQXsWuXxCQ7oQTQ9V3W85BlzBx8porO/tVM4ARiEhCgru6E0FW
         CzvL4tVh06hxIDsgI6GJ3DxDH87TFbxck+A0z2h7YNiwDimDsupV0A79XJVGlBkqLZrM
         SDDC+7V5zqga8bK9nAZJ8cIEWNi0tksfZyo74CXgb5SJuTj7lZRHH8pcko9Hh5VCWI5r
         6NUA==
X-Forwarded-Encrypted: i=1; AJvYcCURECAisdnZDDcJMhmxSQ7gYIGHjtoIcmdTf3Bk4TdWc2wBEzd3sKvICdBs29N+jjZFvsEa3YFhEScg4v5PT0QWgvH7uk4qIfJ5PA==
X-Gm-Message-State: AOJu0YyJVyya6PAjbyEPIbalSferUIfuGLX5EGHLN0FOOrP6ilAVg9bK
	HfGSgXn5f0ixOqokRow61/IlKWdJyRUUZx4C/eLByCP09R+6Cw7oijyy55hdg0vhZUDahkhi/g8
	h4QEwePxoqWiB2O4uWO0Xb3f3r7E4lz13d/IHit8R1B3GfUj2OEHkkM1t4Rc=
X-Received: by 2002:a17:907:c805:b0:a68:b73d:30d0 with SMTP id a640c23a62f3a-a6fab609e47mr400228266b.6.1718874076402;
        Thu, 20 Jun 2024 02:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5+F4gugdmHhB163V4ULVbHnYMOFq3eTuk1V982iZ6yAjow4HL/6ytgFaWqg7nTSdPpnke9w==
X-Received: by 2002:a17:907:c805:b0:a68:b73d:30d0 with SMTP id a640c23a62f3a-a6fab609e47mr400225566b.6.1718874075875;
        Thu, 20 Jun 2024 02:01:15 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3356sm742953866b.40.2024.06.20.02.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:01:14 -0700 (PDT)
Date: Thu, 20 Jun 2024 05:01:08 -0400
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
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v9 2/6] virtio: remove support for names array
 entries being null.
Message-ID: <20240620044839-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-3-xuanzhuo@linux.alibaba.com>
 <20240620035749-mutt-send-email-mst@kernel.org>
 <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>

On Thu, Jun 20, 2024 at 04:39:38PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 04:02:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Apr 24, 2024 at 05:15:29PM +0800, Xuan Zhuo wrote:
> > > commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> > > support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> > > doesn't apply. And not one uses this.
> > >
> > > On the other side, that makes some trouble for us to refactor the
> > > find_vqs() params.
> > >
> > > So I remove this support.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Acked-by: Eric Farman <farman@linux.ibm.com> # s390
> > > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> >
> >
> > I don't mind, but this patchset is too big already.
> > Why do we need to make this part of this patchset?
> 
> 
> If some the pointers of the names is NULL, then in the virtio ring,
> we will have a trouble to index from the arrays(names, callbacks...).
> Becasue that the idx of the vq is not the index of these arrays.
> 
> If the names is [NULL, "rx", "tx"], the first vq is the "rx", but index of the
> vq is zero, but the index of the info of this vq inside the arrays is 1.


Ah. So actually, it used to work.

What this should refer to is

commit ddbeac07a39a81d82331a312d0578fab94fccbf1
Author: Wei Wang <wei.w.wang@intel.com>
Date:   Fri Dec 28 10:26:25 2018 +0800

    virtio_pci: use queue idx instead of array idx to set up the vq
    
    When find_vqs, there will be no vq[i] allocation if its corresponding
    names[i] is NULL. For example, the caller may pass in names[i] (i=4)
    with names[2] being NULL because the related feature bit is turned off,
    so technically there are 3 queues on the device, and name[4] should
    correspond to the 3rd queue on the device.
    
    So we use queue_idx as the queue index, which is increased only when the
    queue exists.
    
    Signed-off-by: Wei Wang <wei.w.wang@intel.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Which made it so setting names NULL actually does not reserve a vq.

But I worry about non pci transports - there's a chance they used
a different index with the balloon. Did you test some of these?

-- 
MST

