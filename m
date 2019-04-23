Return-Path: <SRS0=oVSW=SZ=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v2 7/8] s390: vfio-ap: handle bind and unbind of AP queue
 device
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
 <1555796980-27920-8-git-send-email-akrowiak@linux.ibm.com>
 <20190423155458.65966ebf.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 23 Apr 2019 11:27:11 -0400
MIME-Version: 1.0
In-Reply-To: <20190423155458.65966ebf.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <604cb4b6-5baa-16f9-4e6e-1459453376b6@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 4/23/19 9:54 AM, Halil Pasic wrote:
> On Sat, 20 Apr 2019 17:49:39 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
>> +
>> +	/*
>> +	 * If the queue is assigned to the mdev device and the mdev device
>> +	 * is in use by a guest
>> +	 */
>> +	if (matrix_mdev && matrix_mdev->kvm) {
>> +		/* Plug the adapter into the guest */
>> +		set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
>> +
>> +		/* Make sure the queue is also plugged in to the guest */
>> +		if (!test_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm))
>> +			set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
>> +
>> +		vfio_ap_mdev_update_crycb(matrix_mdev);
> 
> With this you effectively grant access to all the assigned domains on
> the AP identified by the apid, not only to the domain identified by
> apqi! But some of these queues may still not be bound to the vfio_ap
> driver.

I have been doing some more testing since I last visited and discovered
that there needs to be additional checking here.

> 
> IMHO you should only set the apid-th bit in apm if all queues (apid, q)
> such that q-th bit is set in aqm are bound to the vfio_ap driver.

This is partially correct. It is not necessary to verify that the
affected queues are bound to the vfio_ap driver. It is only necessary
to verify they are not reserved for use by a zcrypt driver since we
are allowing assignment of APQNs for queues that are not available (see
patch 3/8).

> 
> BTW a 'shadow' (or effective) apm would perfectly suffice. I don't think
> you fiddle with shadow_crycb->a[qd]m, and if you do, I don't think that's
> a good idea.

I do not think it is accurate to refer to the APM in the shadow CRYCB as
an effective mask. Effective masking is a firmware construct. The CRYCB
of the guest may be configured with APQNs that are not available.

The shadow CRYCB is in fact a copy of the guest CRYCB. Whenever the
masks in the guest CRYCB are set, they are set from the masks in the
shadow CRYCB. The lifespan of the shadow CRYCB is synonymous with the
lifespan of the guest.

Each of the mdev device sysfs assignment/unassignment interfaces does
fiddle with the masks in the shadow CRYCB if a guest is using the mdev
device. This allows us to hot plug/unplug AP resources for the guest.
Recall that an adapter or domain can not be assigned unless each
new APQN created is NOT reserved for use by the zcrypt drivers via
the AP bus's apmask/aqmask sysfs interfaces, and the APQN is not 
assigned to any other mdev device. That is how protection is
provided against inadvertently sharing AP queues between guests or
the guest and the host. I do have to add that verification to
the vfio_ap_mdev_probe_queue function though.



> 
> Regards,
> Halil
> 
>> +	}
>> +}
> 
