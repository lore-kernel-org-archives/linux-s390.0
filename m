Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AD9C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 10 Jun 2022 22:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348463AbiFJWoP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Jun 2022 18:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348424AbiFJWoO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Jun 2022 18:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A1C23C71C
        for <linux-s390@vger.kernel.org>; Fri, 10 Jun 2022 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654901052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pblZd+Kqp7f2K+2rxNpvXUuiOLaopPh9IaEYk0kwYKE=;
        b=NTjYhRsx6ctDVsjQjsegWvbKCxKclOsEO07UrXSk8ypDynoqmphEPoXwlWosTDmIHU9jKu
        NKAwmxOJK34qSCSYKb+G7QwCrJl47j/kbQpKWg4P/UnmlckC+uUe3niKVZInsbxS/dMuzs
        suM1nz9eAMOXglsw91/x6M5dOdPLk4g=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-nCiLvhMuMgyV6JmFRu8T3Q-1; Fri, 10 Jun 2022 18:44:11 -0400
X-MC-Unique: nCiLvhMuMgyV6JmFRu8T3Q-1
Received: by mail-il1-f200.google.com with SMTP id h18-20020a056e021d9200b002d40280eeadso266910ila.23
        for <linux-s390@vger.kernel.org>; Fri, 10 Jun 2022 15:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pblZd+Kqp7f2K+2rxNpvXUuiOLaopPh9IaEYk0kwYKE=;
        b=enLTcZCKEWQBrjFwzlR8t2ILKViNgUmGV12HT0YbAEgFN15BufPejsEianfrLADxg8
         /Qud4JOuwu4MJhsgSnwSfN3CnC+Y6QvrBP/t7gZybn95bAozWC0oTYHusJGWvHCzO/QL
         w35Vrh8uW0HItvoh1/pW1Qmt5JDl3auGkzRM2B5bBMDL6uMPEZmi1exhdXGxbZGbbAg3
         /waAhY73cdam+dwPazJEb3GcETfGxu25pCBWl7Uzml8rsRZXOZ6J26FqM6iMAkZZj5E8
         U4rn0kslJBxVApiB64xg3gWHJbaIvinFFjjDpAWXnncjE2mTILa9zqF6nBQqCAAHbuYc
         2FYw==
X-Gm-Message-State: AOAM53324o0Qf/YFpacaZIM08uoNc2aRRnSH67itmcLYOJeuGz+EtAUw
        lkBPOT8TFBm4RUD12WDhjNqzPqoIm9C3NTu9JLBWhj4XU2p8lp/bbbBuV8PANO5HoDzYOUOQFCB
        gRo07JZk1hwGVXUzn4yibKg==
X-Received: by 2002:a02:c811:0:b0:332:2c2e:88e0 with SMTP id p17-20020a02c811000000b003322c2e88e0mr343362jao.132.1654901050841;
        Fri, 10 Jun 2022 15:44:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgEFjSHs9TXHG3p6x60NRKxwsOGKtJ1mMFIodXcBQ3lbM9zLgveeGgcd98DfNgAuz2vKQAXQ==
X-Received: by 2002:a02:c811:0:b0:332:2c2e:88e0 with SMTP id p17-20020a02c811000000b003322c2e88e0mr343346jao.132.1654901050600;
        Fri, 10 Jun 2022 15:44:10 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y2-20020a926402000000b002d3a3a089b3sm130533ilb.1.2022.06.10.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 15:44:09 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:44:07 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kwankhede@nvidia.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, diana.craciun@oss.nxp.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, yishaih@nvidia.com, hch@lst.de
Subject: Re: [PATCH] vfio: de-extern-ify function prototypes
Message-ID: <20220610164407.25feeb23.alex.williamson@redhat.com>
In-Reply-To: <20220610000434.GE1343366@nvidia.com>
References: <165471414407.203056.474032786990662279.stgit@omen>
        <20220610000434.GE1343366@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 9 Jun 2022 21:04:34 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 08, 2022 at 12:55:13PM -0600, Alex Williamson wrote:
> > The use of 'extern' in function prototypes has been disrecommended in
> > the kernel coding style for several years now, remove them from all vfio
> > related files so contributors no longer need to decide between style and
> > consistency.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> > 
> > A patch in the same vein was proposed about a year ago, but tied to an ill
> > fated series and forgotten.  Now that we're at the beginning of a new
> > development cycle, I'd like to propose kicking off the v5.20 vfio next
> > branch with this patch and would kindly ask anyone with pending respins or
> > significant conflicts to rebase on top of this patch.  Thanks!  
> 
> Can you stick it in your branch please?

Thanks for the R-b, it was my plan today to put it in my next branch,
but I can't currently test vfio on mainline due to:

https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen/

I'll get this in once there's a mainline base where vfio still works.  Thanks,

Alex

