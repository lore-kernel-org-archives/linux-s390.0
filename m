Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727730AbfGRO1n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 10:27:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IEJCuv095322
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 10:27:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tts6vm9gv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 10:27:42 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 18 Jul 2019 15:27:40 +0100
Date: Thu, 18 Jul 2019 16:27:35 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Is __dma_direct_alloc_pages broken on s390?
In-Reply-To: <20190718131059.GA18742@infradead.org>
References: <20190718091700.353b3721@ezekiel.suse.cz>
        <20190718113633.GB3581@osiris>
        <20190718135112.5c65685f@ezekiel.suse.cz>
        <20190718145044.03dc9804.pasic@linux.ibm.com>
        <20190718131059.GA18742@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190718162735.1559b561.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Petr Tesarik <ptesarik@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

On Thu, 18 Jul 2019 06:10:59 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Jul 18, 2019 at 02:50:44PM +0200, Halil Pasic wrote:
> > > I wondered why the kernel works OK on my system, and it is in fact not
> > > so bad. If the first allocation fails, the kernel adds GFP_DMA and
> > > retries, so this is not fatal, but with a proper definition of
> > > ARCH_ZONE_DMA_BITS it should be possible to get success in the first
> > > attempt already, let's do it.
> > > 
> > > Petr T
> > 
> > I fully agree! I will post a patch that provides correct
> > ARCH_ZONE_DMA_BITS for s390.
> > 
> > BTW I wonder if ARCH_ZONE_DMA_BITS can be inferred from MAX_DMA_ADDRESS,
> > and why do we need both.@Christoph, maybe you can help me understand if
> > there is a relationship between the two or not, or?
> 
> MAX_DMA_ADDRESS is a bit of a weird beast which I honestly do not
> understand fully, but most of the uses in common code look a little
> bogus, and we should probably get rid of it.

Thanks!

Regards,
Halil
