Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728000AbgBQOPW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 09:15:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HEF8R4145383
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 09:15:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6af345j8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 09:15:20 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <uweigand@de.ibm.com>;
        Mon, 17 Feb 2020 14:15:18 -0000
Date: Mon, 17 Feb 2020 15:15:11 +0100
From: Ulrich Weigand <uweigand@de.ibm.com>
Subject: Re: [PATCH v2 40/42] example for future extension: mm:gup/writeback:
 add callbacks for inaccessible pages: source indication
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-41-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214222658.12946-41-borntraeger@de.ibm.com>
Message-Id: <20200217141511.GA14704@oc3748833570.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>

On Fri, Feb 14, 2020 at 05:26:56PM -0500, Christian Borntraeger wrote:
> +enum access_type {
> +	MAKE_ACCESSIBLE_GENERIC,
> +	MAKE_ACCESSIBLE_GET,
> +	MAKE_ACCESSIBLE_GET_FAST,
> +	MAKE_ACCESSIBLE_WRITEBACK
> +};
>  #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
> -static inline int arch_make_page_accessible(struct page *page)
> +static inline int arch_make_page_accessible(struct page *page, int where)

If we want to make this distinction, wouldn't it be simpler to just
use different function names, like
  arch_make_page_accessible_for_writeback
  arch_make_page_accessible_for_gup
etc.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  GNU/Linux compilers and toolchain
  Ulrich.Weigand@de.ibm.com
