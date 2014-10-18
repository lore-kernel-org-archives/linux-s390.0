From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 2/4] mm: introduce new VM_NOZEROPAGE flag
Date: Sat, 18 Oct 2014 09:28:17 -0700
Message-ID: <54429521.80402@intel.com>
References: <1413554990-48512-1-git-send-email-dingel@linux.vnet.ibm.com>	<1413554990-48512-3-git-send-email-dingel@linux.vnet.ibm.com>	<54419265.9000000@intel.com> <20141018164928.2341415f@BR9TG4T3.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20141018164928.2341415f@BR9TG4T3.de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.cz>, Rik van Riel <riel@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Bob Liu <lliubbo@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Gleb Natapov <gleb@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Jianyu Zhan <nasa4836@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Weitz <konstantin.weitz@gmail.com>, kvm@vger.kernel.org, linux390@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin
List-ID: <linux-s390.vger.kernel.org>

On 10/18/2014 07:49 AM, Dominik Dingel wrote:
> On Fri, 17 Oct 2014 15:04:21 -0700
> Dave Hansen <dave.hansen@intel.com> wrote:
>> Is there ever a time where the VMAs under an mm have mixed VM_NOZEROPAGE
>> status?  Reading the patches, it _looks_ like it might be an all or
>> nothing thing.
> 
> Currently it is an all or nothing thing, but for a future change we might want to just
> tag the guest memory instead of the complete user address space.

I think it's a bad idea to reserve a flag for potential future use.  If
you _need_ it in the future, let's have the discussion then.  For now, I
think it should probably just be stored in the mm somewhere.

>> Full disclosure: I've got an x86-specific feature I want to steal a flag
>> for.  Maybe we should just define another VM_ARCH bit.
>>
> 
> So you think of something like:
> 
> #if defined(CONFIG_S390)
> # define VM_NOZEROPAGE	VM_ARCH_1
> #endif
> 
> #ifndef VM_NOZEROPAGE
> # define VM_NOZEROPAGE	VM_NONE
> #endif
> 
> right?

Yeah, something like that.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
