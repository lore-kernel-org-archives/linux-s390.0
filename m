Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FB3C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 27 May 2022 10:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348618AbiE0Keu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 May 2022 06:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240583AbiE0Keu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 May 2022 06:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF153106340
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653647687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J1xQ8OiQHH9ksLcm4a9s84IyD29bInrw0vUd6yz8xCk=;
        b=AWRryVfY6HJn6AMJFvSSwvNFE/3shn7k4GiIQLhBwuik2v0QTUNHEe+TQXFTo229LAUYfD
        iq4IXDPUSQ4k7yTnhAFXfEOv4k65EkwIQFEijIJ+qBlg3muI1ZBO7vc9an+i0ajxsvvgDy
        iKPTJudh/VzGG2nkAdjXVdwUQHhqBk8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-pivH1Yb6PQySf0e_ACSjlw-1; Fri, 27 May 2022 06:34:45 -0400
X-MC-Unique: pivH1Yb6PQySf0e_ACSjlw-1
Received: by mail-qv1-f69.google.com with SMTP id dy10-20020ad44e8a000000b004625c7238edso3192334qvb.0
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 03:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1xQ8OiQHH9ksLcm4a9s84IyD29bInrw0vUd6yz8xCk=;
        b=JOig7VEW+gBUsZMOUcJrNvsGfxnRfVA5O59cMcEY7vF1IMv3a/WZLbaSVoHdQTHzuG
         fxjF3B+mjYhi0oLZS0H13NqMGB4fOEEGAy/cFzMVJ9HYdtyXHZr7dgt73q25MhPxD85o
         HRdo7eHeAvXppNVG/UXULnn1IZn2DG275uKn5jlBTIJG7dhH8I+50f9qlxvnqHVgJV2L
         prShxtiuCS+HoxTxHlIw0N3DRKDrXBcLzP0gtrkM+iYtfnyoQtFr+XWyyMfdF+xOBKtz
         JFDdjIe6Rs/QIyb528sZvwSVWvXOCx2UHP1MOWKQ0LqNPA+Ypirsf7PzudczBTUcEsyT
         9E9A==
X-Gm-Message-State: AOAM531dNy3gES5B3+zLzZ45sBIcpMOzTxEBVHw3fxz+HzVER7y0+xDb
        6uSaaDiI0YcOG6+idUH4KX9FGyuU9uje6MTCmT/OHKdhJT6J6EjCLrgNO95/KOQjPOXdSmQBGwS
        pSnnDHXrzb6Jhql+cRhb9Jw==
X-Received: by 2002:a05:620a:4042:b0:6a5:aded:fe52 with SMTP id i2-20020a05620a404200b006a5adedfe52mr5591548qko.365.1653647685388;
        Fri, 27 May 2022 03:34:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqxv+VTwgq+LPdZICQyGqh24jAfcU1fwHBx1WzLpbtJcUIqfLL3McbVD+9ZVGHmS3yYq9xJg==
X-Received: by 2002:a05:620a:4042:b0:6a5:aded:fe52 with SMTP id i2-20020a05620a404200b006a5adedfe52mr5591538qko.365.1653647685166;
        Fri, 27 May 2022 03:34:45 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it. [87.12.25.16])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a401300b006a10c8d5d96sm2802962qko.3.2022.05.27.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:34:44 -0700 (PDT)
Date:   Fri, 27 May 2022 12:34:36 +0200
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
Subject: Re: [PATCH V6 2/9] virtio: use virtio_reset_device() when possible
Message-ID: <20220527103436.erqkgeh34prlvssh@sgarzare-redhat>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220527060120.20964-3-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 27, 2022 at 02:01:13PM +0800, Jason Wang wrote:
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

Maybe I had already reviewed it :-), anyway:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

