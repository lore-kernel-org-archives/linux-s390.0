Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E20C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CD461165
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 16:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhKAQYD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 Nov 2021 12:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232416AbhKAQYD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Nov 2021 12:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9idZ9g7Qiy202IHm24WOcqzjkMEWV4Amwu/3bidfKY=;
        b=Jb2ieF+UJCAXaI4awu80SUFZWF1CkD+S/ZJK/qbpHthY8oUap767smt5XzxZrVboica49v
        Gc/NLA+cN/NPFJyzzwDixs9cL1vW5tpevJ1qXmdcl2xVTclP6wi6hIsKzEOnYopmlUHAik
        6/rk9NCN9qyolMzY00bExSCWPb1mljU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-zrlqlwQ7MwyIIFXJzGJXsw-1; Mon, 01 Nov 2021 12:21:28 -0400
X-MC-Unique: zrlqlwQ7MwyIIFXJzGJXsw-1
Received: by mail-qv1-f71.google.com with SMTP id fq15-20020a056214258f00b003831673b6bfso16813090qvb.15
        for <linux-s390@vger.kernel.org>; Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E9idZ9g7Qiy202IHm24WOcqzjkMEWV4Amwu/3bidfKY=;
        b=DrILtxVs4ExI8gDEVY2Lc2hylAjCBCp/HPvyu7I+1Gs7oMTQ9e6EH6RBQHcucvBqFg
         OTMqlGVvBTJXr9bZdCBCGpa1aZomMiEtZZQbBJcG1b7IkZdffYilJV05ryimqv7A8bpB
         Ng5Sew5TYDBicVi9vp84IB8cBFHXah/74NlewakXs0N8uuq/o2JO/LoXOYdJbJVGCYN4
         e/uvb/PnJIyYbiCfzC0v4dXFRyGX+8nzZloedFDqemvUIRLQPOEx23slaSy6TzY39BYi
         Cs2sIts0Qcgi1lPzuHtGi1Ikkl7L7zwLOhfKhV0DABqnPsnLLAnAJgtZM9qpjgs80+6Q
         UE9Q==
X-Gm-Message-State: AOAM530cfOYkv8LeOipeP7sE68OdiExf3/gOhjZRQouinqver4J2Vw4Q
        qUdZ5uBxwbOtkF7GDPY1yGKar4qY2g3WkYZdPMVQ0f4se4c6YQ2lpCsr5Fxzr4Nrm4fRGVMN5vG
        FZqptDA29SEbwO8zpicUn
X-Received: by 2002:ac8:7d04:: with SMTP id g4mr30472030qtb.183.1635783688228;
        Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXhGf8N2V91WU2Co6WJDyYs4GGgkn9JXnS/oEwWuG4J0RZNo7zMUQJUBh2KgjI9ZclpX5QJg==
X-Received: by 2002:ac8:7d04:: with SMTP id g4mr30472009qtb.183.1635783688071;
        Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id bj3sm2670847qkb.75.2021.11.01.09.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:21:27 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:21:26 -0400
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
Subject: Re: [PATCH 10/11] dm-stripe: add a stripe_dax_pgoff helper
Message-ID: <YYAUBkiPlRCVPnyv@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-11-hch@lst.de>
 <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 27 2021 at  9:41P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a helper to perform the entire remapping for DAX accesses.  This
> > helper open codes bdev_dax_pgoff given that the alignment checks have
> > already been done by the submitting file system and don't need to be
> > repeated.
> 
> Again, looks good. Kind of embarrassing when the open-coded version is
> less LOC than using the helper.
> 
> Mike, ack?

Acked-by: Mike Snitzer <snitzer@redhat.com>

