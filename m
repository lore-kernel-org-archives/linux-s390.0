Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB38EC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 29 Sep 2022 17:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiI2RuC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiI2RuB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Sep 2022 13:50:01 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877FE1276F
        for <linux-s390@vger.kernel.org>; Thu, 29 Sep 2022 10:49:59 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id i12so1383988qvs.2
        for <linux-s390@vger.kernel.org>; Thu, 29 Sep 2022 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xa8hoH9SnDPlJIeXGYh843CRJD1tjWdMf/dTq8TipPM=;
        b=TTqX1qhbwY8oXLjTYWELHEsRERRC+tYA4I14qRpviPTnMPxxd/vPEPS/znbsofO0+c
         4bwTdW8+z/pWbH07euOuLtVPnrXYN4FM3+Cx3+6df9BnwzMRVSyQ1vC15hIyhMjMipuQ
         qlzZ7Fu4h7IQcnc4aD13PnswpHL+dCBN4e0DgSfgytTo+Borsg650FpgD3ZVlkkzogU1
         opPTvDdjbXUTLZKa0F4b83jrDhZt81cEI/hRhpm0Bun+0Wq7SRl0wOcvarlvT3D7N0e1
         b7XskLXtlA/O+SKSR/BQgRPL969bnpg4P6x3JIZubcOO7fHzsFTljemfyNnz/GZSpyiX
         iL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xa8hoH9SnDPlJIeXGYh843CRJD1tjWdMf/dTq8TipPM=;
        b=4dcuk60p+14xE+9ujKNJtFl8LtJdGOzYF2jqDktEmT1dS2pg6iOboEgUG/Mkizscry
         D/ayuCNXCdXPtqweLheq1RgzI207oLtz8Iv2g4rcseA/AGXLC3rWh1mNBHZLZBUU7xgL
         oSnWLIBT3X653oBy0lrMw8X1a6b/tZmTyIJgAUCPVyBl9P7tUPia7EK9XH2IhtvAQPfw
         Np+G5SR3X54G/qdrER2pVRoKkNzeEctGlYkkWtSSAB2U8rUcYez1Qh2KgxvtW5IMW9dI
         l0s2hwx9rZmhs7X1JLYKU1cQ1ANbVo8Aa42Yvk6q4BoLYgiCZvN0Q4rixMstHPOJ8tfp
         I7dg==
X-Gm-Message-State: ACrzQf1sNOkCMETnNBnwg95LihHAiSx270nzKmSTnKQ1Ghm7YItkl0bU
        H8BSlDpFyo7+Q4gjbnll9Iz4JQ==
X-Google-Smtp-Source: AMsMyM7Xarezc23TZVeEEbR3Uk9puQBAc1mIn47qgL8JGhJP31afpTjPWuOiERJgd9lOx+IPbEN2Vg==
X-Received: by 2002:a05:6214:3006:b0:496:ad87:6784 with SMTP id ke6-20020a056214300600b00496ad876784mr3557984qvb.7.1664473798680;
        Thu, 29 Sep 2022 10:49:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id 85-20020a370758000000b006ceb8f36302sm6929qkh.71.2022.09.29.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:49:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1odxfY-003fcM-BW;
        Thu, 29 Sep 2022 14:49:56 -0300
Date:   Thu, 29 Sep 2022 14:49:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 15/15] vfio: Add struct device to vfio_device
Message-ID: <YzXaxPpkc+90Xx+T@ziepe.ca>
References: <20220921104401.38898-1-kevin.tian@intel.com>
 <20220921104401.38898-16-kevin.tian@intel.com>
 <20220929105519.5c9ae1d8.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929105519.5c9ae1d8.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 29, 2022 at 10:55:19AM -0600, Alex Williamson wrote:
> Hi Kevin,
> 
> This introduced the regression discovered here:
> 
> https://lore.kernel.org/all/20220928125650.0a2ea297.alex.williamson@redhat.com/
> 
> Seems we're not releasing the resources when removing an mdev.  This is
> a regression, so it needs to be fixed or reverted before the merge
> window.  Thanks,

My guess at the fix for this:

https://lore.kernel.org/r/0-v1-013609965fe8+9d-vfio_gvt_unregister_jgg@nvidia.com

Jason
