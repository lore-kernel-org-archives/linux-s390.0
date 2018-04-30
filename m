From: David Hildenbrand <david@redhat.com>
Date: Mon, 30 Apr 2018 15:38:06 +0000
Subject: Re: [bug report] KVM: s390: vsie: support transactional execution
Message-Id: <95e13c8c-3b1e-8640-c59e-b8fbeac89072@redhat.com>
In-Reply-To: <1185d8f6-ab29-e140-82cd-b28a17ef802c@redhat.com>
References: <1185d8f6-ab29-e140-82cd-b28a17ef802c@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 30.04.2018 16:57, David Hildenbrand wrote:
> On 30.04.2018 16:29, Cornelia Huck wrote:
>> On Mon, 30 Apr 2018 17:04:35 +0300
>> Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> [sent to David's current address]
>>
>>> [ Old warnings because this is non-x86 - dan ]
>>>
>>> Hello David Hildenbrand,
>>>
>>> The patch 166ecb3d3cfe: "KVM: s390: vsie: support transactional
>>> execution" from Nov 25, 2015, leads to the following static checker
>>> warning:
>>>
>>> 	arch/s390/kvm/vsie.c:581 pin_blocks()
>>> 	warn: was expecting a 64 bit value instead of '~8191'
>>>
>>> arch/s390/kvm/vsie.c
>>>    548  static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>    549  {
>>>    550          struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>>>    551          struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>>>    552          hpa_t hpa;
>>>    553          gpa_t gpa;
>>>                 ^^^^^
>>> gpa_t is a u64.
>>>
>>>    554          int rc = 0;
>>>    555  
>>>    556          gpa = READ_ONCE(scb_o->scaol) & ~0xfUL;
>>>    557          if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
>>>    558                  gpa |= (u64) READ_ONCE(scb_o->scaoh) << 32;
>>>    559          if (gpa) {
>>>    560                  if (!(gpa & ~0x1fffUL))
>>>    561                          rc = set_validity_icpt(scb_s, 0x0038U);
>>>    562                  else if ((gpa & ~0x1fffUL) == kvm_s390_get_prefix(vcpu))
>>>    563                          rc = set_validity_icpt(scb_s, 0x0011U);
>>>    564                  else if ((gpa & PAGE_MASK) !=
>>>    565                           ((gpa + sizeof(struct bsca_block) - 1) & PAGE_MASK))
>>>    566                          rc = set_validity_icpt(scb_s, 0x003bU);
>>>    567                  if (!rc) {
>>>    568                          rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
>>>    569                          if (rc)
>>>    570                                  rc = set_validity_icpt(scb_s, 0x0034U);
>>>    571                  }
>>>    572                  if (rc)
>>>    573                          goto unpin;
>>>    574                  vsie_page->sca_gpa = gpa;
>>>    575                  scb_s->scaoh = (u32)((u64)hpa >> 32);
>>>    576                  scb_s->scaol = (u32)(u64)hpa;
>>>    577          }
>>>    578  
>>>    579          gpa = READ_ONCE(scb_o->itdba) & ~0xffUL;
>>>                                                  ^^^^^
>>> Here it's UL.
>>>
>>>    580          if (gpa && (scb_s->ecb & ECB_TE)) {
>>>    581                  if (!(gpa & ~0x1fffU)) {
>>>                                    ^^^^^^^^^
>>> But here it's u32.  So the high 32 bits are not considered.  Possibly it
>>> doesn't matter?
> 
> /me trying to remember what the young David wanted to achieve here
> 
> (Christian, can you double check in the SIE documentation, I assume the
> last 13 bits of the address must not be set because of alignment, right?
> Unfortunately I don't remember)

Looking at it again, this check does not seem to do what I thought it
would do :) Alignment is handled already handled by the defined number
of bits (READ_ONCE(scb_o->itdba) & ~0xffUL).

So this is rather a check that the used address must not lie in the
lower 8k of memory. (low core for real addressing)

This could be triggered by a nested hypervisor but would not do any harm
to us: We simply pin the defined guest (nested hypervisor) address and
forward it.

It sure should be fixed to catch all error cases.

> 
> 0x1fffU ->  0x0000000000001fffULL
> ~0x1fffU -> 0x00000000ffffe000ULL
> 
> Now, if we have an address like 100001fff
> 
> gpa = 100001fff
> !(gpa & ~0x1fffU) -> 1
> !(gpa & ~0x1fffUL) -> 0
> 
> So we would not get equal results.
> 
> Three years later, I would simply have written this as
> if (gpa & 0x1fffUL)
> 
> Then, also the mussing "L" would not have mattered.
> 
> But anyhow: While this looks like a BUG, I expect it to not be
> triggerable (is that a word?) because we have a safety net: We forward
> the offset in the page to the SIE. The SIE will perform the same check
> again on our calculated address. It will trigger a validity intercept
> for us that we silently forward.
> 
> Dan, whatever tool you're using, nice work! Thanks a lot!
> 
> 
>>>
>>>    582                          rc = set_validity_icpt(scb_s, 0x0080U);
>>>    583                          goto unpin;
>>>    584                  }
>>>    585                  /* 256 bytes cannot cross page boundaries */
>>>    586                  rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
>>>    587                  if (rc) {
>>>    588                          rc = set_validity_icpt(scb_s, 0x0080U);
>>>    589                          goto unpin;
>>>    590                  }
>>>    591                  vsie_page->itdba_gpa = gpa;
>>>    592                  scb_s->itdba = hpa;
>>>
>>> regards,
>>> dan carpenter
>>
> 
> 


-- 

Thanks,

David / dhildenb
