Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F52C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 10 May 2022 15:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbiEJPd2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 10 May 2022 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345852AbiEJPdI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 May 2022 11:33:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88168CCC1
        for <linux-s390@vger.kernel.org>; Tue, 10 May 2022 08:26:07 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFJoKN027082;
        Tue, 10 May 2022 15:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ol6frAO8TVR1oaaFTjN+QYA5CyFxWCXeOgDsUAr8E0g=;
 b=ZNZI8/GPMVBiqwiKSUOv8uxvVQfLZ74LwK64qg/rRwaW7kl1NOlAHS14zOAbUAiKpuxL
 by61sXIW8Q8T/MGWiGs4xIp4qOip769DJh19xj9w/GjIVdc3cUHUYbDM6il0a1xKWl8z
 MMCgGzX/frQ1YrKM5MWCTMiQMy6zWvt5kzgPi1wQ4UntE+N/oMP8eUSRQxiYTgzppbVk
 4zkhIXxnYmNK0pi2vQhF7FCf27ZVQY23LEwoVJ+YSImnWRzBox5LIvXO+340CgngwjMw
 UAVyA7rSNu2wD+NvuISWecWBAOkh27goOV3qjnlm1K+P+NMRuyN32+xTsBgDUAcEPYvC QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fytkkr5a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:26:02 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24AFO48T009223;
        Tue, 10 May 2022 15:26:01 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fytkkr59c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:26:01 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24AF8MsN028690;
        Tue, 10 May 2022 15:26:00 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3fwgd9u9n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:26:00 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24AFPxMI34537884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 15:25:59 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7CC8AE064;
        Tue, 10 May 2022 15:25:59 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 164E9AE060;
        Tue, 10 May 2022 15:25:55 +0000 (GMT)
Received: from [9.211.49.28] (unknown [9.211.49.28])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 May 2022 15:25:54 +0000 (GMT)
Message-ID: <ef3ea28b-ccfb-f354-bd6d-6290a2aa4b3e@linux.ibm.com>
Date:   Tue, 10 May 2022 11:25:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: s390-iommu.c default domain conversion
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, schnelle@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>
References: <20220509233552.GT49344@nvidia.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20220509233552.GT49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iv_rPGqwc3NhJuyNthG7ttiVqEJkxvjy
X-Proofpoint-GUID: Yg94RQJNLyfaEZ9_vHfDe2AeG9CNsIrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_03,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=955 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205100069
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/9/22 7:35 PM, Jason Gunthorpe wrote:
> Hi s390 folks/Matthew
> 
> Since everyone is looking at iommu support for the nested domains,
> could we also tackle the default domain conversion please? s390 is one
> of the last 4 drivers that need it.
> 
>  From what I can see it looks like when detach_dev() is called it
> expects the platform's dma_ops to work in arch/s390/pci/pci_dma.c ?

Yes

> 
> Has anyone thought about converting the dma_ops to use the normal DMA
> API iommu support and run it through the iommu driver instead of
> through the dma_ops?
> 
> Alternatively perhaps we can keep the dma_ops with some iommu
> side-change.

It has come up before.  So ultimately the goal is to be driving the dma 
through the default iommu domain (via dma-iommu) rather than directly in 
the dma_ops?  One of our main concerns is performance loss from s390-ism 
optimizations in the dma_ops like RPCIT avoidance / lazy map + global 
flush (maybe I am wrong or something can be generalized through the api 
- or something is already there that will work).  Of course there are 
some obvious benefits too, we have some duplication of work between 
s390-iommu.c and arch/s390/pci/pci_dma.c

I think the reality is that Niklas and I need to have a close look and 
do some testing on our end to see what it will take and if we can get 
acceptable performance from a conversion, then get back to you.

Thanks,
Matt


