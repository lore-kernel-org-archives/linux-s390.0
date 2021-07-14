Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7929EC07E9A
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 13:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5921961369
	for <linux-s390@archiver.kernel.org>; Wed, 14 Jul 2021 13:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhGNN2E (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:28:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231391AbhGNN2D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Jul 2021 09:28:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EDFrIk066326;
        Wed, 14 Jul 2021 09:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xk7fQo3cNb82lvfg0DyWEvxbqnwJtuEL6Bv2LaV32WI=;
 b=ljXZrSkan+fXOkIdB4OQjify6RS928QT1PLrRVEyZuSFOFUWUg5yIWqx3IkE3vR17WGT
 pVQjdOxw53wrn+ZHFn3PN2q4v+9dA0ToUDjMYhF4gZTdQKvnTpB3pMZ1fSBPJvwCXNPT
 K80nSmhFJxKZUXa3UxCr37wVwlu8O8QhIDilRCofTDhKTl/4oMlVc6udfyFKV01x+uNV
 E03xJJZwy1Qk8Ry8Duulfq3VIr81A7kJX7RvQzTljYE8bM5CBJF3kbRDY91QZmwytmGM
 wqLH+aaaODQVOUNB4cA6NhIdI8fhriWR3wXNdiu5Om3UkoqOCMvaOq/ZOtyEMeaj7nYx +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39sey9vgkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 09:25:10 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16EDH9Fa074426;
        Wed, 14 Jul 2021 09:25:10 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39sey9vgk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 09:25:09 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16EDIA64010096;
        Wed, 14 Jul 2021 13:25:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 39q36c45ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 13:25:09 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16EDP5tp54460886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 13:25:05 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20AD613606A;
        Wed, 14 Jul 2021 13:25:05 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE5EF136055;
        Wed, 14 Jul 2021 13:25:03 +0000 (GMT)
Received: from [9.85.184.30] (unknown [9.85.184.30])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jul 2021 13:25:03 +0000 (GMT)
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
 <20210713013815.57e8a8cb.pasic@linux.ibm.com>
 <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
 <20210713184517.48eacee6.pasic@linux.ibm.com>
 <20210713170533.GF136586@nvidia.com>
 <9512a7fb-cc55-cd9b-cdf9-7c19d0567311@linux.ibm.com>
 <20210713192138.GG136586@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <dc18ff02-80f6-e59e-5f08-417434e74706@linux.ibm.com>
Date:   Wed, 14 Jul 2021 09:25:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210713192138.GG136586@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X5AJ5zYoa4ftOIdf_4qa1Ft-1rzlB1x_
X-Proofpoint-ORIG-GUID: F1OCd-iPYhSLRl0yaEZaKOhT5Ud_a4zl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_07:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


> This patch shows it works as a rwsem - look at what had to be changed
> to make it so and you will find some clue to where the problems are in
> kvm_busy version.
>
> In any event, I don't care anymore - please just get this merged, to
> AlexW's tree so I don't have conflicts with the rest of the ap changes
> for VFIO I've got queued up.

Christian, can you merge this with AlexW's tree? Halil suggested
the 'fixes' and 'cc stable' tags ought to be removed, do I need
to post another version or can you take those out when merging?

>
> Jason

