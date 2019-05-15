Return-Path: <SRS0=A7Pw=TP=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v2 0/7] s390: vfio-ccw fixes
References: <20190514234248.36203-1-farman@linux.ibm.com>
 <20190515144530.5603097b.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Wed, 15 May 2019 09:21:06 -0400
MIME-Version: 1.0
In-Reply-To: <20190515144530.5603097b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8a3e8e4d-2f47-2180-67ec-83934277f088@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 5/15/19 8:45 AM, Cornelia Huck wrote:
> On Wed, 15 May 2019 01:42:41 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> The attached are a few fixes to the vfio-ccw kernel code for potential
>> errors or architecture anomalies.  Under normal usage, and even most
>> abnormal usage, they don't expose any problems to a well-behaved guest
>> and its devices.  But, they are deficiencies just the same and could
>> cause some weird behavior if they ever popped up in real life.
>>
>> I have tried to arrange these patches in a "solves a noticeable problem
>> with existing workloads" to "solves a theoretical problem with
>> hypothetical workloads" order.  This way, the bigger ones at the end
>> can be discussed without impeding the smaller and more impactful ones
>> at the start.
>>
>> Per the conversations on patch 7, the last several patches remain
>> unchanged.  They continue to buid an IDAL for each CCW, and only pin
>> guest pages and assign the resulting addresses to IDAWs if they are
>> expected to cause a data transfer.  This will avoid sending an
>> unmodified guest address, which may be invalid but anyway is not mapped
>> to the same host address, in the IDAL sent to the channel subsystem and
>> any unexpected behavior that may result.
>>
>> They are based on 5.1.0, not Conny's vfio-ccw tree even though there are
>> some good fixes pending for 5.2 there.  I've run this series both with
>> and without that code, but couldn't decide which base would provide an
>> easier time applying patches.  "I think" they should apply fine to both,
>> but I apologize in advance if I guessed wrong!  :)
> 
> They also should apply on current master, no? My 5.2 branch should be
> all merged by now :)

Yeah, I just haven't updated my branches yet.  :)

> 
> Nothing really jumped out at me; I'm happy to queue the patches if I
> get some more feedback.
> 
>>
>>
>> Changelog:
>>   v1 -> v2:
>>    - Patch 1:
>>       - [Cornelia] Added a code comment about why we update the SCSW when
>>         we've gone past the end of the chain for normal, successful, I/O
>>    - Patch 2:
>>       - [Cornelia] Cleaned up the cc info in the commit message
>>       - [Pierre] Added r-b
>>    - Patch 3:
>>       - [Cornelia] Update the return code information in prologue of
>>         pfn_array_pin(), and then only call vfio_unpin_pages() if we
>>         pinned anything, rather than silently creating an error
>>         (this last bit was mentioned on patch 6, but applied here)
>>       - [Eric] Clean up the error exit in pfn_array_pin()
>>    - Patch 4-7 unchanged
>>
>> Eric Farman (7):
>>    s390/cio: Update SCSW if it points to the end of the chain
>>    s390/cio: Set vfio-ccw FSM state before ioeventfd
>>    s390/cio: Split pfn_array_alloc_pin into pieces
>>    s390/cio: Initialize the host addresses in pfn_array
>>    s390/cio: Allow zero-length CCWs in vfio-ccw
>>    s390/cio: Don't pin vfio pages for empty transfers
>>    s390/cio: Remove vfio-ccw checks of command codes
>>
>>   drivers/s390/cio/vfio_ccw_cp.c  | 159 +++++++++++++++++++++++---------
>>   drivers/s390/cio/vfio_ccw_drv.c |   6 +-
>>   2 files changed, 119 insertions(+), 46 deletions(-)
>>
> 
