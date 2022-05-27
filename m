Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F83C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 27 May 2022 10:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbiE0KuL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 May 2022 06:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbiE0KuJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 May 2022 06:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57F4212B019
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653648607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2Lh+gpGDkrHKWoEv+QKFc0qknv05ZH2I5oLoT3BQ3w=;
        b=ez9AvT1B4NZ/MUDoOykLozkTNl8FJXcGC15qzLS0DRTXuXdkh63SwQEPnVC0UWwRtiA3sC
        2hxEopK8rrOzSipx/hZOzvb/vrd6hHPHXKOFv7/uc0fl5/eBb83K2zzHvMBs3A0eDTi5ga
        WXKypaY0X0DhTZWNPXoeAi2l7lEuYk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-BHZHLglXNleXVI5Me-0dbg-1; Fri, 27 May 2022 06:50:06 -0400
X-MC-Unique: BHZHLglXNleXVI5Me-0dbg-1
Received: by mail-wm1-f70.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso4659198wms.0
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 03:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2Lh+gpGDkrHKWoEv+QKFc0qknv05ZH2I5oLoT3BQ3w=;
        b=yZ2K8SMxjO7YCDZWcGjBMpMxCi5+FAMPkQ2NbV3ZKGAp5svEHc9OuytaPeUGSQmSN6
         of9fA2m2bXGjJalWw9YlCfIzy2ZHI96altEg45J9WexEbKQNs8oI1+7Ujd4wPieeH6Am
         DffoaZFOVivR6TMts9Gkfm/JmSgubbZQZapOuX6GS9vL9P03t/+7DDp5Xbcj9x6MF+Kz
         LKSU9MLe/9whGVHOJp9wF4+97fyotf1ET5Wf5UE/eDS4L2sqcs6E4RerHkB7h6bCizLX
         LAL1ifjLUWogq+w+bR+mPvSnOToj9pjGsr+OzPaRk9tuWOWSbi6rucqco9kogBsf27YL
         2jDA==
X-Gm-Message-State: AOAM531hmnrrlFKXXhMZy65is8hvq8AuJjtKR9sQl1YQBjx/ak1k0Me3
        DpHaJnD5GCPudgCmAN3iWxZlMAVYiZzHq3tTKrKSLN/vC01aran686JK0UsNrVKXm3ZW34DZS/A
        2xL3jqi0wtVA2R8U3Bddt4Q==
X-Received: by 2002:adf:d1e7:0:b0:20f:dd30:489b with SMTP id g7-20020adfd1e7000000b0020fdd30489bmr19682804wrd.94.1653648605109;
        Fri, 27 May 2022 03:50:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS7mTUl4muodaOxpb3A92/00mQUnf2JML65CurJrTdcEaXMLxZDQNgec7W8o6+Bm+X58NZew==
X-Received: by 2002:adf:d1e7:0:b0:20f:dd30:489b with SMTP id g7-20020adfd1e7000000b0020fdd30489bmr19682778wrd.94.1653648604834;
        Fri, 27 May 2022 03:50:04 -0700 (PDT)
Received: from redhat.com ([2.55.130.213])
        by smtp.gmail.com with ESMTPSA id r2-20020a7bc082000000b00397402ae674sm1828344wmh.11.2022.05.27.03.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:50:04 -0700 (PDT)
Date:   Fri, 27 May 2022 06:50:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com, cohuck@redhat.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V6 9/9] virtio: use WARN_ON() to warning illegal status
 value
Message-ID: <20220527064118-mutt-send-email-mst@kernel.org>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-10-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527060120.20964-10-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

At a minimum, I don't see why it's part of the series. Host can always
crash the guest if it wants to ...
The point of BUG_ON is device or driver is already corrupted so we
should not try to drive it.  If you still want this in pls come up with
a better commit log explaining the why.

On Fri, May 27, 2022 at 02:01:20PM +0800, Jason Wang wrote:
> We used to use BUG_ON() in virtio_device_ready() to detect illegal

not really, BUG_ON just crashes the kernel.  we detect by checking
status.

> status value, this seems sub-optimal since the value is under the
> control of the device. Switch to use WARN_ON() instead.

some people use crash on warn so ...

> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/linux/virtio_config.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index d4edfd7d91bb..9a36051ceb76 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -255,7 +255,7 @@ void virtio_device_ready(struct virtio_device *dev)
>  {
>  	unsigned status = dev->config->get_status(dev);
>  
> -	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> +	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>  

we lose debuggability as guest will try to continue.
if we are doing this let us print a helpful message and dump a lot of
state right here.

>  	/*
>  	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> -- 
> 2.25.1

