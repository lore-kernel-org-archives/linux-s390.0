Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727915AbgBTRA0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 12:00:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KH0LsB146706
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 12:00:25 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubghc1t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 12:00:25 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 20 Feb 2020 17:00:09 -0000
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com> <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Feb 2020 18:00:02 +0100
MIME-Version: 1.0
In-Reply-To: <20200220163135.GA13192@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <c41d567c-85ba-0f19-e56f-1b6cc4581d89@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>



On 20.02.20 17:31, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
>> >From a users perspective it makes absolutely perfect sense to use the
>> bounce buffers when they are NEEDED. 
>> Forcing the user to specify iommu_platform just because you need bounce buffers
>> really feels wrong. And obviously we have a severe performance issue
>> because of the indirections.
> 
> The point is that the user should not have to specify iommu_platform.

I (and Halil) agree on that. From a user perspective we want to
have the right thing in the guest without any command option. The iommu_plaform
thing was indeed a first step to make things work. 

I might mis-read Halils patch, but isnt one effect of this patch set 
that things WILL work without iommu_platform?


> We need to make sure any new hypervisor (especially one that might require
> bounce buffering) always sets it, as was a rather bogus legacy hack
> that isn't extensibe for cases that for example require bounce buffering.
