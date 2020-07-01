Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgGAJYj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 05:24:39 -0400
Date: Wed, 1 Jul 2020 11:24:28 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v1] s390/extmem: remove stale -ENOSPC comment and handling
Message-ID: <20200701092428.GA5008@osiris>
References: <20200625150029.45019-1-david@redhat.com>
 <20200630084240.8283-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630084240.8283-1-david@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

On Tue, Jun 30, 2020 at 10:42:40AM +0200, David Hildenbrand wrote:
> segment_load() will no longer return -ENOSPC. If a segment overlaps with
> storage, we now also return -EBUSY. Remove the stale comment from
> __segment_load() and the stale handling from segment_warning().
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/extmem.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied, thanks!
