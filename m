Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218AFC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 19 May 2022 08:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiESIcY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 May 2022 04:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiESIcX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 May 2022 04:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EB0272224
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652949142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4zGkqLBS/TAgxZK9Jmx8vQw2RK+jMADwG0s4JnBJWNc=;
        b=EVFHclpekAS9EFXvigYeklIOBIBrAmUdLlz81UtHJlV94aDWJuuwsXoXh+QZPBam3iZ0xM
        QObl5CNnN06Zqbb8MNEMoSJIXmveGOLQ1Rgq9Atd4Ge45TYox+UMNVeLnXumW23L2sAGIE
        Rg0sTKcVI4XkBbBSbqmWr3EVm6f0Efk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-H8vEEsf5MaaVsT7H15FnIw-1; Thu, 19 May 2022 04:32:20 -0400
X-MC-Unique: H8vEEsf5MaaVsT7H15FnIw-1
Received: by mail-wm1-f72.google.com with SMTP id k35-20020a05600c1ca300b003946a9764baso4206729wms.1
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zGkqLBS/TAgxZK9Jmx8vQw2RK+jMADwG0s4JnBJWNc=;
        b=MmQCTOKDGztr22E4p10tYByy9GLz14kuRXg7B+MP06LZ+mELoL+bKUq9T1DI6SrEmm
         x9YRjUEZJyRPswivGY2QC7IfTwfq0pv7XzhtO+eB+qgLR8wC0bfX4dbF+UTi/8kFQ4x2
         0Trw6LXfvO07el6KPGuk4d9a4zSvBdBvqcU9rxekAgJs1mU4mLR7oEblURtsA2euua66
         YEb0h8mbOAAMCAy7MA8wZzFjwiiIb4GIDIJ88LnYiXutqmcl1sJu6o3uezXPSCDnyAcA
         gVkWb8IbIQB9JGR16tusUUzVQtp0e+66S0AChDEDkiFSDvIhh1Z+Hut9BsNGZuWORM2m
         qjwQ==
X-Gm-Message-State: AOAM532wbBUxUaIQVDXcdisvjYbereYI95NCcd7b1Gk9sTJugJSvs98K
        6hKrBnhrhl7qQXce6BWvcZuM48ihPHAHEd4seGdei52P+e6IPhvMRQDrDS4l5S6iBtnxvzxqlHR
        zlZayLUqaFuI5dr3/PB+ImQ==
X-Received: by 2002:a05:6000:2c2:b0:20c:c6e1:e881 with SMTP id o2-20020a05600002c200b0020cc6e1e881mr2965132wry.333.1652949139809;
        Thu, 19 May 2022 01:32:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyio4JEWQmgkioPkbNgTt2e70V8qT0vr7F8BBMxVMH/FsBBAQUG715vLlB3cyn0DlqD+bNL7Q==
X-Received: by 2002:a05:6000:2c2:b0:20c:c6e1:e881 with SMTP id o2-20020a05600002c200b0020cc6e1e881mr2965117wry.333.1652949139611;
        Thu, 19 May 2022 01:32:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id l6-20020adfa386000000b0020cfed0bb7fsm4441801wrb.53.2022.05.19.01.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:32:18 -0700 (PDT)
Date:   Thu, 19 May 2022 10:32:13 +0200
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
Subject: Re: [PATCH V5 2/9] virtio: use virtio_reset_device() when possible
Message-ID: <20220519083213.jwzr272vvkh6ogq4@sgarzare-redhat>
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220518035951.94220-3-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 18, 2022 at 11:59:44AM +0800, Jason Wang wrote:
>This allows us to do common extension without duplicating code.
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
> drivers/virtio/virtio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

