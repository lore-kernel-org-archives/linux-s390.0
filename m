From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
Date: Mon, 9 Jul 2018 11:21:15 +0200
Message-ID: <0580735b-8813-f860-a2ac-654d82203b35@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 03/07/2018 01:10, Halil Pasic wrote:
>
>
> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>> This patch provides documentation describing the AP architecture and
>> design concepts behind the virtualization of AP devices. It also
>> includes an example of how to configure AP devices for exclusive
>> use of KVM guests.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>
> I don't like the design of external interfaces except for:
> * cpu model features, and
> * reset handling.
>
> In particular:
>
>
...snip...

> 4) If I were to act out the role of the administrator, I would prefer 
> to think of
> specifying or changing the access controls of a guest in respect to AP 
> (that is
> setting the AP matrix) as a single atomic operation -- which either 
> succeeds or fails.
>
> The operation should succeed for any valid configuration, and fail for 
> any invalid
> on.
>
> The current piecemeal approach seems even less fitting if we consider 
> changing the
> access controls of a running guest. AFAIK changing access controls for 
> a running
> guest is possible, and I don't see a reason why should we artificially 
> prohibit this.
>
> I think the current sysfs interface for manipulating the matrix is 
> good for
> manual playing around, but I would prefer having an interface that is 
> better
> suited for programs (e.g. ioctl).

I disagree with using ioctl.
I agree that the current implementation is not right.
The configuration of APM and AQM should always be guarantied as coherent
within the host but it can be done doing the right checks when using the 
sysfs.

Regards,

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
