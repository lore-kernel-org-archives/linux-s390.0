Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9B9C07E95
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 17:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4B461C69
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 17:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGGRTq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:19:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGGRTp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Jul 2021 13:19:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167H5Cp2001712;
        Wed, 7 Jul 2021 13:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iTPIlJcDi+QcKrtPLGq5b7lyXQ7r/sjKRcBvPlCojjs=;
 b=TOv2bwc4q+rjLPbUmLbfD+I0Qo+0qV+5jkPcGhgm/1opytKmXUSmM+NS8uyNpptw7vbf
 UsABF79iEzopa1/KyQj8mj5N62inziOgTvKXgw/Ep8jDu+Kneej/oRPI/2eVa7w8mMCd
 WUwcbbhOJw/Yr6HVECNneL4wRrDI3UhKEEm1VSNvpESMRgfsd3BHNNl1ZLuJ/3167Qj8
 XVQS9ckneQtb2XYeNdv2GqybZtSNEMOShP8ZxpyquEyeUpn4zcPnYWGpq5UheCMTQsJP
 ovjrn7Op2aYSwL0cIHIi2hsxWJ9b1tKG2zr23BKm5Bti4Ft8S6ierBkGVq/+H4fOMvAa gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39nc7xg3m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 13:17:04 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 167H5JQU002357;
        Wed, 7 Jul 2021 13:17:03 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39nc7xg3km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 13:17:03 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 167HC6DZ012056;
        Wed, 7 Jul 2021 17:17:02 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 39jfhc16s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 17:17:02 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 167HH13T24117622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Jul 2021 17:17:01 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 110B86A04D;
        Wed,  7 Jul 2021 17:17:01 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC5ED6A054;
        Wed,  7 Jul 2021 17:16:59 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.163.230])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  7 Jul 2021 17:16:59 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210621155714.1198545-1-akrowiak@linux.ibm.com>
 <20210621155714.1198545-3-akrowiak@linux.ibm.com>
 <8936a637-68cd-91f0-85da-f0fce99315cf@linux.ibm.com>
 <53181dcb-cabc-d6a1-3bbe-7eba298f06fe@de.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <d6389aab-f6ad-1f48-5997-783c57201f3d@linux.ibm.com>
Date:   Wed, 7 Jul 2021 13:16:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <53181dcb-cabc-d6a1-3bbe-7eba298f06fe@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -rnAUq6t2YNOnvue8oV47CsWLoA9zhPh
X-Proofpoint-ORIG-GUID: i9FPZsDxryJ_R4FmNm533GzyPdTKD4jw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_08:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/1/21 11:25 AM, Christian Borntraeger wrote:
> On 30.06.21 17:18, Tony Krowiak wrote:
>> I assumed that this patch would get queued along with the other one 
>> in this series,
>> but it looks like that was an erroneous assumption. Should this also 
>> be queued?
>
> Sorry, this is on my todo list.


I rolled this up into the patch I posted today:
Message ID: <20210707154156.297139-1-akrowiak@linux.ibm.com>
s390/vfio-ap: do not open code locks for VFIO_GROUP_NOTIFY_SET_KVM 
notification

