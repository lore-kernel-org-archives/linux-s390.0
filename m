From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 02 Aug 2018 11:18:53 +0000
Subject: Re: [PATCH v7 09/22] s390: vfio-ap: register matrix device with VFIO mdev framework
Message-Id: <20180802131853.2f2290c7.cohuck@redhat.com>
In-Reply-To: <46d292dd-7578-1ba6-4561-d42a6441debf@linux.ibm.com>
References: <46d292dd-7578-1ba6-4561-d42a6441debf@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 1 Aug 2018 17:34:26 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 07/27/2018 07:26 AM, Halil Pasic wrote:
> >
> >
> > On 07/27/2018 01:17 PM, Cornelia Huck wrote:  
> >> On Fri, 27 Jul 2018 13:13:40 +0200
> >> Halil Pasic <pasic@linux.ibm.com> wrote:
> >>  
> >>>>> @@ -65,6 +66,21 @@ static int vfio_ap_matrix_dev_create(void)
> >>>>>    {
> >>>>>        int ret;
> >>>>>    +    mutex_init(&matrix_dev.lock);
> >>>>> +    INIT_LIST_HEAD(&matrix_dev.mdev_list);
> >>>>> +
> >>>>> +    /* Test if PQAP(QCI) instruction is available */
> >>>>> +    if (test_facility(12)) {
> >>>>> +        ret = ap_qci(&matrix_dev.info);
> >>>>> +        if (ret && (ret != -EOPNOTSUPP)) {  
> >>>>
> >>>> So, is facility 12 a pre-req for PQAP(QCI)? Can the code work if
> >>>> matrix_dev.info is not populated?  
> >>>
> >>> Yes and yes. It's basically only used in vfio_ap_matrix_init() and it
> >>> has fallbacks.  
> >>
> >> Ok. So facility 12 is required but not sufficient for PQAP(QCI) to be
> >> available? (Just asking as I cannot check the doc; if it works with
> >> fallbacks I'm fine.)  
> 
> I took a look at the ap_qci() function. It returns:
> 
>      0:           success
>      -EOPNOTSUPP: returned when an exception occurs executing the
>                   PQAP(QCI) instruction
> 
> I conclude that if STFLE.12 is set, then the PQAP(QCI) instruction
> should work. If -ENOPNOTSUPP is returned, then this would be a
> serious error and I think we should return an error from this function.

Sounds reasonable to me.

> 
> >>  
> >
> > AFAIR it should be sufficient in our case. My guess is that the non 0
> > return code stands for program exceptions that are not related to the
> > availability of QCI.  
> 
> 
> 
> 
