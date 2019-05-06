Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH 6/7] s390/cio: Don't pin vfio pages for empty transfers
References: <20190503134912.39756-1-farman@linux.ibm.com>
 <20190503134912.39756-7-farman@linux.ibm.com>
 <20190506172054.612fd557.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Mon, 6 May 2019 11:40:54 -0400
MIME-Version: 1.0
In-Reply-To: <20190506172054.612fd557.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d99db4cd-a671-ad3b-ba52-2b50c8cd40aa@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 5/6/19 11:20 AM, Cornelia Huck wrote:
> On Fri,  3 May 2019 15:49:11 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> If a CCW has a count of zero, then no data will be transferred and
>> pinning/unpinning memory is unnecessary.
>>
>> In addition to that, the skip flag of a CCW offers the possibility of
>> data not being transferred, but is only meaningful for certain commands.
>> Specifically, it is only applicable for a read, read backward, sense, or
>> sense ID CCW and will be ignored for any other command code
>> (SA22-7832-11 page 15-64, and figure 15-30 on page 15-75).
> 
> This made me look at QEMU, and it seems that we cheerfully ignore that
> flag so far in our ccw interpretation code :/

Yup...  :(

> 
>>
>> (A sense ID is xE4, while a sense is x04 with possible modifiers in the
>> upper four bits.  So we will cover the whole "family" of sense CCWs.)
>>
>> For all those scenarios, since there is no requirement for the target
>> address to be valid, we should skip the call to vfio_pin_pages() and
>> rely on the IDAL address we have allocated/built for the channel
>> program.  The fact that the individual IDAWs within the IDAL are
>> invalid is fine, since they aren't actually checked in these cases.
>>
>> Set pa_nr to zero, when skipping the pfn_array_pin() call, since it is
>> defined as the number of pages pinned.  This will cause the vfio unpin
>> logic to return -EINVAL, but since the return code is not checked it
>> will not harm our cleanup path.
> 
> We could also try to skip the unpinning, but this works as well.

In an earlier version I had, I was re-purposing other fields in 
pfn_array, which was rather kludgy.  I could easily add a check for 
non-zero pa_nr here, just to be clear of what we're doing (or in case we 
decide TO check the return code from vfio_unpin_pages() some day).

> 
>>
>> As we do this, since the pfn_array_pin() routine returns the number of
>> pages pinned, and we might not be doing that, the logic for converting
>> a CCW from direct-addressed to IDAL needs to ensure there is room for
>> one IDAW in the IDAL being built since a zero-length IDAL isn't great.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_cp.c | 61 +++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 55 insertions(+), 6 deletions(-)
> 
> Looks good to me.
> 
