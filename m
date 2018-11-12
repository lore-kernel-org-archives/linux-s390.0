From: Eric Farman <farman@linux.ibm.com>
Date: Mon, 12 Nov 2018 14:16:55 +0000
Subject: Re: [RFC PATCH v1 01/10] s390/cio: Fix cleanup of pfn_array alloc failure
Message-Id: <0cbf5ace-61cf-4444-1951-be06e72163ad@linux.ibm.com>
In-Reply-To: <5ca40893-a4fd-ba87-c44f-8e9e47bf7bce@linux.ibm.com>
References: <5ca40893-a4fd-ba87-c44f-8e9e47bf7bce@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 11/12/2018 09:04 AM, Eric Farman wrote:
> 
> 
> On 11/12/2018 05:59 AM, Cornelia Huck wrote:
>> On Mon, 12 Nov 2018 11:41:50 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 12/11/2018 11:32, Cornelia Huck wrote:
>>>> On Mon, 12 Nov 2018 11:28:38 +0100
>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>> Hi Eric,
>>>>>
>>>>> I think the problem here comes from the pfn_array_table_unpin_free()
>>>>> doing both unpin and free.
>>>>>
>>>>> I would prefer that you change the� pfn_array_table_init() to 
>>>>> return the
>>>>> pointer, so you can free the pointer in the caller like:
>>>>>
>>>>>
>>>>> ���������� p = pfn_array_table_init(pat, 1);
>>>>> ���������� if (!p)
>>>>> ������������������ goto out_init;
>>>>>
>>>>> ���������� ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev, ccw->cda,
>>>>> ccw->count);
>>>>> ���������� if (ret < 0)
>>>>> ������������������ goto out_free;
>>>>> ...
>>>>>
>>>>> out_unpin:
>>>>> ���������� pfn_array_table_unpin_free(pat, cp->mdev);
>>>>> out_free:
>>>>> ����pfn_array_table_free(p);
>>>>> out_init:
>>>>> ���������� ccw->cda = 0;
>>>>> ���������� return ret;
>>>>> }
>>>>>
>>>>>
>>>>> And modify the pfn_array_table_unpin_free() to pfn_array_table_unpin()
>>>>> and add the freeing in pfn_array_table_free(p).
>>>>>
>>>>>
>>>>> Something like that with a correct return code handle.
>>>>>
>>>>> Which would make the code more logical and readable.
>>>>>
>>>>> What do you think?
>>>>
>>>> While I agree that this would improve the code, I'm not sure how much
>>>> of it remains at the end of this series (I haven't read it completely
>>>> yet.) IOW, is this a code change that would get kicked out again 
>>>> anyway?
>>>
>>> At the end,pfn_array_alloc_pin() is decoupled in pfn_array_alloc() and
>>> pfn_array_pin() which is a good thing but but the pfn_array_unpin_free()
>>> survives as unpin + free.
> 
> And don't forget, pfn_array_table_unpin_free() goes away entirely.� I do 
> add a 

check for a

> non-zero iova in patch 8.
> 

Sorry.  Coffee hasn't kicked in yet.  :)

>>
>> OK, this seems like a good idea to me, then :)
>>
