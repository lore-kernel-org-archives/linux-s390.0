Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729188AbgF2TDG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Jun 2020 15:03:06 -0400
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
References: <20200625150029.45019-1-david@redhat.com>
 <20200626192253.2281d95d@thinkpad> <20200626204621.55248f99@thinkpad>
 <20200629115537.GC4468@osiris>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0c783dbb-630c-6440-74b8-8b40af146d6a@redhat.com>
Date: Mon, 29 Jun 2020 14:01:22 +0200
MIME-Version: 1.0
In-Reply-To: <20200629115537.GC4468@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On 29.06.20 13:55, Heiko Carstens wrote:
> On Fri, Jun 26, 2020 at 08:46:21PM +0200, Gerald Schaefer wrote:
>> Verified with DCSS overlapping boot and standby memory, works fine.
>> As expected, the error message changes, but I don't think that is a
>> problem, as long as you also remove the old -ENOSPC case / comment
>> in arch/s390/mm/extmem.c. It is actually more correct now I guess,
>> -ENOSPC doesn't look like the correct return value anyway.
>>
>> Thanks for cleaning up! Looks good to me, and removes > 100 LOC,
>> unless Heiko remembers some other issues from ancient times.
>>
>> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>> Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> [DCSS]
> 
> Looks good to me too. Gerald, thanks for looking and verifying this,
> and David, thanks for providing the patch.
> 
> Applied.
> 

Thanks Gerald and Heiko! Should I send an addon patch to tweak the
documentation or resend this patch?

-- 
Thanks,

David / dhildenb
