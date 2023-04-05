Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7925C7619A
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 15:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbjDEPR5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbjDEPRa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 11:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A36729E
        for <linux-s390@vger.kernel.org>; Wed,  5 Apr 2023 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680707691;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSbeq35rqJ3WHS2Hi/jg4P1mAmdjaUY8F18xUXAczgA=;
        b=gSSVyvFoUXCNoo/1byPgfTM1SY/JN2C4zt9KN+GOL0G+Kn8xt6tY5W0DEPbAahj6HyMC1X
        Bl8dDJJLNH75S63a6ueTu4B85ht30P07n6979m9YhnCSU/gmsYKmiKaTVUY4weNsTqyYwb
        H74iPdzCKmK19iZHhEaHekBZZaxh0PU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-YxCG4aQ_M2qTiCXNaA7FbA-1; Wed, 05 Apr 2023 11:14:43 -0400
X-MC-Unique: YxCG4aQ_M2qTiCXNaA7FbA-1
Received: by mail-qk1-f199.google.com with SMTP id 66-20020a370345000000b00746886b1593so16298875qkd.14
        for <linux-s390@vger.kernel.org>; Wed, 05 Apr 2023 08:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSbeq35rqJ3WHS2Hi/jg4P1mAmdjaUY8F18xUXAczgA=;
        b=LcbtiNlcsZBnMURkwNk1LlXn9kzxc7mMLX08UPbEBvVdR8kZDy0FGUqe21C36QBD2x
         CzrsvQDkHA0jartxXtAaAWr16ArRXF2OAkI+gJMkSVbh0c4Jb1rT50EXFaZDIn9OoHDX
         HhR5qXeebjfB3zTPDB7Ka3B8JKmuBMpgjf55vjcYJtMpnISQhhki+Xw12JSQcXRYOQrC
         pQSFrVKPpu4JcHSzL+HAdJkHBKD//7MtT7IfTuBcfV2cKTSNyim3CGeKq43Evfi5zK12
         227XjP8MMz0XA2ELYZ4jV/nK3gUow0qQys8x5e2VXUr9YqhQ7nOKFhhppMW6IWRsx2oO
         IUxA==
X-Gm-Message-State: AAQBX9f+4CBU3Ux92tbEJu39AAPOHvFSWyUuGbLXBUsajhcLa2Dlqs3K
        eD5xx1A0JS8au7Lc6ZovE6LgMybzesR1ZdUwiuOOBf+PQrwCggvqm2q2Z4vFzltmme/Q1mHDJjr
        u1Y/DFgCFT08hic85ENVMSA==
X-Received: by 2002:ac8:5cc5:0:b0:3d6:ff99:7e9e with SMTP id s5-20020ac85cc5000000b003d6ff997e9emr5229935qta.33.1680707682479;
        Wed, 05 Apr 2023 08:14:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zlgevm6Gpp8gQwtyz6Xv8+LMvLwjE1yHVNcDW2XGpmSXvtrNr59FUgRAfBeWw7meygfbGx0A==
X-Received: by 2002:ac8:5cc5:0:b0:3d6:ff99:7e9e with SMTP id s5-20020ac85cc5000000b003d6ff997e9emr5229887qta.33.1680707682097;
        Wed, 05 Apr 2023 08:14:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id i19-20020ac87653000000b003e38e2815a5sm4031551qtr.22.2023.04.05.08.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:14:39 -0700 (PDT)
Message-ID: <48208e9e-2721-bea5-3a5e-852e32185d34@redhat.com>
Date:   Wed, 5 Apr 2023 17:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 02/12] vfio/pci: Only check ownership of opened devices
 in hot reset
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
 <20230401144429.88673-3-yi.l.liu@intel.com>
 <844faa5c-2968-2a4f-8a70-900f359be1a0@redhat.com>
 <DS0PR11MB75290339DD0FD467146D4655C3939@DS0PR11MB7529.namprd11.prod.outlook.com>
 <fc87191d-2e79-83c3-b5ba-7f8b1083988a@redhat.com>
 <DS0PR11MB7529441450FE32DC9578C6B8C3939@DS0PR11MB7529.namprd11.prod.outlook.com>
 <5781064c-8742-d37d-57dc-7a7238e948d5@redhat.com>
 <ZC1eg8ZqwkfKuTDx@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZC1eg8ZqwkfKuTDx@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jason,

On 4/5/23 13:41, Jason Gunthorpe wrote:
> On Tue, Apr 04, 2023 at 05:59:01PM +0200, Eric Auger wrote:
>
>>> but the hot reset shall fail as the group is not owned by the user.
>> sure it shall but I fail to understand if the reset fails or the device
>> plug is somehow delayed until the reset completes.
> It is just racy today - vfio_pci_dev_set_resettable() doesn't hold any
> locks across the pci_walk_bus() check to prevent hot plug in while it is
> working on the reset.

OK thanks

Eric
>
> Jason
>

