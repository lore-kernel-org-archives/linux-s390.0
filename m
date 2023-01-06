Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E6C54EBD
	for <linux-s390@archiver.kernel.org>; Fri,  6 Jan 2023 18:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjAFSDu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Jan 2023 13:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjAFSDq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Jan 2023 13:03:46 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7781E7816C
        for <linux-s390@vger.kernel.org>; Fri,  6 Jan 2023 10:03:44 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4bf16baa865so31915337b3.13
        for <linux-s390@vger.kernel.org>; Fri, 06 Jan 2023 10:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eEZ+gYj0Aw+/KwbtFpG2nTsQkTPCh9mgBN01WMoyG9k=;
        b=OzVb12i+p6fOtM4DB2gKbTCs0cki5Fq0J8zbVCA9+s+IHVwl1v2mmg2tUA/kHlUeM5
         gcBf9BkwuXBfra9aw7I7qPxNWmrxVsGvsSTcYt5pN90lcNdU0LH4vR4vdKwXmqrkNEkB
         +7Porj92aplLQ7EHn/oUBeVP4iW3/97Oh9YiRMrZIWpVPHD8X8Sk9YNwEfxC9Yrn6OJ9
         hPFDDgCHhiK0K5LH75O2cjOc+ImE5x7gXfBCqHLXphTeiD1ODx384s3PExRjcoHS3UMc
         YtssPKyqW98lOUSghqORXRLNCgmVAkVRqRZg5Bqqt6nGR08THSoad7uCemzkmYOF7fE4
         I4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEZ+gYj0Aw+/KwbtFpG2nTsQkTPCh9mgBN01WMoyG9k=;
        b=pf9r8SMu5fY0TVSJw+uAwFuekVNqUvSDmCKCsj4o38GuXM+zYbZh+ONCp6jA+5moiS
         e7oWYNTNrE/lTBWXDvKULmWz3Bupy61U7Ku763/k4ZZnw4DOtQw2LxS2btMhtF3OL/Kj
         sB7P0QK/o0eiuMYit8S5miYdmZIZj+/rZGtBN/gBqhZJ7KxhGpp7Tww2lNikoCkSjmOu
         AMqcpYGljaX8wa2I7dNdZQcmPuSHOUUQCWaI5ijQqnMu+dWnsH/Cav7+ZFCNYg8UWZiu
         HQx9WeniQ1NMAaNLz4M15jldKdKijbRxDZwRpuh4DJLXxqKuYtlGpuWZO4w7ITJbT65g
         RYeQ==
X-Gm-Message-State: AFqh2kqP5BjyT+5oqfcqX3GSc//DsiA8nc3i3fkRvTVNnDG7HWnPz1n4
        IcIqv/vp0olQKEaCGnkk/Vc5OA==
X-Google-Smtp-Source: AMrXdXtnu9QwBw2wQNo31FczW5+WnhFlUNv8RYqwfNZOO2ksTfO54O6qmb9EFz86Ms57s9KHu+WGVg==
X-Received: by 2002:a05:7500:4c94:b0:ee:9be:ff3 with SMTP id la20-20020a0575004c9400b000ee09be0ff3mr3614532gab.68.1673028223580;
        Fri, 06 Jan 2023 10:03:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a0f0e00b006fbb4b98a25sm863965qkl.109.2023.01.06.10.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:03:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pDr4A-006UoM-Fa;
        Fri, 06 Jan 2023 14:03:42 -0400
Date:   Fri, 6 Jan 2023 14:03:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Christian =?utf-8?Q?Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] vfio/type1: Respect IOMMU reserved regions in
 vfio_test_domain_fgsp()
Message-ID: <Y7hifk0RHT3tlqqW@ziepe.ca>
References: <20230104154202.1152198-1-schnelle@linux.ibm.com>
 <20230104154202.1152198-2-schnelle@linux.ibm.com>
 <20230106102450.2e6c70bb.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106102450.2e6c70bb.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jan 06, 2023 at 10:24:50AM -0700, Alex Williamson wrote:

> > -	ret = iommu_map(domain->domain, 0, page_to_phys(pages), PAGE_SIZE * 2,
> > -			IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> > -	if (!ret) {
> > -		size_t unmapped = iommu_unmap(domain->domain, 0, PAGE_SIZE);
> > +	list_for_each_entry(region, regions, list) {
> > +		if (region->end - region->start < PAGE_SIZE * 2 ||
> > +				region->start % (PAGE_SIZE*2))
> 
> Maybe this falls into the noise, but we don't care if region->start is
> aligned to a double page, so long as we can map an aligned double page
> within the region.  Maybe something like:

> 	dma_addr_t start = ALIGN(region->start, PAGE_SIZE * 2);
> 
> 	if (start >= region->end || (region->end - start < PAGE_SIZE * 2))
> 		continue;

Yeah, that is more technically correct

Jason
