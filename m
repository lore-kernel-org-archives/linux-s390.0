From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 00/16] KVM/s390: Hugetlbfs enablement
Date: Wed, 14 Feb 2018 16:07:46 +0100
Message-ID: <7dadc09b-8ada-a9e4-14c1-aca36ac0afe5@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>
 <70de883f-4120-1b36-fb0f-5b940b05aab4@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <70de883f-4120-1b36-fb0f-5b940b05aab4@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 14.02.2018 16:01, Janosch Frank wrote:
> On 14.02.2018 15:30, David Hildenbrand wrote:
>> On 09.02.2018 10:34, Janosch Frank wrote:
>>> Since the z10 s390 does support 1M pages, but whereas hugetlbfs
>>> support was added quite fast, KVM always used standard 4k pages for
>>> guest backings.
>>>
>>> This patchset adds full support for 1M huge page backings for s390
>>> KVM guests. I.e. we also support VSIE (nested vms) for these guests
>>> and are therefore able to run all combinations of backings for all
>>> layers of guests.
>>>
>>> When running a VSIE guest in a huge page backed guest, we need to
>>> split some huge pages to be able to set granular protection. This way
>>> we avoid a prot/unprot cycle if prefixes and VSIE pages containing
>>> level 3 gmap DAT tables share the same segment, as the prefix has to
>>> be accessible at all times and the VSIE page has to be write
>>> protected.
>>>
>>> Branch:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git hlp_vsie
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=hlp_vsie
>>>
>>
>> A general proposal: We will have split PMDs with fake PGSTE. This is
>> nasty but needed. I think we should hinder virtualization from making
>> use of these. Just like we already do for vSIE.
>>
>> Should we make the KVM_CAP_S390_HPAGE a configuration option?
>>
>> Without it being set, don't allow mapping huge pages into the GMAP.
>> Everything as usual.
>>
>> With it being set (by user space when it thinks we need huge pages),
>> allow mapping huge pages into the GMAP AND
>> - Explicitly disable CMMA. Right now we trust on user space to do the
>>   right thing. ecb2 &= ~ECB2_CMMA
>> - Disable PFMFI -> ecb2 &= ~ECB2_PFMFI
>> - Disable SKF by setting scb->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE
>>
>> So user space has to explicitly indicate and allow huge pages. This will
>> result in all instructions that touch the PGSTE getting intercepted, so
>> we can properly work on the huge PMDs instead.
> 
> My only concern here is:
> Can this coexist with the cpumodels in a coordinated way?
> 

We already have to fake away the CMMA facility in user space. So that
shouldn't be a problem. The other instructions
- PFMF
- ISKE, SSKE ...

Will simply always be interpreted. Should not affect the CPU model.

-- 

Thanks,

David / dhildenb
