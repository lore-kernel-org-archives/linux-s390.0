Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgCMMEp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Mar 2020 08:04:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DBwdjk051908
        for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2020 08:04:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yr0ch3wre-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2020 08:04:44 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 13 Mar 2020 12:04:40 -0000
Subject: Re: [PATCH -next 018/491] KERNEL VIRTUAL MACHINE for s390 (KVM/s390):
 Use fallthrough;
References: <cover.1583896344.git.joe@perches.com>
 <d63c86429f3e5aa806aa3e185c97d213904924a5.1583896348.git.joe@perches.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 13 Mar 2020 13:04:35 +0100
MIME-Version: 1.0
In-Reply-To: <d63c86429f3e5aa806aa3e185c97d213904924a5.1583896348.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <354d7bd6-025a-6012-523a-e82d4a99cf77@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joe Perches <joe@perches.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org


On 11.03.20 05:51, Joe Perches wrote:
> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

I have applied this with a fixed link.

> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/s390/kvm/gaccess.c   | 23 +++++++++++++----------
>  arch/s390/kvm/interrupt.c |  2 +-
>  arch/s390/kvm/kvm-s390.c  |  4 ++--
>  arch/s390/mm/gmap.c       |  6 +++---
>  4 files changed, 19 insertions(+), 16 deletions(-)
[...]
