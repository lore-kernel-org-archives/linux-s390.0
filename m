Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:56978 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgCYBNg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Mar 2020 21:13:36 -0400
Subject: Re: [PATCH 4/4] hugetlbfs: clean up command line processing
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-5-mike.kravetz@oracle.com>
 <CAHS8izOhjvNVDXsx_SqP_oUQhCw-i_xcG9hxbvV86fFDeY_SAw@mail.gmail.com>
 <d067c5d1-89b8-a71b-7b71-a8bbbd613efa@huawei.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0cfeecb3-95d6-9fd2-d985-f70f1dd416b9@oracle.com>
Date: Tue, 24 Mar 2020 18:12:02 -0700
MIME-Version: 1.0
In-Reply-To: <d067c5d1-89b8-a71b-7b71-a8bbbd613efa@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>, Mina Almasry <almasrymina@google.com>
Cc: Linux-MM <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>

On 3/23/20 8:47 PM, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> 
> 
> On 2020/3/24 8:43, Mina Almasry wrote:
>> On Wed, Mar 18, 2020 at 3:07 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>> +default_hugepagesz - Specify the default huge page size.  This parameter can
>>> +       only be specified on the command line.  No other hugetlb command line
>>> +       parameter is associated with default_hugepagesz.  Therefore, it can
>>> +       appear anywhere on the command line.  Valid default huge page size is
>>> +       architecture dependent.
>>
>> Maybe specify what happens/should happen in a case like:
>>
>> hugepages=100 default_hugepagesz=1G
>>
>> Does that allocate 100 2MB pages or 100 1G pages? Assuming the default
>> size is 2MB.

That will allocate 100 1G pages as 1G is the default.  However, if the
command line reads:

hugepages=100 default_hugepagesz=1G hugepages=200

You will get this warning,

HugeTLB: First hugepages=104857600 kB ignored

>>
>> Also, regarding Randy's comment. It may be nice to keep these docs in
>> one place only, so we don't have to maintain 2 docs in sync.

Let me think about that a bit.  We should probably expand the
kernel-parameters doc.  Or, we should at least make it more clear.  This
doc also talks about the command line parameters and in general goes into
more detail.  However, more people read kernel-parameters doc.

>>> +
>>>  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
>>>  indicates the current number of pre-allocated huge pages of the default size.
>>>  Thus, one can use the following command to dynamically allocate/deallocate
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index cc85b4f156ca..2b9bf01db2b6 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
<snip>
>>> -static int __init hugetlb_nrpages_setup(char *s)
>>> +/*
>>> + * hugepages command line processing
>>> + * hugepages must normally follows a valid hugepagsz specification.  If not,
>>
>> 'hugepages must' or 'hugepages normally follows'
>>> + * ignore the hugepages value.  hugepages can also be the first huge page
>>> + * command line option in which case it specifies the number of huge pages
>>> + * for the default size.
>>> + */
>>> +static int __init hugepages_setup(char *s)
>>>  {
>>>         unsigned long *mhp;
>>>         static unsigned long *last_mhp;
>>>
>>>         if (!parsed_valid_hugepagesz) {
>>> -               pr_warn("hugepages = %s preceded by "
>>> +               pr_warn("HugeTLB: hugepages = %s preceded by "
>>>                         "an unsupported hugepagesz, ignoring\n", s);
>>>                 parsed_valid_hugepagesz = true;
>>>                 return 1;
>>>         }
>>>         /*
>>> -        * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter yet,
>>> -        * so this hugepages= parameter goes to the "default hstate".
>>> +        * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter
>>> +        * yet, so this hugepages= parameter goes to the "default hstate".
>>>          */
>>>         else if (!hugetlb_max_hstate)
>>>                 mhp = &default_hstate_max_huge_pages;
>>
>> We don't set parsed_valid_hugepagesz to false at the end of this
>> function, shouldn't we? Parsing a hugepages= value should 'consume' a
>> previously defined hugepagesz= value, so that this is invalid IIUC:
>>
>> hugepagesz=x hugepages=z hugepages=y
>>
> In this case, we'll get:
> "HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring
> hugepages=y"
> 

Thanks Longpeng (Mike),

I believe that is the desired message in this situation.  The code uses saved
values of mhp (max hstate pointer) to catch this condition.  Setting
parsed_valid_hugepagesz to false would result in the message:

HugeTLB: hugepages=y preceded by an unsupported hugepagesz, ignoring

Thanks for all your comments I will incorporate in v2 and send later this
week.
-- 
Mike Kravetz
