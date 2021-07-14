Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6644CC12002
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 19:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A764613BE
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 19:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhGNTF1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhGNTF1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Jul 2021 15:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626289355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFMVPE+n/KeTvvfcTz8BsFDOSTNgAFC7F/IHRyxFJmc=;
        b=i/6plcX/VyNSOWVL6DQ9cOsTfYx0LTG4etdvlDv1BqfdT30YigzOJsRmTOWrYndatt+ihL
        bdpZxOJFAFhpSSLg96jx1HJT2bgdDbt98vA/Ttbq2G0ZT56yKcdGS8MfOVzj2c/n93gQld
        BaXQvOIOAEwclidljNdX7etqryHWUvQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Tu0LPMDKM1qbcNYO6sHljg-1; Wed, 14 Jul 2021 15:02:11 -0400
X-MC-Unique: Tu0LPMDKM1qbcNYO6sHljg-1
Received: by mail-oo1-f71.google.com with SMTP id c25-20020a4a8f990000b029024c6d57447aso2503647ooj.17
        for <linux-s390@vger.kernel.org>; Wed, 14 Jul 2021 12:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFMVPE+n/KeTvvfcTz8BsFDOSTNgAFC7F/IHRyxFJmc=;
        b=Ru9VVoYUs9Eq97jSSKbzSgMVtCZh5Zbsw9uhH8QvuDQ3qphNI0g2YVLiD0sdfgWN/k
         NVTNlvW/g6vdAvJu/alQguroGcBzzeB11iZa6A21Uzb0mgcKA5EYkpgy1/QzeEEq6WKs
         HZSXDueaUOly51ZU2eOAA8zaHsHarl+qsBuEDvmEyULZ5yB61lufwOiXg917ErpecBY0
         hzaJo0HtkYTBmv4QjsVQPeHZjvMh5NAazyGOObs4qf0FSdgrQr2ZjZ9zshrSF0NhNTGr
         BGNq5O0KwBeLOnkCIHpaCZUEjBR193MtrNYV7n8wR7GsdWPu//oaDyjs/rLyOKuNNjV2
         Aihw==
X-Gm-Message-State: AOAM531vC1/iPFRRkW8+k3Ak2FG2lr1g5qMui/1jFfnAL9091KpK87fu
        RxHpTMNLlU2ZCKYmL0qAlauszkv10vg9cSKTty1dH4FwvDtdCH2DUQHeM54rbdIaTxs9atah6KF
        4RrmQnUucubsfkwmtNtGk4A==
X-Received: by 2002:a05:6808:68d:: with SMTP id k13mr8538412oig.83.1626289331021;
        Wed, 14 Jul 2021 12:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmWMx0geU1BNiLf2IsT9q6idWWJuEft9e76PzdT0hS84lYGsbY/IMct48LwOS/vpZ04uvQvA==
X-Received: by 2002:a05:6808:68d:: with SMTP id k13mr8538396oig.83.1626289330814;
        Wed, 14 Jul 2021 12:02:10 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id l8sm654946oie.0.2021.07.14.12.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:02:10 -0700 (PDT)
Date:   Wed, 14 Jul 2021 13:02:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210714130208.1eb5c677.alex.williamson@redhat.com>
In-Reply-To: <9c50fb1b-4574-0cfc-487c-64108d97ed73@de.ibm.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
        <20210713013815.57e8a8cb.pasic@linux.ibm.com>
        <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
        <20210713184517.48eacee6.pasic@linux.ibm.com>
        <20210713170533.GF136586@nvidia.com>
        <9512a7fb-cc55-cd9b-cdf9-7c19d0567311@linux.ibm.com>
        <20210713192138.GG136586@nvidia.com>
        <dc18ff02-80f6-e59e-5f08-417434e74706@linux.ibm.com>
        <9c50fb1b-4574-0cfc-487c-64108d97ed73@de.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 14 Jul 2021 19:56:42 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 14.07.21 15:25, Tony Krowiak wrote:
> >   
> >> This patch shows it works as a rwsem - look at what had to be changed
> >> to make it so and you will find some clue to where the problems are in
> >> kvm_busy version.
> >>
> >> In any event, I don't care anymore - please just get this merged, to
> >> AlexW's tree so I don't have conflicts with the rest of the ap changes
> >> for VFIO I've got queued up.  
> > 
> > Christian, can you merge this with AlexW's tree? Halil suggested
> > the 'fixes' and 'cc stable' tags ought to be removed, do I need
> > to post another version or can you take those out when merging?  
> 
> Normally this would go via the KVM/s390 or s390 tree (as Alex did
> not want to handle s390 vfio devices).
> 
> Alex, as Jason is waiting for this to be in your tree could you take
> this patch via your tree ?(please remove cc stable and Fixes for now
> I want this to settle a bit).
> 
> To carry this patch in your tree with my kvm/s390 and s390 maintainer hat
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Is this intended for v5.14 or v5.15?  I don't have a v5.15 next branch
yet, so if this were to get into v5.14 before I create that, it'd be
there for Jason as well.  Posting a branch that we both merge into our
linux-next branches would be another option.  I can take it either way,
just trying to understand what we're wanting to achieve.  Thanks,

Alex

