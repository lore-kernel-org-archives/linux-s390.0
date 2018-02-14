From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC/PATCH v3 00/16] KVM/s390: Hugetlbfs enablement
Date: Wed, 14 Feb 2018 16:48:49 +0100
Message-ID: <0d53e8c2-2f9c-b874-61ac-aad03be6c038@de.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>
 <70de883f-4120-1b36-fb0f-5b940b05aab4@linux.vnet.ibm.com>
 <7dadc09b-8ada-a9e4-14c1-aca36ac0afe5@redhat.com>
 <9a8bc606-217c-db26-3a1a-85c8405c9487@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <9a8bc606-217c-db26-3a1a-85c8405c9487@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 02/14/2018 04:33 PM, Janosch Frank wrote:
> On 14.02.2018 16:07, David Hildenbrand wrote:
>> On 14.02.2018 16:01, Janosch Frank wrote:
>>> On 14.02.2018 15:30, David Hildenbrand wrote:
>>>> On 09.02.2018 10:34, Janosch Frank wrote:
>>>>> Since the z10 s390 does support 1M pages, but whereas hugetlbfs
>>>>> support was added quite fast, KVM always used standard 4k pages for
>>>>> guest backings.
>>>>>
>>>>> This patchset adds full support for 1M huge page backings for s390
>>>>> KVM guests. I.e. we also support VSIE (nested vms) for these guests
>>>>> and are therefore able to run all combinations of backings for all
>>>>> layers of guests.
>>>>>
>>>>> When running a VSIE guest in a huge page backed guest, we need to
>>>>> split some huge pages to be able to set granular protection. This way
>>>>> we avoid a prot/unprot cycle if prefixes and VSIE pages containing
>>>>> level 3 gmap DAT tables share the same segment, as the prefix has to
>>>>> be accessible at all times and the VSIE page has to be write
>>>>> protected.
>>>>>
>>>>> Branch:
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git hlp_vsie
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=hlp_vsie
>>>>>
>>>>
>>>> A general proposal: We will have split PMDs with fake PGSTE. This is
>>>> nasty but needed. I think we should hinder virtualization from making
>>>> use of these. Just like we already do for vSIE.
>>>>
>>>> Should we make the KVM_CAP_S390_HPAGE a configuration option?
>>>>
>>>> Without it being set, don't allow mapping huge pages into the GMAP.
>>>> Everything as usual.
>>>>
>>>> With it being set (by user space when it thinks we need huge pages),
>>>> allow mapping huge pages into the GMAP AND
>>>> - Explicitly disable CMMA. Right now we trust on user space to do the
>>>>   right thing. ecb2 &= ~ECB2_CMMA
>>>> - Disable PFMFI -> ecb2 &= ~ECB2_PFMFI
>>>> - Disable SKF by setting scb->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE
>>>>
>>>> So user space has to explicitly indicate and allow huge pages. This will
>>>> result in all instructions that touch the PGSTE getting intercepted, so
>>>> we can properly work on the huge PMDs instead.

I think it would work out fine for the Linux case. We do not use storage keys.
And if a guest uses them they will be slower if the host uses large pages. Tough.

>>>
>>> My only concern here is:
>>> Can this coexist with the cpumodels in a coordinated way?
>>>
>>
>> We already have to fake away the CMMA facility in user space. So that
>> shouldn't be a problem. The other instructions
>> - PFMF
>> - ISKE, SSKE ...
>>
>> Will simply always be interpreted. Should not affect the CPU model.
> 
> Bear with me, it was a long day:
> 
> Would it make sense to force user space to configure HPAGE before asking
> for model data, so that we can remove these model bits already from
> kernel side and wouldn't need extensive handling on two points?
Looks like that we do not claim CMMA and storage key interpretion anyway
via the CPU model.

In the kernel we should then modify try_handle_skey to not believe in
sclp.has_skey (but a new flag instead). For VSIE we already disable
storage key interpretion (and do it manually). We could then also make
the HPAGE stuff XOR KVM_S390_VM_MEM_ENABLE_CMMA. Whatever comes first will
trigger an -EINVAL for the 2nd.

Something like this.
