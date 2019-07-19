Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbfGSPrU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jul 2019 11:47:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6JFkebL118269
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 11:47:19 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tug6f1x16-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 11:47:19 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 19 Jul 2019 16:47:18 +0100
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <20190718032858.28744-6-bauerman@linux.ibm.com> <4a07bf75-b516-c81b-da7a-4b323e6d7e52@amd.com> <c85ae8ff-3b7b-88bf-6b6a-c41b159c9cc2@redhat.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 5/6] fs/core/vmcore: Move sev_active() reference to x86 arch code
In-reply-to: <c85ae8ff-3b7b-88bf-6b6a-c41b159c9cc2@redhat.com>
Date: Fri, 19 Jul 2019 12:47:03 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <87h87igh6w.fsf@morokweng.localdomain>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: lijiang <lijiang@redhat.com>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Baoquan He <bhe@redhat.com>


Hello Lianbo,

lijiang <lijiang@redhat.com> writes:

> 在 2019年07月19日 01:47, Lendacky, Thomas 写道:
>> On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
>>> Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
>>> appear in generic kernel code because it forces non-x86 architectures to
>>> define the sev_active() function, which doesn't make a lot of sense.
>>>
>>> To solve this problem, add an x86 elfcorehdr_read() function to override
>>> the generic weak implementation. To do that, it's necessary to make
>>> read_from_oldmem() public so that it can be used outside of vmcore.c.
>>>
>>> Also, remove the export for sev_active() since it's only used in files that
>>> won't be built as modules.
>>>
>>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> 
>> Adding Lianbo and Baoquan, who recently worked on this, for their review.
>> 
>
> This change looks good to me.
>
> Reviewed-by: Lianbo Jiang <lijiang@redhat.com>

Thanks for your review!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
