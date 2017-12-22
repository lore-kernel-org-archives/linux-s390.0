From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC/PATCH v2 00/22] KVM/s390: Hugetlbfs enablement
Date: Fri, 22 Dec 2017 10:08:34 +0100
Message-ID: <56a7166e-fc58-4796-dc38-46fdeccb70cc@de.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <862443e7-f7c3-ea24-9093-43cb8529175c@de.ibm.com>
 <2ae18dbd-1be3-d575-5bc4-cc0d3675d77c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <2ae18dbd-1be3-d575-5bc4-cc0d3675d77c@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 12/21/2017 01:00 PM, David Hildenbrand wrote:
> On 20.12.2017 13:23, Christian Borntraeger wrote:
>> FWIW, this patch set has survived some testing on my side (with storage
>> keys, with VSIE, with both), so I would say that after a respin with some 
>> patch sqashing we give it some more days for the last reviews and then apply
>> the whole thing via a topic branch via Martins s390 tree. I will merge
>> this branch as well to solve the potential conflicts with 
>> Davids patch ( s390x/mm: cleanup gmap_pte_op_walk() ) which is still
>> pending in my tree
>>
> 
> "postcopy works every second try, seems to be QEMU or my setup".
> Shouldn't we first understand why? gmap is a very sensible topic and we
> should rather spend more time understanding everything. We don't want
> guest escalation bugs.


I somehow missed that in the cover letter. Yes we should make sure that this works (
on the other hand I usually blame postcopy because userfault makes several assumptions
which are somewhat "brave". See the empty zero page issue, which could in theory also break
if a postcopy guest does some clever ballooning in and out). But anyway I will have a look
after christmas into postcopy.

FWIW; Martin and I looked over the patches and they seem good enough (after we fixed postcopy).
I also did some testing on that and it seems to work fine so far (including classic migration).
