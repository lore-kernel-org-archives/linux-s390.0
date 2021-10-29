Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34609C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1391461051
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 15:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhJ2PpM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Oct 2021 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJ2PpK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Oct 2021 11:45:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86473C061767
        for <linux-s390@vger.kernel.org>; Fri, 29 Oct 2021 08:42:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q187so10309650pgq.2
        for <linux-s390@vger.kernel.org>; Fri, 29 Oct 2021 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkrK8/+uwUhU1+ibCc9sihgvRMe3oeCDEJlEEAsQMNY=;
        b=6wmVMWLAKN8exE8XR8wv/iFYhudFZm/xaEJpNEZmOxWSzGBAVEn+M6ckTQFipGdRJT
         yb6PYTTcKIVqTXGsV3bkPy2TCiq4+HLgRy2cRXBAvM33znfROc4XjMNFzIfr4UE69rdj
         4eISFf7aFEyAHo2Sf/MANtuSqjdRnwdAyb7h0RnbdOmg2MrJVd+mPCxh87qxZR21UV1T
         Jo7MDmjd0zsp2/1yCw8PZ5/EZTwQNFNoOJVWhez881Nf3OlrTKHfCKrLAxk43DLXDdPH
         n00SPDakiTsjm+voDnH7pSuvR7gHcdocX6KbBQemE5xaUaALVKmTKfT7gJVRpb96WLOa
         Bfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkrK8/+uwUhU1+ibCc9sihgvRMe3oeCDEJlEEAsQMNY=;
        b=2vOW1mPqX23BT0gAHUvtcijCIU8KZ9woOpM8/yUkAXFdnjdWciyVVKRJasFJH40IZH
         qTZ3X478JxPmsSZk1IFzkfUY6MiBM+KXW1yDAgbgAEwNJthAtJ4uuTXYJxZNZd6hX19x
         vwNp+wNi6swKoHYW6wr8ObHxotzY6M+yp/9lAd3qWxVjteEml3kblCGQeyPuOTrQ2Oi0
         E6LxkKGpx159I/mLz7iEYaeFpxT4mbw0qXJCEzZftnShPnP11TtYd3XuspZxAL6NSH/4
         E5dJK8CUOSyQ7CTJy9/wEXDDIZWlqwST9ucy4jyUZVI88xS1ifAabXAyuyn23QOXxvBx
         29pQ==
X-Gm-Message-State: AOAM530PRrTsA+PMb4UHpANk9Kf2asTactFSwCXaS5ceRHmEtJwlP/vt
        UvByx1QWwNvvW5CRrb0L6RLUIUqU291G4cVXOmwF1w==
X-Google-Smtp-Source: ABdhPJwscYMJBcsf4QuT7rFuYsL/BYYBLAhJeu/07ZB2t6F9Qexmb3kIziq0UAiLr3A7UbGhuhxXArjTEfzlR4kAptU=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr11616698pfu.61.1635522160977; Fri, 29
 Oct 2021 08:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
 <20211029105139.1194bb7f@canb.auug.org.au>
In-Reply-To: <20211029105139.1194bb7f@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 08:42:29 -0700
Message-ID: <CAPcyv4g8iEyN5UN1w1xBqQDYSb3HCh7_smsmjt-PiHORRK+X9Q@mail.gmail.com>
Subject: Re: futher decouple DAX from block devices
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 28, 2021 at 4:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dan,
>
> On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > My merge resolution is here [1]. Christoph, please have a look. The
> > rebase and the merge result are both passing my test and I'm now going
> > to review the individual patches. However, while I do that and collect
> > acks from DM and EROFS folks, I want to give Stephen a heads up that
> > this is coming. Primarily I want to see if someone sees a better
> > strategy to merge this, please let me know, but if not I plan to walk
> > Stephen and Linus through the resolution.
>
> It doesn't look to bad to me (however it is a bit late in the cycle :-(
> ).  Once you are happy, just put it in your tree (some of the conflicts
> are against the current -rc3 based version of your tree anyway) and I
> will cope with it on Monday.

Christoph, Darrick, Shiyang,

I'm losing my nerve to try to jam this into v5.16 this late in the
cycle. I do want to get dax+reflink squared away as soon as possible,
but that looks like something that needs to build on top of a
v5.16-rc1 at this point. If Linus does a -rc8 then maybe it would have
enough soak time, but otherwise I want to take the time to collect the
acks and queue up some more follow-on cleanups to prepare for
block-less-dax.
