From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 00/16] KVM/s390: Hugetlbfs enablement
Date: Wed, 14 Feb 2018 16:56:16 +0100
Message-ID: <28551222-18a6-4566-0b7a-acc366c860c3@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>
 <70de883f-4120-1b36-fb0f-5b940b05aab4@linux.vnet.ibm.com>
 <7dadc09b-8ada-a9e4-14c1-aca36ac0afe5@redhat.com>
 <9a8bc606-217c-db26-3a1a-85c8405c9487@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <9a8bc606-217c-db26-3a1a-85c8405c9487@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


>> Will simply always be interpreted. Should not affect the CPU model.
> 
> Bear with me, it was a long day:
> 
> Would it make sense to force user space to configure HPAGE before asking
> for model data, so that we can remove these model bits already from
> kernel side and wouldn't need extensive handling on two points?

It doesn't make any difference though. The problem is that we will
always have to probe the CPU model without knowing which type of memory
we will have. This is than reported e.g. via "virsh domcapabilities".

So it is better to do like "you're supporting cmma" while you actually
silently disable it when huge pages are used. Otherwise, the expanded
host model won't be able to run. Please note that this is not a problem
for migration: We expect the same command line, so also the same "lying
about CMMA" on both sides.

Wonder if there would be any way to fake CMMA support when not having
PGSTE - at least in a sane way. (always intercept and ignore or sth like
that - that would make it even easier to handle)


-- 

Thanks,

David / dhildenb
