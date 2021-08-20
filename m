Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA7AC4320A
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BCD6108B
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 22:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbhHTWm1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 18:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240326AbhHTWm1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Aug 2021 18:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629499307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMddBmsWMWI5jF8CTPkKHEEdWMRR3jjcIFCbvP295Do=;
        b=TaCZqkAjbfXL6GoLOKK9FSfs1tMQ4pXeYufy2dKUXiyGDez+YlYF7oyf0jYgyBzyAfygY1
        sbbCGYjMz9yN1BQoGwU0kppJJa2jWCwmk8pWlD7Isvu8b68qumRBpXpED6cqQdimguRUVI
        jdmzlk1f4o/4VBc//uFmN2YX9rfb1OU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-s1sf09_hMvuV5wJUQaxxeQ-1; Fri, 20 Aug 2021 18:41:44 -0400
X-MC-Unique: s1sf09_hMvuV5wJUQaxxeQ-1
Received: by mail-ot1-f70.google.com with SMTP id m32-20020a9d1d230000b02905103208125aso5547413otm.3
        for <linux-s390@vger.kernel.org>; Fri, 20 Aug 2021 15:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PMddBmsWMWI5jF8CTPkKHEEdWMRR3jjcIFCbvP295Do=;
        b=T+s5cz5ej67oVILzqk+zyCYEH34vKRPpp3Ht/PQE2t4DoVUmQ62v37nZGsMHpucl9G
         gW835E34VkIPYyIE9ucIEvz5xxvoudF2hFCYwfWGg4AnLHETQWCASO91mPfjWPZGeM/M
         j9K3DTsEEGDeKrYHsggCAV9uUsbFfraRZ7+JXY7ZzywqMZh0ZCbDrbMzsZezAQPk2vhg
         OyLsasDzQsVPEZEXlob888evpMGOZ8bueiMMsSJCnImQjM7u1GQrzUcAL4BvcYmsOtab
         O7uGvnEcjeXprpNvB/yh435wtsPNxzIGIiMVC0o/eTLBSD2GAiFqAXZhMncRN+VYV6hx
         9WlA==
X-Gm-Message-State: AOAM5329ICNMUgFmXq9vmIfOQzbmhdHk+LV5bv07NCE21DkzF3XIHtrC
        rlH/EXERR5nIcYhAf908UN/NNFwxkJ43Mg/8s3wbvwaLKBVMVySuPfSZjDXpW4KuVy7I2IdWTGP
        HUh+a+7nRPYC4Th5QOfpxjg==
X-Received: by 2002:a9d:7a8a:: with SMTP id l10mr19044157otn.256.1629499303769;
        Fri, 20 Aug 2021 15:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcFQXjKweunIGJyfApLENZn5qAh9f4tNkrZ9b1APukTQz366kMOunJGqWYj0xce16/nBRqGw==
X-Received: by 2002:a9d:7a8a:: with SMTP id l10mr19044147otn.256.1629499303534;
        Fri, 20 Aug 2021 15:41:43 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id o4sm1762132oik.49.2021.08.20.15.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:41:43 -0700 (PDT)
Date:   Fri, 20 Aug 2021 16:41:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
Message-ID: <20210820164142.1dcea352.alex.williamson@redhat.com>
In-Reply-To: <d905d1fa-2852-4fb7-5b56-4b3b12d8994f@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-2-akrowiak@linux.ibm.com>
        <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
        <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
        <20210819115433.76153ae4.alex.williamson@redhat.com>
        <20210819175807.GC1721383@nvidia.com>
        <d905d1fa-2852-4fb7-5b56-4b3b12d8994f@linux.ibm.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 20 Aug 2021 18:05:08 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 8/19/21 1:58 PM, Jason Gunthorpe wrote:
> > On Thu, Aug 19, 2021 at 11:54:33AM -0600, Alex Williamson wrote:
> >  
> >> Nope.  The only requests for merges through my tree that I'm aware of
> >> were [1] and what I understand was the evolution of that here now [2].
> >> Maybe you're thinking of [3], which I do see in mainline where this was
> >> 2/2 in that series but afaict only patch 1/2 was committed.  I guess
> >> that explains why there was no respin based on comments for this patch.
> >> Thanks,  
> > Tony,
> >
> > If you take Alex's tree from here:
> >
> > https://github.com/awilliam/linux-vfio/commits/next  
> 
> I navigated to this URL and clicked the green 'Code'
> button. I was given the option to download the zip file or
> use git to checkout the code at the URL displayed
> 'https://github.com/awilliam/linux-vfio.git'. I cloned the
> repo at that URL and the code was definitely not in any
> way similar to my code base. In particular, the
> arch/s390/include/asm/kvm_host.h file did not have any
> of the crypto structures.
> 
> I then downloaded the zip file and expanded it. The code
> looked legitimate, but this was not a git repository, so I
> had no way to cherry-pick my patches nor format patches
> to post to this mailing list.
> 
> Next, I tried cloning from 
> 'https://github.com/awilliam/linux-vfio-next.git',
> but I was prompted for uid/pw.
> 
> So, the question is, how to I get the linux-vfio-next repo upon which I
> can rebase my patches? I apologize for my ignorance.

You can use git fetch to download the objects, ex:

$ git fetch git://github.com/awilliam/linux-vfio.git next
$ git checkout FETCH_HEAD

Or you could add a remote, ex:

$ git remote add vfio git://github.com/awilliam/linux-vfio.git
$ git remote update vfio
$ git checkout vfio/next

The former might be easier and add a lot less crufty objects to your
local tree if this is a one-off activity.  Thanks,

Alex

