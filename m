Return-Path: <owner-linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] s390/mm: allow gmap code to retry on faulting in
 guest memory
References: <1447890598-56860-1-git-send-email-dingel@linux.vnet.ibm.com>
 <1447890598-56860-3-git-send-email-dingel@linux.vnet.ibm.com>
 <20151119091808.5d84c8ba@mschwide>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <564D8774.8090206@de.ibm.com>
Date: Thu, 19 Nov 2015 09:25:24 +0100
MIME-Version: 1.0
In-Reply-To: <20151119091808.5d84c8ba@mschwide>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Rientjes <rientjes@google.com>, Eric B Munson <emunson@akamai.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Mel Gorman <mgorman@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/19/2015 09:18 AM, Martin Schwidefsky wrote:
> On Thu, 19 Nov 2015 00:49:58 +0100
> Dominik Dingel <dingel@linux.vnet.ibm.com> wrote:
> 
>> The userfaultfd does need FAULT_FLAG_ALLOW_RETRY to not return
>> VM_FAULT_SIGBUS.  So we improve the gmap code to handle one
>> VM_FAULT_RETRY.
>>
>> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
>> ---
>>  arch/s390/mm/pgtable.c | 28 ++++++++++++++++++++++++----
>>  1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
>> index 54ef3bc..8a0025d 100644
>> --- a/arch/s390/mm/pgtable.c
>> +++ b/arch/s390/mm/pgtable.c
>> @@ -577,15 +577,22 @@ int gmap_fault(struct gmap *gmap, unsigned long gaddr,
>>  	       unsigned int fault_flags)
>>  {
>>  	unsigned long vmaddr;
>> -	int rc;
>> +	int rc, fault;
>>
>> +	fault_flags |= FAULT_FLAG_ALLOW_RETRY;
>> +retry:
>>  	down_read(&gmap->mm->mmap_sem);
>>  	vmaddr = __gmap_translate(gmap, gaddr);
>>  	if (IS_ERR_VALUE(vmaddr)) {
>>  		rc = vmaddr;
>>  		goto out_up;
>>  	}
>> -	if (fixup_user_fault(current, gmap->mm, vmaddr, fault_flags)) {
>> +	fault = fixup_user_fault(current, gmap->mm, vmaddr, fault_flags);
>> +	if (fault & VM_FAULT_RETRY) {
>> +		fault_flags &= ~FAULT_FLAG_ALLOW_RETRY;
>> +		fault_flags |= FAULT_FLAG_TRIED;
>> +		goto retry;
>> +	} else if (fault) {
>>  		rc = -EFAULT;
>>  		goto out_up;
>>  	}
> 
> Me thinks that you want to add the retry code into fixup_user_fault itself.
> You basically have the same code around the three calls to fixup_user_fault.
> Yes, it will be a common code patch but I guess that it will be acceptable
> given userfaultfd as a reason.

That makes a lot of sense. In an earlier discussion (a followup of Jasons
mm: Loosen MADV_NOHUGEPAGE to enable Qemu postcopy on s390) patch.

Andrea suggested the following:

It's probably better to add a fixup_user_fault_unlocked that will work
like get_user_pages_unlocked. I.e. leaves the details of the mmap_sem
locking internally to the function, and will handle VM_FAULT_RETRY
automatically by re-taking the mmap_sem and repeating the
fixup_user_fault after updating the FAULT_FLAG_ALLOW_RETRY to
FAULT_FLAG_TRIED.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
