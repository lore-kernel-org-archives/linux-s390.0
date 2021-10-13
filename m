Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A78C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 12:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006E860527
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 12:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhJMMtK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231644AbhJMMtJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Oct 2021 08:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634129226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wp+/d0F+qzlGdrrSoGXSKcXwbRm7uRB50CWJ1pV00sA=;
        b=QTfNvJnvYCHpzqE66sRusuz1zu12vlFMJtnztwxJHUwYBkzKknvA73NKrPHeLAR6PxCJTg
        2fxmvvWIR5fhtgBlTzAE95BoM6uDoBfkrPptCOyftCexUSTcji9m2zSfP/5ina8dZ921fx
        r/UCLKppOJOSg2SEdosYUbsOHpEX+W0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-oHizhZmNPCG8J7VR-DmWyg-1; Wed, 13 Oct 2021 08:47:05 -0400
X-MC-Unique: oHizhZmNPCG8J7VR-DmWyg-1
Received: by mail-wr1-f69.google.com with SMTP id r16-20020adfb1d0000000b00160bf8972ceso1871713wra.13
        for <linux-s390@vger.kernel.org>; Wed, 13 Oct 2021 05:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wp+/d0F+qzlGdrrSoGXSKcXwbRm7uRB50CWJ1pV00sA=;
        b=CrXWlZfxKKi65MzQqquhH8agReNlrlLZKv7Et1U8sk9Z65Dp2TH8nVudOn57rYDUlq
         bnjmrh7neL2uXsYUR1vzyPev3l74z0R6Iq3Z3y8qSMEIJe8thUAnnakb2Ne/pMXjhPsF
         ayffR6JbXNB1Qc1Q8naYHJgWKzH0URdrLtgYz+e2jCRQscnvhoUpSQlInWTkAUkMu5Ah
         RzZkpYFML/4UaVp7C/5vgh0uBJmAh+Rim6zBSZJNfXydaUq4W54HSot7zU3eKBhRQTp7
         cEsxhqyklO9EDwvzPdPtM9Bgex/KIdqJ3oP0D6dzu7MvUJZr/q+IJSxcJvw9Xpr3qaj2
         g7Ig==
X-Gm-Message-State: AOAM531ZvLLBS6emY4B/b0N2XEgBk1DaZ6POT9tes0/UEOy+YB4uTM2b
        zn1gpEMKyilsC1B09sf6GQdrOMEsr7AuSH71MmYWjfaxWcdK+JLQDmLMPSES9hIjDiTZPO4gD17
        gdLd28qpYCQuNVUQ020bDkA==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr12306413wmj.160.1634129224184;
        Wed, 13 Oct 2021 05:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3bu0Nu2sTQ0+QNSDdqXyjCUIauFl76JolUN+8aoRczJi/YTb07iDFPZNwrmi/5HPNNvtB6A==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr12306384wmj.160.1634129223978;
        Wed, 13 Oct 2021 05:47:03 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id b190sm5299164wmd.25.2021.10.13.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:47:03 -0700 (PDT)
Date:   Wed, 13 Oct 2021 08:46:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        markver@us.ibm.com, Cornelia Huck <cohuck@redhat.com>,
        linux-s390@vger.kernel.org, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211013084640-mutt-send-email-mst@kernel.org>
References: <20211011053921.1198936-1-pasic@linux.ibm.com>
 <20211013060923-mutt-send-email-mst@kernel.org>
 <96561e29-e0d6-9a4d-3657-999bad59914e@de.ibm.com>
 <20211013081836-mutt-send-email-mst@kernel.org>
 <20211013144408.2812d9bd.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013144408.2812d9bd.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 13, 2021 at 02:44:08PM +0200, Halil Pasic wrote:
> On Wed, 13 Oct 2021 08:24:53 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > OK this looks good! How about a QEMU patch to make it spec compliant on
> > > > BE?  
> > > 
> > > Who is going to do that? Halil? you? Conny?  
> > 
> > Halil said he'll do it... Right, Halil?
> 
> I can do it but not right away. Maybe in a couple of weeks. I have some
> other bugs to hunt down, before proceeding to this. If somebody else
> wants to do it, I'm fine with that as well.
> 
> Regards,
> Halil

Couple of weeks is ok I think.

-- 
MST

