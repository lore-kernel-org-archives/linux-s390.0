From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] mm: introduce new VM_NOZEROPAGE flag
Date: Mon, 20 Oct 2014 20:14:53 +0200
Message-ID: <5445511D.1090603@redhat.com>
References: <1413554990-48512-1-git-send-email-dingel@linux.vnet.ibm.com>	<1413554990-48512-3-git-send-email-dingel@linux.vnet.ibm.com>	<54419265.9000000@intel.com> <20141018164928.2341415f@BR9TG4T3.de.ibm.com> <54429521.80402@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <54429521.80402@intel.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.cz>, Rik van Riel <riel@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Bob Liu <lliubbo@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Gleb Natapov <gleb@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Jianyu Zhan <nasa4836@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Weitz <konstantin.weitz@gmail.com>, kvm@vger.kernel.org, linux390@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin
List-ID: <linux-s390.vger.kernel.org>

On 10/18/2014 06:28 PM, Dave Hansen wrote:
> > Currently it is an all or nothing thing, but for a future change we might want to just
> > tag the guest memory instead of the complete user address space.
>
> I think it's a bad idea to reserve a flag for potential future use.  If
> you_need_  it in the future, let's have the discussion then.  For now, I
> think it should probably just be stored in the mm somewhere.

I agree with Dave (I thought I disagreed, but I changed my mind while 
writing down my thoughts).  Just define mm_forbids_zeropage in 
arch/s390/include/asm, and make it return mm->context.use_skey---with a 
comment explaining how this is only for processes that use KVM, and then 
only for guests that use storage keys.

Paolo (who was just taught what storage keys really are)

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
