Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhBAOmU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Feb 2021 09:42:20 -0500
Subject: Re: [PATCH v13 09/15] s390/vfio-ap: allow hot plug/unplug of AP
 resources using mdev device
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
 <20201223011606.5265-10-akrowiak@linux.ibm.com>
 <20210112021251.0d989225.pasic@linux.ibm.com>
 <20210112185550.1ac49768.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <5a221fb3-4dc0-0aef-7910-51f395ba1bcd@linux.ibm.com>
Date: Mon, 1 Feb 2021 09:41:29 -0500
MIME-Version: 1.0
In-Reply-To: <20210112185550.1ac49768.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 1/12/21 12:55 PM, Halil Pasic wrote:
> On Tue, 12 Jan 2021 02:12:51 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>>> @@ -1347,8 +1437,11 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
>>>   	apqi = AP_QID_QUEUE(q->apqn);
>>>   	vfio_ap_mdev_reset_queue(apid, apqi, 1);
>>>   
>>> -	if (q->matrix_mdev)
>>> +	if (q->matrix_mdev) {
>>> +		matrix_mdev = q->matrix_mdev;
>>>   		vfio_ap_mdev_unlink_queue(q);
>>> +		vfio_ap_mdev_refresh_apcb(matrix_mdev);
>>> +	}
>>>   
>>>   	kfree(q);
>>>   	mutex_unlock(&matrix_dev->lock);
> Shouldn't we first remove the queue from the APCB and then
> reset? Sorry, I missed this one yesterday.

Yes, that's probably the order in which  it should be done.
I'll change it.

>
> Regards,
> Halil
