Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727505AbfIXGua (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Sep 2019 02:50:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8O6lpmq100628
        for <linux-s390@vger.kernel.org>; Tue, 24 Sep 2019 02:50:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v7cpu2q1d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Sep 2019 02:50:29 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 24 Sep 2019 07:50:26 +0100
Subject: Re: [RFC patch 00/15] entry: Provide generic implementation for host
 and guest entry/exit work
References: <20190919150314.054351477@linutronix.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 24 Sep 2019 08:50:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190919150314.054351477@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ae5c6329-4ddf-2243-3a86-fbfdfd029918@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>



On 19.09.19 17:03, Thomas Gleixner wrote:
> When working on a way to move out the posix cpu timer expiry out of the
> timer interrupt context, I noticed that KVM is not handling pending task
> work before entering a guest. A quick hack was to add that to the x86 KVM
> handling loop. The discussion ended with a request to make this a generic
> infrastructure possible with also moving the per arch implementations of
> the enter from and return to user space handling generic.
> 
>   https://lore.kernel.org/r/89E42BCC-47A8-458B-B06A-D6A20D20512C@amacapital.net
> 
> You asked for it, so don't complain that you have to review it :)
> 
> The series implements the syscall enter/exit and the general exit to
> userspace work handling along with the pre guest enter functionality.
> 
> The series converts x86 and ARM64. x86 is fully tested including selftests
> etc. ARM64 is only compile tested for now as my only ARM64 testbox is not
> available right now.

It seems that s390x would also need to look into TIF_NOTIFY_PENDING before
entering a KVM guest. Given that the s390x entry path is still in assembler
this might not be something to do quickly.

Would it make sense to actually start with a minimal solution (e.g. one that
provides notify_resume_pending like your original patch) as a fix. That would
also be simple to backport. And then we can do the proper rework on top.

Or do we consider anything that depends on TIF_NOTIFY_PENDING before entering
a guest as not important enough for stable?
After all the vcpu_run ioctl almost never returns to userspace and nothing 
was obviously broken.

Another question: Are there callbacks due to TIF_NOTIFY_PENDING that should
NOT happen as long as we stay in the vpcu loop?
