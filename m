Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44968 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgGCPtG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 11:49:06 -0400
Date: Fri, 3 Jul 2020 17:48:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v1 0/9] s390: implement and optimize vmemmap_free()
Message-ID: <20200703154856.GA5294@osiris>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Fri, Jul 03, 2020 at 03:39:08PM +0200, David Hildenbrand wrote:
> This series is based on the latest s390/features branch [1]. It implements
> vmemmap_free(), consolidating it with vmem_add_range(), and optimizes it by
> - Freeing empty page tables (now also done for idendity mapping).
> - Handling cases where the vmemmap of a section does not fill huge pages
>   completely.

Nice! You implemented some things I "always wanted to do". Maybe I
should just do nothing and wait until patches appear ;)

Will take a look at the series next week. Thanks!
