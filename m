From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 01/15] s390: zcrypt: externalize AP instructions
 available function
Date: Mon, 7 May 2018 16:55:20 +0200
Message-ID: <88fadaf1-595a-ac72-279a-6706f149be9b@redhat.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <7e537cfc-5d67-c188-2890-191608cb7b4f@redhat.com>
 <6ece398b-49eb-c048-64c7-85acf3801103@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ece398b-49eb-c048-64c7-85acf3801103@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07.05.2018 16:02, Tony Krowiak wrote:
> On 05/04/2018 03:19 AM, David Hildenbrand wrote:
>> On 15.04.2018 23:22, Tony Krowiak wrote:
>>> If the AP instructions are not available on the linux host, then
>>> AP devices can not be interpreted by the SIE. The AP bus has a
>> This statement is wrong. The instructions can be interpreted by SIE e.g.
>> if there are no devices assigned to a guest. This is e.g. the case for
>> !CONFIG_ZCRYPT.
> 
> While the statement is admittedly poorly worded, it is not wrong.
> Without going into architectural details, If the AP instructions
> are not available, they will not be interpreted for guest
> level 1 - i.e., the linux host. If AP instructions are not interpreted
> for guest level 1, then they will not be interpreted for guest
> level 2 regardless of whether ECA_APIE is set for guest level 2 or
> not. I don't see how CONFIG_ZCRYPT has anything to do with this.
> 
> 
>>
>> Also, doesn't this directly imply that the other execution control
>> should also not be used ("intercept AP instuctions"). This would be bad.
>> Just because !CONFIG_ZCRYPT does not imply that you can't emulate AP
>> devices for a guest.
> 
> Setting CONFIG_ZCRYPT=n simply means that the AP bus will not be built
> and therefore the AP bus interfaces will not be available to KVM.
> As far as ECA_APIE goes, there are only two choices: Set the bit to
> enable SIE interpretation of AP instructions; Clear the bit to use

I thought somebody once mentioned once in one of these threads that
there are actually 2 different bits. One to control interpretation and
one to control interception.

> interception. We are only supporting SIE interpretation of AP
> instructions at this time, so we need a sure-fire way to determine
> if the AP instructions are installed, which is the point of this patch.
> Since there are no intercept handlers at this time, when the AP bus
> module on the guest is initialized, the init function will fail and
> the bus will not come up. There are protections built into userspace
> (QEMU in this case) to ensure that a guest is not started if the CPU
> model feature for AP instructions is not turned on for the guest. The
> CPU model feature will be enabled by the KVM only if the AP instructions
> are installed on the linux host. Again, that is reason for this
> patch.
> 



-- 

Thanks,

David / dhildenb
