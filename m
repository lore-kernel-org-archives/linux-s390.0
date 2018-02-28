From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 05/15] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Wed, 28 Feb 2018 19:10:19 +0100
Message-ID: <20180228191019.20507888.cohuck@redhat.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1519741693-17440-6-git-send-email-akrowiak@linux.vnet.ibm.com>
        <bdc22d47-afe6-a71a-615d-3beffd4ada3e@linux.vnet.ibm.com>
        <c7ae5d8e-aa40-9da5-afdf-af53487de3c3@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c7ae5d8e-aa40-9da5-afdf-af53487de3c3@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 28 Feb 2018 11:43:37 -0500
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 02/28/2018 10:33 AM, Pierre Morel wrote:
> > On 27/02/2018 15:28, Tony Krowiak wrote:  

(...)

> >> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> >> index cbe1d97..9f23caf 100644
> >> --- a/arch/s390/Kconfig
> >> +++ b/arch/s390/Kconfig
> >> @@ -771,6 +771,14 @@ config VFIO_CCW
> >>         To compile this driver as a module, choose M here: the
> >>         module will be called vfio_ccw.
> >>
> >> +config VFIO_AP
> >> +    def_tristate m

Any reason you default to m instead of n here?

> >> +    prompt "Support for virtual Adjunct Processor device interface"  
> >
> > The VFIO AP devices are not virtual.
> > What about
> >     "VFIO support for AP devices"  
> Sounds good.

+1

> >  
> >> +    depends on ZCRYPT && VFIO_MDEV_DEVICE
> >> +    help
> >> +        driver grants access to Adjunct Processor (AP) devices

s/driver/This driver/

> >> +        via the VFIO mediated device interface.

You also might want to add

"To compile this driver as a module, choose M here: the
module will be called..."

> >> +
> >>   endmenu

It's a tad confusing to find this in the I/O submenu, but I don't
really have a better idea.

> >>
> >>   menu "Dump support"
> >> diff --git a/arch/s390/configs/default_defconfig 
> >> b/arch/s390/configs/default_defconfig
> >> index 5af8458..40fa3f6 100644
> >> --- a/arch/s390/configs/default_defconfig
> >> +++ b/arch/s390/configs/default_defconfig  
> >
> > Not sure that this file belongs to this patch  
> Neither am I, but at the time I inserted this here - well before August 
> of last year - I was using vfio-ccw as a model.
> If someone can verify this does not belong here, I'd be more than happy 
> to remove it.

I don't see any entry for VFIO_CCW in there?

> >
> >  
> >> @@ -719,3 +719,6 @@ CONFIG_APPLDATA_BASE=y
> >>   CONFIG_KVM=m
> >>   CONFIG_KVM_S390_UCONTROL=y
> >>   CONFIG_VHOST_NET=m
> >> +VFIO_MDEV=m
> >> +VFIO_MDEV_DEVICE=m
> >> +CONFIG_VFIO_AP=m  
> >
> > What is your goal when modifying this three files?
> > Could you add a comment in the commit message?  
> As stated above, this was originally based on the vfio-ccw model and has 
> been in the
> patch series since its inception. I'd be happy to remove it if it is not 
> necessary.

I'd vote for removing it.

(...)

> >> +static int vfio_ap_matrix_dev_create(void)
> >> +{
> >> +    int ret;
> >> +
> >> +    vfio_ap_root_device = root_device_register(VFIO_AP_ROOT_NAME);
> >> +
> >> +    ret = PTR_ERR_OR_ZERO(vfio_ap_root_device);  
> >
> > IS_ERR() is enough, root_device_register() never return NULL.  
> I searched the kernel code to look at other places the 
> root_device_register()
> function is called to see how the return value is handled. I've seen all 
> of the
> following used:
> if (IS_ERR())
>      ret = PTR_ERR()
> PTR_ERR()
> PTR_ERR_OR_ZERO()
> 
> I'm not sure why this is a concern, but I'll use the first option above
> since PTR_ERR_OR_ZERO() also embeds the first option.

PTR_ERR_OR_ZERO() seems like the best choice for the way the return
code is processed here. (It's just unfortunate that its name conjures
up connotations of NULL-pointer handling.)

> >> +    if (ret)
> >> +        goto done;
