Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE40C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 22 Jun 2022 01:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355455AbiFVBSB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Jun 2022 21:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiFVBSA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jun 2022 21:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5141F19
        for <linux-s390@vger.kernel.org>; Tue, 21 Jun 2022 18:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655860677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wuuPsrvpildfWMsTFBzbFCeyycT4LB8kmzw//Wg2WxM=;
        b=Qb/3BPtZIGsVHmjkts8gnMMnCq/X1ipaGxVuE0KMzg/T0modeFuGSXQ9OHBKEud8jLfjT3
        1wW+T2a+E2G37mGU+fn/DG/ir9+a+Une+qqnaCBXMyrj1NQsk1Rc+JA0AhM2tqR3c4nW8n
        ckr4gcCUo9rdkNqxSwQRFH8qFsXgzGQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642--3FlVvcSO12xn9BHSL4QQA-1; Tue, 21 Jun 2022 21:17:56 -0400
X-MC-Unique: -3FlVvcSO12xn9BHSL4QQA-1
Received: by mail-lf1-f70.google.com with SMTP id u5-20020a056512128500b00479784f526cso7700520lfs.13
        for <linux-s390@vger.kernel.org>; Tue, 21 Jun 2022 18:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuuPsrvpildfWMsTFBzbFCeyycT4LB8kmzw//Wg2WxM=;
        b=KlGbfxHGviKHLo881eQeShI3m/p41RyH14GmzwqU85TM8O0t5myCnBlEXKfvD05oCv
         mAsfVV5Jo30POUrONfv9z0D5Cg6bbUStA+rKgrJpDgCeDlRMRicO0pSphrGeKe0+LOFa
         9Qo5e3iKrxWrN+4AkzLHULk5HfTbjN0G2mVpG+YKB9Rm1/EMyphcv55JeFy0eX9DgvYK
         v4C3VMf94MXe7mKywwEp0GT7y2BYxtdvp+d9qYMqnV8EYwAftSi35uaMcsmTmr9BorDa
         qOdQ7WjFv88zEE4hwjwqGGJ4u3htPaJQRrNSeTWNNf7pC6EikS1SYy3T5KKtuWzoZEII
         rFYA==
X-Gm-Message-State: AJIora+oudAdNFwOYdMhiA19UXLaala6kogjPk953P0OrfVlOUT7CyMj
        VP1dVPEi8uhzByNBvrXg/MpBYVMsqPYYpf3RINuwyqEzrjPTe23/blxeyCLAi4PnYyLkOvRNHmu
        ead9gdyOwxESpU5dFqAquUzfMkrJ2texcHdQtVg==
X-Received: by 2002:a2e:8417:0:b0:25a:7fa7:fe5a with SMTP id z23-20020a2e8417000000b0025a7fa7fe5amr446417ljg.323.1655860675038;
        Tue, 21 Jun 2022 18:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tQNlmQ8fPIImazbU50qDI+J7JfZUZ94bHEMA0uqALx+tS95NtR1kJrk5qBRHT/YHfDAiJWdNBd86xhIi+W7kQ=
X-Received: by 2002:a2e:8417:0:b0:25a:7fa7:fe5a with SMTP id
 z23-20020a2e8417000000b0025a7fa7fe5amr446411ljg.323.1655860674845; Tue, 21
 Jun 2022 18:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220620024158.2505-1-jasowang@redhat.com> <87y1xq8jgw.fsf@redhat.com>
 <CACGkMEun6C9RgQVGq1B8BJMd9DyRQkSXj8shXVVhDymQYQLxgA@mail.gmail.com> <87sfny8hj8.fsf@redhat.com>
In-Reply-To: <87sfny8hj8.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 22 Jun 2022 09:17:37 +0800
Message-ID: <CACGkMEsg9791gQAtsz6fCM_=9_VmbqY=FehoTnpyiaJ7mCosDA@mail.gmail.com>
Subject: Re: [PATCH V2] virtio: disable notification hardening by default
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, mst <mst@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 21, 2022 at 5:58 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Tue, Jun 21 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Tue, Jun 21, 2022 at 5:16 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> The ifdeffery looks a big ugly, but I don't have a better idea.
> >
> > I guess you meant the ccw part, I leave the spinlock here in V1, but
> > Michael prefers to have that.
>
> Not doing the locking dance is good; I think the #ifdefs all over are a
> bit ugly, but as I said, I can't think of a good, less-ugly way...

Probably, but this is the way that is used by other subsystems. E.g
CONFIG_HARDEN_USERCOPY etc.

>
> > In the future, we may consider removing that, one possible way is to
> > have a per driver boolean for the hardening.
>
> As in "we've reviewed and tested this driver, so let's turn it on for
> every device bound to it"?

Right.

Thanks

>

