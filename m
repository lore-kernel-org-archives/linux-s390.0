Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28616 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727600AbgCCIHm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Mar 2020 03:07:42 -0500
Subject: Re: [PATCH v2 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200303002506.173957-1-imbrenda@linux.ibm.com>
 <20200303002506.173957-3-imbrenda@linux.ibm.com>
 <99903e77-7720-678e-35c5-6eb9e35e7fcb@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <21c62e25-c0f8-a9d4-5501-49fd660c6c81@redhat.com>
Date: Tue, 3 Mar 2020 09:07:32 +0100
MIME-Version: 1.0
In-Reply-To: <99903e77-7720-678e-35c5-6eb9e35e7fcb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: borntraeger@de.ibm.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>


> Your style earlier in the patch was easier on the reader, why not stay consistent
> with that (and with this file, which tends also to do this), so:
> 
> 		if (flags & FOLL_PIN) {
> 			ret = arch_make_page_accessible(page);
> 			if (ret) {
> 				unpin_user_page(page);
> 				goto pte_unmap;
> 			}
> 		}
> 

+1

-- 
Thanks,

David / dhildenb
