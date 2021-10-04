Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648C6C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC17611C0
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 15:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhJDPHS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233853AbhJDPHR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 11:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633359925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKqfFNCEMivwB08FbXWvEqkCe6mHCvfbmubuJ0I97xQ=;
        b=PA5NJefekyfUmlATpzBM6lh9B9YY6GEpuBaxgEeQJOap2dYBJuGm3lpY7PkCgpcsZGiEoP
        22C/AYTGHrpfO+6VKXQlf6bWO4Xk9l5MaKibZigJ+drU7I2l8X0Q+EK+uBXaGEPXZsh4nd
        a+bqyWjq0BpFZ7nxH5eEPlQWPp/cyUM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-JJvzXx75NtGhXr3uUf740Q-1; Mon, 04 Oct 2021 11:05:24 -0400
X-MC-Unique: JJvzXx75NtGhXr3uUf740Q-1
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso17421724edj.20
        for <linux-s390@vger.kernel.org>; Mon, 04 Oct 2021 08:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKqfFNCEMivwB08FbXWvEqkCe6mHCvfbmubuJ0I97xQ=;
        b=04u1tcn5kWTM02VozdvFzvRIQ7ETVXNhrbv6nuH2M3c4qW9DilnktZi+MzR2YdjgqA
         57wjSeLyEet5+PHtxk2pSz0nUwT0HCOd4Jywu0bk9H43+l8RLcqFh0riHrmzTnflwrDH
         rAqImYDKK/1VNnFuAskHrO9VbTdkXJx7kN4Vaw1RqkC4jWSnPC2BD2NMGKAiJ71GVL1I
         gf+cp28tDr5u4i/Y3+cBjMckIAzwAVNxk2r6cCD7qAw7u8h9hSqKFHr5WrY4jII7tlUG
         2/6bBVCIFXh0XWglKMamW+WSJ364Z3uxdG5FkrLMwxTGkLQD2nMSfdOv6kowQNzYCR0T
         smXw==
X-Gm-Message-State: AOAM533oxiNAopS4LfsVJnQwuBMuFySuYAR84wvB1B+iI6bZSF4/fJJW
        IP3nT8uhVJlwlxTSbdhCohvzAoyK7MwCzmho95DM6KQ5WQRlb6TlF5pI6uJSlMdvS7Chpa472xN
        g6QmiIKN7JCruFkgBRGDOFQ==
X-Received: by 2002:aa7:c418:: with SMTP id j24mr2864613edq.227.1633359923359;
        Mon, 04 Oct 2021 08:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU9JadIuhF6Ys560lNNF+Op6UHEczKovjv7KBzOJz0VaWG0AO+P6FEUJqR3gX5bD8rYhffhA==
X-Received: by 2002:aa7:c418:: with SMTP id j24mr2864584edq.227.1633359923175;
        Mon, 04 Oct 2021 08:05:23 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
        by smtp.gmail.com with ESMTPSA id x13sm6473465ejv.64.2021.10.04.08.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:05:22 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:05:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004110152-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rz83lx0.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
> >> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
> >> >  Specification text within these sections generally does not apply
> >> >  to non-transitional devices.
> >> >  
> >> > +\begin{note}
> >> > +The device offers different features when used through
> >> > +the legacy interface and when operated in accordance with this
> >> > +specification.
> >> > +\end{note}
> >> > +
> >> > +Transitional drivers MUST use Devices only through the legacy interface
> >> 
> >> s/Devices only through the legacy interface/devices through the legacy
> >> interface only/
> >> 
> >> ?
> >
> > Both versions are actually confused, since how do you
> > find out that device does not offer VIRTIO_F_VERSION_1?
> >
> > I think what this should really say is
> >
> > Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
> > the legacy interface.
> 
> Ok, that makes sense.
> 
> Would it make sense that transitional drivers MUST accept VERSION_1
> through the non-legacy interface? Or is that redundant?

We already have:

A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.


> >
> >
> > Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
> > through the legacy interface if offered?
> 
> I think that the Linux drivers will not operate on feature bit 32+ if
> they are in legacy mode?


Well ... with PCI there's no *way* for host to set bit 32 through
legacy. But it might be possible with MMIO/CCW. Can you tell me
what happens then?


> >> 
> >> Generally, looks good to me.
> >
> > Do we want to also add explanation that features can be
> > changed until FEATURES_OK?
> 
> I always considered that to be implict, as feature negotiation is not
> over until we have FEATURES_OK. Not sure whether we need an extra note.

Well Halil here says once you set a feature bit you can't clear it.
So maybe not ...

-- 
MST

