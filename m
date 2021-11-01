Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF006C43217
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 16:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C59C61101
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 16:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhKAQV5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 Nov 2021 12:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232643AbhKAQV4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Nov 2021 12:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C05du9bq5580dSm6IfhlDVs1xfqwhE2XhWSAZIf2yew=;
        b=ioV3bcGv85AIWOyDAkvGTS2TjAGuZiacWuWeZda+/ETDMsG5qLftSzKgmpK4q7FS2Umsnf
        OuoVbJYNu0QBQKDOLBcLohvnvmr9NWJFWEYFcXZ9DiQb5Vo6bNW/Ia5YX9AjfY0Qa//PCi
        FpPo81IXuUBBkxwQAldvhalUJRAF/xs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-2pB9uh6YM3mz7JL-DafAoA-1; Mon, 01 Nov 2021 12:19:21 -0400
X-MC-Unique: 2pB9uh6YM3mz7JL-DafAoA-1
Received: by mail-qk1-f197.google.com with SMTP id h8-20020a05620a284800b0045ec745583cso10825831qkp.6
        for <linux-s390@vger.kernel.org>; Mon, 01 Nov 2021 09:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C05du9bq5580dSm6IfhlDVs1xfqwhE2XhWSAZIf2yew=;
        b=mZqpHm7YblM68IcrSz1YRv+7sQyOgGLYdMWehOfqVlzbfvPlrKlXSClQ3CPRNqReW7
         y/4hQbA+6Q7qidqJvLnvN1WVgcXeYaMXy7/VqVac9sSh0PxfB+qZlWGIWDN/qPmae+Q6
         nMV1hrQjDKv2pBLmafsDKI4VUU1fYFmbF6k1oS6CydhXB6At9aPp4UGXv1VTB//iGL12
         uibzwdWNmEivsq6hw0N2yI7eUP8afhFNkq/3mdhuZh4R3y6q/EZNxwCbC706OlZUpTBz
         maN5bj5Hq57+u3zPWdMPKXrGa9VkaBNENozEFz4wdZnss+lKQwAWjsLsXEMsVPXRLgip
         aFjQ==
X-Gm-Message-State: AOAM530gLPkqXanT92YLOvG6hw+lcK5Rjz4KyZgkTSYUM5FGz+Lr3ZkS
        efvE7cIXtuPRcCwi23WPALr5mNdm33YskUxXE+UMUyoAMc+g5qhUKGsgl25eSJFSSr4MsVhhjer
        QeGYHbR/VTpmsHGI2FDYt
X-Received: by 2002:a0c:b341:: with SMTP id a1mr28270554qvf.21.1635783560974;
        Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvmIEea110PcdB5LDCY7U1ej3BdqkCE7DUWVGoDnBFq+m2W3EEPnU5Ptqvnzv3GNnSJbsMew==
X-Received: by 2002:a0c:b341:: with SMTP id a1mr28270537qvf.21.1635783560844;
        Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g8sm1775746qko.27.2021.11.01.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:19:19 -0400
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
Subject: Re: [PATCH 09/11] dm-log-writes: add a log_writes_dax_pgoff helper
Message-ID: <YYATh6yxGehyjpcm@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-10-hch@lst.de>
 <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 27 2021 at  9:36P -0400,
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
> 

Acked-by: Mike Snitzer <snitzer@redhat.com>

