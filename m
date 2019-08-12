Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38744 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLVHA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Aug 2019 17:07:00 -0400
Subject: Re: [PATCH 2/7] s390/pci: Replace PCI_BAR_COUNT with PCI_STD_NUM_BARS
References: <20190811150802.2418-1-efremov@linux.com>
 <20190811150802.2418-3-efremov@linux.com> <20190812200201.GC11785@google.com>
From: Denis Efremov <efremov@linux.com>
Message-ID: <a23079db-e130-e3b5-deee-ff7c06d9191e@linux.com>
Date: Tue, 13 Aug 2019 00:06:55 +0300
MIME-Version: 1.0
In-Reply-To: <20190812200201.GC11785@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> 
> There's a loop just below here that should be rewritten in the typical
> style:
> 
>         i = PCI_IOV_RESOURCES;
>         for (; i < PCI_SRIOV_NUM_BARS + PCI_IOV_RESOURCES; i++) {
>                 len = pci_resource_len(pdev, i);
> 
> Again, not strictly related to this patch, but probably trivial enough
> to do in the same patch.
> 

I think it's already fixed in a separate patch https://lkml.org/lkml/2019/8/6/694
Thanks for the review, I will send v2.

Denis
