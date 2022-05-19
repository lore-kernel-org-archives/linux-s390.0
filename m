Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C77C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 19 May 2022 08:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiESIet (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 May 2022 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiESIes (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 May 2022 04:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2C4C74DC3
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652949287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RXQa/is57ndmeB4UOc268UZ9oUyQAZpGNBvHCtt4ZMQ=;
        b=XYEX3fcWt/be2EZlP1kdRbN/3G23998sXwwW8lUKYfyyGJe5+IAhW4OaC7YjVcwfPydArQ
        Bx4hsyB1CbS51dNiodDTaMuIajCbgt9t74+sei+iMQZ/LPWRA9qceFMRzO7B0uMKlAIx7C
        rVEPlqT+Qxf22LTq8oXVasr+MlpDIFE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-cK58pTgFOiuUk_ed5RICUA-1; Thu, 19 May 2022 04:34:45 -0400
X-MC-Unique: cK58pTgFOiuUk_ed5RICUA-1
Received: by mail-wr1-f69.google.com with SMTP id d7-20020adfef87000000b0020e621f932aso1231946wro.18
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RXQa/is57ndmeB4UOc268UZ9oUyQAZpGNBvHCtt4ZMQ=;
        b=mXUtpGmPDX27IcSE72vOjx8TtOHZSEgdx49+XIttHkkeZyZN+/M/6TRZHrOVEMSgAx
         AzpJSI9h8kNkoFAgymlZthrUQ5WMAr9L7NfiIMAYDgb2mrHy9bpCaGLnvPfpw3u+ZP8E
         v7lwVHe4Wpss8495Td9bfc9gkxisxsVHg1HMumOhDGLqlfn4TVF6DGEiymv9Ji/hp9mI
         Al8krwyWEUpIZYt3p+ze1DpgTC4JLgMf310+Q+zLwNJwPXi+XouWT3GlrORk+ShejiNa
         CaNhC5WWJ7thC+Ukc6ynAigp7pP7/YbySI/n7PWi0oVpRs7RTMYL7PEeaNcwZoxUPqTh
         TIDw==
X-Gm-Message-State: AOAM5310M+fJWvK0UwT4bMO++wGoht/4eo/cUhHw0V/4Na0cJHAt+vNN
        rwqjs1FgdlPiyhuVgxwJSDc6O6zbtOvtY5kTJnZuxXwTngiq4if0IniCdEyZGaoece+2gVy+AbY
        u3fyyKvokRnB89VDN5NaOwQ==
X-Received: by 2002:a05:600c:4f03:b0:394:6499:21c7 with SMTP id l3-20020a05600c4f0300b00394649921c7mr2708647wmq.103.1652949284635;
        Thu, 19 May 2022 01:34:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAkq9/tyayvfVCMywTQMNAHfHo8x/Yw3YYtWkfOqMxHBW6hbphrtHFbnw12lWB4vdPFEW1PA==
X-Received: by 2002:a05:600c:4f03:b0:394:6499:21c7 with SMTP id l3-20020a05600c4f0300b00394649921c7mr2708636wmq.103.1652949284410;
        Thu, 19 May 2022 01:34:44 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id n4-20020a1c2704000000b003942a244f3asm6212873wmn.19.2022.05.19.01.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:34:43 -0700 (PDT)
Date:   Thu, 19 May 2022 10:34:40 +0200
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
Subject: Re: [PATCH V5 9/9] virtio: use WARN_ON() to warn illegal status value
Message-ID: <20220519083440.luyv6lzcq3fiw27e@sgarzare-redhat>
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-10-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220518035951.94220-10-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 18, 2022 at 11:59:51AM +0800, Jason Wang wrote:
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

