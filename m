Return-Path: <SRS0=aATr=IG=vger.kernel.org=linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87847C433E0
	for <linux-s390@archiver.kernel.org>; Mon,  8 Mar 2021 08:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CF8601FB
	for <linux-s390@archiver.kernel.org>; Mon,  8 Mar 2021 08:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCHIqR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 8 Mar 2021 03:46:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230509AbhCHIpp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Mar 2021 03:45:45 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1288Xe77026296;
        Mon, 8 Mar 2021 03:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DwOvn0WzlW9SzVvImqvD0oYntAZztKuINqCyrmRKV9k=;
 b=aQIl7paDByq/D3PSz+xq7rGd07ChftGIzwKG6mFMFKNhMwUgsOZgPZAJ+r8LzFDqGQXG
 Czcca2gNgyW9htLu/63mVnc9iOqB0w1xPHMn6VyDoYtWfjso/pAi9biyx1IU9BxDCexP
 ez0xRs/Dx30/6C62hnGPrJpZ4IxRjNmblwf+3zOP014gsesq+p1Cp0rUaS8Swkf8p9eW
 Clt8bvldOuYOL2UeTPeiyWEb4GWYxd//l3S2Rjei/2erIIhl9BEpLWKbDahGY66fE9+S
 RgXCi2VDBkUgTr8swry2AA+xLzkXIlVjfhMgZvDDmrSD3y3wG/B3Ritzp9MdrzZxiQm0 ZQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3757wwav8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 03:45:34 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1288c1pe030994;
        Mon, 8 Mar 2021 08:45:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3741c8gume-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 08:45:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1288jUF144892486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 08:45:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F16E1AE045;
        Mon,  8 Mar 2021 08:45:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B982DAE057;
        Mon,  8 Mar 2021 08:45:29 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.49.28])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Mar 2021 08:45:29 +0000 (GMT)
To:     Christoph Hellwig <hch@infradead.org>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org
References: <YEXXCw2MYKzAIKX6@infradead.org>
From:   Stefan Haberland <sth@linux.ibm.com>
Subject: Re: can we kill the internal blkdev_get in the dasd driver now?
Message-ID: <c79c866e-4a91-a629-f067-83af9ad5252c@linux.ibm.com>
Date:   Mon, 8 Mar 2021 09:45:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YEXXCw2MYKzAIKX6@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_02:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=874 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080045
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 08.03.21 um 08:49 schrieb Christoph Hellwig:
> Hi DASD maintainers,
>
> I've recently changed the life time rules for struct block_device so
> that is is a long-living instead of an ephemeral structure, that is the=

> whole device block_device exists from the time the disk is alloced unti=
l
> it is feed, and the partitions exist from as soon as they are scanned.
>
> With this the blkdev_get in the DASD driver should not be required, but=

> there seems to be a lot of magic that accounts of it in the open count.=

>
> Any chance one of you maintainers could try to remove it to further
> simplify our open and liftetime rules?
>

Hi Christoph,

yes, sounds like a good idea. I will have a look at this.


