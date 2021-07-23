Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1E0C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 08:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB9760E0C
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 08:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhGWIGz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:06:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43082 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234311AbhGWIGy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Jul 2021 04:06:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16N8Xf5n078056;
        Fri, 23 Jul 2021 04:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zBjhx0J/gTbLIX8o/G22Lyc4piL3CKnQLcUrRMOIbSw=;
 b=MerVx9hmWCH0UlossvG4YR4Yxg1XtuUkMRPphHqN4yCPj9M1i087UF4Bf9nCOB22mOHK
 cPmYY+35gZNdbxKu8AdG3fEYoAZdYhlD5qPiPAfhkg9HF3ZYti9BtkgSyIudhw47xG6g
 AhovUYFP7134qkVUJNMbUGm22IYHDbJK00Dq7MEMm7fuitrvKbqVNZBEYO/P9nENogZw
 UO0AludyiYV9qaMQq8OZKhnrCFQyDHHkCfkEucKOf1/srRIRBRA8sXd7G1Xl3gfa1mqD
 +UKSXZRMR7zOlBp2zjEqr+O6/2XOu7K0m1ffRjG1BjPfXT87se7r2llYkHzpekbyN4CM PQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ytc78bty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 04:47:09 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16N8Y1s7007131;
        Fri, 23 Jul 2021 08:47:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 39upfh9swt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 08:47:07 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16N8iaSg23658884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 08:44:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 487E94204F;
        Fri, 23 Jul 2021 08:47:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F75742041;
        Fri, 23 Jul 2021 08:47:03 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.6.217])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 23 Jul 2021 08:47:03 +0000 (GMT)
Date:   Fri, 23 Jul 2021 10:47:01 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
Message-ID: <20210723104701.3f8ac227.pasic@linux.ibm.com>
In-Reply-To: <b8985c53-a83d-f11f-9fa8-af06d1d4bfd0@de.ibm.com>
References: <20210720133826.9075-1-will@kernel.org>
        <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
        <20210723031252.655d6a83.pasic@linux.ibm.com>
        <b8985c53-a83d-f11f-9fa8-af06d1d4bfd0@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sUv-Q8d94Qfk_kxPtGywvzAB6JS8DuBE
X-Proofpoint-ORIG-GUID: sUv-Q8d94Qfk_kxPtGywvzAB6JS8DuBE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_04:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230049
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 23 Jul 2021 08:14:19 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Resending with the correct email of Heiko....
> 
> On 23.07.21 03:12, Halil Pasic wrote:
> > On Thu, 22 Jul 2021 21:22:58 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 20.07.21 15:38, Will Deacon wrote:  
> >>> Hi again, folks,
> >>>
> >>> This is version two of the patch series I posted yesterday:
> >>>
> >>>     https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
> >>>
> >>> The only changes since v1 are:
> >>>
> >>>     * Squash patches 2 and 3, amending the commit message accordingly
> >>>     * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
> >>>
> >>> I'd usually leave it a bit longer between postings, but since this fixes
> >>> issues with patches in -next I thought I'd spin a new version immediately.
> >>>
> >>> Cheers,  
> >>
> >> FWIW, I just bisected virtio-errors with secure execution mode
> >> qemu-system-s390x: virtio-serial-bus: Unexpected port id 4205794771 for device virtio-serial0.0
> >>
> >> to
> >> commit 903cd0f315fe426c6a64c54ed389de0becb663dc
> >> Author: Claire Chang <tientzu@chromium.org>
> >> Date:   Thu Jun 24 23:55:20 2021 +0800
> >>
> >>        swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing
> >>
> >> Unfortunately this patch series does NOT fix this issue, so it seems that even more
> >> things are broken.
> >>
> >> Any idea what else might be broken?  
> > 
> > I've done some debugging, and I think I know what is going on. Since
> > that commit we need to set force_swiotlb before the swiotlb itself is
> > initialized. So the patch below should fix the problem.
> > 
> > --------------------8<-------------------------------------
> > 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > Date: Fri, 23 Jul 2021 02:57:06 +0200
> > Subject: [PATCH 1/1] s390/pv: fix the forcing of the swiotlb
> > 
> > Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
> > swiotlb data bouncing") if code sets swiotlb_force it needs to do so
> > before the swiotlb is initialised. Otherwise
> > io_tlb_default_mem->force_bounce will not get set to true, and devices
> > that use (the default) swiotlb will not bounce  despite switolb_force
> > having the value of SWIOTLB_FORCE.
> > 
> > Let us restore swiotlb functionality for PV by fulfilling this new
> > requirement.
> >   
> I would add:
> Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
> as this patch breaks things
> and
> Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
> 
> to make the s390 init code more robust in case people start backporting things.

I agree. Do we want this backported to the stable releases that have
64e1f0c531d1  (i.e. do we need a cc stable) or should the fixes tag just
serve as metadata? My guess is, it's the former. In that sense should I
add the tags along with an explanation for the second fixes respin with
cc stable? 

(BTW I don't think this formally qualifies for the stable backports, but
I hope we can make an exception...)

> 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>  
> 
> I can confirm that this fixes the problem. This also makes sense codewise.
> 
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks!

Regards,
Halil
> 
> Konrad, Heiko, Vasily, any preference which tree this goes? I think s390
> would be easiest, but that requires that the patches in the swiotlb tree have
> fixed commit IDs.
> 
> > ---
> >   arch/s390/mm/init.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> > index 8ac710de1ab1..07bbee9b7320 100644
> > --- a/arch/s390/mm/init.c
> > +++ b/arch/s390/mm/init.c
> > @@ -186,9 +186,9 @@ static void pv_init(void)
> >   		return;
> >   
> >   	/* make sure bounce buffers are shared */
> > +	swiotlb_force = SWIOTLB_FORCE;
> >   	swiotlb_init(1);
> >   	swiotlb_update_mem_attributes();
> > -	swiotlb_force = SWIOTLB_FORCE;
> >   }
> >   
> >   void __init mem_init(void)
> >   

