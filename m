Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A34C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  9 Dec 2021 05:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhLIFvF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:51:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232361AbhLIFvE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Dec 2021 00:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639028851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTAn1ztGmocc9lVa3A3/+M3LMLwmgt1eLb7L68uXAdc=;
        b=E8Z6RRx5gT5mcb7jnlunYCPofg6v/fj9Nllwn14Cf8dAknjiD0JqIM1Ekxja1n9VTxQh16
        ZZ8DpvM24nX87vmOTf5kHRE0HwXuSEOXSfeJwKzPn6mugFwWBuVyWZVsQdONDwUcgiZxWN
        JqWQbY6nhU3/EZDP8ZmsLpQ9j9IOeV8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-v5WqFo-rM1mDIlhLBXRimA-1; Thu, 09 Dec 2021 00:47:30 -0500
X-MC-Unique: v5WqFo-rM1mDIlhLBXRimA-1
Received: by mail-lf1-f69.google.com with SMTP id bq6-20020a056512150600b0041bf41f5437so2202462lfb.17
        for <linux-s390@vger.kernel.org>; Wed, 08 Dec 2021 21:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTAn1ztGmocc9lVa3A3/+M3LMLwmgt1eLb7L68uXAdc=;
        b=hKOSaIVxow8noXbEzHDe3H3TNW0LVOR5gGWGNFsXoJuf+gbwI2SEElx+lA6f9eIHF6
         PPMWe0OxrgEEp+6nQengJhNGP5J0C6z76NK0u4U19HykySmmmywm52l9zvoDl2pKZXWK
         jNHoZyD5sNmifYGieEjCvP1yKIL/vFZAclBXBCNWAHSBZwqMqqQoQn6ArskqT1cxwZRm
         z2hY2wCl+Meapmmoyo3zRlHK97cIZCIopiGGjauuONnGzZAFGYW6d3sALlrxpmMSMlMs
         1z1woN3XWRhH7wHJ98hsDKlaPX79sJGbEMHc35GCTcIL5+BSUntwNSfCy2ctwKAPWAUm
         oqzA==
X-Gm-Message-State: AOAM531UhUSBWqocmhPF9aAT6QAnORV0HEyAUrrmWLHh6mxB7KtC3i76
        XZy4GT0TzhnH5n8jhXRTbdHcePI/OOAGaa1/yWWkC78w0YyUAoUFcJPAyYMlGbj5XxRYaK+oHCa
        6Bbh8GwrjAZmQp9f6VBNrwa9BuOtrUN5nB+33oQ==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr4000047ljw.217.1639028848304;
        Wed, 08 Dec 2021 21:47:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwq/umBaPtYwDOFSZQvlFRjjQexm+OmnMnO6A8JPT/yt1E5P3J0cUOqEOEr99euJsOw+HZezXtE5wjdaUSNzOc=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr4000032ljw.217.1639028848143;
 Wed, 08 Dec 2021 21:47:28 -0800 (PST)
MIME-Version: 1.0
References: <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com> <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx> <20211202135502.GP4670@nvidia.com>
 <BN9PR11MB527696C0E8D08680FFFB6BAB8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB527696C0E8D08680FFFB6BAB8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Dec 2021 13:47:17 +0800
Message-ID: <CACGkMEv_b=WLUp1_fUtfaxo9_Y95x=u+Za2-sxTRrmXe-J_jRA@mail.gmail.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Dec 9, 2021 at 1:41 PM Tian, Kevin <kevin.tian@intel.com> wrote:
>
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, December 2, 2021 9:55 PM
> >
> > Further, there is no reason why IMS should be reserved exclusively for
> > VFIO!
>
> This is correct. Just as what you agreed with Thomas, the only difference
> between IMS and MSI is on where the messages are stored. Physically
> it is unreasonable for the HW to check whether an interrupt is used for
> a specific software usage (e.g. virtualization) since it doesn't have such
> knowledge. At most an entry is associated to PASID, but again the PASID
> can be used anywhere.

Note that vDPA had the plan to use IMS for the parent that can have a
huge amount of instances.

Thanks

>
> The wording in current IDXD spec is not clear on this part. We'll talk to
> the spec owner to have it fixed.
>
> Thanks
> Kevin
>

