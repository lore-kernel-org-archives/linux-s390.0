Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH v3 08/13] mm/debug_vm_pgtable/thp: Use page table
 depost/withdraw with THP
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-9-aneesh.kumar@linux.ibm.com>
 <e7877a8d-b433-0cb4-50a7-631de0022c24@arm.com>
 <9beaaf93-b2dd-6d56-7737-9f022760f246@linux.ibm.com>
 <d80a91c3-0edf-7e2f-8101-2d37a371f4bd@csgroup.eu>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <2fb4ac88-d417-2bdd-3c56-a816c356636a@linux.ibm.com>
Date: Tue, 1 Sep 2020 13:10:13 +0530
MIME-Version: 1.0
In-Reply-To: <d80a91c3-0edf-7e2f-8101-2d37a371f4bd@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>

On 9/1/20 12:20 PM, Christophe Leroy wrote:
> 
> 
> Le 01/09/2020 à 08:25, Aneesh Kumar K.V a écrit :
>> On 9/1/20 8:52 AM, Anshuman Khandual wrote:
>>>
>>>
>>>
>>> There is a checkpatch.pl warning here.
>>>
>>> WARNING: Possible unwrapped commit description (prefer a maximum 75 
>>> chars per line)
>>> #7:
>>> Architectures like ppc64 use deposited page table while updating the 
>>> huge pte
>>>
>>> total: 0 errors, 1 warnings, 40 lines checked
>>>
>>
>> I will ignore all these, because they are not really important IMHO.
>>
> 
> When doing a git log in a 80 chars terminal window, having wrapping 
> lines is not really convenient. It should be easy to avoid it.
> 

We have been ignoring that for a long time  isn't it?

For example ppc64 checkpatch already had
--max-line-length=90


There was also recent discussion whether 80 character limit is valid any 
more. But I do keep it restricted to 80 character where ever it is 
easy/make sense.

-aneesh
