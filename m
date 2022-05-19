Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DA3C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 19 May 2022 08:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiESIeL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 May 2022 04:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiESIeK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 May 2022 04:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEB18737B5
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652949248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e36VWZ5DWvtpQPTuTGZUg65mwhzA3Ro0bMqrlq/Fvz0=;
        b=RbB3h40sCWvVQm364D+zXUkG3O2p+LjeKQcbqGWMieSSkTDLi9q92Cs4lwiTEmMk+DHQG+
        Ho1Ll8ouQdqiq5s+GYFi+e9+R6CjEZpFnQ0HlyfaM8TLN57up3ttze6iZJ2W4w+SsZ0kQe
        zIEslzuCCjlX6abPV1CkpcWuNEsS47c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-QIk5g26cOZy2iUo9xja4BQ-1; Thu, 19 May 2022 04:34:06 -0400
X-MC-Unique: QIk5g26cOZy2iUo9xja4BQ-1
Received: by mail-wm1-f69.google.com with SMTP id m26-20020a7bcb9a000000b0039455e871b6so1566498wmi.8
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e36VWZ5DWvtpQPTuTGZUg65mwhzA3Ro0bMqrlq/Fvz0=;
        b=fEL9no52Qwm/jefltyGg3hXcC+3aTbIQFASJczU4ce5GolBYuVy2oUnlsAaHWPslSu
         oZGnFDklPAKCSDmmHSVV50FaXbTuJ6RRRhvBBz+srpWwvnEsdrDfIaR/nVAM5OFVZzH0
         puir3BVtxiTQFTy7UWKWoRmmIAx3Vm841cLFgdEISy0OIQNxtCTY0JyUzXNEMdbfLVM4
         Z66PcehgEkfHhu3G5/mFWvo8M9bDjAT4YZsKz/vpriKMpMTAyOFYQBDbCHKFqlMC2NjV
         LBpnp8ibVJ1eHR2vMDMQdpaPMFU4jnkIFS0mc6IiQfHJ3oIefE/aM57eW3VBurT28K1h
         ilFw==
X-Gm-Message-State: AOAM531rPusViKQFmvXQKYZnp9WuL5wo/mTsuS2y9orQzb8aYNaqYL4R
        udzR2cA4xYVjjY3In+BCyAYET3diwkaRm553McHaxGsQQXCBQ1Mp96uwxcCvX2SfCgyJ+CYgdGq
        LZiDFu9s2N6Jef8ac+qqrAw==
X-Received: by 2002:a5d:6a4e:0:b0:20d:83:f5bb with SMTP id t14-20020a5d6a4e000000b0020d0083f5bbmr2963264wrw.392.1652949245040;
        Thu, 19 May 2022 01:34:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz05m0Do5MtdQDqPk7YxffOwGGKVjHy6V0eWXG2QT+lHKjiwAFQdDwNmmaqWWjoSwfqFAMZew==
X-Received: by 2002:a5d:6a4e:0:b0:20d:83:f5bb with SMTP id t14-20020a5d6a4e000000b0020d0083f5bbmr2963236wrw.392.1652949244809;
        Thu, 19 May 2022 01:34:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bce1a000000b003942a244f3fsm6669865wmc.24.2022.05.19.01.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:34:04 -0700 (PDT)
Date:   Thu, 19 May 2022 10:34:01 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com, cohuck@redhat.com, eperezma@redhat.com,
        lulu@redhat.com, xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V5 3/9] virtio: introduce config op to synchronize vring
 callbacks
Message-ID: <20220519083401.ynmjdihi4hnjahlg@sgarzare-redhat>
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220518035951.94220-4-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 18, 2022 at 11:59:45AM +0800, Jason Wang wrote:
>This patch introduces new virtio config op to vring
>callbacks. Transport specific method is required to make sure the
>write before this function is visible to the vring_interrupt() that is
>called after the return of this function. For the transport that
>doesn't provide synchronize_vqs(), use synchornize_rcu() which
>synchronize with IRQ implicitly as a fallback.
>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: "Paul E. McKenney" <paulmck@kernel.org>
>Cc: Marc Zyngier <maz@kernel.org>
>Cc: Halil Pasic <pasic@linux.ibm.com>
>Cc: Cornelia Huck <cohuck@redhat.com>
>Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
>Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
>Cc: linux-s390@vger.kernel.org
>Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

