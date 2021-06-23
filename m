Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A0C2B9F4
	for <linux-s390@archiver.kernel.org>; Wed, 23 Jun 2021 01:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B9661361
	for <linux-s390@archiver.kernel.org>; Wed, 23 Jun 2021 01:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFWBXh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Jun 2021 21:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229769AbhFWBXh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Jun 2021 21:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624411280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WZjidwpALD0+6okLjRpzpQCZxBF9g0JCe+CU6OJZxo=;
        b=cZHnSC89gbIAWWcRT9UJhnH41wDlBldJwiBRVp2bpErPQXDJFv/TzXDuTGgGfI7dD+tilt
        CehZBb/iOjBosGe6umczxrlVrwVBqftwJUUu4kPMvXT+oiPHaR+Y0Fn6fQfQVdgA2VMvk9
        1qRvE084CPFlTxBPiIhF1VdjhhNO8wE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-GjDaArltPteixoQwMTb7TA-1; Tue, 22 Jun 2021 21:21:18 -0400
X-MC-Unique: GjDaArltPteixoQwMTb7TA-1
Received: by mail-ot1-f69.google.com with SMTP id z17-20020a9d46910000b02903fb81caa138so207111ote.18
        for <linux-s390@vger.kernel.org>; Tue, 22 Jun 2021 18:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=6WZjidwpALD0+6okLjRpzpQCZxBF9g0JCe+CU6OJZxo=;
        b=Qv16n8hC2IMbI15aZMamNWxiu0IuolsFrOlCYwjNvGHgYEk2WMe31P8znHugiuujQk
         BWcgaE8SGef4OyTGl96uwegTSSkVlwqbKlOD6jRVay6BTZzHwLXKAItgz3Xp7PvBK8Xw
         N8u9NZUGMnOq85AWfSeBxAxwvVKg2qM4bhJeVgmpHG9vo2RjcyXCvpdktzcBDn/4155w
         mPzCMz1KR1ouYeoT+Pi47nCIwE9lGWSOD5C41pT7n9jYwm7DxPcFdMu/JPFZK4uThnO/
         t9hTwUdOubkRxfzrq525+KC3mimWCgYcuoo0P5gfZCTtUlP/aAU6WK8SXQ0vArPa/RfO
         FjgA==
X-Gm-Message-State: AOAM533V6g2sbq+4oYQNhxZTAyNTkpAAdlq1IZ0mdG29k1DDaBWU7KjB
        FfzXklX7jNoBpABe6ckT+QKSB0tcLK9zjlUgTUn1ta43MpnDgSTE3ueI9luWm/CIXEHE+Few3wh
        5hv1QQF0GQ2gvMuOd3W/kGQ==
X-Received: by 2002:a9d:c04:: with SMTP id 4mr5426572otr.245.1624411278072;
        Tue, 22 Jun 2021 18:21:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIMydhH4YIk5UlsJLWeyye09J8NdqydLo549hleKoU/i5XuOd4xS2Z30zIrGFONsoACRmAyw==
X-Received: by 2002:a9d:c04:: with SMTP id 4mr5426545otr.245.1624411277887;
        Tue, 22 Jun 2021 18:21:17 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id q18sm239916otf.72.2021.06.22.18.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 18:21:17 -0700 (PDT)
Date:   Tue, 22 Jun 2021 19:21:15 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: Allow mdev drivers to directly create the vfio_device (v4)
Message-ID: <20210622192115.71e7e333.alex.williamson@redhat.com>
In-Reply-To: <20210623000550.GI2371267@nvidia.com>
References: <20210617142218.1877096-1-hch@lst.de>
        <20210623000550.GI2371267@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 22 Jun 2021 21:05:50 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jun 17, 2021 at 04:22:08PM +0200, Christoph Hellwig wrote:
> > This is my alternative take on this series from Jason:
> > 
> > https://lore.kernel.org/dri-devel/87czsszi9i.fsf@redhat.com/T/
> > 
> > The mdev/vfio parts are exactly the same, but this solves the driver core
> > changes for the direct probing without the in/out flag that Greg hated,
> > which cause a little more work, but probably make the result better.  
> 
> I did some testing and it looks good, thanks
> 
> I see Alex has this in hch-mdev-direct-v4 in linux-next now, so
> expecting this to be in the next merge window?

Yeah, sorry I didn't send out an "applied" note, end of the day
yesterday and forgot today.  My bad.  I expect this to go into v5.14
given the acks and Greg's deferral for the driver-core changes to go
through the vfio tree.  Speak now, or... Thanks,

Alex

