Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726804AbfHPKpS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Aug 2019 06:45:18 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GAfd5V151358
        for <linux-s390@vger.kernel.org>; Fri, 16 Aug 2019 06:45:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2udrqwvvx1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 16 Aug 2019 06:45:16 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sebott@linux.ibm.com>;
        Fri, 16 Aug 2019 11:45:14 +0100
Date: Fri, 16 Aug 2019 12:45:09 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH v2 02/10] s390/pci: Loop using PCI_STD_NUM_BARS
In-Reply-To: <20190816092437.31846-3-efremov@linux.com>
References: <20190816092437.31846-1-efremov@linux.com> <20190816092437.31846-3-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1908161244060.1860@schleppi>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Denis Efremov <efremov@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Denis Efremov wrote:
> Refactor loops to use 'i < PCI_STD_NUM_BARS' instead of
> 'i <= PCI_STD_RESOURCE_END'.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  arch/s390/include/asm/pci.h     |  5 +----
>  arch/s390/include/asm/pci_clp.h |  6 +++---
>  arch/s390/pci/pci.c             | 16 ++++++++--------
>  arch/s390/pci/pci_clp.c         |  6 +++---
>  4 files changed, 15 insertions(+), 18 deletions(-)
> 

Acked-by: Sebastian Ott <sebott@linux.ibm.com>
