From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 0/4] KVM: s390: refactor cpuflag handling
Date: Wed, 24 Jan 2018 17:43:50 +0100
Message-ID: <44211f75-51b6-5d26-b217-49ad071faae8@de.ibm.com>
References: <20180123170531.13687-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180123170531.13687-1-david@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Series applied. Thanks

On 01/23/2018 06:05 PM, David Hildenbrand wrote:
> We already have __set_cpuflag(), but its limited to interrupt.c. Conny
> suggested __clear_cpuflag(). I went one step further and introduce
> - kvm_s390_set_cpuflags()
> - kvm_s390_clear_cpuflags()
> - kvm_s390_test_cpuflags()
> 
> All applicable places are converted to use the new helpers. This beautifies
> the code at a couple of places quite a bit.
> 
> David Hildenbrand (4):
>   KVM: s390: rename __set_cpuflag() to kvm_s390_set_cpuflags()
>   KVM: s390: reuse kvm_s390_set_cpuflags()
>   KVM: s390: introduce and use kvm_s390_clear_cpuflags()
>   KVM: s390: introduce and use kvm_s390_test_cpuflags()
> 
>  arch/s390/kvm/interrupt.c | 43 +++++++++++++++++++------------------------
>  arch/s390/kvm/kvm-s390.c  | 30 ++++++++++++++----------------
>  arch/s390/kvm/kvm-s390.h  | 17 ++++++++++++++++-
>  arch/s390/kvm/priv.c      |  6 +++---
>  arch/s390/kvm/sigp.c      | 14 +++++---------
>  arch/s390/kvm/vsie.c      |  4 ++--
>  6 files changed, 59 insertions(+), 55 deletions(-)
> 
