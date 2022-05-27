Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D21C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 27 May 2022 10:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbiE0Kgo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 May 2022 06:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiE0Kgn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 May 2022 06:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 001416591
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653647801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2OTG3cehkDKC9XILcBu3L3NTinwiyGs3kvyt5+4+bQ=;
        b=Lc8WEtyBseAqvltFmcxHec+/mK550vwecMrbK//jn1YuozlQrju4/LiS8V7Lc1PG71k44Q
        L60yiRH2l2BbGBZffiBWlaaeWGQLSb2cMkHUBum8B3PzHUk4Lj4DdU/DQWaJHr1RzHDD3I
        E9MjP6xlrBX7N4t7NCrNClWbcQIJ/vQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-3OVizqKXMzeg79P8ub310A-1; Fri, 27 May 2022 06:36:39 -0400
X-MC-Unique: 3OVizqKXMzeg79P8ub310A-1
Received: by mail-qk1-f199.google.com with SMTP id j12-20020ae9c20c000000b0069e8ac6b244so3567902qkg.1
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2OTG3cehkDKC9XILcBu3L3NTinwiyGs3kvyt5+4+bQ=;
        b=4AS3SvDqU4fR2nHnWInlV1fBmXfFFVOz6Ai6nEE4+yFWyXE3S7kfWQu2GtiLvH3g8z
         GzGeOGsCjHDcdCfg4XEIETyMAKqBy21IPsvtzqO/Vmn0imIUbaOM1+bdewVsiAgmofD3
         OQunq90yHz2n1id2tuLKcJILXQ4XvaOMF3Krd6Yi/n6YcqXduEzydBSmHyFsXUt/x2Rz
         vtQAj8JqvqaFNFHJ04w8kTlZdpozKaz7twqJuOIw8Pcf7+nxU6KmjgphOgTZp1ILVxJd
         wshF3aTEBHDuScxpUBb96ueTytDN9XD8R0lvlkNG1MAtOjPOOkR8NBtIQyoIe+Y2g1U6
         fS9g==
X-Gm-Message-State: AOAM532YwBYbyrPxtWbIVQxNTtZIKrkdjYftVfo0WxKWw7o9WGlD5+5M
        +qCg9Z4Tprytd0k2RUTiFMDgJzh86jMYDycW/jF/MC+gmu7EJ2qza8+XmGigCAxpQPO3whlyD3t
        9dXajkXoLhO6dngw9pLAVuA==
X-Received: by 2002:a05:622a:293:b0:2f9:3ab6:a462 with SMTP id z19-20020a05622a029300b002f93ab6a462mr18387271qtw.546.1653647799265;
        Fri, 27 May 2022 03:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCj+m03onZL8ESQWhknID+ES7qStMFrkjNlklugGOQyZkMOqq0rGwzKUL4uYoaC7qHSvuTtQ==
X-Received: by 2002:a05:622a:293:b0:2f9:3ab6:a462 with SMTP id z19-20020a05622a029300b002f93ab6a462mr18387263qtw.546.1653647799063;
        Fri, 27 May 2022 03:36:39 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id m184-20020a37bcc1000000b006a323e60e29sm2557931qkf.135.2022.05.27.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:36:38 -0700 (PDT)
Date:   Fri, 27 May 2022 12:36:32 +0200
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
Subject: Re: [PATCH V6 3/9] virtio: introduce config op to synchronize vring
 callbacks
Message-ID: <20220527103632.ujsefjwkddoaoxwi@sgarzare-redhat>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220527060120.20964-4-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 27, 2022 at 02:01:14PM +0800, Jason Wang wrote:
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

