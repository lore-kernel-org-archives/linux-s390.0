Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973A4C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F2C615E6
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhJELWX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 07:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234333AbhJELWW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 07:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633432831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8DxNvJPCW0wWRkzK7is2TKN8eqfqYzj6jjWzgoTSkB0=;
        b=O3J0BYrh/6MyaVfuUIqwey05Wno9o4wV0wIYo5hPl+Dg7K8+IoUWXk+oz71QwbFYYmMYZg
        JWgDGlkU60YzTP7uFwK9xiLYYsIc4wtgk8vRUKRL9uAQyfqx4HJoXnX2R8Tdpymo+qrDEH
        yTJW/mJv9z/eX6w4y7JScjJ1SWg4mWc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-eb_Dh-YPO3GLtKvPW1krmg-1; Tue, 05 Oct 2021 07:20:27 -0400
X-MC-Unique: eb_Dh-YPO3GLtKvPW1krmg-1
Received: by mail-ed1-f72.google.com with SMTP id 2-20020a508e02000000b003d871759f5dso20294325edw.10
        for <linux-s390@vger.kernel.org>; Tue, 05 Oct 2021 04:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8DxNvJPCW0wWRkzK7is2TKN8eqfqYzj6jjWzgoTSkB0=;
        b=tSUoAJ/Ecg3nubzvjGBXDcz3dRCttpSnKyhGo4Yj7qSPRb4AkGnDpN7wPEbtICXJ1d
         FxdhDRPfGRMcAmdpy2F6KwF77eYa/Iwe8Qjr1hJigWyipspRWDmWDlg+r9uWH9zzKGUV
         X7ABZ+OGwbi2/rD7jhblcFfbZoxhWGkKBzsg5XPwDdOumL9thmz6WBN8C1mEYDzKbCwv
         zigDLY5YSrtiRVS3bKc5+7hSpRj0nuKFFGrB08dsi1ybMIqs6c9eBx8p3jnP+vStYzvh
         3WT16APtqvyCS5Ha+1JeOlCcHL2234gD6QlCZMo46uTA9QqOzuX6UioLfoEDtcxAHSNz
         VJMg==
X-Gm-Message-State: AOAM531wwgwhWUQA+k65E9Ydgnr28ZU6CDER4NFtfCSZiNqnKmr34vpk
        i9d55pk6QkP1kGTtLyzbudFXKzkbAL2fgOsHGZ0RIRKde0UGtu/yrLWD6vIAGK6Qp8HUq1h2Gma
        Ls03nYM/dlPqaFJ62MPPTGg==
X-Received: by 2002:a17:906:3a0a:: with SMTP id z10mr12655452eje.111.1633432825628;
        Tue, 05 Oct 2021 04:20:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX7CkJhv+B6EpESQjJAlERsSi/L6SFxie1MuYGz7XrNTrZeHjtBwjO3hp8O2z35qxUHeEJOQ==
X-Received: by 2002:a17:906:3a0a:: with SMTP id z10mr12655428eje.111.1633432825464;
        Tue, 05 Oct 2021 04:20:25 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id b2sm8650876edv.73.2021.10.05.04.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 04:20:24 -0700 (PDT)
Date:   Tue, 5 Oct 2021 07:20:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        markver@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005072006-mutt-send-email-mst@kernel.org>
References: <87r1d64dl4.fsf@redhat.com>
 <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com>
 <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
 <20211004040937-mutt-send-email-mst@kernel.org>
 <20211005124303.3abf848b.pasic@linux.ibm.com>
 <87lf372084.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf372084.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 05, 2021 at 01:13:31PM +0200, Cornelia Huck wrote:
> On Tue, Oct 05 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 4 Oct 2021 05:07:13 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> Well we established that we can know. Here's an alternative explanation:
> >
> >
> > I thin we established how this should be in the future, where a transport
> > specific mechanism is used to decide are we operating in legacy mode or
> > in modern mode. But with the current QEMU reality, I don't think so.
> > Namely currently the switch native-endian config -> little endian config
> > happens when the VERSION_1 is negotiated, which may happen whenever
> > the VERSION_1 bit is changed, or only when FEATURES_OK is set
> > (vhost-user).
> >
> > This is consistent with device should detect a legacy driver by checking
> > for VERSION_1, which is what the spec currently says.
> >
> > So for transitional we start out with native-endian config. For modern
> > only the config is always LE.
> >
> > The guest can distinguish between a legacy only device and a modern
> > capable device after the revision negotiation. A legacy device would
> > reject the CCW.
> >
> > But both a transitional device and a modern only device would accept
> > a revision > 0. So the guest does not know for ccw.
> 
> Well, for pci I think the driver knows that it is using either legacy or
> modern, no?
> 
> And for ccw, the driver knows at that point in time which revision it
> negotiated, so it should know that a revision > 0 will use LE (and the
> device will obviously know that as well.)
> 
> Or am I misunderstanding what you're getting at?

Exactly what I'm saying.

