Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729672AbfLEQJn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 11:09:43 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5G5wvD091122
        for <linux-s390@vger.kernel.org>; Thu, 5 Dec 2019 11:09:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wq2tuqsvt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Dec 2019 11:09:41 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 5 Dec 2019 16:09:39 -0000
Date: Thu, 5 Dec 2019 17:09:30 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: ENOTSUPP -> EOPNOTSUPP fixups
References: <20191205125147.229367-1-borntraeger@de.ibm.com>
 <087b1693-6ec0-94e3-d94a-f55c2e717438@redhat.com>
 <26f905be-3f09-3b3b-3008-ef64fc93e36c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f905be-3f09-3b3b-3008-ef64fc93e36c@de.ibm.com>
Message-Id: <20191205160930.GA13800@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>

On Thu, Dec 05, 2019 at 02:16:02PM +0100, Christian Borntraeger wrote:
> On 05.12.19 14:09, Thomas Huth wrote:
> > On 05/12/2019 13.51, Christian Borntraeger wrote:
> >> There is no ENOTSUPP for userspace
> >>
> >> Reported-by: Julian Wiedmann <jwi@linux.ibm.com>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >> -		return -ENOTSUPP;
> >> +		return -EOPNOTSUPP;
> > There seems to be another one in arch/s390/include/asm/uv.h, are you
> > going to fix that, too?
> I looked into that but it seemed that this is not exposed to
> userspace and just kept internal.

Could you remove that one as well, please? Otherwise people start
copy-pasting this (again). I thought we got rid of them all, and now
they crept in again.

Same for dasd ioctl code...
