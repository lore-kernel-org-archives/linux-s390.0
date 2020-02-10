Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730186AbgBJM4p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 07:56:45 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ACnHJT043472
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:56:43 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u9nw9hp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 07:56:43 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 12:56:41 -0000
Subject: Re: [PATCH/RFC] KVM: s390: protvirt: pass-through rc and rrc
References: <62d5cd46-93d7-e272-f9bb-d4ec3c7a1f71@de.ibm.com>
 <20200210114526.134769-1-borntraeger@de.ibm.com>
 <a94f3d09-1474-29d2-a2d3-3118170e494e@de.ibm.com>
 <20200210135040.24f06b8e.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 13:56:36 +0100
MIME-Version: 1.0
In-Reply-To: <20200210135040.24f06b8e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b99afb71-c8cb-0608-6583-99ac482f8322@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: thuth@redhat.com, Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, david@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com



On 10.02.20 13:50, Cornelia Huck wrote:
> On Mon, 10 Feb 2020 13:06:19 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> What about the following. I will rip out RC and RRC but add 
>> a 32bit flags field (which must be 0) and 3*64 bit reserved.
> 
> Probably dumb question: How are these new fields supposed to be used?

This was planned for error handling in QEMU. As we have no user of rc/rrc
yet, I have ripped that out and added a flag field + 16 bytes of reserved.
Usage is as usual flags must be 0. When flags!=0 the reserved fields will
have a new meaning. 
