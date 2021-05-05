Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52348C433B4
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 16:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0166121F
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 16:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhEEQ33 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 May 2021 12:29:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233826AbhEEQ32 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 May 2021 12:29:28 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145GE0ti163264;
        Wed, 5 May 2021 12:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Sw6cbMoInoBsIxOzJg6bFTqm7D1aKZpZ6bnjS/Gqti8=;
 b=q5qQEjjShvbgw2wkX/TH+Wjc4G9bEHyEPGgAV35YOvk53M89YstkiFbDjd0nmOAYlg94
 0Gs4eBJopMIGl5RjVM2zfdr+uUSP0wD3kV7IbiR2LhmLpG5JuGX1srq7RQ/MEViUJeRA
 tJlmMcMDjo80Gs5+66+zA5CrSjj/k0ePJycOt4wzIfXR6UeGsDQdgL5ZxeLvZj7N8DaY
 u2C24QErQqn4jKsft46OxjnvLWJb0ioj7hwgN0WC64IiHQ4FYAk1JOGBAqT00/aIdKiW
 p1xQQ17mNlH/SsWW7uBhg3045dCIWlccHTlcwLxT6KEiJslaPgggSRXxWoKpsUnKbXaL fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38bxpxgd4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 12:28:26 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 145GEJPH167182;
        Wed, 5 May 2021 12:28:26 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38bxpxgd4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 12:28:26 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 145GRve8007848;
        Wed, 5 May 2021 16:28:25 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 38behdwdus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 16:28:25 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 145GSOGV38535424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 May 2021 16:28:24 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17F7513604F;
        Wed,  5 May 2021 16:28:24 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8519D136051;
        Wed,  5 May 2021 16:28:22 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.140.234])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 May 2021 16:28:22 +0000 (GMT)
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
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
Message-ID: <781f8c98-a366-6e8d-ce5e-b8fe7da36b12@linux.ibm.com>
Date:   Wed, 5 May 2021 12:28:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TCI9Eq10L3apQSr87KPzJO1Ujpk3v86u
X-Proofpoint-ORIG-GUID: TI5SUoEludNy_VBWfCjRRnTBL8vTz7Nm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=935
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050113
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/3/21 4:14 PM, Tony Krowiak wrote:
...
>
> Up to this point, the onus for ensuring the proper procedure
> is followed when managing pass-through crypto devices
> for a KVM guest is left to the system administrator. In
> other words, we don't prevent an admin from shooting
> him/herself in the foot when doing things such as removing
> an mdev while a KVM guest is using it. With this in mind,
> I will handle this case in the follow-on patches implementing
> dynamic AP configuration support for KVM guests.

Change of plans: Based upon my exchanges with Jason, I have
decided to create a patch specifically to do the cleanup in
the mdev remove callback regardless of whether a KVM guest
is using the mdev or not.

>
>>
>

