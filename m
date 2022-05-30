Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB471C433FE
	for <linux-s390@archiver.kernel.org>; Mon, 30 May 2022 15:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbiE3Puj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 May 2022 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242896AbiE3Pu1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 May 2022 11:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 926026F499
        for <linux-s390@vger.kernel.org>; Mon, 30 May 2022 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653923753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12VfNwWXDrykTTd5k3EIeimf5dPLnKOI2VkXPTFFsm4=;
        b=NLdxSapqu10LOm40U1RAfC8n30CW8EOHhe0wQK6q3DmiAmdWRXYr4JhEOxtfNsABuGUr3a
        /Y1s7cgAQcyhXsK5EGnV+ns6/V0L/saP+/gPWHlj5HPE2EhY19rZi4P/Kh5JYYn26hF+bW
        ZmIuvQXVkeRUPCD1Le6Zi1jB4UMqV6Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279--p11x1JpOUyGCym6hs50Cw-1; Mon, 30 May 2022 11:15:50 -0400
X-MC-Unique: -p11x1JpOUyGCym6hs50Cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 266B0811E80;
        Mon, 30 May 2022 15:15:50 +0000 (UTC)
Received: from localhost (unknown [10.39.194.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C428F40CF8EE;
        Mon, 30 May 2022 15:15:49 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V6 7/9] virtio: allow to unbreak virtqueue
In-Reply-To: <20220527060120.20964-8-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-8-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 30 May 2022 17:15:48 +0200
Message-ID: <87v8tnt5jv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 27 2022, Jason Wang <jasowang@redhat.com> wrote:

> This patch allows the new introduced __virtio_break_device() to
> unbreak the virtqueue.
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
>  drivers/virtio/virtio_ring.c | 22 ++++++++++++++++++++++
>  include/linux/virtio.h       |  1 +
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 9d0bae4293be..9c231e1fded7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2395,6 +2395,28 @@ void virtio_break_device(struct virtio_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(virtio_break_device);
>  
> +/*
> + * This should allow the device to be used by the driver. You may
> + * need to grab appropriate locks to flush the write to
> + * vq->broken. This should only be used in some specific case e.g
> + * (probing and restoring). This function should only be called by the

Minor: "...some specific cases, e.g. probing and restoring."

But no need to respin from my side.

> + * core, not directly by the driver.
> + */

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

