Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A733FC433FE
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 16:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EDD61101
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 16:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhKAQV2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 Nov 2021 12:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232630AbhKAQV1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Nov 2021 12:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+PlMFyDlSdyotYZmkf9Kx/3zxEQEZ+hPS+mrYwQmhsg=;
        b=EW0fz8Qe+ut9KmyCoRnOsO+APBwR60Zxa92KxIOw0e3QnKU/DslfH1ELoHiVCkefhnbYEu
        QOheCjtisgQ1WDDVDdsZ6TkXRMXrhS8S5d86zD8pYK3L36Z6H1AbIQBLv7Ig/obIp6gM7b
        CYbnS/lTZusUX2RMuk9U17L7r0fDKrA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-zITu0mzINp6tyDbj05HKtQ-1; Mon, 01 Nov 2021 12:18:52 -0400
X-MC-Unique: zITu0mzINp6tyDbj05HKtQ-1
Received: by mail-qt1-f197.google.com with SMTP id h4-20020ac85844000000b002a9f083974bso12365470qth.22
        for <linux-s390@vger.kernel.org>; Mon, 01 Nov 2021 09:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+PlMFyDlSdyotYZmkf9Kx/3zxEQEZ+hPS+mrYwQmhsg=;
        b=z9J6mdn7gPUAxFKdCMxLHaSTRn906+DeFatHEzkyP8K56Ndh3QvdqRy9hrh0og2oEn
         KXdIloeZqsUphq1xD6NQxdHnmBJu5Rww45bvd+37PyzOOryZAB0FFPSomQlS2VEsWMOE
         OEQ++yy+qzLBED4lGemf7JTgHi9ZOHpQBTK5jJmUhqvwB67D0oR12P2s2qRmwnMF0x7k
         EBSAebkyRk0ov6kLLL3pXT+SMEx6V0gxHDxHrcLvXSy8NoVY04cojnV/wqF6eQs3Oeei
         U1sHPC0kLj5K/1lB8EPFqifaIe4pHTweKP0uLeflAG+yCz+XyYywur36tDbCYeIiH+EY
         Z6ow==
X-Gm-Message-State: AOAM532+FZg6toqx7d9rmIZTznObd4MImrRg8Ql+pI8RNJhH+eLG5PRV
        qTZLsykDKLi5sF2MpnKRTuCN+T4DRHKtguVbfTJGSucG/PLcT1XSpSyA1SiBm7Yf9ivS56xF9kD
        5p7SNtpQweFY+dPTFlhN1
X-Received: by 2002:ac8:183:: with SMTP id x3mr31456936qtf.270.1635783531653;
        Mon, 01 Nov 2021 09:18:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx06c4hivJwjfQA8DeAKPNXipJ/hNPI/8Dli7abowyJqKsKBWURc5Mk5ISYlLWlJ3N1kL0ucw==
X-Received: by 2002:ac8:183:: with SMTP id x3mr31456902qtf.270.1635783531462;
        Mon, 01 Nov 2021 09:18:51 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id q20sm10701041qkl.53.2021.11.01.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:18:51 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:18:50 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 08/11] dm-linear: add a linear_dax_pgoff helper
Message-ID: <YYATamEnd6imRSxt@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-9-hch@lst.de>
 <CAPcyv4iK-Op9Nxoq91YLv0aRj6PkGF64UY0Z_kfovF0cpuJ_JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iK-Op9Nxoq91YLv0aRj6PkGF64UY0Z_kfovF0cpuJ_JQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 27 2021 at  9:32P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a helper to perform the entire remapping for DAX accesses.  This
> > helper open codes bdev_dax_pgoff given that the alignment checks have
> > already been done by the submitting file system and don't need to be
> > repeated.
> 
> Looks good.
> 
> Mike, ack?

Acked-by: Mike Snitzer <snitzer@redhat.com>

