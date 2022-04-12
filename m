Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49380C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 13:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353245AbiDLNby (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbiDLNbv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 09:31:51 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DC9FD3B
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 06:29:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r25so5741812qtp.8
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=utHfHRuEPsFSz+t+xVfjXy9ka6MMfgaIZASNpR7InEI=;
        b=SxlfMPQPhz+k04tLf1e3BiEJDZeTeSTHtmTmHpU/IotpKeudy7b1diCTvh0ntAbJmg
         +AHt6cJnIoJiag2v2tCfGYjXHyS5MMQFahb4J4exdhP+HvXug+HGUrqhFW74n4LXWGCu
         8JOpmoawvLnfHkdQneaEVx5KiqZ+gdSlZGfg/O018VShj4JdRwdflY/sPFMN0+0NHwKR
         8E+A6g3UnmsZoQG1EMLXQaoIlKNPycu4cyR+RVvWJ4Uqu+ZfHBJLF95ckXrfwm1yc6+9
         YPqAZ8NWvwoEW10PTJm2+WVwyfXBiaPh1RI/YAe1aWtg+jYvUMq0n4WvxIM9FV4rpTCn
         LOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=utHfHRuEPsFSz+t+xVfjXy9ka6MMfgaIZASNpR7InEI=;
        b=L2lfKoSgdNio3RP220hmk6yIFd4Gsgi+H4BXyohhMB+GsXN+lRhEoM+iMxDCsr05MV
         O06xuyjZHh5K7MCc3GBQwO5MzOIayM3zxinzs1hbA474D1vDMEut5qmph10qp4H60K61
         qOULy/sCUXZlCCgIu/aag0QT6q+akHCcmjFHAOjdKq1e9JYOeySM0DNdUxBLKjLnPCbi
         FJMfaqlbh2LeOHVCfiHaDCLRwRc8aDZOz6nci5J2ppqYTTRC7KtSWx0s7/ufP85Jdg/6
         x/PTLuZYCoQN7kbLNgj4wVFzZD5sprvbuxrCtEMBuN69VBvoLININN445ibpoh47i4d8
         8T9w==
X-Gm-Message-State: AOAM533XBow8LPVJY2rmP4IR4PQss4LUwpTQQH6xbbrkNu0W+276VKvH
        wV0b2xNnR2uU4Eh46AMmroD0gQ==
X-Google-Smtp-Source: ABdhPJzR1/3qgAB9udxtprYbf3EHazhFycozkIuHDQce9GFcvxEpv9Sv2My0uQTgIIcCUEot20+ozg==
X-Received: by 2002:ac8:7ca2:0:b0:2eb:db4c:1b53 with SMTP id z2-20020ac87ca2000000b002ebdb4c1b53mr3155060qtv.307.1649770171417;
        Tue, 12 Apr 2022 06:29:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a4-20020a37b104000000b0069c2ba88bdasm2820895qkf.85.2022.04.12.06.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:29:30 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1neGaH-000nVL-7x; Tue, 12 Apr 2022 10:29:29 -0300
Date:   Tue, 12 Apr 2022 10:29:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, schnelle@linux.ibm.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, frankja@linux.ibm.com,
        david@redhat.com, imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 15/21] KVM: s390: pci: add routines to start/stop
 interpretive execution
Message-ID: <20220412132929.GC64706@ziepe.ca>
References: <20220404174349.58530-1-mjrosato@linux.ibm.com>
 <20220404174349.58530-16-mjrosato@linux.ibm.com>
 <20220408124707.GY64706@ziepe.ca>
 <b143e333-0add-8042-12de-7e9e8b275ec0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b143e333-0add-8042-12de-7e9e8b275ec0@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 12, 2022 at 09:14:36AM -0400, Matthew Rosato wrote:
> On 4/8/22 8:47 AM, Jason Gunthorpe wrote:
> > On Mon, Apr 04, 2022 at 01:43:43PM -0400, Matthew Rosato wrote:
> > > +int kvm_s390_pci_register_kvm(struct device *dev, void *data)
> > > +{
> > > +	struct zpci_dev *zdev = NULL;
> > > +	struct kvm *kvm = data;
> > > +
> > > +	/* Only proceed for zPCI devices, quietly ignore others */
> > > +	if (dev_is_pci(dev))
> > > +		zdev = to_zpci_dev(dev);
> > > +	if (!zdev)
> > > +		return 0;
> > 
> > Especially since this only works if we have zpci device
> > 
> > So having the zpci code hook the kvm notifier and then call the arch
> > code from the zpci area seems pretty OK
> > 
> > Also why is a struct kvm * being passed as a void *?
> 
> Only because the function is intended to be called via
> iommu_group_for_each_dev (next patch) which requires int (*fn)(struct device
> *, void *)

I think this further says this should be called from vfio on the
actual struct device that is assigned to the KVM, not try to deduce it
from the gorup..

Jason
