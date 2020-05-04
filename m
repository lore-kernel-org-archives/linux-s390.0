Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728983AbgEDPoX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 11:44:23 -0400
Date: Mon, 4 May 2020 18:44:10 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: linux-next: Tree for May 4 --> mm: free_area_init: allow
 defining max_zone_pfn in descending order does increase memory use
Message-ID: <20200504154410.GF342687@linux.ibm.com>
References: <20200504173547.2cdd83bf@canb.auug.org.au>
 <9e9edd1e-6653-a585-0e22-69930a07dce1@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9edd1e-6653-a585-0e22-69930a07dce1@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Hartmayer <mhartmay@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Ho Christian,

On Mon, May 04, 2020 at 04:50:06PM +0200, Christian Borntraeger wrote:
> Mike,
> commit 51a2f644fd020d5f090044825c388444d11029d ("mm: free_area_init: allow defining max_zone_pfn in descending order")
> does increase the memory use on s390 (e.g. 700 MB vs.1.8 GB).
> 
> Something is odd in this patch. Any idea?

Yeah, this patch is buggy. In short, it breaks zone size calculation on
s390 and some other architectures.

I've just replied at [1] with more details and a fix.

[1] https://lore.kernel.org/linux-mm/20200504153901.GM14260@kernel.org/

-- 
Sincerely yours,
Mike.
