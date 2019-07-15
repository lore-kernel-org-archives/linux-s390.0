Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730937AbfGOUOe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 16:14:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FKBusl100352
        for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2019 16:14:33 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ts037rkme-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2019 16:14:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 15 Jul 2019 21:14:32 +0100
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-4-bauerman@linux.ibm.com> <20190712150912.3097215e.pasic@linux.ibm.com> <87tvbqgboc.fsf@morokweng.localdomain> <20190715160317.7e3dfb33.pasic@linux.ibm.com> <20190715143039.GA6892@lst.de>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86 arch code
In-reply-to: <20190715143039.GA6892@lst.de>
Date: Mon, 15 Jul 2019 17:14:04 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <875zo3njhv.fsf@morokweng.localdomain>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, "Lendacky, Thomas" <thomas.lendacky@amd.com>


Christoph Hellwig <hch@lst.de> writes:

> On Mon, Jul 15, 2019 at 04:03:17PM +0200, Halil Pasic wrote:
>> > I thought about that but couldn't put my finger on a general concept.
>> > Is it "guest with memory inaccessible to the host"?
>> >
>>
>> Well, force_dma_unencrypted() is a much better name thatn sev_active():
>> s390 has no AMD SEV, that is sure, but for virtio to work we do need to
>> make our dma accessible to the hypervisor. Yes, your "guest with memory
>> inaccessible to the host" shows into the right direction IMHO.
>> Unfortunately I don't have too many cycles to spend on this right now.
>
> In x86 it means that we need to remove dma encryption using
> set_memory_decrypted before using it for DMA purposes.  In the SEV
> case that seems to be so that the hypervisor can access it, in the SME
> case that Tom just fixes it is because there is an encrypted bit set
> in the physical address, and if the device doesn't support a large
> enough DMA address the direct mapping code has to encrypt the pages
> used for the contigous allocation.
>
>> Being on cc for your patch made me realize that things got broken on
>> s390. Thanks! I've sent out a patch that fixes protvirt, but we are going
>> to benefit from your cleanups. I think with your cleanups and that patch
>> of mine both sev_active() and sme_active() can be removed. Feel free to
>> do so. If not, I can attend to it as well.
>
> Yes, I think with the dma-mapping fix and this series sme_active and
> sev_active should be gone from common code.  We should also be able
> to remove the exports x86 has for them.
>
> I'll wait a few days and will then feed the dma-mapping fix to Linus,
> it might make sense to either rebase Thiagos series on top of the
> dma-mapping for-next branch, or wait a few days before reposting.

I'll rebase on top of dma-mapping/for-next and do the break up of patch
2 that you mentioned as well.

--
Thiago Jung Bauermann
IBM Linux Technology Center
