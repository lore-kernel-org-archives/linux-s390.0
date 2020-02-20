Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728368AbgBTQXb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 11:23:31 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KGK3lW057620
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 11:23:30 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y99pg20n9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 11:23:30 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 20 Feb 2020 16:23:27 -0000
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com> <20200220161146.GA12709@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Feb 2020 17:23:20 +0100
MIME-Version: 1.0
In-Reply-To: <20200220161146.GA12709@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>



On 20.02.20 17:11, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 05:06:05PM +0100, Halil Pasic wrote:
>> Currently force_dma_unencrypted() is only used by the direct
>> implementation of the DMA API, and thus resides in dma-direct.h. But
>> there is nothing dma-direct specific about it: if one was -- for
>> whatever reason -- to implement custom DMA ops that have to in the
>> encrypted/protected scenarios dma-direct currently deals with, one would
>> need exactly this kind of information.
> 
> I really don't think it has business being anywhre else, and your completely
> bogus second patch just proves the point.

From a users perspective it makes absolutely perfect sense to use the
bounce buffers when they are NEEDED. 
Forcing the user to specify iommu_platform just because you need bounce buffers
really feels wrong. And obviously we have a severe performance issue
because of the indirections.

Now: I understand that you want to get this fixes differently, but maybe you 
could help to outline how this could be fixed proper. 

Christian
