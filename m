Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1167 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727833AbgEDOuS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 10:50:18 -0400
Subject: Re: linux-next: Tree for May 4 --> mm: free_area_init: allow defining
 max_zone_pfn in descending order does increase memory use
References: <20200504173547.2cdd83bf@canb.auug.org.au>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <9e9edd1e-6653-a585-0e22-69930a07dce1@de.ibm.com>
Date: Mon, 4 May 2020 16:50:06 +0200
MIME-Version: 1.0
In-Reply-To: <20200504173547.2cdd83bf@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Marc Hartmayer <mhartmay@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Mike,
commit 51a2f644fd020d5f090044825c388444d11029d ("mm: free_area_init: allow defining max_zone_pfn in descending order")
does increase the memory use on s390 (e.g. 700 MB vs.1.8 GB).

Something is odd in this patch. Any idea?
