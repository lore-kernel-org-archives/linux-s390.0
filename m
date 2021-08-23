Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393F3C4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1DA613CD
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 15:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhHWPSk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 11:18:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhHWPSj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 11:18:39 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NF2umR075654;
        Mon, 23 Aug 2021 11:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=joRttYs9N4ZWr34z4vspyOpC3YJqV16TS83slYUX8KI=;
 b=aGnWgfpzBS6HUsyRhJ+15JG51/F0fkRMP3UUoFE6YaK1U/bSHk2cevoI06fUwCk4r/rk
 xYUp8JSYwTlP4i6qPknR55CHgWGOMg3nPWV0WzALuyonwDzG2dGBHRcdwNQuTgJKGvQ8
 Pq1QCDsmygrl5do0TyxsXcoj2m3FLJcm2gCrm5C58zje5uefQwxUy6a0d64dysp6/EWS
 aHvOVYeCGUlqJ0RTYYBCJ8hN81R4zTlsgYPXhAsV1qDVa9Zlt48ZMNdpX0AchET9yjjU
 RdzfYasZBB8IbTW8FsEQmSaDyvJbHt5GHL4Y7GAZn6n1iHQDODn/RnpqS3sa6boTfA4x GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amamgynnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 11:17:56 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NF3GGv076806;
        Mon, 23 Aug 2021 11:17:55 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amamgynn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 11:17:55 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NFHLV2010883;
        Mon, 23 Aug 2021 15:17:54 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 3ajs4b90yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 15:17:54 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NFHnBW13238614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 15:17:49 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD360136074;
        Mon, 23 Aug 2021 15:17:48 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDAF3136066;
        Mon, 23 Aug 2021 15:17:47 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 15:17:47 +0000 (GMT)
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception handler
 function pointer
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, david@redhat.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
 <20210719193503.793910-2-akrowiak@linux.ibm.com>
 <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
 <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
 <20210819115433.76153ae4.alex.williamson@redhat.com>
 <20210819175807.GC1721383@nvidia.com>
 <d905d1fa-2852-4fb7-5b56-4b3b12d8994f@linux.ibm.com>
 <20210820223049.GJ1721383@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <5ed12778-bd0e-20dd-15e7-3639dbf1c87c@linux.ibm.com>
Date:   Mon, 23 Aug 2021 11:17:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820223049.GJ1721383@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RJNXGD5iPK4BskVfuUaCcaZbhkOyIMbG
X-Proofpoint-GUID: OZQcPZrxzPj3-QOTN5-VEK3pwnyK0ENt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_03:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thanks, I think I've got it now.

On 8/20/21 6:30 PM, Jason Gunthorpe wrote:
> git reset --hard origin/next

