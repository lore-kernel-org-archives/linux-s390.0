Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD9C77B7D
	for <linux-s390@archiver.kernel.org>; Thu, 18 May 2023 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjERToZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 May 2023 15:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjERToZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 May 2023 15:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BC2E6D
        for <linux-s390@vger.kernel.org>; Thu, 18 May 2023 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684439025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PA8QlisVvQUIBeB7cAo5RqDhEmfbmuvIuFemkqkHNmY=;
        b=SG0KXQZH+iTbfzvk5mPOQOAxaiiFBHPnSXFGFiwj97pufkShBB/tk3JgU1OTxxmFgNij2B
        JhGXEDAH12MMWnmiPRMO+fZrVM93mL8RgLrjte01aJlkAWzNrgQUfMQ4Lny9p8pL6VvoIb
        DM05Dmcu04kFoNxyVs+tOBuQE3KdwBY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-Mz9fskwGOf2-ipRKj_D0dA-1; Thu, 18 May 2023 15:43:44 -0400
X-MC-Unique: Mz9fskwGOf2-ipRKj_D0dA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-76c3e89c73aso200306339f.1
        for <linux-s390@vger.kernel.org>; Thu, 18 May 2023 12:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684439023; x=1687031023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PA8QlisVvQUIBeB7cAo5RqDhEmfbmuvIuFemkqkHNmY=;
        b=h6OH7wC8cJKRTuBIWsUhdfU0T7gz7WuWgVDclrFoXjF6Yxyth0FbntIBKb01fPtOMa
         /ugzIICIDMRBAuFoyjp1gQbdtn2HyGxurEuZlb8gu6rERqbc5cOGFplMWq3jjpCaveDN
         43Mz+4tvutqeuIKrQxKQxeT5ZTLcCfsV6rxJJGPuU7g4hGHMufkZ+MvHQRs5CC3UpT4Y
         QZZTvd4SY45CT9rTcpi5i6DNTcOfUBHBD/DlD6+DeKeEUYlg+IdgXSnVZBEeUyN3lXyG
         s5RnXapIQXceLM/uIq1tjJ1PV0V9BEHgxCXK5YAgSA8Wd0DtLcfs6qNcBZNSLWehR2vr
         UsdA==
X-Gm-Message-State: AC+VfDyCKYLiiIxsOyqpOMgTHgjKX3MJqm2k2slp4yKx7PPuxB9SIEoE
        C3HBYf3CZeCxfIridlj9AzYD//hYLMQ6E0uIcRcoUBiKrj9XbOrgkHOBeMfnUr9s/vwN55fTm9A
        O7qpjnv8U2HgF/kJ3LrTiUsGPTYIs6A==
X-Received: by 2002:a5d:94cd:0:b0:76c:8a8f:edc2 with SMTP id y13-20020a5d94cd000000b0076c8a8fedc2mr7297142ior.12.1684439023154;
        Thu, 18 May 2023 12:43:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rw6SJnwSqjfCyaFRoKbONMXxWejcCpLIQx2vrAykC+soNBYYP2BWJo0LZ1SBw5bDgbglmXQ==
X-Received: by 2002:a5d:94cd:0:b0:76c:8a8f:edc2 with SMTP id y13-20020a5d94cd000000b0076c8a8fedc2mr7297117ior.12.1684439022870;
        Thu, 18 May 2023 12:43:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w31-20020a056638379f00b00405f36ed05asm636935jal.55.2023.05.18.12.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 12:43:41 -0700 (PDT)
Date:   Thu, 18 May 2023 13:43:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "clegoate@redhat.com" <clegoate@redhat.com>
Subject: Re: [PATCH v5 01/10] vfio-iommufd: Create iommufd_access for
 noiommu devices
Message-ID: <20230518134340.0a39629b.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529AD3369CE1F296086A607C37F9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230513132136.15021-1-yi.l.liu@intel.com>
        <20230513132136.15021-2-yi.l.liu@intel.com>
        <20230517112609.78a3e916.alex.williamson@redhat.com>
        <ZGUbAzl985p5kX1Z@nvidia.com>
        <DS0PR11MB7529AD3369CE1F296086A607C37F9@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 18 May 2023 12:23:29 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, May 18, 2023 2:21 AM
> > 
> > On Wed, May 17, 2023 at 11:26:09AM -0600, Alex Williamson wrote:
> >   
> > > It's not clear to me why we need a separate iommufd_access for
> > > noiommu.  
> > 
> > The point was to allocate an ID for the device so we can use that ID
> > with the other interfaces in all cases.  
> 
> I guess Alex's question is why adding a new pointer named noiommu_access
> while there is already the iommufd_access pointer named iommufd_access.

Yes, precisely.  Sorry that was confusing, we need the access for
noiommu but it's not clear why that access needs to be stored in a
separate pointer when we can already differentiate noiommu devices
otherwise.  Thanks,

Alex

