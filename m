Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA05EC11F64
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EF961997
	for <linux-s390@archiver.kernel.org>; Mon, 28 Jun 2021 20:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhF1UcB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:32:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233832AbhF1UcB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Jun 2021 16:32:01 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SK3xHh191629;
        Mon, 28 Jun 2021 16:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=T/X0AWFySB1qm7I+J/JXYaQ73ERSk11h084c2j+kwVI=;
 b=pGv/neZhrkIK/1BPXjllwBhBFMpgL/xzzv2ZWo34IY2Je0P6w11u3uuOfEWTtzY4vaeM
 QiaInQM4W26BR2lnxZ/auDcLm3yzwDzgTpXffkJrXHd8Ew21nc51LhSi5x5SpzA88gC5
 w9Wl6pJbWMS4bK9CkX7AkDreNWQmifOesUdJZNa4Mdl2XcTk2TePFftX6uJCHb7pbfUf
 qOuQjZGTFOfhjVALEbSvZd28dzjP8rnlvxf2Q8LKLYSUc+VrsG7GynHtpMpcoElhIOOs
 W2H5yZjVoUm1LZ8H6dZCv2G/BXlLdtAsMcjF/KTTk10QBJKtB2NbW0x3hK+2Kyw/9e7F Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39fkkv2t24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 16:29:32 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SK56Y2001551;
        Mon, 28 Jun 2021 16:29:32 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39fkkv2t1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 16:29:32 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SKTUhD031338;
        Mon, 28 Jun 2021 20:29:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 39duv8ggea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 20:29:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SKTQnH33358194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 20:29:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24F1B4C058;
        Mon, 28 Jun 2021 20:29:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 322884C050;
        Mon, 28 Jun 2021 20:29:25 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.75.254])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 28 Jun 2021 20:29:25 +0000 (GMT)
Date:   Mon, 28 Jun 2021 22:29:23 +0200
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
Message-ID: <20210628222923.21a257c8.pasic@linux.ibm.com>
In-Reply-To: <20210625220758.80365-1-akrowiak@linux.ibm.com>
References: <20210625220758.80365-1-akrowiak@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CxEU1N4YCnkFLEJR_l64zXtq4GeWgF-v
X-Proofpoint-ORIG-GUID: ogAhWMHvtvD9I7kNlCQWJZDuvllyqwBt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106280129
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 25 Jun 2021 18:07:58 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

What is a suitable base for this patch. I've tried the usual suspects,
but none of them worked.

> The fix to resolve a lockdep splat while handling the
> VFIO_GROUP_NOTIFY_SET_KVM event introduced a kvm_busy flag indicating that
> the vfio_ap device driver is busy setting or unsetting the KVM pointer.
> A wait queue was employed to allow functions requiring access to the KVM
> pointer to wait for the kvm_busy flag to be cleared. For the duration of
> the wait period, the mdev lock was unlocked then acquired again after the
> kvm_busy flag was cleared. This got rid of the lockdep report, but didn't
> really resolve the problem.

Can you please elaborate on the last point. You mean that we can have
circular locking even after 0cc00c8d4050, but instead of getting stuck in
on a lock we will get stuck on wait_event_cmd()? If that is it, please
state it clearly in the description, and if you can to it in the short
description.

> 
> This patch removes the the kvm_busy flag and wait queue as they are not
> necessary to resolve the lockdep splat problem. The wait queue was
> introduced to prevent changes to the matrix used to update the guest's
> AP configuration. The idea was that whenever an adapter, domain or control
> domain was being assigned to or unassigned from the matrix, the function
> would wait until the group notifier function was no longer busy with the
> KVM pointer.
> 
> The thing is, the KVM pointer value (matrix_mdev->kvm) is always set and
> cleared while holding the matrix_dev->lock mutex. The assignment and
> unassignment interfaces also lock the matrix_dev->lock mutex prior to
> checking whether the matrix_mdev->kvm pointer is set and if so, returns
> the -EBUSY error from the function. Consequently, there is no chance for
> an update to the matrix to occur while the guest's AP configuration is
> being updated.
> 
> Fixes: 0cc00c8d4050 ("s390/vfio-ap: fix circular lockdep when setting/clearing crypto masks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
