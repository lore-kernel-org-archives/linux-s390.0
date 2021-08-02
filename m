Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ED5C00143
	for <linux-s390@archiver.kernel.org>; Mon,  2 Aug 2021 13:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F2561216
	for <linux-s390@archiver.kernel.org>; Mon,  2 Aug 2021 13:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhHBN4f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:56:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235705AbhHBNyR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Aug 2021 09:54:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172DYWid155617;
        Mon, 2 Aug 2021 09:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=pPj6dAAf/pstG9xv4fqPWVScQVbjVCC2j4zlCq2/JOk=;
 b=dDStCavylTTnQy9SlKsQjd6piIMX8o0Qxa+D7WIwQ92JKJ8byjEAON22AOwh2sI11p2C
 TswyHKQgDAC50Z3hZcvMmyB99SBo9XElzgMzqN81gElQMWbryyJSkRLuOceYt1/1OaIQ
 A25ztKS/pPLmfObY419zDLnsdHK7Vvu/4juWXEJvqbHZTO0rnc18G3gbtpNT+eDbymt+
 2rWplk35zn3F6YSqAyRyv25GIrdgyVg1b0313wUy3i3xh4+nvpvWKSmV81J8ptPArzjK
 j8oVk3mYb0BPWQPVNtJKB2V1DSLBqwmucJYEZBivpaTE5B3QF55d7RQC6w2YNpTDRZS9 Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a5m01mhyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 09:54:07 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 172DYg5d156184;
        Mon, 2 Aug 2021 09:54:06 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a5m01mhxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 09:54:06 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 172DleSw014997;
        Mon, 2 Aug 2021 13:54:05 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3a4x58ce58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Aug 2021 13:54:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 172Ds1KM30015840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Aug 2021 13:54:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CCF6A406A;
        Mon,  2 Aug 2021 13:54:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D183BA4060;
        Mon,  2 Aug 2021 13:53:59 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.87.196])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  2 Aug 2021 13:53:59 +0000 (GMT)
Date:   Mon, 2 Aug 2021 15:53:55 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210802155355.22b98789.pasic@linux.ibm.com>
In-Reply-To: <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MOFS3Gyh8Ve1LlkpOGy8nTWHMAp8da-U
X-Proofpoint-GUID: _F1f2EQd7B7sAbw5nOQGbcQTKjCpUMsR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_05:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108020090
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 2 Aug 2021 09:10:26 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> PING!
> 
> This patch will pre-req version 17 of a patch series I have waiting in 
> the wings,
> so I'd like to get this one merged ASAP. In particular, if a KVM 
> maintainer can
> take a look at the comments concerning the taking of the kvm->lock 
> before the
> matrix_mdev->lock it would be greatly appreciated. Those comments begin with
> Message ID <20210727004329.3bcc7d4f.pasic@linux.ibm.com> from Halil Pasic.

As far as I'm concerned, we can move forward with this. Was this
supposed to go in via Alex's tree?

> 
> On 7/19/21 3:35 PM, Tony Krowiak wrote:
> > This series is actually only comprised of a single patch to replace the
> > open coded locks used during VFIO_GROUP_NOTIFY_SET_KVM notification. The
> > first patch is included because it is a pre-req slotted to be merged but is
> > not yet available in the kernel.
> >
> > Tony Krowiak (2):
> >    s390/vfio-ap: r/w lock for PQAP interception handler function pointer
> >    s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM
> >      notification
> >
> >   arch/s390/include/asm/kvm_host.h      |   8 +-
> >   arch/s390/kvm/kvm-s390.c              |  28 +++++-
> >   arch/s390/kvm/priv.c                  |  10 +-
> >   drivers/s390/crypto/vfio_ap_ops.c     | 127 +++++++++-----------------
> >   drivers/s390/crypto/vfio_ap_private.h |   4 +-
> >   5 files changed, 77 insertions(+), 100 deletions(-)
> >  
> 

