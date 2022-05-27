Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A88C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 27 May 2022 10:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiE0Kfn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 May 2022 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243748AbiE0Kfm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 May 2022 06:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5374312AB0B
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 03:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653647740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/zrleRNQCe5coayR0kaH9WedW9Vs8BA6BoXc0zZ1wCI=;
        b=goBpEklEUPgII/COdGR5f7xux0iu1LGspXRXSJHAN9eQIz7boP41tP84DMYGPBiB1zPh/V
        KDyyGyT5+EOnewtQr6HSyK7FfoUl7AFXBA0HDXRrhrKeAqPjpRiMz3+bShOFfkHFxVv2Uc
        vDgnpPbBdj/vxbLKSwk0tfMlW7GtS8I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-pKyV3zPUPQi5un2FzXUbtA-1; Fri, 27 May 2022 06:35:37 -0400
X-MC-Unique: pKyV3zPUPQi5un2FzXUbtA-1
Received: by mail-qv1-f69.google.com with SMTP id j2-20020a0cfd42000000b0045ad9cba5deso3155656qvs.5
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 03:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/zrleRNQCe5coayR0kaH9WedW9Vs8BA6BoXc0zZ1wCI=;
        b=37vSCkCYz6nOo8mpJNC8IFMn1sGnQfNfqH9dquTm++n43WPAUcBl7DZ6/+qcnaDoJr
         8xIGI1wJpLGHLUEhnUyS6N9yMpvl769/9TsFIK/K0OnocILx3ngIfXO38Ur8nRGrvAg7
         JzBvMYvZWH4/UN0pz+hlE2hJCDYAHFsL2qouCiyK/4buMyqX93YFrP/maNEGhjDppfVg
         BtdO5+l/MQlLUnYedVrxi7y1arbJRrXDq2tb0lsdx/Dcquw8iQM2KkfWPXNWWDgfRArP
         yT38P8OyVku1FCugyXKSE8hLwBnt3xQv3rlTVn55vp02EQMXELXgPjx8oIoh/jACwdc3
         5P0A==
X-Gm-Message-State: AOAM531MZe4iVfYh9Nq/hwOptpT0bE86ex6umRTW4JOvlror3Ld+SiFY
        j6h5/OJRiSoTgkewdsbpkSgoM7WqBNltBCOHto6Z0dN8DqBgsRh5Rf5Ae/hCB3q10FmGKy/LUW8
        ys4OTsjJnfyarnBHbw78+HQ==
X-Received: by 2002:a05:622a:178f:b0:2f3:dd2e:6054 with SMTP id s15-20020a05622a178f00b002f3dd2e6054mr32734463qtk.554.1653647736331;
        Fri, 27 May 2022 03:35:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/DdJ7C1pNGSuqERmPyGufmFDtkXuN7ZZ9wXEOlVJRq4YbuWRCxS9DqSNdvMaM0Tg+oETAlQ==
X-Received: by 2002:a05:622a:178f:b0:2f3:dd2e:6054 with SMTP id s15-20020a05622a178f00b002f3dd2e6054mr32734439qtk.554.1653647736086;
        Fri, 27 May 2022 03:35:36 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id c142-20020ae9ed94000000b006a33fc1113csm2498024qkg.23.2022.05.27.03.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:35:35 -0700 (PDT)
Date:   Fri, 27 May 2022 12:35:29 +0200
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
Subject: Re: [PATCH V6 9/9] virtio: use WARN_ON() to warning illegal status
 value
Message-ID: <20220527103529.kc6tpon3lohceskm@sgarzare-redhat>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-10-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220527060120.20964-10-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 27, 2022 at 02:01:20PM +0800, Jason Wang wrote:
>We used to use BUG_ON() in virtio_device_ready() to detect illegal
>status value, this seems sub-optimal since the value is under the
>control of the device. Switch to use WARN_ON() instead.
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
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> include/linux/virtio_config.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

