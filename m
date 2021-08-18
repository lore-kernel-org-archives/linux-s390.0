Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9107C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 16:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A85160F11
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 16:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhHRQjw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 12:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhHRQjt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 12:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629304754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZaLFXRzV9l0fgdri7hzFzPxavfz8D2UkZEnURZcUSE=;
        b=AMrGWJBgNJ/4DvORLv505gaGDEHh1gKJM82zh714u4nxctkiG0amWqU5ZgIdi+cgez5qvd
        t9A9dw9uV3OnrgPOYZLdLgoB7cRS07B14dmWCRvwRnNAMSNOsKvIoZ5610KHSenT2qIKpt
        jeCS/DaE6ADnflZHKN+1Ow3NKZp1GC4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-G2SvjZR6N5-uoRfIY8o6Wg-1; Wed, 18 Aug 2021 12:39:12 -0400
X-MC-Unique: G2SvjZR6N5-uoRfIY8o6Wg-1
Received: by mail-oo1-f72.google.com with SMTP id u5-20020a4aae850000b02902869d22d7a1so1308040oon.5
        for <linux-s390@vger.kernel.org>; Wed, 18 Aug 2021 09:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZaLFXRzV9l0fgdri7hzFzPxavfz8D2UkZEnURZcUSE=;
        b=TcDH+UGMliHutEZOeg+Zy5Cv9xqi/IWx9zmvqfyEoedOWn7wSvc/UAe7Q/rMw8QqQ4
         LxZV8ZEbMVq3mB9b2547iagsxFOGh7njVKrcgXbDQOp7wtNOOpwjeDDPpqXb8QOGYolQ
         7QmLLeOrYFUYp2N6K0umoMPN7kenRMPp+RDWlG0GoIi60SAWDkGKolzrTjkFRZ7F7lk/
         u27rwiTZYCLYrGPdcy8HLrLb9yxNWrQwiwfFep3EpwQI9/BIxGiD6eD9p7bxxM1fut84
         bLBuro9dx3h8w9knguXdXNOWE5oYl9I5AxTwp4gZPC/ASDC7okWBVdRIn1wTAybCE07G
         Lnfw==
X-Gm-Message-State: AOAM533q5hkB2Uod1hd3piIuSS5y5Hg5bNaDdG6dVjICducizzUDa5e2
        ME5zxlwTrNvuNFoSbLp3lb2jt6RhfcZBArQzCgdSfpi++CVUA+xMVqSncBiBsAzee4BaaP7f+Qi
        sqBROoGKy4oziBwZilPreDw==
X-Received: by 2002:a05:6830:913:: with SMTP id v19mr7650690ott.156.1629304752143;
        Wed, 18 Aug 2021 09:39:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsaGD1Dsv42EHMoGBypp5qPbWYWKQDHHY5MdTgQNhj+75F6/mx8z3kSdarO0OmQmDzK5F5xQ==
X-Received: by 2002:a05:6830:913:: with SMTP id v19mr7650664ott.156.1629304751883;
        Wed, 18 Aug 2021 09:39:11 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id h14sm111621otm.5.2021.08.18.09.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:39:11 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:39:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        kwankhede@nvidia.com, david@redhat.com, pbonzini@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210818103908.31eb5848.alex.williamson@redhat.com>
In-Reply-To: <6d64bd83-1519-6065-a4cd-9356c6be5d1a@de.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
        <20210802155355.22b98789.pasic@linux.ibm.com>
        <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
        <6d64bd83-1519-6065-a4cd-9356c6be5d1a@de.ibm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 18 Aug 2021 17:59:51 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02.08.21 18:32, Tony Krowiak wrote:
> > 
> > 
> > On 8/2/21 9:53 AM, Halil Pasic wrote:  
> >> On Mon, 2 Aug 2021 09:10:26 -0400
> >> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>  
> >>> PING!
> >>>
> >>> This patch will pre-req version 17 of a patch series I have waiting in
> >>> the wings,
> >>> so I'd like to get this one merged ASAP. In particular, if a KVM
> >>> maintainer can
> >>> take a look at the comments concerning the taking of the kvm->lock
> >>> before the
> >>> matrix_mdev->lock it would be greatly appreciated. Those comments begin with
> >>> Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.  
> >> As far as I'm concerned, we can move forward with this. Was this
> >> supposed to go in via Alex's tree?  
> > 
> > I am not certain, Christian queued the previous patches related to
> > this on:
> > 
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
> > 
> > Jason G., since this will need to be integrated with your other patches,
> > where should this be queued?  
> 
> 
> This previous patch (s390/vfio-ap: clean up mdev resources when remove callback invoked) is
> already in master.
> Can you respin the series with all Acks and RBs?
> 
> Alex, can you then take these 2 patches via your tree? Thanks
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> for this series.


I see some review feedback that seems to suggest a new version would be
posted:

https://lore.kernel.org/linux-s390/0f03ab0b-2dfd-e1c1-fe43-be2a59030a71@linux.ibm.com/

I also see in this thread:

https://lore.kernel.org/linux-s390/20210721164550.5402fe1c.pasic@linux.ibm.com/

that Halil's concern's around open/close races are addressed by Jason's
device_open/close series that's already in my next branch and he
provided an Ack, but there's still the above question regarding the
kvm->lock that was looking for a review from... I'm not sure, maybe
Connie or Paolo.  Christian, is this specifically what you're ack'ing?

It can ultimately go in through my tree, but not being familiar with
this code I'd hope for more closure.  Thanks,

Alex

