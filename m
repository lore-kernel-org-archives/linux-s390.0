Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26636C4707F
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056BE6141C
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhEYNXj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 09:23:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20256 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233070AbhEYNXi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 09:23:38 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PD2xQ8193391;
        Tue, 25 May 2021 09:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=K5Eg/Y8WBtC6LNWqswlZBHi6Sv18XbNTuKVd4d1ufVE=;
 b=nlEerzB41DQsQFLsy+dgHKVeu7+QdwPlUUWAy1oSgToJOV2nGDtJUTTWpXX2rBlGTo55
 p1WNGovxXPYR3uqxkZXdnTroMK6pKdV9A11zqI8TiEG729Gk/TDf/Cp85HlpOBjutsRX
 lUBdZQZyiqX8p0Phxo4OhdK9ZKb224NwC9n7tlRybamhqx+TEj/yKxKr+liBV4HTGMp1
 Jc/lYhp8gpkKbtPSG1W9bW/fPvt+f8wNFaoOyfbZEN0S6bJtdGpZHSmU75hvnNV7DLsl
 W+1MaED9afY/yvmpoBgZHjQ/z47+cgcqEzTdJylrNkH1Kv2NVf6yFlo9JDmIJ7HN7iFV tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38s1rt0nf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:22:06 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PD6cop015392;
        Tue, 25 May 2021 09:22:05 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38s1rt0nem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:22:05 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PDE3FL007881;
        Tue, 25 May 2021 13:22:05 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 38s1ghgam7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 13:22:05 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PDM4iw27001150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 13:22:04 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4530136055;
        Tue, 25 May 2021 13:22:03 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93BBD136076;
        Tue, 25 May 2021 13:22:02 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 13:22:02 +0000 (GMT)
Subject: Re: [PATCH v4 1/2] s390/vfio-ap: fix memory leak in mdev remove
 callback
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-2-akrowiak@linux.ibm.com>
 <20210525150337.021aabd8.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <876faab1-e401-8009-e855-a2c7aad340c9@linux.ibm.com>
Date:   Tue, 25 May 2021 09:22:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525150337.021aabd8.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tMOTg1NPDSwmlw7C25_l0OCdbto6kgN1
X-Proofpoint-GUID: t2d2WYG6zld_Ktlo_D26qe1wX4F3tTc6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_06:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/25/21 9:03 AM, Halil Pasic wrote:
> On Fri, 21 May 2021 15:36:47 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> The mdev remove callback for the vfio_ap device driver bails out with
>> -EBUSY if the mdev is in use by a KVM guest. The intended purpose was
>> to prevent the mdev from being removed while in use; however, returning a
>> non-zero rc does not prevent removal. This could result in a memory leak
>> of the resources allocated when the mdev was created. In addition, the
>> KVM guest will still have access to the AP devices assigned to the mdev
>> even though the mdev no longer exists.
>>
>> To prevent this scenario, cleanup will be done - including unplugging the
>> AP adapters, domains and control domains - regardless of whether the mdev
>> is in use by a KVM guest or not.
>>
>> Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> AFAIU we all agree that, after patch there is a possibility for an use
> after free error.

I am assuming here that you meant to say that after applying
patch 1/2, there is a possibility for a use after free error.

> I'm a little confused by the fact that we want this
> one for stable, but the patch that fixes the use after free as no
> Cc stable (it can't have a proper fixes tag, because this one is not yet
> merged). Actually I'm not a big fan of splitting up patches to the
> extent that when not all patches of the series are applied we get bugous
> behavior (e.g. patch n breaks something that is live at patch n level,
> but it is supposed to be OK, because patch n+m is going to fix it (where
> n,m \in \Z^{+}).
>
> Do we want to squash these? Is the use after free possible prior to this
> patch?

I am fine with squashing these if that is the consensus here. Prior
to this patch, the remove callback function returned -EBUSY
if a guest is still using the matrix_mdev (i.e., matrix_mdev->kvm
not NULL), so the matrix_mdev was not freed and hence the
memory leak for this this patch was designed to fix.

>
> Regards,
> Halil

