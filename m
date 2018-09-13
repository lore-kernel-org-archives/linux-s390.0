From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v9 13/22] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
Date: Thu, 13 Sep 2018 11:12:09 +0200
Message-ID: <1375257e-38c3-f9e3-049e-d1a602d084c9@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820160802.1fe8f704.cohuck@redhat.com>
 <0e8bac2b-31a0-a1de-c6cf-e824cd256af6@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0e8bac2b-31a0-a1de-c6cf-e824cd256af6@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 09/12/2018 07:01 PM, Tony Krowiak wrote:
> On 08/20/2018 10:08 AM, Cornelia Huck wrote:
>> I find this output to be a bit confusing; but OTOH, I'm probably not
>> the person to parse it :) Still, some comments.
>>
>>  From previous discussions, ISTR that this is mainly supposed to be a
>> debugging/administration aid. Of course, this generates some questions:
>> - Should this be in sysfs (sysfs attributes are supposed to follow the
>>    "one value per file" rule, at least for the most part), or would
>>    debugfs be a better fit?
>> - Should userspace code be able to introspect the current
>>    configuration? If yes, it might be better to have some
>>    not-so-nice-but-easily-parsable output, possibly one attribute for
>>    the assigned adapters and one for the assigned domains, and a tool
>>    which distills that into a nice "matrix" with labeled rows and
>>    columns for human consumption.
>>
>> That said, I don't really have major objections to that interface.
> 
> For now, I will leave it in, but we could conceivably simplify configuration
> of the matrix and adhere to sysfs rules by modeling this after the AP bus
> apmask and aqmask sysfs interfaces. If we did that, there would need to be only
> three RW sysfs interfaces:
> 
> apm or apmask or ap_mask or adapter_mask or apid_mask
> aqm or aqmask or aq_mask or domains or usage_domain_mask or apqi_mask
> adm or admask or ad_mask or control_domains or control_domain_mask or domain_mask
> 
> To assign a device, either a bitmask or a comma separated list of IDs prepended
> with a '+' could be passed in. To unassign a device, either a bitmask in or a
> comma-separated list of IDs prepended with a '-' could be passed in.
> 
> Reading an attribute would return the mask. As you suggested, tools could be
> provided to parse the output and display it in a human-readable format.
> 

I would prefer an interface where one can set at least one whole mask in one
go over the current one that let us manipulate just one bit at a time.

Hallil

>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c |   52 +++++++++++++++++++++++++++++++++++++
>>>   1 files changed, 52 insertions(+), 0 deletions(-)
> 
> 
