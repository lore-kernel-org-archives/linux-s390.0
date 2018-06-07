From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
Date: Thu, 7 Jun 2018 15:16:22 +0200
Message-ID: <adc6b4cd-e104-98fa-6d1b-29bd2a638e5c@linux.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <a6bba129-8a3c-a848-65aa-b67816bf2d25@linux.ibm.com>
 <53275110-45fb-d50f-c97e-93141378f094@linux.vnet.ibm.com>
 <89bda651-d465-af50-a737-1900a54b01c8@linux.ibm.com>
 <6f67a282-773d-3fca-5b36-cc23ad49ba5b@linux.vnet.ibm.com>
 <32340d2a-bea6-bdb1-38a6-76afe3d54672@linux.ibm.com>
 <624dcbbf-5f40-6f27-b173-a4c533dd7781@linux.vnet.ibm.com>
 <4f42fa11-e9cc-20a9-3068-b103a8ead644@linux.ibm.com>
 <525163cf-d656-b146-05b6-2efbbd2f5a9d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <525163cf-d656-b146-05b6-2efbbd2f5a9d@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, pmorel@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 06/07/2018 02:53 PM, Tony Krowiak wrote:
>>>> 2) As I said above, what you show is not the effective mask used by the guest
>>>
>>> Why would a sysfs attribute for the mediated matrix device show the effective
>>> mask used by the guest?
>>
>> OK, bad word, "effective", replace with "really".
>>
>> We do not implement any kind of provisioning nor do we implement update
>> of the CRYCB at any point after the first mediated device open.
> 
> I think this is a way we might be able to hot plug/unplug devices.
> 
>>
>>
>> Binding a queue and updating the mask can be done at any time (may be we should change this ?)
> 
> As I said above, I think we can utilize this as a means of hot plugging/unplugging AP
> adapters and domains. If the guest is running when an adapter or domain is assigned,
> we can update the guest's CRYCB at that time.
> 
>>
>>
>> What is the point of showing a matrix which will never be used by the guest?
> 
> That is simply not true. The matrix WILL be used by a guest the next time a
> guest is configured with a vfio-ap device referencing the path to the
> mediated matrix device - i.e., -device vfio-ap,sysfsdev=$PATH. The point
> is to show the matrix assigned to the mediated matrix device. In my mind, the
> mediated matrix device is a separate object from the guest. Sure it is used
> to configure a guest's matrix when the guest is started, but it could be used
> to configure the matrix for any guest; it has no direct connection to a
> particular guest until a guest using the device is started. IMHO the sysfs
> attributes for the mediated matrix device reflect only the attributes of
> the device, not the attributes of a guest.

So bottom line is what? Is the interface going to change so that modifications
to the mdev's matrix will be reflected immediately -- to support hotplug of
domains and ap cards?

Or are you intending to keep the interface as is?

If the matrix assigned to the mediated device can differ from the matrix
of the guest (that is the masks in the CRYCB, and I'm talking about a running
guest) do you provide a way for the host admin to examine the matrix of the
guest? If not, why do you think that information is irrelevant to the host
admin?

Regards,
Halil
