Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693225EF8B
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200457; cv=none; b=qsh7Wx3mtd0xWcriZF404gHqRdaRi13Ntw9tb6dO03DZNkU0FUtpt55MmCo0plYrubaJLgpvIL3ScUaoKyXF0TmT+TG7DC2UAKXxLkwnxr5LjcQB8VuxHv3dsO2pEqFw+dBLsRT6/v5OjZtUUIPEHfvni/gbC+vDBf8s5Ewjrno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200457; c=relaxed/simple;
	bh=b8JlKxfWsW1Q1FUlQniB4qLGZUd/o9jlhbIFjs404XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN9ZGdUMFJ22ZlHBZB8YpAz+G+oebvP6lMrMnRiVVz5OqfH9w7Ge0QM6g7uEalqjJc0hI/TXNj88qyb9DAqHS/yZ52lL0My66dLrJf7N+ltOj8ncAVY5R+cQ/16I59lkwSWRXdjZT97rLhgtu/F/ABOHIThYm4B827aZj2Dw180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPn8yJv2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPn8yJv2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744200454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93G2Nz5v0VWYsyTUc29spHX3l7oxT61r/O1+sjmvXx0=;
	b=YPn8yJv2fCX/cl5qhxpmWtoHCaDhKTNAQ5jayOT+6oWOJTbaxW3uMFZIwSsDognrY+Nv81
	5o7ASho3MbDHcmuLt/97/JgIvtePOyNx0yignUryU6uPKTcO3uuFQlj3xNrJ/F0JpojRMY
	vEpX3P8OL3s4FL8V+HHHMUtThFhyoSM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-vFy2Z8faNEKWVDD6NKfMfQ-1; Wed, 09 Apr 2025 08:07:33 -0400
X-MC-Unique: vFy2Z8faNEKWVDD6NKfMfQ-1
X-Mimecast-MFC-AGG-ID: vFy2Z8faNEKWVDD6NKfMfQ_1744200452
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so38984905e9.0
        for <linux-s390@vger.kernel.org>; Wed, 09 Apr 2025 05:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744200452; x=1744805252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93G2Nz5v0VWYsyTUc29spHX3l7oxT61r/O1+sjmvXx0=;
        b=LRyb86zuVXAuqSklSlLasVaRM+LD9iV4idpxXsiyXxVUXas4Rl3yeKZDJ75vfcVxco
         5UwJevjucgaPTj3w8fBVrxCMGNf2RCDKy13d10mM0rjIP/KChKW+I88ugXWzRCLtI9vf
         SN+oVFmFhXWv0jogA6CDUNUhRQypwjgAn1Qf5vanJIAff6FUSoiexm7Ctb/SOyMCeOeF
         JZVoS1fGx3qhqGY/6Atd5N+83jszyKOXGuG65N6KDkwQhfeW0HGR2m50bYNEeZ5dLNHo
         2nd+cWCPRylF384KPf1MVviN8AZaPFMfH3H34IlzVbM82E92FlLzGfabzGKNtoJlB2xx
         W2ow==
X-Forwarded-Encrypted: i=1; AJvYcCWLrEkYP7ehZxHaJm5u5fxYE6J3g4OqgYEHa3IwxtnZVEAnULCHzpo1gCiSmAF50JjL9m8VGHhNiUvo@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpHSyNn5a733tXTJ6dv1DZ2P9oesJuoxCPqTuhV+OmjSZcW6Q
	FGOAVS6KIFq96o0KjnddzR0z4dE8gCfZmzcHlH4WhamNxlGqJKT3icmLLpuw0sZ5aUJT1PNQg6U
	+G8h7aSDDdGXrgxw3FMItO/4thhdU3u0rCAW/3UbYqa7/cO2B0vuciMq07Ko=
X-Gm-Gg: ASbGncsxtjXz8q55FodfdpSe9ko4g93dRYDz35cWwVD2u6n4JYo5vSHhRbSs/HiPqYt
	y5wQQGbtpNAEfPJyr8blF0gC9lXR5ub68z6TjlAgWLCFU0ndBftWNKiDC9Ja5RBJ0fYVOfjn1Jh
	iYGGkjppCwN8kb2orgaPBnJdUMYGweC9szFMly2IUdDiH2nfZNsu/SkAKxPYVYmGIMsfTydd0qH
	uQ4a/MyJK8Cmjq5DDGCGJBuv1qCtPhCT+h5j61DPIafW+zl/SfyASzQikbuqB6rpdM3W4cbBHsh
	LtJv/w==
X-Received: by 2002:a05:600c:4f06:b0:43c:eec7:eabb with SMTP id 5b1f17b1804b1-43f1eca7d49mr25281725e9.8.1744200452000;
        Wed, 09 Apr 2025 05:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgSZUF2eaDFJtZf7ycuhgCh7uKezx7J6gwsxBt6Ke0ZQtqogJFzTU/28nf3axU595G1MOTHA==
X-Received: by 2002:a05:600c:4f06:b0:43c:eec7:eabb with SMTP id 5b1f17b1804b1-43f1eca7d49mr25281355e9.8.1744200451567;
        Wed, 09 Apr 2025 05:07:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm18374765e9.22.2025.04.09.05.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:07:30 -0700 (PDT)
Date: Wed, 9 Apr 2025 08:07:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>,
	Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250409073652-mutt-send-email-mst@kernel.org>
References: <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
 <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
 <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
 <20250407170239-mutt-send-email-mst@kernel.org>
 <440de313-e470-4afa-9f8a-59598fe8dc21@redhat.com>
 <20250409065216-mutt-send-email-mst@kernel.org>
 <4ad4b12e-b474-48bb-a665-6c1dc843cd51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad4b12e-b474-48bb-a665-6c1dc843cd51@redhat.com>

On Wed, Apr 09, 2025 at 01:12:19PM +0200, David Hildenbrand wrote:
> On 09.04.25 12:56, Michael S. Tsirkin wrote:
> > On Wed, Apr 09, 2025 at 12:46:41PM +0200, David Hildenbrand wrote:
> > > On 07.04.25 23:20, Michael S. Tsirkin wrote:
> > > > On Mon, Apr 07, 2025 at 08:47:05PM +0200, David Hildenbrand wrote:
> > > > > > In my opinion, it makes the most sense to keep the spec as it is and
> > > > > > change QEMU and the kernel to match, but obviously that's not trivial
> > > > > > to do in a way that doesn't break existing devices and drivers.
> > > > > 
> > > > > If only it would be limited to QEMU and Linux ... :)
> > > > > 
> > > > > Out of curiosity, assuming we'd make the spec match the current QEMU/Linux
> > > > > implementation at least for the 3 involved features only, would there be a
> > > > > way to adjust crossvm without any disruption?
> > > > > 
> > > > > I still have the feeling that it will be rather hard to get that all
> > > > > implementations match the spec ... For new features+queues it will be easy
> > > > > to force the usage of fixed virtqueue numbers, but for free-page-hinting and
> > > > > reporting, it's a mess :(
> > > > 
> > > > 
> > > > Still thinking about a way to fix drivers... We can discuss this
> > > > theoretically, maybe?
> > > 
> > > Yes, absolutely. I took the time to do some more digging; regarding drivers
> > > only Linux seems to be problematic.
> > > 
> > > virtio-win, FreeBSD, NetBSD and OpenBSD and don't seem to support
> > > problematic features (free page hinting, free page reporting) in their
> > > virtio-balloon implementations.
> > > 
> > > So from the known drivers, only Linux is applicable.
> > > 
> > > reporting_vq is either at idx 4/3/2
> > > free_page_vq is either at idx 3/2
> > > statsq is at idx2 (only relevant if the feature is offered)
> > > 
> > > So if we could test for the existence of a virtqueue at an idx easily, we
> > > could test from highest-to-smallest idx.
> > > 
> > > But I recall that testing for the existance of a virtqueue on s390x resulted
> > > in the problem/deadlock in the first place ...
> > > 
> > > -- 
> > > Cheers,
> > > 
> > > David / dhildenb
> > 
> > So let's talk about a new feature bit?
> 
> Are you thinking about a new feature that switches between "fixed queue
> indices" and "compressed queue indices", whereby the latter would be the
> legacy default and we would expect all devices to switch to the new
> fixed-queue-indices layout?
> 
> We could make all new features require "fixed-queue-indices".

I see two ways:
1. we make driver behave correctly with in spec and out of spec devices
   and we make qemu behave correctly with in spec and out of spec devices
2. a new feature bit

I prefer 1, and when we add a new feature we can also
document that it should be in spec if negotiated.

My question is if 1 is practical.





> > 
> > Since vqs are probed after feature negotiation, it looks like
> > we could have a feature bit trigger sane behaviour, right?
> 
> In the Linux driver, yes. In QEMU (devices), we add the queues when
> realizing, so we'd need some mechanism to adjust the queue indices based on
> feature negotiation I guess?

Well we can add queues later, nothing prevents that.


> For virtio-balloon it might be doable to simply always create+indicate
> free-page hinting to resolve the issue easily.


OK, so
- for devices, we suggest that basically VIRTIO_BALLOON_F_REPORTING
  only created with VIRTIO_BALLOON_F_FREE_PAGE_HINT and 
  VIRTIO_BALLOON_F_FREE_PAGE_HINT only created with VIRTIO_BALLOON_F_STATS_VQ

I got that.


Now, for drivers.

If the dependency is satisfied as above, no difference.

What should drivers do if not?



I think the thing to do would be to first probe spec compliant
vq numbers? If not there, try with the non compliant version?


However,  you wrote:
> > > But I recall that testing for the existance of a virtqueue on s390x resulted
> > > in the problem/deadlock in the first place ...

I think the deadlock was if trying to *use* a non-existent virtqueue?

This is qemu code:

    case CCW_CMD_READ_VQ_CONF:
        if (check_len) {
            if (ccw.count != sizeof(vq_config)) {
                ret = -EINVAL;
                break;
            }
        } else if (ccw.count < sizeof(vq_config)) {
            /* Can't execute command. */
            ret = -EINVAL;
            break;
        }
        if (!ccw.cda) {
            ret = -EFAULT;
        } else {
            ret = ccw_dstream_read(&sch->cds, vq_config.index);
            if (ret) {
                break;
            }
            vq_config.index = be16_to_cpu(vq_config.index);
            if (vq_config.index >= VIRTIO_QUEUE_MAX) {
                ret = -EINVAL;
                break;
            }
            vq_config.num_max = virtio_queue_get_num(vdev,
                                                     vq_config.index);
            vq_config.num_max = cpu_to_be16(vq_config.num_max);
            ret = ccw_dstream_write(&sch->cds, vq_config.num_max);
            if (!ret) {
                sch->curr_status.scsw.count = ccw.count - sizeof(vq_config);
            }
        }

and

            
int virtio_queue_get_num(VirtIODevice *vdev, int n)
{               
    return vdev->vq[n].vring.num;
}           
            


it seems to happily return vq size with no issues?




> For virtio-fs it might not be that easy.

virtio fs? But it has no features?

> > 
> > I kind of dislike it that we have a feature bit for bugs though.
> > What would be a minimal new feature to add so it does not
> > feel wrong?
> 
> Probably as above: fixed vs. compressed virtqueue indices?
> 
> -- 
> Cheers,
> 
> David / dhildenb

