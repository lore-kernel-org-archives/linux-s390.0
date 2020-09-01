Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:39153 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIAGvI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Sep 2020 02:51:08 -0400
Subject: Re: [PATCH v3 08/13] mm/debug_vm_pgtable/thp: Use page table
 depost/withdraw with THP
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-9-aneesh.kumar@linux.ibm.com>
 <e7877a8d-b433-0cb4-50a7-631de0022c24@arm.com>
 <9beaaf93-b2dd-6d56-7737-9f022760f246@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d80a91c3-0edf-7e2f-8101-2d37a371f4bd@csgroup.eu>
Date: Tue, 1 Sep 2020 08:50:56 +0200
MIME-Version: 1.0
In-Reply-To: <9beaaf93-b2dd-6d56-7737-9f022760f246@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>



Le 01/09/2020 à 08:25, Aneesh Kumar K.V a écrit :
> On 9/1/20 8:52 AM, Anshuman Khandual wrote:
>>
>>
>>
>> There is a checkpatch.pl warning here.
>>
>> WARNING: Possible unwrapped commit description (prefer a maximum 75 
>> chars per line)
>> #7:
>> Architectures like ppc64 use deposited page table while updating the 
>> huge pte
>>
>> total: 0 errors, 1 warnings, 40 lines checked
>>
> 
> I will ignore all these, because they are not really important IMHO.
> 

When doing a git log in a 80 chars terminal window, having wrapping 
lines is not really convenient. It should be easy to avoid it.

Christophe
