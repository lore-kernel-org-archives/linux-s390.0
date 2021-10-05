Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC5C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B3A60F93
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhJELNa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 07:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234128AbhJELNa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 07:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633432299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeArBAcS9Q84SLX+oAxukLYME3k/d29Rm/s+++jGKPE=;
        b=ZcCuFqMVf7URhd8RcB7JNygzxhK70C+piChv456ImybACHPAUOrnnsuILbVvNeBBBjiugQ
        xcJTb33i7KpJZ5yza+lC6tWfyICx9Yiabvg2JH+b76RI8LX4mzT8C0zXYrYKfmzP+8er2q
        0MGLSwos/0eof98r/50QdY3QUzq10fw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-37yN3EZNNnWR6gScwNZVEw-1; Tue, 05 Oct 2021 07:11:38 -0400
X-MC-Unique: 37yN3EZNNnWR6gScwNZVEw-1
Received: by mail-ed1-f69.google.com with SMTP id x5-20020a50f185000000b003db0f796903so2091501edl.18
        for <linux-s390@vger.kernel.org>; Tue, 05 Oct 2021 04:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eeArBAcS9Q84SLX+oAxukLYME3k/d29Rm/s+++jGKPE=;
        b=a/raAPhYTRSM56Lc1x1ejdkX74u1baSB9aZ+IxQBwffG4Ubryn3X10jfCoGcr6IlDP
         5ISkc1GvuTH7kXLQo5FArJDgc0jR1cU9br2HOQZjZR1tvczuCPLpmEk+nqPqlq+L6KZ0
         1CQLIxBKQ6eKIvMVu+qWJv4ccG7QyfhIxtNH3KpPjp3+GreonV0z0j235QEgH67cnWXR
         rLrbGnprjP1YkVrBHqUuLjb4Jx3ZMtlWXBzOp3LU5Ec8jCbpdrj4KAxcyP5ETAuuneJB
         vpF/gZgXW6n1dTXKLuKxu5UpJhwxDD2wbxhB1OWj3IyUm4o0r04g4D5KaTf2AWgHHNeN
         5jHw==
X-Gm-Message-State: AOAM532mejh/teS9M8rMKXd8ft27lFGVanb5b8eiiIIBSZEWVaeW6+3X
        LoOkwNndF+uXAFT0IibieruOMNb3Tj5mNgyywD9XEM4OpK3x0CepZs7CfQlR1kTgB0FY2yCuQT9
        U8bvn39F7HIeLEamVKAtBmA==
X-Received: by 2002:a17:906:81da:: with SMTP id e26mr23837028ejx.296.1633432297527;
        Tue, 05 Oct 2021 04:11:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcsiNXEPQdBdUK3S2sCQgXB8aTeyms7C9ktkEXECdOiZs9AxXkmtcIiymlmiwW6qydZSPVfw==
X-Received: by 2002:a17:906:81da:: with SMTP id e26mr23837003ejx.296.1633432297372;
        Tue, 05 Oct 2021 04:11:37 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id q6sm7451568ejm.106.2021.10.05.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 04:11:36 -0700 (PDT)
Date:   Tue, 5 Oct 2021 07:11:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005071128-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <20211005092539.145c9cc4.pasic@linux.ibm.com>
 <20211005035014-mutt-send-email-mst@kernel.org>
 <20211005124634.2a774796.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005124634.2a774796.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 05, 2021 at 12:46:34PM +0200, Halil Pasic wrote:
> On Tue, 5 Oct 2021 03:53:17 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > Wouldn't a call from transport code into virtio core
> > > be more handy? What I have in mind is stuff like vhost-user and vdpa. My
> > > understanding is, that for vhost setups where the config is outside qemu,
> > > we probably need a new  command that tells the vhost backend what
> > > endiannes to use for config. I don't think we can use
> > > VHOST_USER_SET_VRING_ENDIAN because  that one is on a virtqueue basis
> > > according to the doc. So for vhost-user and similar we would fire that
> > > command and probably also set the filed, while for devices for which
> > > control plane is handled by QEMU we would just set the field.
> > > 
> > > Does that sound about right?  
> > 
> > I'm fine either way, but when would you invoke this?
> > With my idea backends can check the field when get_config
> > is invoked.
> > 
> > As for using this in VHOST, can we maybe re-use SET_FEATURES?
> > 
> > Kind of hacky but nice in that it will actually make existing backends
> > work...
> 
> Basically the equivalent of this patch, just on the vhost interface,
> right? Could work I have to look into it :)

yep

