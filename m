Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C21EB64D8
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jun 2023 14:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbjFMOeH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbjFMOdm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jun 2023 10:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2F6E7A
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686666777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOBe3u1s+eJFktwias29L+WsMYtJMq4jH6Tw+Vkgi2s=;
        b=S1TMnUQcbrI/9JC+th7jCBHdp1Q4Xcz2wCUZ8BFXpNt7TFq+F12jEYXLOv0h9AufZCNx6k
        +7VwXnTpwX1SHNehhQlTjNgynCIPxIbXIJki6i6lsLDCN8PkdoC0HxVZPYFK/UeddLUvxy
        i9vtMZc62y9ULDIRF+53WWl1VGS6KkM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-UzMlfo1wPWG7NOxBk_6zSA-1; Tue, 13 Jun 2023 10:32:43 -0400
X-MC-Unique: UzMlfo1wPWG7NOxBk_6zSA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-77a1335cf04so761451839f.3
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666751; x=1689258751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOBe3u1s+eJFktwias29L+WsMYtJMq4jH6Tw+Vkgi2s=;
        b=eoPHkCPFViNnj1uaDNJKm3ggqVlOS+k85pmQNoyFWkt/gZSwAcyNov5W0oT5sZZmFe
         7NanbnR/7PRlOQVYMx8j0YgO2e6v1AeuV9j1BtnXjaM5qmyhDyMb/03fq+3i4iOn9bta
         h2qHCLkEwJd5rWidpHM0qLi8BNDrYdLY1PwrWbBlcUMl8/W+u1CWFBkW8WWrgT4z3bH9
         tweUAwU3MFpQQjzKMYYiGs0slwlPomlNf37DZ0kosUsgZ5dZqGP3PkHmKuF8EjFo1NbW
         53mbrbhhbr+Akcq16A8PEIkPf12bEgBWGQtInVc/sidqzkYRYYjS4UlnCn9SIzSNiolu
         QbGA==
X-Gm-Message-State: AC+VfDzckiLCHOeuoH1INpgVVnRW+GC0SoGvOr2qanBbzmV0B6bH6hKS
        1kuKlNQjpId++ilzhXKYGWtBeDcznQmXM4zRCI9uafu3lspVPkSMPLW4Vf70BeRMhxmLRAKeRDU
        ifZBGYzmsu+Lw5d1rwZ4vzA==
X-Received: by 2002:a5e:9509:0:b0:77a:1307:1e4e with SMTP id r9-20020a5e9509000000b0077a13071e4emr12425278ioj.18.1686666750951;
        Tue, 13 Jun 2023 07:32:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4252UgzyjwK/6JESBkuqoz4Fs2H4UTz+cTpv5sInamQj+vl124qFJiPwRZfg1A0weA4qrYTA==
X-Received: by 2002:a5e:9509:0:b0:77a:1307:1e4e with SMTP id r9-20020a5e9509000000b0077a13071e4emr12425253ioj.18.1686666750721;
        Tue, 13 Jun 2023 07:32:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c7-20020a6bfd07000000b00760f256037dsm3847559ioi.44.2023.06.13.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:32:30 -0700 (PDT)
Date:   Tue, 13 Jun 2023 08:32:29 -0600
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
Subject: Re: [PATCH v7 8/9] vfio/pci: Extend
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO for vfio device cdev
Message-ID: <20230613083229.44a3f3ec.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529CFADCF0D6D6451E4F92AC355A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230602121515.79374-1-yi.l.liu@intel.com>
        <20230602121515.79374-9-yi.l.liu@intel.com>
        <ZIhXMmYjCyUdlGxe@nvidia.com>
        <DS0PR11MB7529CFADCF0D6D6451E4F92AC355A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Jun 2023 12:50:43 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, June 13, 2023 7:47 PM
> > 
> > On Fri, Jun 02, 2023 at 05:15:14AM -0700, Yi Liu wrote:  
> > > +/*
> > > + * Return devid for a device which is affected by hot-reset.
> > > + * - valid devid > 0 for the device that is bound to the input
> > > + *   iommufd_ctx.
> > > + * - devid == VFIO_PCI_DEVID_OWNED for the device that has not
> > > + *   been bound to any iommufd_ctx but other device within its
> > > + *   group has been bound to the input iommufd_ctx.
> > > + * - devid == VFIO_PCI_DEVID_NOT_OWNED for others. e.g. device
> > > + *   is bound to other iommufd_ctx etc.
> > > + */
> > > +int vfio_iommufd_device_hot_reset_devid(struct vfio_device *vdev,
> > > +					struct iommufd_ctx *ictx)
> > > +{
> > > +	struct iommu_group *group;
> > > +	int devid;
> > > +
> > > +	if (vfio_iommufd_device_ictx(vdev) == ictx)
> > > +		return vfio_iommufd_device_id(vdev);
> > > +
> > > +	group = iommu_group_get(vdev->dev);
> > > +	if (!group)
> > > +		return VFIO_PCI_DEVID_NOT_OWNED;
> > > +
> > > +	if (iommufd_ctx_has_group(ictx, group))
> > > +		devid = VFIO_PCI_DEVID_OWNED;
> > > +	else
> > > +		devid = VFIO_PCI_DEVID_NOT_OWNED;
> > > +
> > > +	iommu_group_put(group);
> > > +
> > > +	return devid;
> > > +}
> > > +EXPORT_SYMBOL_GPL(vfio_iommufd_device_hot_reset_devid);  
> > 
> > This function really should not be in the core iommufd.c file - it is
> > a purely vfio-pci function - why did you have to place it here?  
> 
> Put it here can avoid calling iommufd_ctx_has_group() in vfio-pci,
> which requires to import IOMMUFD_NS. If this reason is not so
> strong I can move it back to vfio-pci code.

The PCI-isms here are the name of the function and the return value,
otherwise this is simply a "give me the devid for this device in this
context".  The function name is trivial to change and we can define the
internal errno usage such that the vfio-pci-core code can interpret the
correct uAPI value.  For example, -EXDEV ("Cross-device link") could
maybe be interpreted as owned and any other errno is not-owned, -ENODEV
maybe being the default.

Errno values are often contentious, are there other suggestions?
Thanks,

Alex

