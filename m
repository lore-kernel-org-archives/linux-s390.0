From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/5] KVM: s390: patches for 4.15
Date: Wed, 8 Nov 2017 12:10:53 +0100
Message-ID: <20171108121053.172fa481.cohuck@redhat.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171108084143.78654-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  8 Nov 2017 09:41:38 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> My next pull request will be pretty small it seems as exitless
> interrupt, crypto and large page support are all not ready yet.

I'm looking forward to the exitless interrupt patches :)

> Anyway here is what I have pending as of today and what will
> be part of my next pull request. 

Yup, looks sane to me.

> 
> Christian Borntraeger (1):
>   KVM: s390: document memory ordering for kvm_s390_vcpu_wakeup
> 
> David Hildenbrand (1):
>   KVM: s390: vsie: use common code functions for pinning
> 
> Michael Mueller (2):
>   KVM: s390: abstract conversion between isc and enum irq_types
>   KVM: s390: clear_io_irq() requests are not expected for adapter
>     interrupts
> 
> Tony Krowiak (1):
>   KVM: s390: SIE considerations for AP Queue virtualization
> 
>  Documentation/virtual/kvm/devices/s390_flic.txt |  3 ++
>  arch/s390/include/asm/kvm_host.h                | 25 +++++++++++--
>  arch/s390/kvm/interrupt.c                       | 26 +++++++++++--
>  arch/s390/kvm/vsie.c                            | 50 +++++++++----------------
>  include/linux/kvm_host.h                        |  1 +
>  virt/kvm/kvm_main.c                             |  4 +-
>  6 files changed, 67 insertions(+), 42 deletions(-)
> 
