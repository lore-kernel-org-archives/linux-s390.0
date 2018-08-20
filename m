From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
Date: Mon, 20 Aug 2018 18:43:33 +0200
Message-ID: <6a7aa016-d116-b0d8-9cce-71245cad2f16@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820162317.08bd7d23.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 08/20/2018 04:23 PM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:09 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Provides the sysfs interfaces for:
>>
>> 1. Assigning AP control domains to the mediated matrix device
>>
>> 2. Unassigning AP control domains from a mediated matrix device
>>
>> 3. Displaying the control domains assigned to a mediated matrix
>>     device
>>
>> The IDs of the AP control domains assigned to the mediated matrix
>> device are stored in an AP domain mask (ADM). The bits in the ADM,
>> from most significant to least significant bit, correspond to
>> AP domain numbers 0 to 255. On some systems, the maximum allowable
>> domain number may be less than 255 - depending upon the host's
>> AP configuration - and assignment may be rejected if the input
>> domain ID exceeds the limit.
> 
> Please remind me of the relationship between control domains and usage
> domains... IIRC, usage domains allow both requests and configuration,
> while control domains allow only configuration, and are by convention a
> superset of usage domains.
> 

The whole terminology with control and usage domains is IMHO a bit
confusing. With the HMC one can assign a domain either as a 'Control'
or as a 'Control and Usage' domain.

Regarding the masks in the CRYCB, the AQM controls 'using' the domain
(e.g. if AQM bit is zero NQAP will refuse to enqueue on that queue)
while ADM tells if the guest is allowed to 'change' the given domain.
Whether a command-request is of type 'using' or 'changing' is a property
of the command request.

You can think of 'using' a domain like signing stuff with a key residing
within the domain, and of 'changing' a domain like issuing a command to
generate a new key for the given domain.


> Is there a hard requirement somewhere in there, or can the admin
> cheerfully use different masks for usage domains and control domains
> without the SIE choking on it?
> 

It is a convention. AFAIR it ain't architecture. SIE won't choke on it
I've tried it out. I was arguing along the lines that the kernel should
not enforce this convention -- tooling can still do that if we want this
enforced.

Regards,
Halil
