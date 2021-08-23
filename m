Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E0C4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 14:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3FA61206
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 14:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhHWOGt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 10:06:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhHWOGs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 10:06:48 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NE2ubY109623;
        Mon, 23 Aug 2021 10:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=bOin9H3/j8g9XbLCcxMtctZkDI1hAxdofJouD39ZKKs=;
 b=Uj3MpLREZFTwpPG7riHPRe9kkdBOnR/AzPJTZR846c00HxqOOlyaDbEONKv0YrsHy4x9
 B6BzEw/hdskdSJQ46JAaTcE0h65qT0jbEikRsWbDc9fIgTGbwEJuqr6QH8wY+/22qRiw
 IGKaXjYYMRukF0azjsr/DUsYlBHHyB/NuZldV31nLho7JpwH/IZtKTOL4meLf/L4mGAI
 zFxqwo5dCrcLkG/Zio50CzOXrtP7DWCwEEuyG/euSK6tfbowBnFEV6IaMnnY0kyo01XQ
 WNBYRPMH0W+6lZrc0e5+H8G3fR9TVvlPyJC/HaWhiHFJLSKALu/9ZJ+dgKE2lAUMUUlf bg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amamgw2fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 10:05:55 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NE3eWQ012401;
        Mon, 23 Aug 2021 14:05:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ajs48bcvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 14:05:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NE5nQo23855460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 14:05:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5975F4C044;
        Mon, 23 Aug 2021 14:05:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D36274C046;
        Mon, 23 Aug 2021 14:05:48 +0000 (GMT)
Received: from thinkpad (unknown [9.171.9.196])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 23 Aug 2021 14:05:48 +0000 (GMT)
Date:   Mon, 23 Aug 2021 16:05:46 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org
Subject: Re: can we finally kill off CONFIG_FS_DAX_LIMITED
Message-ID: <20210823160546.0bf243bf@thinkpad>
In-Reply-To: <20210820054340.GA28560@lst.de>
References: <20210820054340.GA28560@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1A_TPo4dkfWUK9cCFGq2PmlskZkAXvhC
X-Proofpoint-GUID: 1A_TPo4dkfWUK9cCFGq2PmlskZkAXvhC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_03:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=779 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230098
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 20 Aug 2021 07:43:40 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> looking at the recent ZONE_DEVICE related changes we still have a
> horrible maze of different code paths.  I already suggested to
> depend on ARCH_HAS_PTE_SPECIAL for ZONE_DEVICE there, which all modern
> architectures have anyway.  But the other odd special case is
> CONFIG_FS_DAX_LIMITED which is just used for the xpram driver.  Does
> this driver still see use?  If so can we make it behave like the
> other DAX drivers and require a pgmap?  I think the biggest missing
> part would be to implement ARCH_HAS_PTE_DEVMAP for s390.

Puh, yes, that seems to be needed in order to enable ZONE_DEVICE, and
then we could use devm_memremap_pages(), at least that was my plan
some time ago. However, either the ARCH_HAS_PTE_DEVMAP dependency
is new, or I overlooked it before, but we do not have any free bits
in the pte left, so this is not going to work.

Would it strictly be necessary to implement ZONE_DEVICE, or would
it be enough if we would use e.g. add_memory() instead of just
adding the DCSS memory directly to the kernel mapping via
vmem_add_mapping()? That way we might at least get the struct pages,
but somehow it doesn't feel completely right.
