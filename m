Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72786C07E9A
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 17:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5658C613BF
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 17:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhGNR7n (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:59:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63604 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhGNR7m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Jul 2021 13:59:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EHXRe3178379;
        Wed, 14 Jul 2021 13:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=i9bwBZ8IqeFc9nLc0MfjYTOu7SfcLlWpJZJth8+oVKk=;
 b=rn2klkTmWK4W5w1hWgvYfdCWMvCSJ9wmxqUVb2PKFQZinO7ugvs41MDS103NoxOU/ZDp
 E9L7jq43OLazgEvVYSEXBpGyf9Zr1hq1wJpK4FMidSLy/mko74DlwW2xg+a+McdaNG6R
 KenCLYvij6LPYPkrmEOu54DOLEgBwrLaVK9e/n9+vICTs6IdfUSz1zjWUM9SnoN864yC
 TCjyBv9SgZiKQOmJSUvaPXr1vFjPPCUjuGIA6ZqHsk13pHACiRA7Bn9jl28sSk5hKsQQ
 0TidVWJ3uRHuyQnFqcYEDO6gA5VY9kd5PDTVpQR3LHmYULsGpHzmuMsmJGIYhudq2uVo 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ssmrcgqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 13:56:48 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16EHYpBc187192;
        Wed, 14 Jul 2021 13:56:48 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ssmrcgpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 13:56:48 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16EHmvgK012696;
        Wed, 14 Jul 2021 17:56:46 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 39q3689vxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 17:56:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16EHugP832178542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 17:56:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3C4F11C04C;
        Wed, 14 Jul 2021 17:56:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4478C11C04A;
        Wed, 14 Jul 2021 17:56:42 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.81.11])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jul 2021 17:56:42 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>, alex.williamson@redhat.com
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
 <20210713013815.57e8a8cb.pasic@linux.ibm.com>
 <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
 <20210713184517.48eacee6.pasic@linux.ibm.com>
 <20210713170533.GF136586@nvidia.com>
 <9512a7fb-cc55-cd9b-cdf9-7c19d0567311@linux.ibm.com>
 <20210713192138.GG136586@nvidia.com>
 <dc18ff02-80f6-e59e-5f08-417434e74706@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <9c50fb1b-4574-0cfc-487c-64108d97ed73@de.ibm.com>
Date:   Wed, 14 Jul 2021 19:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <dc18ff02-80f6-e59e-5f08-417434e74706@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZjTRbgEzRYPzOr3ZuGsF5gBBpfwf1gEN
X-Proofpoint-GUID: c1spNyS56X5voCqnnhZfMd5GzRcrwV1-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_10:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=982
 bulkscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140105
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 14.07.21 15:25, Tony Krowiak wrote:
> 
>> This patch shows it works as a rwsem - look at what had to be changed
>> to make it so and you will find some clue to where the problems are in
>> kvm_busy version.
>>
>> In any event, I don't care anymore - please just get this merged, to
>> AlexW's tree so I don't have conflicts with the rest of the ap changes
>> for VFIO I've got queued up.
> 
> Christian, can you merge this with AlexW's tree? Halil suggested
> the 'fixes' and 'cc stable' tags ought to be removed, do I need
> to post another version or can you take those out when merging?

Normally this would go via the KVM/s390 or s390 tree (as Alex did
not want to handle s390 vfio devices).

Alex, as Jason is waiting for this to be in your tree could you take
this patch via your tree ?(please remove cc stable and Fixes for now
I want this to settle a bit).

To carry this patch in your tree with my kvm/s390 and s390 maintainer hat
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


