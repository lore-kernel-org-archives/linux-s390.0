Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B1C2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 14:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9486142D
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 14:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhEYOJf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 10:09:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233785AbhEYOJX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 10:09:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PE5mpF081533;
        Tue, 25 May 2021 10:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=reply-to : subject : to
 : cc : references : from : message-id : date : mime-version : in-reply-to
 : content-type : content-transfer-encoding; s=pp1;
 bh=rU5BL0PnMvVU5rXRhfXgdKVlAntKLCTHcgOZuWIM2RI=;
 b=iRLd9vDiDO0xyyiSOIyMPOm/05+Ny8KiaCq0B+QmOu60ps2LPAO2nZK5u1VRg01Xv+2c
 v0j41TIFobQB8hj4bmAgYd2BcvLC24BMJFYo0UqR1zZ7B6N+UGuU/ECkoBJH0lUQmz8B
 52p0fdLUzATpiCeWFeGD08IXtmF8m5VGw05GLZsaFNr6aX5dB/L72aT0wo/u9CIo7f05
 OzfzyeLhYsLVBOx/JDKKKfI9TrdHGMNOCeNXAp9LsSDbfcLDq60ltZ94ExCt1+500lN7
 5AOJpo4ueb2HmU33Kv1sPj9PCsQ2WHgOwin0J2JAu4W9zGeZeVxn3auKWm0GWe0ZUZR+ mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38s275h6y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 10:07:52 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PE62Kq083273;
        Tue, 25 May 2021 10:07:51 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38s275h6x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 10:07:51 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PE7Znt015969;
        Tue, 25 May 2021 14:07:50 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 38s1q6ghps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 14:07:50 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PE7mBE21758458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 14:07:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF33D7807A;
        Tue, 25 May 2021 14:07:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FF5778070;
        Tue, 25 May 2021 14:07:47 +0000 (GMT)
Received: from [9.85.129.37] (unknown [9.85.129.37])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 14:07:47 +0000 (GMT)
Reply-To: jjherne@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <20df4cd0-7859-4727-42bd-9ef419455039@linux.ibm.com>
 <20210525132628.GX1002214@nvidia.com>
From:   "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Message-ID: <e80fcdb4-202b-f339-87c9-987a5b5e6fe3@linux.ibm.com>
Date:   Tue, 25 May 2021 10:07:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20210525132628.GX1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qW0Pzx8Nds36aUmGn6v21o3V3TzH1g97
X-Proofpoint-GUID: WDnYRfk3GmayeNPctu6VH5AWgotXd-Z6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_07:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/25/21 9:26 AM, Jason Gunthorpe wrote:
> On Tue, May 25, 2021 at 09:24:59AM -0400, Jason J. Herne wrote:
>> change the function pointer to point to vfio_ap_ops:handle_pqap(). When we
>> unload the module we change the function pointer back to the stub.  The
>> updates should be atomic operations so no lock needed, right?
> 
> No
> 
> Jason
> 

Okay... Would you be willing to elaborate, please? A counter argument, or a simple 
explanation would be appreciated. A simple "no" does not really do much to advance the 
discussion :).

I'm fairly sure that a 64-bit pointer would be updated atomically. A reader of this value 
is either going to see value A or value B, not the high half of A and the low half of B. 
Maybe we also need a memory barrier to prevent stale values from being seen on another core?

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
