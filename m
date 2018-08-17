From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 18/22] s390: vfio-ap: implement VFIO_DEVICE_RESET ioctl
Date: Fri, 17 Aug 2018 15:03:35 -0400
Message-ID: <b432c371-0246-7260-c00f-05fe30a2aa03@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-19-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180815183835.66470bc6.cohuck@redhat.com>
 <4bcf1214-1978-aa11-ca22-7ab4352dacfb@linux.ibm.com>
 <20180817113830.250a4285.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817113830.250a4285.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/17/2018 05:38 AM, Cornelia Huck wrote:
> On Wed, 15 Aug 2018 17:05:48 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 08/15/2018 12:38 PM, Cornelia Huck wrote:
>>> On Mon, 13 Aug 2018 17:48:15 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>> +	case VFIO_DEVICE_RESET:
>>>> +		ret = vfio_ap_mdev_reset_queues(mdev, true);
>>> If I see it correctly, you call this function only ever with force ==
>>> true (here and in the previous patch). Is that what you intended?
>> That does seem to be the case now; however, I think at one time there were
>> additional calls to this function. For some reason of which I am not aware,
>> those were removed, so there is probably no need for it now.
> If you don't see a need for it anymore, I'd just remove the parameter.
> Even makes vfio_ap_mdev_reset_queues() a bit nicer :)

I guess I wasn't clear, I intended to remove it.

>
