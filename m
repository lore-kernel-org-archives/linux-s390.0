Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgD2Rbs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 13:31:48 -0400
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
 <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <b077744e-65be-f89c-55bb-4fc0f712eb76@de.ibm.com>
Date: Wed, 29 Apr 2020 19:31:22 +0200
MIME-Version: 1.0
In-Reply-To: <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, peterz@infradead.org, sean.j.christopherson@intel.com



On 29.04.20 18:07, Dave Hansen wrote:
> On 4/28/20 3:50 PM, Claudio Imbrenda wrote:
>> If a page is inaccesible and it is used for things like sendfile, then
>> the content of the page is not always touched, and can be passed
>> directly to a driver, causing issues.
>>
>> This patch fixes the issue by adding a call to arch_make_page_accessible
>> in page_cache_pipe_buf_confirm; this fixes the issue.
> 
> I spent about 5 minutes putting together a patch:
> 
> 	https://sr71.net/~dave/intel/accessible.patch
> 
> It adds a page flag ("daccess") which starts out set.  It clears the
> flag it when the page is added to the page cache or mapped as anonymous.

And that of course does not work. Pages are not made unaccessible at a random
point in time. We do check for several page flags and page count before doing
so and we also do this while with paqe_ref_freeze to avoid several races.
I guess you just hit one of those.
