Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F22DC7618A
	for <linux-s390@archiver.kernel.org>; Mon, 20 Mar 2023 16:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCTQaL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjCTQ34 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Mar 2023 12:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9401AE050
        for <linux-s390@vger.kernel.org>; Mon, 20 Mar 2023 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679329260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4L6DVT+Pk28ITSy1tgi6rl1jBkKGjMU3pOGcr32oZA=;
        b=cvqTojc6kJkiYHeVomteHR6a9Z/GwwXYyeuHfQ78j7TpVxInUjZIPMPQNz0SzsBFQ/Hnn0
        bgXA/m/qgUpeJfsUHq2Jm8b7ON9i5/ujx5ZMst/Z+YYY9XZOvKaA2zuK28yhBC69JzTSjY
        l5kq3F1d6MYIYohHUOxPvO10vgzNiwI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Xec46rceMoGDw5dZo75xLw-1; Mon, 20 Mar 2023 12:20:58 -0400
X-MC-Unique: Xec46rceMoGDw5dZo75xLw-1
Received: by mail-io1-f69.google.com with SMTP id z184-20020a6bc9c1000000b00754a6f609b9so4270570iof.19
        for <linux-s390@vger.kernel.org>; Mon, 20 Mar 2023 09:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4L6DVT+Pk28ITSy1tgi6rl1jBkKGjMU3pOGcr32oZA=;
        b=6+4DL2OiMSkHnDifc86qIzMrhvQriy9Ds1igimxKWu+fP1PmpDyPnvps+JImZ3ozZG
         4A5oYEdudRg+fE0Ef4u3L5qJO3sJHzN2YlefHD48XOTIaSsQMfltObRHrbBUK3yd/95s
         TQ0JQw8pJGQRMBL7fgsv0ZG/bY22MMLw2xmvETttXH9SD9wTY6nRMMrC/Nesd8sMgVNr
         RP0bYxJVplesvS6oU9YY4mzg4xD3NVvW++b+0HyGiO8I1/JsBoixuCXX7bHO6Ku1GzGo
         rCdCqs1zexRNvz7D+izXW135LqZqHxPwO9EjO3pN/hH6qi+2w4wnmwXy7QllurX9p9aZ
         tbww==
X-Gm-Message-State: AO0yUKWEqAAP46xLJblTWlMi4OwVHCDfNkm9Aj4UVRlT7bGOI9AX04dc
        +1THG5ktyu67Yu0lCvdoi5sFfvSLtZ/ma7+Ea/sD15TaHekkZOd4zRbo2BnJZX69MqonbByWbnG
        Rjpt/4fp3yxQJX/NNIi9h7A==
X-Received: by 2002:a6b:5b10:0:b0:74c:c47e:e338 with SMTP id v16-20020a6b5b10000000b0074cc47ee338mr128173ioh.1.1679329258343;
        Mon, 20 Mar 2023 09:20:58 -0700 (PDT)
X-Google-Smtp-Source: AK7set97GHkYl2layDS31jJOAtlRGfxngf7zDEp2X1/Dqkij6Q0vtlnDp1hQ4qhoR9DYj5Ifg0fn+w==
X-Received: by 2002:a6b:5b10:0:b0:74c:c47e:e338 with SMTP id v16-20020a6b5b10000000b0074cc47ee338mr128146ioh.1.1679329258095;
        Mon, 20 Mar 2023 09:20:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 124-20020a021182000000b00404b939d865sm3373857jaf.147.2023.03.20.09.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:20:57 -0700 (PDT)
Date:   Mon, 20 Mar 2023 10:20:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Lizhe <sensor1010@163.com>, wintera@linux.ibm.com,
        wenjia@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net/iucv: Remove redundant driver match function
Message-ID: <20230320102056.1be1fcf7.alex.williamson@redhat.com>
In-Reply-To: <ZBdtn0wFunrkvml9@osiris>
References: <20230319050840.377727-1-sensor1010@163.com>
        <ZBdtn0wFunrkvml9@osiris>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, 19 Mar 2023 21:16:31 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Sun, Mar 19, 2023 at 01:08:40PM +0800, Lizhe wrote:
> > If there is no driver match function, the driver core assumes that each
> > candidate pair (driver, device) matches, see driver_match_device().
> > 
> > Drop the bus's match function that always returned 1 and so
> > implements the same behaviour as when there is no match function  
> ...
> > 
> > Signed-off-by: Lizhe <sensor1010@163.com>
> > ---
> >  net/iucv/iucv.c | 6 ------
> >  1 file changed, 6 deletions(-)  
> ...
> > -static int iucv_bus_match(struct device *dev, struct device_driver *drv)
> > -{
> > -	return 0;  
>         ^^^^^^^^
> 
> If I'm not wrong then 0 != 1.
> 

Seems like an unchecked patch bot, proposed an identical bad patch for
vfio/mdev.  Thanks,

Alex

