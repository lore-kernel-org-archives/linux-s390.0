Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53A3C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 12 Nov 2021 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25D960EE5
	for <linux-s390@archiver.kernel.org>; Fri, 12 Nov 2021 09:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhKLJhn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:37:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234696AbhKLJhm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Nov 2021 04:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636709692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxpcSnWKWAX26f0exTrc0C5AcatqZuzCnik5e/vhTMg=;
        b=QzIQ5+ctWOuJUWZJvlStQpPY4MpMTeZhDONJcFfAV+4+UZneYIA/d6KYi40qblxvlmYCNy
        s3L+OhUFpdDlxIX186bHfbXC4ffMln7rzWkuXSJeOKKQ410lyss1rMySLXGyIErHgc0/eO
        NXGovXB3EmCo32j+lxLdoYmA5NrAhyY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-m6tuCuHxPqS-KI9nnSAthg-1; Fri, 12 Nov 2021 04:34:50 -0500
X-MC-Unique: m6tuCuHxPqS-KI9nnSAthg-1
Received: by mail-lf1-f72.google.com with SMTP id i1-20020a056512340100b003fdd5b951e0so3546195lfr.22
        for <linux-s390@vger.kernel.org>; Fri, 12 Nov 2021 01:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxpcSnWKWAX26f0exTrc0C5AcatqZuzCnik5e/vhTMg=;
        b=s+Nfbuk74hcj1WHI3Z3wwVrUjtyzKuqZGpTKj+fNhhZqqI+Sa614WgxRA3UWwH+4q/
         L8+R2kHoXbdRj1ZBM7SW/aprlFMLMdyEk2jPMK43SLkb1z0hHRz/R6swlh0TzuJpz4iG
         UsbQGYfRZL1j4UXv19T51t4fGPnrhjF6eBuW24fhmn7Nn1ZNpHQJcYCePx0QeVai5TGv
         srmgTJzn0bd7TRadO7KhWQOO2pRaS5i9y/QBWvWi6URvhwYF7IZ+M+L2Ai6u8tf3wZAD
         uocLrU33zc/qNt/vVB+Oeg3P9e8z4vScB1bYGsHghSp2v7wqXsRVuj63Dj6ttifz/9+y
         GcxQ==
X-Gm-Message-State: AOAM532hij+ylC2X0VNpeu6Ny5c3FaXIoTi9uGprLN1N1MtOhuJJu3KM
        QR+IN6ZswfoB/Ev/nKZuxfqYf6vrtGO+ns3wGQVJrpftQ9nJP2VFKITfiXnYDO9gIYHw5M4WNtz
        Gcxxdqogj3i+pahNq6uqncLi638DZJYemPYPrDQ==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr14095543ljp.498.1636709689308;
        Fri, 12 Nov 2021 01:34:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPq5eZKYTUIJgtGo89zamrAE9TJk8OW8ctgHJM8VP8te70PDsioJzwZiAwfBx7HdIOawV5hHvaEzsGybltG8Y=
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr14095517ljp.498.1636709689060;
 Fri, 12 Nov 2021 01:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20211110203322.1374925-1-farman@linux.ibm.com>
 <20211110203322.1374925-3-farman@linux.ibm.com> <dd8a8b49-da6d-0ab8-dc47-b24f5604767f@redhat.com>
 <ab82e68051674ea771e2cb5371ca2a204effab40.camel@linux.ibm.com>
 <32836eb5-532f-962d-161a-faa2213a0691@linux.ibm.com> <b116e738d8f9b185867ab28395012aaddd58af31.camel@linux.ibm.com>
 <85ba9fa3-ca25-b598-aecd-5e0c6a0308f2@redhat.com> <19a2543b24015873db736bddb14d0e4d97712086.camel@linux.ibm.com>
 <ff344676-0c37-610b-eafb-b1477db0f6a1@redhat.com> <006980fd7d0344b0258aa87128891fcd81c005b7.camel@linux.ibm.com>
In-Reply-To: <006980fd7d0344b0258aa87128891fcd81c005b7.camel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Date:   Fri, 12 Nov 2021 10:34:37 +0100
Message-ID: <CADFyXm7XM96yUEU_5Xf-nT8D5E0+sji2AwfKCvr_yvx6fZrf2g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] KVM: s390: Extend the USER_SIGP capability
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, KVM <kvm@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> > > Right, that's exactly what I had at one point. I thought it was too
> > > cumbersome, but maybe not. Will dust it off, pending my question to
> > > Janosch about 0-vs-1 IOCTLs.
> >
> > As we really only care about the SIGP STOP case,
>
> Is that really true? SIGP RESTART does an inject back to KVM, ditto the
> (INITIAL) CPU RESET orders. It's true that SIGP SENSE is getting
> tripped up on whether a vcpu is actually stopped or not, but I believe
> that SIGP SENSE saying "everything's fine" when a vcpu is still busy processing an order isn't great either.

The general rule is "if the guest can detect that it violates the
spec, it needs fixing".

That is true right now when a single VCPU does:

#1: SIGP STOP AND STORE #2
#1: SIGP SENSE #2

Because according to the spec, the SIGP SENSE has to return either
BUSY or indicated STOPPED. And if it indicates STOPPED, the STORE has
to be fully processed.


Can you construct something similar with SIGP INITIAL CPU RESET and
e.g., SIGP SENSE? From a single CPU not:

#1: SIGP INITIAL CPU RESET #2
#1: SIGP SENSE #2

As the SIGP INITIAL CPU RESET is processed fully asynchronous.

Can you come up with an example where using another VCPU we could
reliably detect a difference between

#1: SIGP INITIAL CPU RESET #2
#3: SIGP SENSE #2

and

#3: SIGP SENSE #2
#1: SIGP INITIAL CPU RESET #2

and

#3: SIGP SENSE #2 [and concurrent] #1: SIGP INITIAL CPU RESET #2

If yes, it needs fixing, if not, we can happily ignore it.

