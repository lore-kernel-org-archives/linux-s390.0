Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C9C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 13:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349557AbiETNGL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349703AbiETNGC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 09:06:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294F27C
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 06:05:58 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KCFfub026911;
        Fri, 20 May 2022 13:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tb8DHhk+OnBjTRCb9cZfkaNM8zxaUn8vOGl//v3TL0U=;
 b=OBPyD/z//ywcR6GbWFvGewfWKwyyVMsN0CCXwF7HlVk3oXR1QNBvsdpp9Np07e+jvejj
 u8Lj3xB8H5AImyQu7ERsNecKraO648q5G4vkyjUcRPHehdXJ41UJCGOSVAZ5Wk5fl/En
 hTKNC8iBbQ26cqijORkjI7cAvEQiGyf1NC9vJrZl1JbAYtM9r8Fv302NQxySK+560cbw
 Y0/toI4Gktleru8yvwC/n+OfA4fnYypcdJ9g/aL/tUli/u+JCeZdPwhkowJto2yWgxp9
 Mv9WwcWLO6YJt9VyGU32tB4jRA/RW7GLwtaUmZgfpjBRwnPLrI8loKWndMtp4cFknxN+ RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6au1s03a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 13:05:54 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24KCFnYP027834;
        Fri, 20 May 2022 13:05:53 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6au1s02p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 13:05:53 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KD2rLo023105;
        Fri, 20 May 2022 13:05:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3g4j3gke7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 13:05:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KD5mdW17629540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 13:05:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C43134C044;
        Fri, 20 May 2022 13:05:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34AB64C040;
        Fri, 20 May 2022 13:05:47 +0000 (GMT)
Received: from sig-9-145-82-10.uk.ibm.com (unknown [9.145.82.10])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 13:05:47 +0000 (GMT)
Message-ID: <ef9f26c6a017b479610fcd7a7b93bb07815b89fd.camel@linux.ibm.com>
Subject: Re: s390-iommu.c default domain conversion
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>
Date:   Fri, 20 May 2022 15:05:46 +0200
In-Reply-To: <20220510160911.GH49344@nvidia.com>
References: <20220509233552.GT49344@nvidia.com>
         <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
         <20220510160911.GH49344@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r63ZO87rT0Eupwd0HtkylhrORa3wZph5
X-Proofpoint-ORIG-GUID: XOVz8KJKstj9QiJ1qF3S5qcxJyj3ZXQX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200094
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 2022-05-10 at 13:09 -0300, Jason Gunthorpe wrote:
> On Tue, May 10, 2022 at 11:25:54AM -0400, Matthew Rosato wrote:
> > On 5/9/22 7:35 PM, Jason Gunthorpe wrote:
> > > Hi s390 folks/Matthew
> > > 
> > > Since everyone is looking at iommu support for the nested domains,
> > > could we also tackle the default domain conversion please? s390 is one
> > > of the last 4 drivers that need it.
> > > 
> > >  From what I can see it looks like when detach_dev() is called it
> > > expects the platform's dma_ops to work in arch/s390/pci/pci_dma.c ?
> > 
> > Yes
> > 
> > > Has anyone thought about converting the dma_ops to use the normal DMA
> > > API iommu support and run it through the iommu driver instead of
> > > through the dma_ops?
> > > 
> > > Alternatively perhaps we can keep the dma_ops with some iommu
> > > side-change.
> > 
> > It has come up before.  So ultimately the goal is to be driving the dma
> > through the default iommu domain (via dma-iommu) rather than directly in the
> > dma_ops?  One of our main concerns is performance loss from s390-ism
> > optimizations in the dma_ops like RPCIT avoidance / lazy map +
> > global flush
> 
> The core version is somewhat different, it triggers the
> iotlb_flush_all from a timer, not just on address space wrap around,
> but the fast path on unmap can still skip the zpci_refresh_trans().
> 
> On the other hand it doesn't have the limit of iova space, and the
> iova allocator is somewhat more sophisticated which will optimize
> large page cases that s390 currently doesn't. Basically it will work
> better with things like mlx5 cards in the normal case.
> 
> The lasy flush is done via the IOMMU_DOMAIN_DMA_FQ and the iommu gather->queued
> stuff to allow skipping the RCPIT during the normal iotlb_sync.
> 
> > I think the reality is that Niklas and I need to have a close look and do
> > some testing on our end to see what it will take and if we can get
> > acceptable performance from a conversion, then get back to you.
> 
> It would be a good long term goal, getting rid of these duplicated
> dma_ops is another open task. There is a patch series out there to
> convert arm, so this whole area will become even more niche.
> 
> But another path is to somehow keep them and just allow default
> domains to work - ARM did this.
> 
> Jason

I did some testing and created a prototype that gets rid of
arch/s390/pci_dma.c and works soley via dma-iommu on top of our IOMMU
driver. It looks like the existing dma-iommu code allows us to do this
with relatively simple changes to the IOMMU driver only, mostly just
implementing iotlb_sync(), iotlb_sync_map() and flush_iotlb_all() so
that's great. They also do seem to map quite well to our RPCIT I/O TLB
flush so that's great. For now the prototype still uses 4k pages only.

With that the performance on the LPAR machine hypervisor (no paging) is
on par with our existing code. On paging hypervisors (z/VM and KVM)
i.e. with the hypervisor shadowing the I/O translation tables, it's
still slower than our existing code and interestingly strict mode seems
to be better than lazy here. One thing I haven't done yet is implement
the map_pages() operation or adding larger page sizes. Maybe you have
some tips what you'd expect to be most beneficial? Either way we're
optimistic this can be solved and this conversion will be a high
ranking item on my backlog going forward.

I also stumbled over the following patch series which I think would
also help our paging hypervisor cases a lot since it should alleviate
the cost of shadowing short lived mappings:

https://lore.kernel.org/linux-iommu/20210806103423.3341285-1-stevensd@google.com/

Sadly it seems it hasn't gained much traction so far.

Thanks,
Niklas

