Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0799C4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC48360F92
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 15:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhHWPRM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 11:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbhHWPRL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 11:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629731789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DN1b/ZryAIDQdlT9EYOFyEAWtXpqjUmEBD/b/C3QFkQ=;
        b=CdbPIEq3nX11WfwPTN6qcUKfceqMaA4jAW8mbp+gXioAFLhzH2IS6x+YhppjOXxV+5+0Rl
        6r3bPQotegA3ZCGShJSb7uUCrulJru3xvKXGm8o47bfOtbTVxFxhWnCc6SVUl3dKUp+OET
        lmZ0/4idaRa8Ds4rm9VPnfbxoSodXkI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-07biEgUWOVaeuH_pGj0DYQ-1; Mon, 23 Aug 2021 11:16:27 -0400
X-MC-Unique: 07biEgUWOVaeuH_pGj0DYQ-1
Received: by mail-ot1-f71.google.com with SMTP id v11-20020a056830140b00b0051af4c9ee9fso7095093otp.16
        for <linux-s390@vger.kernel.org>; Mon, 23 Aug 2021 08:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=DN1b/ZryAIDQdlT9EYOFyEAWtXpqjUmEBD/b/C3QFkQ=;
        b=UuXkBYL9vswjs0YoQSuOnx8EZwGD52+ZVxb+GUrNHSZKpZ76QWjLjeVpWppRWe6srm
         u9ef8RUy8iorTcu6G+aI1KwpaptaDlPEd+2veBt+cw2/L+Es01rxTUORSqiob8IOJ2ku
         L6LGByQOmkOhMOA6aeRGi8QEX6R1hfYTIq/wKxNFC0DlF5VzA2cC6VXuT7hdGdTuYVe+
         1w1NiQSydXlDyfXILoqVRani1MRodDnsnJEDfLYLto+Lg5ztRkEo1gnnJctSaijy1K7W
         //gT7iQHBJwpiLonm4AtQpwPS5xSwZFKzj+l0O7dd7pvkJwC4OivmFmEtK18oo3F1pZL
         UJpw==
X-Gm-Message-State: AOAM532u4CGtFhRNmqklSwqzMJNoRN5Hwb5Vws/3CAWRMMnunqJSDQlm
        IuJyf12RHJw4AntliuyBrHdWCzZ1AnYfyOg+VSHauJQsNL4EuqGfJ49AWXvUtm62zZARkRXUsaM
        zOIzg7lgPH/P/5cnzqQrS3w==
X-Received: by 2002:a05:6830:1dac:: with SMTP id z12mr24543873oti.52.1629731787082;
        Mon, 23 Aug 2021 08:16:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqOeF/H0qDGnn9D02GiZCSA4DRcSR8LiSLGylhEba8t1EsbxXzTz8dIto+iigT90XxNROCzg==
X-Received: by 2002:a05:6830:1dac:: with SMTP id z12mr24543850oti.52.1629731786895;
        Mon, 23 Aug 2021 08:16:26 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id x1sm2557766otu.8.2021.08.23.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 08:16:26 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:16:24 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <corbet@lwn.net>,
        <diana.craciun@oss.nxp.com>, <kwankhede@nvidia.com>,
        <eric.auger@redhat.com>, <masahiroy@kernel.org>,
        <michal.lkml@markovi.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <mgurtovoy@nvidia.com>, <jgg@nvidia.com>, <maorg@nvidia.com>,
        <leonro@nvidia.com>
Subject: Re: [PATCH V3 06/13] vfio/pci: Split the pci_driver code out of
 vfio_pci_core.c
Message-ID: <20210823091624.697c67d6.alex.williamson@redhat.com>
In-Reply-To: <20210822143602.153816-7-yishaih@nvidia.com>
References: <20210822143602.153816-1-yishaih@nvidia.com>
        <20210822143602.153816-7-yishaih@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, 22 Aug 2021 17:35:55 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> new file mode 100644
> index 000000000000..15474ebadd98
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci.c
...
> +static int vfio_pci_sriov_configure(struct pci_dev *pdev, int nr_virtfn)
> +{
> +	might_sleep();
> +
> +	if (!enable_sriov)
> +		return -ENOENT;
> +
> +	return vfio_pci_core_sriov_configure(pdev, nr_virtfn);
> +}

As noted in previous version, why do we need the might_sleep() above
when the core code below includes it and there's nothing above that
might sleep before that?  Thanks,

Alex

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 94f062818e0c..87d1960d0d61 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
...
> -static int vfio_pci_sriov_configure(struct pci_dev *pdev, int nr_virtfn)
> +int vfio_pci_core_sriov_configure(struct pci_dev *pdev, int nr_virtfn)
>  {
>  	struct vfio_device *device;
>  	int ret = 0;
>  
>  	might_sleep();
>  
> -	if (!enable_sriov)
> -		return -ENOENT;
> -
>  	device = vfio_device_get_from_dev(&pdev->dev);
>  	if (!device)
>  		return -ENODEV;

