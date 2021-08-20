Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC55C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 17:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2C461101
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 17:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhHTRnD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhHTRnD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Aug 2021 13:43:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CD6C061575
        for <linux-s390@vger.kernel.org>; Fri, 20 Aug 2021 10:42:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x4so9878598pgh.1
        for <linux-s390@vger.kernel.org>; Fri, 20 Aug 2021 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7zxR3GQPr0QInweAIaxU197r+IFtwnG1bELnryA2Nc=;
        b=y4/Hw46Tyt6CJOhTJfOE9fPJwnCmNjav/irCOd0ITLClJD4kBaZFBaPNmhLEKgYk24
         Hrn4r2Q6w0DlrkDpplN5QtQ32ovoKcPRjDTAMkD9QJK5aMAVOCpaLmPMsv8Ynxwaqj6f
         WmOlyA0WtJ5TPCJRNxPn6MHwS7eqaV2F1eDWLLCoxAaVymwJ9jxj3xYIE91Q5EUjsJzC
         jVxKWlEcmgKOf+CO4n7s8cE/7MXPCK3rCpb7xWKV1lachJIXVfNCEjHlfVbDdaL3q9XN
         gl+uy4N15WJagMIN/VjftSEo27OpebEh8C6kXfSgj2ssk2DfVYJqw/XsBBrc8MY8MFBD
         bhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7zxR3GQPr0QInweAIaxU197r+IFtwnG1bELnryA2Nc=;
        b=KJvZqasz5evdxAvn3ec3b7F3pwlO+HfGM6+kozy5Qgkuhqrv42ObzXtQ0IaV7Mlgr6
         f3ExiE0bHDehMafjB1Hov1N3WGD6lQlKZB1GulV2rK9MLzS1vCmvnTvvYf8b0FHAWkYd
         J5hZ4HGkI2FTIRdYQwHmJFMWR0QPnxPSxX/fGlLMskJgH1i6l7oQ0zVXxQmtodIPpYGj
         JOUBEciTFoFSDC+LQohhZ9GgC4RhWemHK5Tf3Ye9imd+n9bO+a5p8DfSaszBu3xh330S
         jdBrHTYD5suOLebxsFjnhNkpZxDhhpSbIJta1UY7N4OqK2VnO/ziwWtA+g4lVv+9CYKj
         OV+Q==
X-Gm-Message-State: AOAM5338XqD1BQDAiKUGSipM4HnrChYKiVUyCXiakDssRQq9D400N5zn
        GSiLqs+UugZ1su1opeM/+8gR/w4GiWfS5xdHcaigmQ==
X-Google-Smtp-Source: ABdhPJy2ILzpIq5YTLy4oxmLmrYnnk2awznkg3/qDwfw/fFwC3GliRWtSeNdqupJrLFOLcKAPGKCJjUInVx1+HGlrs0=
X-Received: by 2002:a63:311:: with SMTP id 17mr19557200pgd.450.1629481344998;
 Fri, 20 Aug 2021 10:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210820054340.GA28560@lst.de> <CAPcyv4i5GHUXPCEu4RbD1x_=usTdK2VWqHfvHFEHijDYBg+CLw@mail.gmail.com>
In-Reply-To: <CAPcyv4i5GHUXPCEu4RbD1x_=usTdK2VWqHfvHFEHijDYBg+CLw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Aug 2021 10:42:14 -0700
Message-ID: <CAPcyv4jpHX4U3XisqVoaMf_qADDzKyDS1wOijCs3JR_ByrXmHA@mail.gmail.com>
Subject: Re: can we finally kill off CONFIG_FS_DAX_LIMITED
To:     Christoph Hellwig <hch@lst.de>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

[ fix Gerald's email ]

On Fri, Aug 20, 2021 at 8:41 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> [ add Gerald and Joao ]
>
> On Thu, Aug 19, 2021 at 10:44 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi all,
> >
> > looking at the recent ZONE_DEVICE related changes we still have a
> > horrible maze of different code paths.  I already suggested to
> > depend on ARCH_HAS_PTE_SPECIAL for ZONE_DEVICE there, which all modern
> > architectures have anyway.  But the other odd special case is
> > CONFIG_FS_DAX_LIMITED which is just used for the xpram driver.  Does
> > this driver still see use?  If so can we make it behave like the
> > other DAX drivers and require a pgmap?  I think the biggest missing
> > part would be to implement ARCH_HAS_PTE_DEVMAP for s390.
> >
>
> Gerald,
>
> Might you still be looking to help dcssblk get out of FS_DAX_LIMITED
> jail [1]? I recall Martin saying that 'struct page' overhead was
> prohibitive. I don't know if Joao's 'struct page' diet patches could
> help alleviate that at all (would require the filesystem to only
> allocate blocks in large page sizes).
>
> [1]: https://lore.kernel.org/r/20180523205017.0f2bc83e@thinkpad
