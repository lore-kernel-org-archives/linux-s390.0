From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/4] s390/mm: prevent and break zero page mappings in
 case of storage keys
Date: Wed, 22 Oct 2014 12:09:31 +0200
Message-ID: <5447825B.5040608@redhat.com>
References: <1413966624-12447-1-git-send-email-dingel@linux.vnet.ibm.com> <1413966624-12447-4-git-send-email-dingel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1413966624-12447-4-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dominik Dingel <dingel@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.cz>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Bob Liu <lliubbo@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Gleb Natapov <gleb@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Jianyu Zhan <nasa4836@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Weitz <konstantin.weitz@gmail.com>, kvm@vger.kernel.org, linux390@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 10/22/2014 10:30 AM, Dominik Dingel wrote:
> As use_skey is already the condition on which we call s390_enable_skey
> we need to introduce a new flag for the mm->context on which we decide
> if zero page mapping is allowed.

Can you explain better why "mm->context.use_skey = 1" cannot be done
before the walk_page_range?  Where does the walk or __s390_enable_skey
or (after the next patch) ksm_madvise rely on
"mm->context.forbids_zeropage && !mm->context.use_skey"?

The only reason I can think of, is that the next patch does not reset
"mm->context.forbids_zeropage" to 0 if the ksm_madvise fails.  Why
doesn't it do that---or is it a bug?

Thanks, and sorry for the flurry of questions! :)

Paolo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
