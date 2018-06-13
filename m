From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 04/13] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Wed, 13 Jun 2018 14:12:21 +0200
Message-ID: <20180613141221.5b924348.cohuck@redhat.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1525705912-12815-5-git-send-email-akrowiak@linux.vnet.ibm.com>
        <889b8d41-e08c-0eb5-2de0-a1d6669a03b3@linux.ibm.com>
        <20180613094812.1fd1846d.cohuck@redhat.com>
        <41e7ccbd-f6f5-ba20-f236-7824c682994d@linux.ibm.com>
        <20180613131402.0305d092.cohuck@redhat.com>
        <7237751c-66b5-d14c-5b71-cc1cfc79db87@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7237751c-66b5-d14c-5b71-cc1cfc79db87@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 13 Jun 2018 14:01:54 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 13/06/2018 13:14, Cornelia Huck wrote:
> > On Wed, 13 Jun 2018 12:54:40 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  
> >> On 13/06/2018 09:48, Cornelia Huck wrote:  
> >>> On Wed, 13 Jun 2018 09:41:16 +0200
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>     
> >>>> On 07/05/2018 17:11, Tony Krowiak wrote:  
> >>>>> Introduces a new AP device driver. This device driver
> >>>>> is built on the VFIO mediated device framework. The framework
> >>>>> provides sysfs interfaces that facilitate passthrough
> >>>>> access by guests to devices installed on the linux host.  
> >>>> ...snip...
> >>>>     
> >>>>> +static int vfio_ap_matrix_dev_create(void)
> >>>>> +{
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	vfio_ap_root_device = root_device_register(VFIO_AP_ROOT_NAME);
> >>>>> +
> >>>>> +	if (IS_ERR(vfio_ap_root_device)) {
> >>>>> +		ret = PTR_ERR(vfio_ap_root_device);
> >>>>> +		goto done;
> >>>>> +	}
> >>>>> +
> >>>>> +	ap_matrix = kzalloc(sizeof(*ap_matrix), GFP_KERNEL);
> >>>>> +	if (!ap_matrix) {
> >>>>> +		ret = -ENOMEM;
> >>>>> +		goto matrix_alloc_err;
> >>>>> +	}
> >>>>> +
> >>>>> +	ap_matrix->device.type = &vfio_ap_dev_type;
> >>>>> +	dev_set_name(&ap_matrix->device, "%s", VFIO_AP_DEV_NAME);
> >>>>> +	ap_matrix->device.parent = vfio_ap_root_device;
> >>>>> +	ap_matrix->device.release = vfio_ap_matrix_dev_release;
> >>>>> +	ap_matrix->device.driver = &vfio_ap_drv.driver;
> >>>>> +
> >>>>> +	ret = device_register(&ap_matrix->device);
> >>>>> +	if (ret)
> >>>>> +		goto matrix_reg_err;
> >>>>> +
> >>>>> +	goto done;
> >>>>> +
> >>>>> +matrix_reg_err:
> >>>>> +	put_device(&ap_matrix->device);  
> >>>> Did not see this before but here you certainly want to
> >>>> do a kfree and not a put_device.  
> >>> No, this must not be a kfree. Once you've tried to register something
> >>> embedding a struct device with the driver core, you need to use
> >>> put_device, as another path may have acquired a reference, even if
> >>> registering ultimately failed. See the comment for device_register().
> >>> IOW, the code is correct.  
> >> learned something again :) ,
> >> but still, a kfree is needed for the kzalloc.
> >> Does'nt it?  
> > No, the put callback for the embedding structure needs to take care of
> > freeing things. Otherwise it is buggy.  
> 
> Seems buggy to me.
> How does the put_device knows if it is embedded and then in what it is 
> embedded ?

It does not need to know; the code registering the structure needs to
set up device->release correctly.

> 
> >  
> >>>     
> >>>>     
> >>>>> +
> >>>>> +matrix_alloc_err:
> >>>>> +	root_device_unregister(vfio_ap_root_device);
> >>>>> +
> >>>>> +done:
> >>>>> +	return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static void vfio_ap_matrix_dev_destroy(struct ap_matrix *ap_matrix)
> >>>>> +{
> >>>>> +	device_unregister(&ap_matrix->device);
> >>>>> +	root_device_unregister(vfio_ap_root_device);  
> >>>> Also here you need a kfree(ap_matrix) too .  
> >>> Same here.
> >>>     
> 
> 
