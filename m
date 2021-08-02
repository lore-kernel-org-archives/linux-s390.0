Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C06C4338F
	for <linux-s390@archiver.kernel.org>; Mon,  2 Aug 2021 13:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B76E60F6D
	for <linux-s390@archiver.kernel.org>; Mon,  2 Aug 2021 13:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhHBNKm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:10:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60999 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233645AbhHBNKl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Aug 2021 09:10:41 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172D5PMf170884;
        Mon, 2 Aug 2021 09:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3gsEIOU5gfGRSpwVWztE7oNu+NNPLYma0ZhBrqxWsAc=;
 b=OU/E4FhroiX4M4e88PLNY8Tg7iwMrMucUax5syROGswAH1gXpbp5qEvylXju/Tt5WRAy
 M/yjFYq/EboAJ5nSHh0riY0pRyVjySxpeRrDRiw8Uzbf7w5ybkwu4fkxxcA3SjQ3Qzyv
 tzvlM3cXrSqZN84c7d/BuLaNrCJASR3WLCAge05W6f/Ae9nRA2ASq5Dx1A1G1SpHeOFL
 xJi5MY+Y5Q8f14+OzMoLW30kytPTS+VFPucC3HzJu6AeZysJKPs7L6sq+EqmrB4Qo8ir
 RNeaxj1sIvQanzn/FvGhZLvc5ZIO7lASkOma9Z8wBLWH99TJ+1klv5F/xzXDHLJ/1ODL jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a5rkx5bpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 09:10:31 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 172D5YY1172061;
        Mon, 2 Aug 2021 09:10:30 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a5rkx5bpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 09:10:30 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 172D8ftF013334;
        Mon, 2 Aug 2021 13:10:29 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3a4x5b321p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 13:10:29 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 172DAS2o43123066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Aug 2021 13:10:28 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4091D6A05A;
        Mon,  2 Aug 2021 13:10:28 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA7016A064;
        Mon,  2 Aug 2021 13:10:26 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.77.143.250])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Aug 2021 13:10:26 +0000 (GMT)
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, david@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
Message-ID: <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
Date:   Mon, 2 Aug 2021 09:10:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719193503.793910-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZzfczKBSFIkz_aBaaXoErrIaJKNPMZ29
X-Proofpoint-ORIG-GUID: gQo6e3YYH3psOFfBahRZln_4dYJ1KwAj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_05:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=980
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108020088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

PING!

This patch will pre-req version 17 of a patch series I have waiting in 
the wings,
so I'd like to get this one merged ASAP. In particular, if a KVM 
maintainer can
take a look at the comments concerning the taking of the kvm->lock 
before the
matrix_mdev->lock it would be greatly appreciated. Those comments begin with
Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.

On 7/19/21 3:35 PM, Tony Krowiak wrote:
> This series is actually only comprised of a single patch to replace the
> open coded locks used during VFIO_GROUP_NOTIFY_SET_KVM notification. The
> first patch is included because it is a pre-req slotted to be merged but is
> not yet available in the kernel.
>
> Tony Krowiak (2):
>    s390/vfio-ap: r/w lock for PQAP interception handler function pointer
>    s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM
>      notification
>
>   arch/s390/include/asm/kvm_host.h      |   8 +-
>   arch/s390/kvm/kvm-s390.c              |  28 +++++-
>   arch/s390/kvm/priv.c                  |  10 +-
>   drivers/s390/crypto/vfio_ap_ops.c     | 127 +++++++++-----------------
>   drivers/s390/crypto/vfio_ap_private.h |   4 +-
>   5 files changed, 77 insertions(+), 100 deletions(-)
>

