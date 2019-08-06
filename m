Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728756AbfHFSLp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Aug 2019 14:11:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76I21q8126574
        for <linux-s390@vger.kernel.org>; Tue, 6 Aug 2019 14:11:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7dq42d7w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 06 Aug 2019 14:11:44 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sebott@linux.ibm.com>;
        Tue, 6 Aug 2019 19:11:41 +0100
Date: Tue, 6 Aug 2019 20:11:36 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH] s390/pci: PCI_IOV_RESOURCES loop refactoring in
 zpci_map_resources
In-Reply-To: <20190806160137.29275-1-efremov@linux.com>
References: <20190806160137.29275-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1908062009230.2835@schleppi>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Denis Efremov <efremov@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019, Denis Efremov wrote:
> This patch alters the for loop iteration scheme in zpci_map_resources
> to make it more usual. Thus, the patch generalizes the style for
> PCI_IOV_RESOURCES iteration and improves readability.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied for inclusion via s390/linux.git . Thanks!

Sebastian
