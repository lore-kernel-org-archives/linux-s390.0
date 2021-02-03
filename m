Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v13 09/15] s390/vfio-ap: allow hot plug/unplug of AP
 resources using mdev device
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
 <20201223011606.5265-10-akrowiak@linux.ibm.com>
 <20210112021251.0d989225.pasic@linux.ibm.com>
 <20210112185550.1ac49768.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <73ad5b17-f252-2aad-1d08-14635c8460ef@linux.ibm.com>
Date: Wed, 3 Feb 2021 18:13:09 -0500
MIME-Version: 1.0
In-Reply-To: <20210112185550.1ac49768.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

I agreed to move the reset, however if the remove callback is
invoked due to a manual unbind of the queue and the queue is
in use by a guest, the cleanup of the IRQ resources after the
reset of the queue will not happen because the link from the
queue to the matrix mdev was removed. Consequently, I'm going
to have to change the patch 05/15 to split the vfio_ap_mdev_unlink_queue()
function into two functions: one to remove the link from the matrix mdev to
the queue; and, one to remove the link from the queue to the matrix
mdev. Only the first will be used for the remove callback which should
be fine since the queue object is freed at the end of the remove
function anyway.

>
> Regards,
> Halil
