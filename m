Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: 4.19.5 and later has tons of false messages "BUG: non-zero
 pgtables_bytes on freeing mm: -16384"
References: <4e58571e-1991-4a70-7012-ff9dd76afee3@de.ibm.com>
 <1d6288dd-a65b-463a-8aeb-33904dafa9cc@de.ibm.com>
 <20181227210136.GV86645@sasha-vm>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 27 Dec 2018 22:06:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181227210136.GV86645@sasha-vm>
Content-Language: en-US
Message-Id: <babf4052-c82c-3bca-0214-4ae3f23fee4e@de.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, stable@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <linux-s390.vger.kernel.org>



On 12/27/2018 10:01 PM, Sasha Levin wrote:
> On Thu, Dec 27, 2018 at 10:28:56AM +0100, Christian Borntraeger wrote:
>>
>>
>> On 27.12.2018 10:13, Christian Borntraeger wrote:
>>> Martin,
>>>
>>> Right now you get a message
>>> "BUG: non-zero pgtables_bytes on freeing mm: -16384"
>>> for EVERY process that exits in 4.19.5 and later.
>>>
>>> bisect points to
>>> commit 4136161d676a93fc8df6bdb80d720c15522d6c24
>>> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>> Date:   Mon Oct 15 11:09:16 2018 +0200
>>>
>>>     s390/mm: fix mis-accounting of pgtable_bytes
>>>
>>>     [ Upstream commit e12e4044aede97974f2222eb7f0ed726a5179a32 ]
>>>
>>> Turns out that this patch requires several dependencies so the autoselection of this
>>> patch was missing that.
>>>
>>> Can we either revert this patch or add the dependencies?
>>>
>>> Christian
>>>
>>
>> It seems that adding
>>
>> commit 6d212db11947ae5464e4717536ed9faf61c01e86 ("mm: add mm_pxd_folded checks to pgtable_bytes accounting functions")
>> fixes the issue.
> 
> I've queued 6d212db11947 for 4.19 for now, thank you.

Not sure, but you might need 
1071fc5779d98 mm: introduce mm_[p4d|pud|pmd]_folded
a8874e7e8a889 mm: make the __PAGETABLE_PxD_FOLDED defines non-empty

to avoid compile errors on !s390.
