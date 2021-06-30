Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45BCC11F66
	for <linux-s390@archiver.kernel.org>; Wed, 30 Jun 2021 22:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6EC613BE
	for <linux-s390@archiver.kernel.org>; Wed, 30 Jun 2021 22:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhF3WmV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 30 Jun 2021 18:42:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231738AbhF3WmV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Jun 2021 18:42:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UMWvts013953;
        Wed, 30 Jun 2021 18:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=XF9LXw97KbrWeexwgFcYihS7dv/08lNCr1HaI4KSSyc=;
 b=Wra1955mf2c9XdAAtj0aruEi3/s/YZ9b/ODxb3jbO64xenUIg6Rfx9QAq7gMuUtWMX98
 ngFviuVjh6d3pRNGgIqf8bZwzr09yTkYV1cIxAlevFp1Ds57ILmZHQp8aRuTScsg3H7W
 9PO4iN79jnQUYwHGDeKxKu6jyNaSPECs6I5zEyGMx98irB38gPIX1pUD+PSRJBKi/yFe
 KTRPzpymz+aK4RrDHpXPvFafn/pv7tMGjLlVI/evxEyfpjauMwAIvuV+dcQmjlbQxnHN
 0zyMbqz/2WXtQaJ14i2AMWdVBARBn6ekNRAiosV+n8FB+W4dqtPAYPEp0Zb+bUy8Cf97 BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39gya2bqck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 18:39:49 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15UMawFO029506;
        Wed, 30 Jun 2021 18:39:49 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39gya2bqc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 18:39:49 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UMYxaM019075;
        Wed, 30 Jun 2021 22:39:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 39duv8h1sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 22:39:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UMdiJu33685912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 22:39:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04B984C720;
        Wed, 30 Jun 2021 22:39:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 178D04C71D;
        Wed, 30 Jun 2021 22:39:43 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.76.157])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 30 Jun 2021 22:39:42 +0000 (GMT)
Date:   Thu, 1 Jul 2021 00:39:41 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not use open locks during
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210701003941.685c524c.pasic@linux.ibm.com>
In-Reply-To: <25edecce-0795-3b00-a155-bfcc8499f1be@linux.ibm.com>
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
        <20210628222923.21a257c8.pasic@linux.ibm.com>
        <25edecce-0795-3b00-a155-bfcc8499f1be@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0hvPfn6d3l8rV4eSCTe3wfM8CqMfSgoI
X-Proofpoint-GUID: v0Tt5zak2VZWRRYP57SUiRuzIN0pgdMO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_12:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300126
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 30 Jun 2021 10:31:22 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 6/28/21 4:29 PM, Halil Pasic wrote:
> > On Fri, 25 Jun 2021 18:07:58 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >
> > What is a suitable base for this patch. I've tried the usual suspects,
> > but none of them worked.  
> 
> I discovered what the problem is here. The patch is based on our
> master branch along with the two pre-requisite patches that were
> recently reviewed and are currently being merged. The two patches
> of which I speak are:
> * [PATCH v6 1/2] s390/vfio-ap: clean up mdev resources when remove 
> callback invoked
>     Message ID: <20210621155714.1198545-2-akrowiak@linux.ibm.com>
> 
> * [PATCH v6 2/2] s390/vfio-ap: r/w lock for PQAP interception handler 
> function pointer
>     <20210621155714.1198545-3-akrowiak@linux.ibm.com>
> 
> I probably should have included those along with this one.

Either that, or state in the cover letter that those are prerequisites.

> 
> >  
> >> The fix to resolve a lockdep splat while handling the
> >> VFIO_GROUP_NOTIFY_SET_KVM event introduced a kvm_busy flag indicating that
> >> the vfio_ap device driver is busy setting or unsetting the KVM pointer.
> >> A wait queue was employed to allow functions requiring access to the KVM
> >> pointer to wait for the kvm_busy flag to be cleared. For the duration of
> >> the wait period, the mdev lock was unlocked then acquired again after the
> >> kvm_busy flag was cleared. This got rid of the lockdep report, but didn't
> >> really resolve the problem.  
> > Can you please elaborate on the last point. You mean that we can have
> > circular locking even after 0cc00c8d4050, but instead of getting stuck in
> > on a lock we will get stuck on wait_event_cmd()? If that is it, please
> > state it clearly in the description, and if you can to it in the short
> > description.  
> 
> This patch was in response to the following review comments made by Jason
> Gunthorpe:
> 
> * Message ID: <20210525162927.GC1002214@nvidia.com>
>     "... the kvm_busy should be replaced by a proper rwsem,
>      don't try to open code locks like that - it just defeats lockdep
>      analysis".
> 
> * Message ID: <20210527112433.GX1002214@nvidia.com>
>     "Usually when people start open coding locks it is often
>     because lockdep complained. Open coding a lock makes
>     lockdep stop because the lockdep code
>     is removed, but it doesn't fix anything. The kvm_busy
>     should be replaced by a proper rwsem, don't try to
>     open code locks like that - it just defeats lockdep
>     analysis."
> 
> I will paraphrase and include the information from Jason's
> comments in the description.
>

This does not answer my questions.

I'm in favor of Jason's proposal, because it is much easier to
comprehend simple rwsem protected than a mutex + wait_queue dance. 

I think Jason was talking about open coding locks in general. I don't
consider it as proof of commit 0cc00c8d4050 not doing what it
advertised. You can add a Suggested-by tag if you like, but you should
be able to tell us what is the merit of your patch.

Regards,
Halil

