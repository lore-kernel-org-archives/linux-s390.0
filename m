Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4363EC43460
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 13:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FD061078
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 13:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhEENIM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 May 2021 09:08:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232395AbhEENIM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 May 2021 09:08:12 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145D3ul6187495;
        Wed, 5 May 2021 09:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=L22Te7s0P25dHUB7EZwitFXKdxZQTN22egG7r6Snrs0=;
 b=ICSpFijqk4M3y+zJcysdPiQvmVD/3tU8m6eJ2MqhrDjLi5fwXIHgC5IFmOx2Nkw+zQNd
 TpJNDKhm8YidJyfUt73+jtkKUQV/tuyPl5a8Xik7kbgj68owbHx9v5WrIdL+lss1RHY6
 WBwzdNN2nvLXF+pEY47Onr8pUfTruHnyGzIVU8Xuyf5nsqBiAt0FJfklBpTC8v38/zgK
 G7+PBMJaSNLyQ1y+pctapf4FXC/1db+Fpfb6jr59/NcN4ecd2O4+SWlqUUSUTHcb5tds
 mVULM8vapkV6uq/F5RTawyXyKUIMNiqGEtsYqT5MIF+6VQTG7A6vFV3JhmD+0nWVCBCE sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38bsva3neq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 09:07:08 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 145D4Cn5189508;
        Wed, 5 May 2021 09:07:08 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38bsva3ne4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 09:07:08 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 145D1fKX013362;
        Wed, 5 May 2021 13:07:06 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 38bedtv83v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 13:07:06 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 145D75SL38208224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 May 2021 13:07:05 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7691C13604F;
        Wed,  5 May 2021 13:07:05 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E33DC136053;
        Wed,  5 May 2021 13:07:03 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.140.234])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 May 2021 13:07:03 +0000 (GMT)
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>,
        "Jason J . Herne" <jjherne@linux.ibm.com>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
 <20210426194859.1665730d.cohuck@redhat.com>
 <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
 <20210503203319.GP1370958@nvidia.com>
 <01ada05b-ecfb-491f-9a34-6d6de54262a0@linux.ibm.com>
 <20210504160432.GB94750@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <289b3a23-6a0c-ac7c-48fb-785402cab385@linux.ibm.com>
Date:   Wed, 5 May 2021 09:07:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504160432.GB94750@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LJ6dOwbFEMCKWP0Rh2xUboolxdjHMlQk
X-Proofpoint-GUID: Ee38OrBCtNtOgCuD0vXPNy6J9VzIMgvg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_07:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050093
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/4/21 12:04 PM, Jason Gunthorpe wrote:
> On Tue, May 04, 2021 at 09:58:45AM -0400, Tony Krowiak wrote:
>>
>> On 5/3/21 4:33 PM, Jason Gunthorpe wrote:
>>> On Mon, May 03, 2021 at 04:14:43PM -0400, Tony Krowiak wrote:
>>>
>>>> This case will occur whenever a user removes the mdev
>>>> by echoing a '1' into the mdev's sysfs 'remove' attribute
>>>> file. I'm not sure it can be considered graceful to take away
>>>> all of the crypto devices from a guest while it is running,
>>>> but there is a way to process the remove callback without
>>>> leaving things in a "weird, half-dead state".
>>> It is acceptable to just sleep here until whatever user controlled
>>> condition is resolved.
>>>
>>> Jason
>> I suppose we could do that, but the user that tried to remove
>> the mdev via its sysfs 'remove' attribute will be left sitting
>> there wondering why the operation didn't complete. That
>> could result in leaving the user hanging in perpetuity.
> Yes.
>
> If the driver can't implement a disconnection then that is
> unavoidable. What it does today by leaking memory under user control
> is not acceptable.

Based upon my observations of the behavior during a removal
of the mdev, memory is not leaked. If the fd for the mdev is
open when an attempt is made to remove it, the operation
will hang until the mdev fd is closed which happens when
either the guest is shut down or the mdev device is detached from
the guest. When the fd is closed, the mdev release callback is
invoked which nullifies the KVM pointer, so when the remove callback
is subsequently invoked, the mdev resources will be cleaned up.
Of course, I imagine there are other possibilities
for how an mdev can be removed, but in the normal course of
events, memory will not be leaked.

>
>> IMHO, the callback should continue to return an int and
>> the caller should display the error if a non-zero rc is
>> returned.
> Nope, there is a reason removal is not allowed to fail.. sysfs remove
> isn't the only reason the mdev driver could be destroyed, the
> underlying physical device could be unplugged or other things.

That may be true with other devices, but the matrix device is
not a real, physical device. Its sole purpose in life is to provide
an anchor for the mdev devices used to provide AP resources
to a guest; however, I get your point.


>
> Drivers need to implement a proper remove.
>
> Jason

