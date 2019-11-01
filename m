Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727771AbfKAIu1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Nov 2019 04:50:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA18lJcw083148
        for <linux-s390@vger.kernel.org>; Fri, 1 Nov 2019 04:50:25 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w0h7r8n16-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 01 Nov 2019 04:50:25 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 1 Nov 2019 08:50:23 -0000
Date: Fri, 1 Nov 2019 09:50:16 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
In-Reply-To: <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-10-frankja@linux.ibm.com>
        <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
        <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
        <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20191101095016.0562fa76@p-imbrenda.boeblingen.de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On Thu, 31 Oct 2019 18:30:30 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 31.10.19 16:41, Christian Borntraeger wrote:
> > 
> > 
> > On 25.10.19 10:49, David Hildenbrand wrote:  
> >> On 24.10.19 13:40, Janosch Frank wrote:  
> >>> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> >>>
> >>> Pin the guest pages when they are first accessed, instead of all
> >>> at the same time when starting the guest.  
> >>
> >> Please explain why you do stuff. Why do we have to pin the hole
> >> guest memory? Why can't we mlock() the hole memory to avoid
> >> swapping in user space?  
> > 
> > Basically we pin the guest for the same reason as AMD did it for
> > their SEV. It is hard  
> 
> Pinning all guest memory is very ugly. What you want is "don't page", 
> what you get is unmovable pages all over the place. I was hoping that 
> you could get around this by having an automatic back-and-forth 
> conversion in place (due to the special new exceptions).

we're not pinning all of guest memory, btw, but only the pages that are
actually used.

so if you have a *huge* guest, only the few pages used by the kernel and
initrd are actually pinned at VM start. Then one by one the ones
actually used when the guest is running get pinned on first use.

I don't need to add anything regarding the other points since the other
have commented already :)
