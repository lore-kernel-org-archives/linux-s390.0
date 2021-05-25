Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DAEC2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 15:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B487361284
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 15:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhEYP62 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 11:58:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231918AbhEYP61 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 11:58:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PFXewf161867;
        Tue, 25 May 2021 11:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sWpa9lvpwKcGlvOMsTYGUtppmcEOL9ULWBsgRjkosaY=;
 b=k9vpN0jsT4DZTvOB5IXRN/v4xK4CRdIkHmFhNs/bQ7e7TzDIcruLb5+rN1pHbaGg82u2
 T3Dc0U4rNK5ajbmGkIAt6Kx01nDG1Jk0UojPzj02/RLkiSE1zNawNznvJULgOIX5eKjJ
 6II4F0I3VjM4OynH/UXEG/XAZ03F77+yxaAGnw5vWu0ZuL+jYGkfqcJPS332gGO6GsMs
 5xtxhwSha5hDJ+A9OAFmFJAPnyk/hbiTTXqw5IvBGHxJpE+wX30c1TU9kq1FStpBbWB7
 LlBWKOMByYmSlgzjjr1+4r8tzyF9nrri0xb3cWEZ8sUsbUh8yCxkCMDVf4YEWPVaPdnh gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s2xvbw3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 11:56:54 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PFXh8p162351;
        Tue, 25 May 2021 11:56:54 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s2xvbw2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 11:56:54 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PFqKGq003471;
        Tue, 25 May 2021 15:56:53 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 38s1hbhurg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 15:56:53 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PFuqfS23265758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 15:56:52 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E90D4136065;
        Tue, 25 May 2021 15:56:51 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB891136061;
        Tue, 25 May 2021 15:56:50 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 15:56:50 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     jjherne@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
 <20210521193648.940864-3-akrowiak@linux.ibm.com>
 <5d15fdf2-aee8-4e6c-c3e1-f07c76ce5974@linux.ibm.com>
 <e2bed0a6-f5e2-0a69-22b9-1b304cbe1362@linux.ibm.com>
 <20210525131912.GW1002214@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <c54ef522-f348-df16-a99f-1e31feb1b0bd@linux.ibm.com>
Date:   Tue, 25 May 2021 11:56:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525131912.GW1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iIWHI-nYv2T0RPAeA9u62p6lt1ykuN8u
X-Proofpoint-GUID: TTqWzYM-uuNS8hmGKB0h1U9sxqDlH2fn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_07:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250094
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


> Why can't you put the locks in the right order? It looked trivial, I'm confused.
>
> Jason

I explained this in one of my responses to the previous series. Maybe I 
didn't do
a good job of it, so let me see if I can provide a more thorough 
explanation.

The handle_pqap() function in priv.c does not have any access to the
matrix_dev->lock which lives in the vfio_ap module, so there is no
way for this function to control the order of locking. The only lock
it can access is the lock provided for the hook function pointer which
must be held for the duration of the execution of the hook. When the
hook function (handle_pqap() in vfio_ap_ops.c) is called, it has to lock
the matrix_dev->lock mutex to do its thing. The interception of the
PQAP instruction that sets off the above scenario can happen simultaneously
with both the vfio_ap_mdev_set_kvm() and vfio_ap_mdev_unset_kvm()
instructions in vfio_ap_ops.c.

The vfio_ap_mdev_set_kvm() function is called only by the group notifier
callback when the vfio_ap driver is notified that the KVM pointer has 
been set.
In this case, we could set the lock for the hook function before setting
the matrix_dev->lock and calling the vfio_ap_mdev_set_kvm() function and
all would be well.

The vfio_ap_mdev_unset_kvm() function, however, is called both by the group
notifier when the KVM pointer has been cleared or when the mdev is
being removed. In both cases, the only way to get the KVM pointer - which
is needed to unplug the AP resources from the guest - is from the 
matrix_mdev
which contains it. This, of course, needs to be done while holding the
matrix_dev->lock mutex. The vfio_ap_mdev_unset_kvm() function also
clears the hook function pointer, but can only get the lock used to 
control access
to it from the matrix_mdev; therein lies the rub. So we can have the 
following
scenario which is flagged by lockdep:

CPU x:                                            CPU y:
--------                                             --------
                                                       lock the 
matrix_dev->lock:
vfio_ap_mdev_set_kvm in vfio_ap_ops.c

lock the hook pointer:
handle_pqap in priv.c

lock the matrix_dev->lock
handle_pqap in vfio_ap_ops.c

                                                       lock the hook 
pointer:
vfio_ap_mdev_set_kvm in vfio_ap_ops.c


Maybe I'm missing something, but I was unable to find a way around this when
the hook function pointer and its locking mechanism is stored in a field 
of a satellite
structure of struct kvm.



