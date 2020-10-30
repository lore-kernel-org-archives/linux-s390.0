Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbgJ3VRZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Oct 2020 17:17:25 -0400
Subject: Re: [PATCH v11 01/14] s390/vfio-ap: No need to disable IRQ after
 queue reset
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
 <20201022171209.19494-2-akrowiak@linux.ibm.com>
 <20201027074846.30ee0ddc.pasic@linux.ibm.com>
 <7a2c5930-9c37-8763-7e5d-c08a3638e6a1@linux.ibm.com>
 <20201030185636.60fcca52.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <66de1211-2a18-8c68-e321-a1af42bc4537@linux.ibm.com>
Date: Fri, 30 Oct 2020 17:17:19 -0400
MIME-Version: 1.0
In-Reply-To: <20201030185636.60fcca52.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 10/30/20 1:56 PM, Halil Pasic wrote:
> On Thu, 29 Oct 2020 19:29:35 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>>>> +void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
>>>> +{
>>>> +	struct vfio_ap_queue *q;
>>>> +	struct ap_queue *queue;
>>>> +	int apid, apqi;
>>>> +
>>>> +	queue = to_ap_queue(&apdev->device);
>>> What is the benefit of rewriting this? You introduced
>>> queue just to do queue->ap_dev to get to the apdev you
>>> have in hand in the first place.
>> I'm not quite sure what you're asking. This function is
>> the callback function specified via the function pointer
>> specified via the remove field of the struct ap_driver
>> when the vfio_ap device driver is registered with the
>> AP bus. That callback function takes a struct ap_device
>> as a parameter. What am I missing here?
> Please compare the removed function vfio_ap_queue_dev_remove() with the
> added function vfio_ap_mdev_remove_queue() line by line. It should
> become clear.

Got it. You are one sharp cookie, I'll fix this.

>
> Regards,
> Halil
