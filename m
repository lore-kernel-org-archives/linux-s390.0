Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] s390/kvm: fix MVPG when in VSIE
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5947ede7-7f9f-cdaa-b827-75a5715e4f12@redhat.com>
Date: Sun, 20 Dec 2020 10:40:27 +0100
MIME-Version: 1.0
In-Reply-To: <20201218141811.310267-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On 18.12.20 15:18, Claudio Imbrenda wrote:
> The current handling of the MVPG instruction when executed in a nested
> guest is wrong, and can lead to the nested guest hanging.

Hi,

thanks for spotting and debugging! Is this related to nested guests
hanging while migrating (mentioned by Janosch at some point)?

Or can this not be reproduced with actual Linux guests?

Thanks!

> 
> This patchset fixes the behaviour to be more architecturally correct,
> and fixes the hangs observed.
> 
> Claudio Imbrenda (4):
>   s390/kvm: VSIE: stop leaking host addresses
>   s390/kvm: extend guest_translate for MVPG interpretation
>   s390/kvm: add kvm_s390_vsie_mvpg_check needed for VSIE MVPG
>   s390/kvm: VSIE: correctly handle MVPG when in VSIE
> 
>  arch/s390/kvm/gaccess.c | 88 ++++++++++++++++++++++++++++++++++++++---
>  arch/s390/kvm/gaccess.h |  3 ++
>  arch/s390/kvm/vsie.c    | 78 +++++++++++++++++++++++++++++++++---
>  3 files changed, 159 insertions(+), 10 deletions(-)
> 


-- 
Thanks,

David / dhildenb
