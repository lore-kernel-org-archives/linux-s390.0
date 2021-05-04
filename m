Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBA7C433ED
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F9E610FB
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 13:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhEDN7w (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 May 2021 09:59:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231216AbhEDN7w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 May 2021 09:59:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144DvupW018600;
        Tue, 4 May 2021 09:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YUpU52uA3C2l5HPMrcWWHn13LoFv0s1a7Shgm9Is8RU=;
 b=YqnwLPqATw4NJIMR6Gg5AGbdPkqDvk8RewcG4z/7+I8qJmq6upWul5XTfDOtsVjlL3lx
 T3KiGVODRSxhz6rn0gS2C0EYMrcRllX1CkF8Q+fLesB99J1a75wxAmhAjdNz5cwi4I4S
 fzBtUwFp1o5HApif5CpgqiFjVWLmR+sUqANW7TgVE31NZshJBh2AOX+4HmJal8/TlM2d
 VJRveZzVtfHGFXCKRxwbLYbsD432zTvPP4md5gMOUGduDQcRnL2qz0oQi+WT/j3xWSbd
 /dhQToImGtQTuG7sYtq8dVXYiC3silH10raGguHOWNbTqc6gmb5pqe0S9oMQ52PYIC3a oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38b7fd87yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:58:50 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 144DnDTD188266;
        Tue, 4 May 2021 09:58:50 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38b7fd87y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 09:58:50 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144DvkUd012507;
        Tue, 4 May 2021 13:58:49 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 38a9xfsy90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 13:58:49 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 144DwlaI37224904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 13:58:48 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE7C613605D;
        Tue,  4 May 2021 13:58:47 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6235313604F;
        Tue,  4 May 2021 13:58:46 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.140.234])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  4 May 2021 13:58:46 +0000 (GMT)
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
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <01ada05b-ecfb-491f-9a34-6d6de54262a0@linux.ibm.com>
Date:   Tue, 4 May 2021 09:58:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503203319.GP1370958@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OCNAhVIIPUCv6gngRHyFCqin2HEuPiKr
X-Proofpoint-GUID: VAfIVAZWiS3_f371H2yTUy9vA6en7EUF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_07:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040101
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/3/21 4:33 PM, Jason Gunthorpe wrote:
> On Mon, May 03, 2021 at 04:14:43PM -0400, Tony Krowiak wrote:
>
>> This case will occur whenever a user removes the mdev
>> by echoing a '1' into the mdev's sysfs 'remove' attribute
>> file. I'm not sure it can be considered graceful to take away
>> all of the crypto devices from a guest while it is running,
>> but there is a way to process the remove callback without
>> leaving things in a "weird, half-dead state".
> It is acceptable to just sleep here until whatever user controlled
> condition is resolved.
>
> Jason

I suppose we could do that, but the user that tried to remove
the mdev via its sysfs 'remove' attribute will be left sitting
there wondering why the operation didn't complete. That
could result in leaving the user hanging in perpetuity.

IMHO, the callback should continue to return an int and
the caller should display the error if a non-zero rc is
returned.


