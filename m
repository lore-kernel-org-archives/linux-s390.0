Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87012ECAAD5
	for <linux-s390@archiver.kernel.org>; Tue, 30 Aug 2022 23:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH3XxX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiH3XxW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Aug 2022 19:53:22 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E36F573
        for <linux-s390@vger.kernel.org>; Tue, 30 Aug 2022 16:53:20 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y18so9845890qtv.5
        for <linux-s390@vger.kernel.org>; Tue, 30 Aug 2022 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=0L9lzbhkZzftrSeDaWijQDCQO9j3SGBYGuP12lwKrD4=;
        b=abU+GXUqXS02jbKnf2PRzA2SplEPWEhWBJXpAj1du50snC84YOMDGmANpop4r2D5RI
         A4U3zwrxmKzP85VmYMfLmMr9d8tg6zzPw06qrOb8xn1+gH+99+F/OqVnG6/Lre9KSBn4
         zo1W9hlGuorJ3UbplvrCJJ7kZsv0daqDi0GQGmd0ruLNnRpZj56ErHB8VXLg1xOm3LHq
         maRIgx82QxWYjhHSesGndBYpHaVl6id5aHSVMfdeECEz4kib+EUHa1ZBuE/1RPBUFsgE
         JcJxShe4TJ5UBGVmwQuxC4y1kwMf2mv/hIY9Ot37rDwVObnAzUnFQD20KAt94BvvUosg
         gM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0L9lzbhkZzftrSeDaWijQDCQO9j3SGBYGuP12lwKrD4=;
        b=y/RxqpZChODcVlfZhECKsinQ9db+jjX3NZpORLDlgHRUCJFrCGewIzXFAxKGmdjq7Y
         tqjruwg1n7wO0/Nqzu13KOHaaiVcKILmsabN6/PnqDDepVmy0TKk+eqK8n8cpw6uDC4s
         2R2QniASD9UIaIobyAv0BaMlohVPfrZWQHjZ4wRhTWZWpc0xRyFFn11FL83XUfgHg5vO
         7oHCd/sIyA3PKMMnRrAEWRoIwq2XFf2dPOMN7NE9+e4RhhZZ/3IpCH4z+oNMgr3hYB2e
         vhKjeyW7HeZnwXy4whh8ZmJ/4nyiaDzSgw99G3jMFwaR51AuPUpERsIAbIYZsrxsPstX
         2YZg==
X-Gm-Message-State: ACgBeo2xUMjXfjshbzbKpnlfmgKbj6StCzOz/rTK5Pb9rla5mzs/dquD
        RwL0+4cVsB/QEywIDDjGWHEcwQ==
X-Google-Smtp-Source: AA6agR6SnhQJ6ZIIgoEC6fgDH1kdHhhz4b0pJAYeL3h92b1z66EiWbI66KVBnDlLAl7TgsI8hPuL0g==
X-Received: by 2002:a05:622a:195:b0:344:5630:dcc with SMTP id s21-20020a05622a019500b0034456300dccmr17037439qtw.598.1661903599526;
        Tue, 30 Aug 2022 16:53:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a0d8d00b006b942f4ffe3sm1800753qkl.18.2022.08.30.16.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:53:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oTB2j-0040T4-8t;
        Tue, 30 Aug 2022 20:53:17 -0300
Date:   Tue, 30 Aug 2022 20:53:17 -0300
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
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 15/15] vfio: Add struct device to vfio_device
Message-ID: <Yw6i7btDKcUDPADP@ziepe.ca>
References: <20220827171037.30297-1-kevin.tian@intel.com>
 <20220827171037.30297-16-kevin.tian@intel.com>
 <20220830161838.4aa47045.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830161838.4aa47045.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 30, 2022 at 04:18:38PM -0600, Alex Williamson wrote:
> On Sun, 28 Aug 2022 01:10:37 +0800
> Kevin Tian <kevin.tian@intel.com> wrote:
> 
> > From: Yi Liu <yi.l.liu@intel.com>
> > 
> > and replace kref. With it a 'vfio-dev/vfioX' node is created under the
> > sysfs path of the parent, indicating the device is bound to a vfio
> > driver, e.g.:
> > 
> > /sys/devices/pci0000\:6f/0000\:6f\:01.0/vfio-dev/vfio0
> > 
> > It is also a preparatory step toward adding cdev for supporting future
> > device-oriented uAPI.
> 
> Shall we start Documentation/ABI/testing/vfio-dev now?  Thanks.

I always thought that was something to use when adding new custom
sysfs attributes?

Here we are just creating a standard struct device with its standard
sysfs?

Jason
