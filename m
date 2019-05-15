Return-Path: <SRS0=A7Pw=TP=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v2 5/7] s390/cio: Allow zero-length CCWs in vfio-ccw
References: <20190514234248.36203-1-farman@linux.ibm.com>
 <20190514234248.36203-6-farman@linux.ibm.com>
 <20190515142339.12065a1d.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <f309cad9-9265-e276-8d57-8b6387f6fed7@linux.ibm.com>
Date: Wed, 15 May 2019 11:04:33 -0400
MIME-Version: 1.0
In-Reply-To: <20190515142339.12065a1d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 5/15/19 8:23 AM, Cornelia Huck wrote:
> On Wed, 15 May 2019 01:42:46 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> It is possible that a guest might issue a CCW with a length of zero,
>> and will expect a particular response.  Consider this chain:
>>
>>     Address   Format-1 CCW
>>     --------  -----------------
>>   0 33110EC0  346022CC 33177468
>>   1 33110EC8  CF200000 3318300C
>>
>> CCW[0] moves a little more than two pages, but also has the
>> Suppress Length Indication (SLI) bit set to handle the expectation
>> that considerably less data will be moved.  CCW[1] also has the SLI
>> bit set, and has a length of zero.  Once vfio-ccw does its magic,
>> the kernel issues a start subchannel on behalf of the guest with this:
>>
>>     Address   Format-1 CCW
>>     --------  -----------------
>>   0 021EDED0  346422CC 021F0000
>>   1 021EDED8  CF240000 3318300C
>>
>> Both CCWs were converted to an IDAL and have the corresponding flags
>> set (which is by design), but only the address of the first data
>> address is converted to something the host is aware of.  The second
>> CCW still has the address used by the guest, which happens to be (A)
>> (probably) an invalid address for the host, and (B) an invalid IDAW
>> address (doubleword boundary, etc.).
>>
>> While the I/O fails, it doesn't fail correctly.  In this example, we
>> would receive a program check for an invalid IDAW address, instead of
>> a unit check for an invalid command.
>>
>> To fix this, revert commit 4cebc5d6a6ff ("vfio: ccw: validate the
>> count field of a ccw before pinning") and allow the individual fetch
>> routines to process them like anything else.  We'll make a slight
>> adjustment to our allocation of the pfn_array (for direct CCWs) or
>> IDAL (for IDAL CCWs) memory, so that we have room for at least one
>> address even though no data will be transferred.
>>
>> Note that this doesn't provide us with a channel program that will
>> fail in the expected way.  Since our length is zero, vfio_pin_pages()

s/is/was/

>> returns -EINVAL and cp_prefetch() will thus fail.  This will be fixed
>> in the next patch.
> 
> So, this failed before, and still fails, just differently? 

Probably.  If the guest gave us a valid address, the pin might actually 
work now whereas before it would fail because the length was zero.  If 
the address were also invalid,

 >IOW, this
> has no effect on bisectability?

I think so, but I suppose that either (A) patch 5 and 6 could be 
squashed together, or (B) I could move the "set pa_nr to zero" (or more 
accurately, set it to ccw->count) pieces from patch 6 into this patch, 
so that the vfio_pin_pages() call occurs like it does today.

> 
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_cp.c | 26 ++++++++------------------
>>   1 file changed, 8 insertions(+), 18 deletions(-)
> 
