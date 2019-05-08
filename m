Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH 7/7] s390/cio: Remove vfio-ccw checks of command codes
References: <20190503134912.39756-1-farman@linux.ibm.com>
 <20190503134912.39756-8-farman@linux.ibm.com>
 <8625f759-0a2d-09af-c8b5-5b312d854ba1@linux.ibm.com>
 <7c897993-d146-bf8e-48ad-11a914a04716@linux.ibm.com>
 <bba6c0a8-2346-cd99-b8ad-f316daac010b@linux.ibm.com>
 <7ac9fb43-8d7a-9e04-8cba-fa4c63dfc413@linux.ibm.com>
 <1f2e4272-8570-f93f-9d67-a43dcb00fc55@linux.ibm.com>
 <5c2b74a9-e1d9-cd63-1284-6544fa4376d9@linux.ibm.com>
 <20190508120648.6c40231d.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Wed, 8 May 2019 15:38:37 -0400
MIME-Version: 1.0
In-Reply-To: <20190508120648.6c40231d.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <abb996d4-4f3d-f10d-7ced-e27ca72a92f0@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 5/8/19 6:06 AM, Cornelia Huck wrote:
> On Wed, 8 May 2019 11:22:07 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> The TEST command is used to retrieve the status of the I/O-device
>> __path__ and do not go up to the device.
>> I did not find clearly that it does not start a data transfer but I
>> really do not think it does.
>> May be we should ask people from hardware.
>> I only found that test I/O (a specific test command) do not initiate an
>> operation.
> 
> FWIW, I'm not sure about what we should do with the test command in any
> case.
> 
> Currently, I see it defined as a proper command in the rather ancient
> "Common I/O Device Commands" (I don't know of any newer public
> version), 

Nor I.  I had to rummage around a few dumpsters to find a copy of this 
one, even.

> which states that it retrieves the status on the parallel
> interface _only_ (and generates a command reject on the serial
> interface). IIRC, the parallel interface has been phased out quite some
> time ago.

The current POPs, towards the bottom left side of page 13-3, has this 
statement:

---
The term “serial-I/O interface” is used to refer the ESCON I/O 
interface, the FICON I/O interface, and the FICON-converted I/O 
interface. The term “parallel-I/O interface” is used to refer to the IBM 
System/360 and System/370 I/O interface.
---

So, yes it was phased out some time ago.  :)

> 
> The current PoP, in contrast, defines this as an _invalid_ command
> (generating a channel program check).

Ditto the ESA/390 POPs (SA22-7201-08).

> 
> So, while the test command originally was designed to never initiate a
> data transfer, we now have an invalid command in its place, and we
> don't know if something else might change in the future (for transfer
> mode, a test-like command is already defined in the PoP).

Indeed, the ccw_is_test() check would need to be reworked if we ever 
want to support transport mode anyway.  :shudder:

> 
> So, the safest course would probably be to handle the ->cda portion and
> send the command down. We'll get a check condition on current hardware,
> but it should be safe if something changes in the future.
> 
> Of course, asking some hardware folks is not a bad idea, either :)
> 

I'll shoot a quick note (and cc Pierre) just for the sake of sanity, but 
I'm still convinced this patch is fine as-is.  :)
