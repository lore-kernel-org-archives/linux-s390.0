Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C9C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiETQ00 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351594AbiETQ0Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 12:26:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F138D5DE7C
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 09:26:22 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KEQH9k003251;
        Fri, 20 May 2022 16:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qkqC9bRaDrHhtBhEmuuoQ47+C1Qc8d9EHHsFjW6O1eQ=;
 b=AjOf+QJ4/FKRDvmFVwv4EpMGmH5ADDzQiVQDHNuSGjLfvqS5hPPFVvbvPvJQnxzTvEq2
 RfbXi5Ieq4BEHXLlwEmd+zLgH2fj2WGl5xs0pzHjdu/LdUDqLh/FOuMidPGVWKnnV8aW
 A153BGuwKBXWrapsEY+tP+yFzrl0pAKIwPfEDiOeULgyqtoCOxiK6NV6dgEyjj23OPV7
 xRbdXiASDxXbEgYUYQnxFSAbEvlBkTUegL5jDdHV65FmGorTQl+AaG5xTwtSIA7NENKg
 n1uvFf+9tfXnp944DnaRZx88nz84MntJs7/9AZ6rHcul23zkFm93vpbBldkZrCDtRpiO IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6crg2jam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:26:10 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24KGKNqQ018282;
        Fri, 20 May 2022 16:26:10 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6crg2ja5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:26:10 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KGD0cd000663;
        Fri, 20 May 2022 16:26:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3g2428ye37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:26:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KGQ5UG42467588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 16:26:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 194B811C04A;
        Fri, 20 May 2022 16:26:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02E0B11C04C;
        Fri, 20 May 2022 16:26:04 +0000 (GMT)
Received: from sig-9-145-82-10.uk.ibm.com (unknown [9.145.82.10])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 16:26:03 +0000 (GMT)
Message-ID: <dd2d49bb798effaeac55f4bf3625f376bb1abda0.camel@linux.ibm.com>
Subject: Re: s390-iommu.c default domain conversion
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>
Date:   Fri, 20 May 2022 18:26:03 +0200
In-Reply-To: <20220520155649.GJ1343366@nvidia.com>
References: <20220509233552.GT49344@nvidia.com>
         <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
         <20220510160911.GH49344@nvidia.com>
         <ef9f26c6a017b479610fcd7a7b93bb07815b89fd.camel@linux.ibm.com>
         <20220520134414.GH1343366@nvidia.com>
         <6271dd24bfcf82b0c1b911a163ae9549c24691a4.camel@linux.ibm.com>
         <20220520155649.GJ1343366@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ez1vTNmtBsB3rRivXzucOswfV5npGokR
X-Proofpoint-ORIG-GUID: 3i0tOx15cWfzu4GPV8ZGqEtxVfV9aOXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_04,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 mlxlogscore=672 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200106
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 2022-05-20 at 12:56 -0300, Jason Gunthorpe wrote:
> On Fri, May 20, 2022 at 05:17:05PM +0200, Niklas Schnelle wrote:
> 
> > > > With that the performance on the LPAR machine hypervisor (no paging) is
> > > > on par with our existing code. On paging hypervisors (z/VM and KVM)
> > > > i.e. with the hypervisor shadowing the I/O translation tables, it's
> > > > still slower than our existing code and interestingly strict mode seems
> > > > to be better than lazy here. One thing I haven't done yet is implement
> > > > the map_pages() operation or adding larger page sizes. 
> > > 
> > > map_pages() speeds thiings up if there is contiguous memory, I'm not
> > > sure what work load you are testing with so hard to guess if that is
> > > interesting or not.
> > 
> > Our most important driver is mlx5 with both IP and RDMA traffic on
> > ConnectX-4/5/6 but we also support NVMes.
> 
> So you probably won't see big gains here from larger page sizes unless
> you also have a specific userspace that is trigger huge pages.
> 
> qemu users spaces do this so it is worth doing anyhow though.
> 
> > > > Maybe you have some tips what you'd expect to be most beneficial?
> > > > Either way we're optimistic this can be solved and this conversion
> > > > will be a high ranking item on my backlog going forward.
> > > 
> > > I'm not really sure I understand the differences, do you have a sense
> > > what is making it slower? Maybe there is some small feature that can
> > > be added to the core code? It is very strange that strict is faster,
> > > that should not be, strict requires synchronous flush in the unmap
> > > cas, lazy does not. Are you sure you are getting the lazy flushes
> > > enabled?
> > 
> > The lazy flushes are the timer triggered flush_iotlb_all() in
> > fq_flush_iotlb(), right? I definitely see that when tracing my
> > flush_iotlb_all() implementation via that path. That flush_iotlb_all()
> > in my prototype is basically the same as the global RPCIT we did once
> > we wrapped around our IOVA address space. I suspect that this just
> > happens much more often with the timer than our wrap around and
> > flushing the entire aperture is somewhat slow because it causes the
> > hypervisor to re-examine the entire I/O translation table. On the other
> > hand in strict mode the iommu_iotlb_sync() call in __iommu_unmap()
> > always flushes a relatively small contiguous range as I'm using the
> > following construct to extend gather:
> > 
> > 	if (iommu_iotlb_gather_is_disjoint(gather, iova, size))
> > 		iommu_iotlb_sync(domain, gather);
> > 
> > 	iommu_iotlb_gather_add_range(gather, iova, size);
> > 
> > Maybe the smaller contiguous ranges just help with locality/caching
> > because the flushed range in the guests I/O tables was just updated.
> 
> So, from what I can tell, the S390 HW is not really the same as a
> normal iommu in that you can do map over IOVA that hasn't been flushed
> yet and the map will restore coherency to the new page table
> entries. I see the zpci_refresh_trans() call in map which is why I
> assume this?

The zpci_refresh_trans() in map is only there because previously we
didn't implement iotlb_sync_map(). Also, we only need to flush on map
for the paged guest case so the hypervisor can update its shadow table.
It happens unconditionally in the existing s390_iommu.c because that
was not well optimized and uses the same s390_iommu_update_trans() for
map and unmap. We had the skipping of the TLB flush handled properly in
the arch/s390/pci_dma.c mapping code where !zdev->tlb_refresh indicates
that we don't need flushes on map.

> 
> (note that normal HW has a HW IOTLB cache that MUST be flushed or new
> maps will not be loaded by the HW, so mapping to areas that previously
> had uninvalidated IOVA is a functional problem, which motivates the
> design of this scheme)

We do need to flush the TLBs on unmap. The reason is that under LPAR
(non paging hypervisor) the hardware can establish a new mapping on its
own if an I/O PTE is changed from invalid to a valid translation and it
wasn't previously in the TLB. I think that's how most hardware IOMMUs
work and how I understand your explanation too.

> 
> However, since S390 can restore coherency during map the lazy
> invalidation is not for correctness but only for security - to
> eventually unmap things that the DMA device should not be
> touching?

As explained above it is for correctness but with the existing code we
handle this slightly differently. As we go through the entire IOVA
space we're never reusing a previously unmapped IOVA until we run out
of IOVAs. Then we do a global flush which on LPAR just drops the
hardware TLBs making sure that future re-uses of IOVAs will trigger a
harware walk of the I/O translation tables. Same constraints just a
different scheme.


