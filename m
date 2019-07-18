Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726513AbfGRNBh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 09:01:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6ICwG9O031445
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 09:01:35 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ttqxq3j9e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 09:01:34 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 18 Jul 2019 14:01:31 +0100
Date: Thu, 18 Jul 2019 15:01:23 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] s390/mm: Remove sev_active() function
In-Reply-To: <20190718084456.GE24562@lst.de>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
        <20190718032858.28744-7-bauerman@linux.ibm.com>
        <20190718084456.GE24562@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190718150123.4230a00c.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

On Thu, 18 Jul 2019 10:44:56 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > -/* are we a protected virtualization guest? */
> > -bool sev_active(void)
> > -{
> > -	return is_prot_virt_guest();
> > -}
> > -
> >  bool force_dma_unencrypted(struct device *dev)
> >  {
> > -	return sev_active();
> > +	return is_prot_virt_guest();
> >  }
> 
> Do we want to keep the comment for force_dma_unencrypted?

Yes we do. With the comment transferred:

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
