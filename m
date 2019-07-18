Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726608AbfGRQl6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 12:41:58 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IGauDl065901
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 12:41:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ttu62kkwh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 12:41:56 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 18 Jul 2019 17:41:55 +0100
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <20190718032858.28744-7-bauerman@linux.ibm.com> <20190718084456.GE24562@lst.de>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] s390/mm: Remove sev_active() function
In-reply-to: <20190718084456.GE24562@lst.de>
Date: Thu, 18 Jul 2019 13:41:25 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d0i747nu.fsf@morokweng.localdomain>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>


Christoph Hellwig <hch@lst.de> writes:

>> -/* are we a protected virtualization guest? */
>> -bool sev_active(void)
>> -{
>> -	return is_prot_virt_guest();
>> -}
>> -
>>  bool force_dma_unencrypted(struct device *dev)
>>  {
>> -	return sev_active();
>> +	return is_prot_virt_guest();
>>  }
>
> Do we want to keep the comment for force_dma_unencrypted?
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you for your review on al these patches.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
