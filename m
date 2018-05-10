From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH] kvm: Change return type to vm_fault_t
Date: Thu, 10 May 2018 20:44:12 +0530
Message-ID: <CAFqt6zYUpKOibZn-e42LnzkXc6a4bu35PZcOAsDwDZV5RzaUXg@mail.gmail.com>
References: <20180418191958.GA25806@jordon-HP-15-Notebook-PC> <20180419155606.45a85009.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419155606.45a85009.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: jhogan@kernel.org, ralf@linux-mips.org, paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, Matthew Wilcox <willy@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 19, 2018 at 7:26 PM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Thu, 19 Apr 2018 00:49:58 +0530
> Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>>  arch/mips/kvm/mips.c       | 2 +-
>>  arch/powerpc/kvm/powerpc.c | 2 +-
>>  arch/s390/kvm/kvm-s390.c   | 2 +-
>>  arch/x86/kvm/x86.c         | 2 +-
>>  include/linux/kvm_host.h   | 2 +-
>>  virt/kvm/arm/arm.c         | 2 +-
>>  virt/kvm/kvm_main.c        | 2 +-
>>  7 files changed, 7 insertions(+), 7 deletions(-)
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

If no further comment, We would like to get this
patch in queue for 4.18.
