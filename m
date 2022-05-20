Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1587C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 15:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiETPRX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 11:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbiETPRW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 11:17:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C333177892
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 08:17:20 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KF86Xg003407;
        Fri, 20 May 2022 15:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fZd1v8a21OgNx7Y06/f+KATzpqPZvl964jOlMG8dWk0=;
 b=njn4ajsdXK/WV7Zq5+kwwm0/vSaq6CUzqw1mUQmfO6ZA9GQaKOigm22TZkpsC+cnNNeh
 w8thuWGm4d1w8vR74VwqBQVNPEUhhr0Lu3z/ULrKGNHeZJw2iqpesZlLrw3nVeDF66EM
 Tel1RVpcvCA5EvLydNUPOT6Xr2lId8xQc8NSPj6HGg8baTp32ndZKlVdFWZsfIdSG3q9
 vi+W8aVeqvW8uimycjjT6Jn7NfGdkxSaQJuxtPmloHS7WLURT6priMmNNz2OSnxhqkLY
 qcbP+H0KBRgCsHaAP0fy/lpNcoDvO8V2jgVocabu7eqJTrDR9xiSj94ejsLkVVJb1dra +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6awnc0xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 15:17:13 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24KFHDMp029530;
        Fri, 20 May 2022 15:17:13 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6awnc0wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 15:17:12 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KF3VgV010844;
        Fri, 20 May 2022 15:17:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429h1et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 15:17:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KFH7L617695050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 15:17:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55A7EA4040;
        Fri, 20 May 2022 15:17:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 347BDA404D;
        Fri, 20 May 2022 15:17:06 +0000 (GMT)
Received: from sig-9-145-82-10.uk.ibm.com (unknown [9.145.82.10])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 15:17:06 +0000 (GMT)
Message-ID: <6271dd24bfcf82b0c1b911a163ae9549c24691a4.camel@linux.ibm.com>
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
Date:   Fri, 20 May 2022 17:17:05 +0200
In-Reply-To: <20220520134414.GH1343366@nvidia.com>
References: <20220509233552.GT49344@nvidia.com>
         <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
         <20220510160911.GH49344@nvidia.com>
         <ef9f26c6a017b479610fcd7a7b93bb07815b89fd.camel@linux.ibm.com>
         <20220520134414.GH1343366@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M4bE8X_vRDJfZmRtRhjfpZXKn8t4JEet
X-Proofpoint-ORIG-GUID: bLK1gim_Vbq8CLwMnbIdo4qQ5hI0DWBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_04,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=588 suspectscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 2022-05-20 at 10:44 -0300, Jason Gunthorpe wrote:
> On Fri, May 20, 2022 at 03:05:46PM +0200, Niklas Schnelle wrote:
> 
> > I did some testing and created a prototype that gets rid of
> > arch/s390/pci_dma.c and works soley via dma-iommu on top of our IOMMU
> > driver. It looks like the existing dma-iommu code allows us to do this
> > with relatively simple changes to the IOMMU driver only, mostly just
> > implementing iotlb_sync(), iotlb_sync_map() and flush_iotlb_all() so
> > that's great. They also do seem to map quite well to our RPCIT I/O TLB
> > flush so that's great. For now the prototype still uses 4k pages only.
> 
> You are going to want to improve that page sizes in the iommu driver
> anyhow for VFIO.

Ok, we'll look into this.

>  
> > With that the performance on the LPAR machine hypervisor (no paging) is
> > on par with our existing code. On paging hypervisors (z/VM and KVM)
> > i.e. with the hypervisor shadowing the I/O translation tables, it's
> > still slower than our existing code and interestingly strict mode seems
> > to be better than lazy here. One thing I haven't done yet is implement
> > the map_pages() operation or adding larger page sizes. 
> 
> map_pages() speeds thiings up if there is contiguous memory, I'm not
> sure what work load you are testing with so hard to guess if that is
> interesting or not.

Our most important driver is mlx5 with both IP and RDMA traffic on
ConnectX-4/5/6 but we also support NVMes.

> 
> > Maybe you have some tips what you'd expect to be most beneficial?
> > Either way we're optimistic this can be solved and this conversion
> > will be a high ranking item on my backlog going forward.
> 
> I'm not really sure I understand the differences, do you have a sense
> what is making it slower? Maybe there is some small feature that can
> be added to the core code? It is very strange that strict is faster,
> that should not be, strict requires synchronous flush in the unmap
> cas, lazy does not. Are you sure you are getting the lazy flushes
> enabled?

The lazy flushes are the timer triggered flush_iotlb_all() in
fq_flush_iotlb(), right? I definitely see that when tracing my
flush_iotlb_all() implementation via that path. That flush_iotlb_all()
in my prototype is basically the same as the global RPCIT we did once
we wrapped around our IOVA address space. I suspect that this just
happens much more often with the timer than our wrap around and
flushing the entire aperture is somewhat slow because it causes the
hypervisor to re-examine the entire I/O translation table. On the other
hand in strict mode the iommu_iotlb_sync() call in __iommu_unmap()
always flushes a relatively small contiguous range as I'm using the
following construct to extend gather:

	if (iommu_iotlb_gather_is_disjoint(gather, iova, size))
		iommu_iotlb_sync(domain, gather);

	iommu_iotlb_gather_add_range(gather, iova, size);

Maybe the smaller contiguous ranges just help with locality/caching
because the flushed range in the guests I/O tables was just updated.

> > I also stumbled over the following patch series which I think would
> > also help our paging hypervisor cases a lot since it should alleviate
> > the cost of shadowing short lived mappings:
> 
> This is quite different than what your current code does though?

Yes

> 
> Still, it seems encouraging
> 
> Jason


