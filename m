Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7F5C47082
	for <linux-s390@archiver.kernel.org>; Wed, 26 May 2021 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0716139A
	for <linux-s390@archiver.kernel.org>; Wed, 26 May 2021 12:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhEZMjk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 May 2021 08:39:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39990 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233524AbhEZMjj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 May 2021 08:39:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QCXwCc071474;
        Wed, 26 May 2021 08:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y/ZAm0hc6y8atguqC+GcaNI2BLv4kgCtQsr6ztIfTKs=;
 b=I4zuADPdMujvWFQEzoAHMzXv4K2/IXa8M0GsKs3tuNrTPRX3tU8wYLwZgfg7ulkgy/pj
 5G0kSuS2FtnEmwnUhcvwJcoSSXamtkhoGZ7UzXl+0DT9Zz1QaQaQAgg9Vkc1TjQqqHBD
 iVBhmYFfXsercWLa8WlKi5HpDyxScWWwCxQcSzjFejbn0WCnZ3MBpEvOSrXD9mLQzWAa
 Ktain9bRh+QdU1BgmYZeYyroYaPGyGrEzbnWfWugqC8zxPEtBgQhQLHKWJ2cgBgm+rXy
 jHyCq+bO+cXjzvfUV2VZXQmPX/tsGxMkMiutwoOBKOiP344Bu83bZktwNsDVZD56gckx ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sp5p0uft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 08:38:04 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14QCYfIC076661;
        Wed, 26 May 2021 08:38:04 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sp5p0ufb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 08:38:04 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14QCaVXx028897;
        Wed, 26 May 2021 12:38:03 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 38s1ggah7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 12:38:03 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14QCc17w28115408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 12:38:02 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFAEB136055;
        Wed, 26 May 2021 12:38:01 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97966136060;
        Wed, 26 May 2021 12:38:00 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 May 2021 12:38:00 +0000 (GMT)
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
Message-ID: <1eda14a0-fdcb-0d47-b1ed-1a1f5847efe8@linux.ibm.com>
Date:   Wed, 26 May 2021 08:37:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525150337.021aabd8.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eO8zM1RmyBDg-hiGg8DFI5E-nOvur_PG
X-Proofpoint-ORIG-GUID: oqQIiT39Wa3hIhvfbTS-OJDKPqDL1ul7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_08:2021-05-26,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260084
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
> after free error. I'm a little confused by the fact that we want this
> one for stable, but the patch that fixes the use after free as no
> Cc stable (it can't have a proper fixes tag, because this one is not yet
> merged). Actually I'm not a big fan of splitting up patches to the
> extent that when not all patches of the series are applied we get bugous
> behavior (e.g. patch n breaks something that is live at patch n level,
> but it is supposed to be OK, because patch n+m is going to fix it (where
> n,m \in \Z^{+}).

After thinking about this some more, this patch does not really
fix a memory leak and should probably not be flagged as a fix
for 258287c994. Memory is not leaked
because the remove callback returns -EBUSY without freeing
mdev storage or resetting the queues.

Under normal circumstances, if the mdev is removed before
the mdev fd is closed (i.e., the guest is shut down), the process
will wait until the fd is closed, at which time the
release callback will get invoked. Since the release callback
clears the KVM pointer from the matrix_mdev, the remove
callback will not return -EBUSY and will in fact free the mdev
storage when it is subsequently invoked.

I am going to change the subject and remove the 'Fixes'
tag as well as the 'Cc' of stable. I'll change the subject to
something like:

"s390/vfio-ap: always free storage for mdev in remove callback"

>
> Do we want to squash these? Is the use after free possible prior to this
> patch?
>
> Regards,
> Halil

