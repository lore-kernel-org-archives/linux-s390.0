Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727245AbfGLV4F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 17:56:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CLqI69085485
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 17:56:03 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tq1edjewf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 17:56:03 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 12 Jul 2019 22:56:02 +0100
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-4-bauerman@linux.ibm.com> <20190712150912.3097215e.pasic@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86 arch code
In-reply-to: <20190712150912.3097215e.pasic@linux.ibm.com>
Date: Fri, 12 Jul 2019 18:55:47 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tvbqgboc.fsf@morokweng.localdomain>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, "Lendacky, Thomas" <thomas.lendacky@amd.com>


[ Cc'ing Tom Lendacky which I forgot to do earlier. Sorry about that. ]

Hello Halil,

Thanks for the quick review.

Halil Pasic <pasic@linux.ibm.com> writes:

> On Fri, 12 Jul 2019 02:36:31 -0300
> Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
>
>> Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
>> appear in generic kernel code because it forces non-x86 architectures to
>> define the sev_active() function, which doesn't make a lot of sense.
>
> sev_active() might be just bad (too specific) name for a general
> concept. s390 code defines it drives the right behavior in
> kernel/dma/direct.c (which uses it).

I thought about that but couldn't put my finger on a general concept.
Is it "guest with memory inaccessible to the host"?

Since your proposed definiton for force_dma_unencrypted() is simply to
make it equivalent to sev_active(), I thought it was more
straightforward to make each arch define force_dma_unencrypted()
directly.

Also, does sev_active() drive the right behavior for s390 in
elfcorehdr_read() as well?

>> To solve this problem, add an x86 elfcorehdr_read() function to override
>> the generic weak implementation. To do that, it's necessary to make
>> read_from_oldmem() public so that it can be used outside of vmcore.c.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  arch/x86/kernel/crash_dump_64.c |  5 +++++
>>  fs/proc/vmcore.c                |  8 ++++----
>>  include/linux/crash_dump.h      | 14 ++++++++++++++
>>  include/linux/mem_encrypt.h     |  1 -
>>  4 files changed, 23 insertions(+), 5 deletions(-)
>
> Does not seem to apply to today's or yesterdays master.

It assumes the presence of the two patches I mentioned in the cover
letter. Only one of them is in master.

I hadn't realized the s390 virtio patches were on their way to upstream.
I was keeping an eye on the email thread but didn't see they were picked
up in the s390 pull request. I'll add a new patch to this series making
the corresponding changes to s390's <asm/mem_encrypt.h> as well.

--
Thiago Jung Bauermann
IBM Linux Technology Center
