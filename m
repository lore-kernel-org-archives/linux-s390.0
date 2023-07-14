Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AC7C001B0
	for <linux-s390@archiver.kernel.org>; Fri, 14 Jul 2023 15:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjGNPYv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Jul 2023 11:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjGNPYu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Jul 2023 11:24:50 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4D2D79
        for <linux-s390@vger.kernel.org>; Fri, 14 Jul 2023 08:24:48 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a3b7fafd61so1633377b6e.2
        for <linux-s390@vger.kernel.org>; Fri, 14 Jul 2023 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689348287; x=1691940287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKCPDDjyadziwl2/AK/7bwW5AQLCnpdzpQfQJ+yWANU=;
        b=VkfHth5MNAZHQQpEhdDGh0pq0hoDNb/IkCyvJyfZlohZ7FEqc/tc2UlGQlp5P+ls2k
         LP4Az77bQs/0UVX1KSsNiwTlKtw8ZJErPfpgp4NpbjjW9RxzvWKdoj5q9JZGtbqYKyMw
         IkbeE1z0uT48kd4G5uv3BxnFhNNELaU6M+7XHRszPJ3LTmAtfce0FwO0kiq6qtWbZVLj
         +GaUqzfPkfSAQcQuVfYKAUHYwjH4iU0nqNSXmWkPMWsXsceycWdUU7PI1Bdr+PTPu7X6
         X/OpA3sg1LJmtBpK2xUftGMYHz3Z91vTuIVh4aBU1pURrsic+RJAvN3CFStnNYgOJO/U
         rXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689348287; x=1691940287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKCPDDjyadziwl2/AK/7bwW5AQLCnpdzpQfQJ+yWANU=;
        b=OLchGX8uMzvxNNNsiZ6hRGxrsUXnaKA8uFduF2CTImtNZEHAdhG3DQTMHNvyLoZmjX
         mn1bDQHu7ya3IBo/3PH9vdg12ZPAuk9ivvDJau7UrneF1+QCx33IfRSBX3fdBATjw+iS
         ZarYIn/piQXmk+IwVLnvqkbEKQlbyKdj9tbRL3doNRBmm0UsOJ7B96R4a8Asxc9YpCCr
         9wkOuxBcYjiQ4DDWjKrpddCI7SGRhJrF1taeI4lKtY7zisOBClFn156vKYLebj+VR9p8
         qTBdo8cKROuXQDVpYT1T7YCGYW8BU3+3SK2qUaV92H9Mn2Ai9rKRMr/iu4kys58M+RXZ
         jbGw==
X-Gm-Message-State: ABy/qLYJ/yuvCDetuY5wfOF+jOi2SNLy2YrFWI5Lrxfty6mMDvWgN15w
        sgboWObdv7lm7HPyp9nwrlsVFQ==
X-Google-Smtp-Source: APBJJlH+MwWcaUVg/7akbj8keBMvf8gq7EKuq9vDRBoNFYJ4+ezTmB048XjMLkW7GX8JAT8v1K03Sg==
X-Received: by 2002:a05:6808:2226:b0:3a3:eceb:7bbc with SMTP id bd38-20020a056808222600b003a3eceb7bbcmr7147567oib.54.1689348287397;
        Fri, 14 Jul 2023 08:24:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x19-20020a17090aa39300b00263154aab24sm1230248pjp.57.2023.07.14.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:24:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qKKez-0017NL-5i;
        Fri, 14 Jul 2023 12:24:45 -0300
Date:   Fri, 14 Jul 2023 12:24:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-usb@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Paul Durrant <paul@xen.org>, Tom Rix <trix@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Kirti Wankhede <kwankhede@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Fei Li <fei1.li@intel.com>, x86@kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Halil Pasic <pasic@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-fpga@vger.kernel.org, Zhi Wang <zhi.a.wang@intel.com>,
        Wu Hao <hao.wu@intel.com>, Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linuxppc-dev@lists.ozlabs.org, Eric Auger <eric.auger@redhat.com>,
        Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, cgroups@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        intel-gvt-dev@lists.freedesktop.org, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Benjamin LaHaise <bcrl@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Moritz Fischer <mdf@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Xu Yilun <yilun.xu@intel.com>, jaz@semihalf.com
Subject: Re: [PATCH 0/2] eventfd: simplify signal helpers
Message-ID: <ZLFovYocElAD7gJ0@ziepe.ca>
References: <20230630155936.3015595-1-jaz@semihalf.com>
 <20230714-gauner-unsolidarisch-fc51f96c61e8@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714-gauner-unsolidarisch-fc51f96c61e8@brauner>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jul 14, 2023 at 09:05:21AM +0200, Christian Brauner wrote:

> I have no skin in the game aside from having to drop this conversion
> which I'm fine to do if there are actually users for this btu really,
> that looks a lot like abusing an api that really wasn't designed for
> this.

Yeah, I think so too. The ACPI thing should use its own FD if it wants
to feed actual data..

Jason

