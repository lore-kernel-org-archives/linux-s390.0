From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 02 Oct 2018 12:52:53 +0000
Subject: Re: [PATCH] s390/cio: Fix how vfio-ccw checks pinned pages
Message-Id: <8050bdbd-bb6d-e4a4-2bc8-4b765f4035df@linux.ibm.com>
In-Reply-To: <20181002100349.650cfc86.cohuck@redhat.com>
References: <20181002100349.650cfc86.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 10/02/2018 04:03 AM, Cornelia Huck wrote:
> On Tue, 2 Oct 2018 08:37:06 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 10/02/2018 03:02 AM, Eric Farman wrote:
>>> We have two nested loops to check the entries within the pfn_array_table
>>> arrays.  But we mistakenly use the outer array as an index in our check,
>>> and completely ignore the indexing performed by the inner loop.
>>>
>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>
>> I think this qualifies for stable.
> 
> Agreed; queued with cc:stable added.
> 
> Thanks for looking into this; anything more in your queue, or should I
> send another pull request soon?
> 

Sorry I didn't get this one out earlier :)

I do have some more in progress, but they're more involved and would 
probably generate some discussion.  Not sure when I'll get them finished 
up, so go ahead and generate the pull when convenient.  Thank you!
