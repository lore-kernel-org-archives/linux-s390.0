Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF89C07E9E
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 19:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24B16128D
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 19:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhGFTPA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:15:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231863AbhGFTPA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 15:15:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166J4JCu173365;
        Tue, 6 Jul 2021 15:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=HG1GLNmHvotq6EFCX6QsGejnQKziX83yfMZ01HgZuUU=;
 b=lS3iiZ+QpjpOUYGyg4AHuW4crOM1qmYhdfLsppQZ4HMju5H29ggiH1mKQhbZFKFpvxtF
 qlEWTUf/CTj9F5Ev4F4FPWMnWt+8dB+ZAmL1RqAFvtmSwMi3IfSEktO3cApglU2FcEVE
 tcszdaOyAhrajaLOUWzleIWhXHBV5RaJADESbO0/zppgMarS6GR+fwJy8qilACByShTk
 37w8I4Q4WfLy4h6r0lrq/BZkBLrxvW05lHTMz3bPRcZjipB5Y682pWhGEL/hve3FxAvT
 EyVBrg6Y7Ttf+Sdvn9dezpIrk0HsOiDeex2P6I1Ko538ElAJt+EkJWbYj4SzKBcp/zMv yQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39mkpv17y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 15:12:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 166J2rS2007971;
        Tue, 6 Jul 2021 19:12:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 39jfh8sdcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 19:12:12 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 166JC8n028442920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jul 2021 19:12:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA4F3A4057;
        Tue,  6 Jul 2021 19:12:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AFBDA404D;
        Tue,  6 Jul 2021 19:12:08 +0000 (GMT)
Received: from thinkpad (unknown [9.171.59.58])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  6 Jul 2021 19:12:08 +0000 (GMT)
Date:   Tue, 6 Jul 2021 21:12:07 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] dma-debug: fix check_for_illegal_area() in
 debug_dma_map_sg()
Message-ID: <20210706211207.48f15496@thinkpad>
In-Reply-To: <3bb87b4c-f646-20fe-7cc5-c7449432811e@arm.com>
References: <20210705185252.4074653-1-gerald.schaefer@linux.ibm.com>
        <20210705185252.4074653-2-gerald.schaefer@linux.ibm.com>
        <3bb87b4c-f646-20fe-7cc5-c7449432811e@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ROsvXMbitoGNJM55LtbKTVrOQx9nf8tg
X-Proofpoint-GUID: ROsvXMbitoGNJM55LtbKTVrOQx9nf8tg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_10:2021-07-06,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 6 Jul 2021 10:22:40 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2021-07-05 19:52, Gerald Schaefer wrote:
> > The following warning occurred sporadically on s390:
> > DMA-API: nvme 0006:00:00.0: device driver maps memory from kernel text or rodata [addr=0000000048cc5e2f] [len=131072]
> > WARNING: CPU: 4 PID: 825 at kernel/dma/debug.c:1083 check_for_illegal_area+0xa8/0x138
> > 
> > It is a false-positive warning, due to a broken logic in debug_dma_map_sg().
> > check_for_illegal_area() should check for overlay of sg elements with kernel
> > text or rodata. It is called with sg_dma_len(s) instead of s->length as
> > parameter. After the call to ->map_sg(), sg_dma_len() contains the length
> > of possibly combined sg elements in the DMA address space, and not the
> > individual sg element length, which would be s->length.
> > 
> > The check will then use the kernel start address of an sg element, and add
> > the DMA length for overlap check, which can result in the false-positive
> > warning because the DMA length can be larger than the actual single sg
> > element length in kernel address space.
> > 
> > In addition, the call to check_for_illegal_area() happens in the iteration
> > over mapped_ents, which will not include all individual sg elements if
> > any of them were combined in ->map_sg().
> > 
> > Fix this by using s->length instead of sg_dma_len(s). Also put the call to
> > check_for_illegal_area() in a separate loop, iterating over all the
> > individual sg elements ("nents" instead of "mapped_ents").
> > 
> > Fixes: 884d05970bfb ("dma-debug: use sg_dma_len accessor")
> > Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > ---
> >   kernel/dma/debug.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index 14de1271463f..d7d44b7fe7e2 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -1299,6 +1299,12 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >   	if (unlikely(dma_debug_disabled()))
> >   		return;
> >   
> > +	for_each_sg(sg, s, nents, i) {
> > +		if (!PageHighMem(sg_page(s))) {
> > +			check_for_illegal_area(dev, sg_virt(s), s->length);
> > +		}
> > +	}
> > +
> >   	for_each_sg(sg, s, mapped_ents, i) {
> >   		entry = dma_entry_alloc();
> >   		if (!entry)
> > @@ -1316,10 +1322,6 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >   
> >   		check_for_stack(dev, sg_page(s), s->offset);
> 
> Strictly this should probably be moved to the new loop as well, as it is 
> similarly concerned with validating the source segments rather than the 
> DMA mappings - I think with virtually-mapped stacks it might technically 
> be possible for a stack page to be physically adjacent to a "valid" page 
> such that it could get merged and overlooked if it were near the end of 
> the list, although in fairness that would probably be indicative of 
> something having gone far more fundamentally wrong. Otherwise, the 
> overall reasoning looks sound to me.

I see, good point. I think I can add this to my patch, and a different
subject like "dma-debug: fix sg checks in debug_dma_map_sg()".

However, I do not quite understand why check_for_stack() does not also
consider s->length. It seems to check only the first page of an sg
element.

So, shouldn't check_for_stack() behave similar to check_for_illegal_area(),
i.e. check all source sg elements for overlap with the task stack area?

If yes, then this probably should be a separate patch, but I can try
to come up with something and send a new RFC with two patches. Maybe
check_for_stack() can also be integrated into check_for_illegal_area(),
they are both called at the same places. And mapping memory from the
stack also sounds rather illegal.
