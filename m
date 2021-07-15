Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ADDC07E96
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 11:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418D06128B
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 11:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbhGOLem (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 07:34:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232053AbhGOLem (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 07:34:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FB7rST123877;
        Thu, 15 Jul 2021 07:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wCXl4FvOWveYn9wbajsePCiSohZfjrdllQOmsbMAstE=;
 b=X9EUIvIIf/XPVyEPzC6kUdsJeL6N8OfxKTRQ9AhX7+1geLLeQGsyMdMW1pYpX58UfhiK
 BNE74VgP5pKuE4cif0gJ0weeXMKA5KjdGFhSKFrTBEGt4yIYI83xRfskb6rBdQUGtj/K
 ob9+03zMVw545PC5dflUHRthiCtg2F66Ilx9s1Sd04Srk533Z85Y8aOuxYA2NU0Knjc7
 py+3P52OpUF7dmDEsOj2Lt88EbPr34yGk3DTKyzjlulY3PKUPZKSanUwL0DnqPYplkPJ
 xLZhR3YHPS2hc2JyFD/lCHK24tMx8u4BPWix05PGt6Nz46wu/KD+JUMtW++XMB4i3ZRq WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ssjyhyjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 07:31:47 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16FBMtUI029606;
        Thu, 15 Jul 2021 07:31:47 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ssjyhyj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 07:31:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16FBSgUJ003708;
        Thu, 15 Jul 2021 11:31:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 39q368a7mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 11:31:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16FBTVNP30540124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 11:29:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49A77A4051;
        Thu, 15 Jul 2021 11:31:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94562A4053;
        Thu, 15 Jul 2021 11:31:39 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.60.220])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 15 Jul 2021 11:31:39 +0000 (GMT)
Date:   Thu, 15 Jul 2021 13:31:36 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210715133136.420c40b0.pasic@linux.ibm.com>
In-Reply-To: <20210713170533.GF136586@nvidia.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
        <20210713013815.57e8a8cb.pasic@linux.ibm.com>
        <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
        <20210713184517.48eacee6.pasic@linux.ibm.com>
        <20210713170533.GF136586@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M7C7Qdb47fVnIGoCjIeERrfNdMs9JJ_q
X-Proofpoint-ORIG-GUID: rda3AXTI5-RzYAVZKYePuPDir_dZqCuO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_07:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Jul 2021 14:05:33 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jul 13, 2021 at 06:45:17PM +0200, Halil Pasic wrote:
> 
> > Jason may give it another try to convince us that 0cc00c8d4050 only
> > silenced lockdep, but vfio_ap remained prone to deadlocks. To my best
> > knowledge using condition variable and a mutex is one of the well known
> > ways to implement an rwlock.   
> 
> The well known pattern is to use a rwsem.

I think you are missing the point. We are discussing whether
this qualifies for stable, i.e. if 0cc00c8d4050 is really broken
like the patch description says.

Using  a readers-writers lock (as a primitive) to implement a
a readers-writers lock is a fallacy, so I guess you wanted to
say that when a readers-writers lock is needed in the kernel the
obvious choices are rw_semaphore and/or rwlock_t (depending on the
spin).

What I wanted to say is using a condition variable and a mutex is
not per-see wrong, because one can even implement an readers-writers
lock with it. For reference see https://en.wikipedia.org/wiki/Readers%E2%80%93writer_lock


> 
> This:
>         wait_event_cmd(matrix_mdev->wait_for_kvm,
>                        !matrix_mdev->kvm_busy,
>                        mutex_unlock(&matrix_dev->lock),
>                        mutex_lock(&matrix_dev->lock));
> 
> 
> Is not really a rwsem, and is invsible to lockdep.
> 

I agree. But this is not a proof of a problem that qualifies to be fixed
using the stable process as documented in 
https://github.com/torvalds/linux/blob/master/Documentation/process/stable-kernel-rules.rst

I'm in favor of rewriting this to use rw_semaphore. I'm not in favor
of proclaiming this a fix for stable, because for that you first have
to prove that you fix a real problem.

I hope we are on the same page.

Regards,
Halil 
