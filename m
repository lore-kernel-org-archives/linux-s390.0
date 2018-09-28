From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v11 26/26] s390: doc: detailed specifications for AP
 virtualization
Date: Fri, 28 Sep 2018 09:20:35 +0200
Message-ID: <4c72d185-c627-f839-2bb0-bda33b647cd8@de.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-27-akrowiak@linux.vnet.ibm.com>
 <20180926164222.74731b74@t450s.home>
 <a9b69a08-e415-4f76-d36c-73fc2a354f9e@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a9b69a08-e415-4f76-d36c-73fc2a354f9e@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 09/27/2018 09:19 PM, Tony Krowiak wrote:
> On 09/26/2018 06:42 PM, Alex Williamson wrote:
>> On Tue, 25 Sep 2018 19:16:41 -0400
>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>
>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>
>>> This patch provides documentation describing the AP architecture and
>>> design concepts behind the virtualization of AP devices. It also
>>> includes an example of how to configure AP devices for exclusive
>>> use of KVM guests.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>> ---
>>>   Documentation/s390/vfio-ap.txt | 782 +++++++++++++++++++++++++++++++++
>>>   MAINTAINERS                    |   1 +
>>>   2 files changed, 783 insertions(+)
>>>   create mode 100644 Documentation/s390/vfio-ap.txt
>> ...
>>> +Example:
>>> +=======
>>> +Let's now provide an example to illustrate how KVM guests may be given
>>> +access to AP facilities. For this example, we will show how to configure
>>> +three guests such that executing the lszcrypt command on the guests would
>>> +look like this:
>>> +
>>> +Guest1
>>> +------
>>> +CARD.DOMAIN TYPE  MODE
>>> +------------------------------
>>> +05          CEX5C CCA-Coproc
>>> +05.0004     CEX5C CCA-Coproc
>>> +05.00ab     CEX5C CCA-Coproc
>>> +06          CEX5A Accelerator
>>> +06.0004     CEX5A Accelerator
>>> +06.00ab     CEX5C CCA-Coproc
>>> +
>>> +Guest2
>>> +------
>>> +CARD.DOMAIN TYPE  MODE
>>> +------------------------------
>>> +05          CEX5A Accelerator
>>> +05.0047     CEX5A Accelerator
>>> +05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
>>                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> Seems like an unfinished thought here.

Can you submit another fixup that takes care of this comment?
