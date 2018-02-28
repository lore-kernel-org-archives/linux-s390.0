Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Feb 2018 13:31:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] net: iucv: Free memory obtained by kzalloc
Message-ID: <20180228133131.0df907ff.cohuck@redhat.com>
In-Reply-To: <78058d34-7cbb-a3e6-6471-e001b93a0523@gmail.com>
References: <6fbfc0b8aa75852c4eed4d05e4c165a493304ced.1519811528.git.arvind.yadav.cs@gmail.com>
        <20180228113042.6a2f5177.cohuck@redhat.com>
        <e4784c9b-380f-4dad-6883-b6350a9e0614@gmail.com>
        <20180228125629.3062ac1d.cohuck@redhat.com>
        <78058d34-7cbb-a3e6-6471-e001b93a0523@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 28 Feb 2018 17:39:53 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> On Wednesday 28 February 2018 05:26 PM, Cornelia Huck wrote:
> > On Wed, 28 Feb 2018 17:14:55 +0530
> > Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> >  
> >> On Wednesday 28 February 2018 04:00 PM, Cornelia Huck wrote:  
> >>> On Wed, 28 Feb 2018 15:24:16 +0530
> >>> Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> >>>     
> >>>> Free memory, if afiucv_iucv_init is not successful and
> >>>> removing a IUCV driver.
> >>>>
> >>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> >>>> ---
> >>>>    net/iucv/af_iucv.c | 5 ++++-
> >>>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> >>>> index 1e8cc7b..eb0995a 100644
> >>>> --- a/net/iucv/af_iucv.c
> >>>> +++ b/net/iucv/af_iucv.c
> >>>> @@ -2433,9 +2433,11 @@ static int afiucv_iucv_init(void)
> >>>>    	af_iucv_dev->driver = &af_iucv_driver;
> >>>>    	err = device_register(af_iucv_dev);
> >>>>    	if (err)
> >>>> -		goto out_driver;
> >>>> +		goto out_iucv_dev;
> >>>>    	return 0;
> >>>>    
> >>>> +out_iucv_dev:
> >>>> +	kfree(af_iucv_dev);
> >>>>    out_driver:
> >>>>    	driver_unregister(&af_iucv_driver);
> >>>>    out_iucv:
> >>>> @@ -2496,6 +2498,7 @@ static void __exit afiucv_exit(void)
> >>>>    {
> >>>>    	if (pr_iucv) {
> >>>>    		device_unregister(af_iucv_dev);
> >>>> +		kfree(af_iucv_dev);
> >>>>    		driver_unregister(&af_iucv_driver);
> >>>>    		pr_iucv->iucv_unregister(&af_iucv_handler, 0);
> >>>>    		symbol_put(iucv_if);  
> >>> No, you must not use kfree() after you called device_register() (even
> >>> if it was not successful!) -- see the comment for device_register().  
> >> Yes, Your are right. First we need to call put_device() then kfree().
> >> I will send updated patch.  
> > No, that's not correct, either. device_register() will give up any
> > reference it obtained, and the caller did not obtain any additional
> > reference, so a put_device() would be wrong. A kfree() on a refcounted
> > structure is wrong as well.  
> If you will see the comment for device_register() (drivers/base/core.c)
> there is mentioned that
> 'NOTE: _Never_ directly free @dev after calling this function, even
> if it returned an error! Always use put_device() to give up the
> reference initialized in this function instead.'
> But as per you comment. we should not use.

You don't need to do a put_device() after your device_unregister(),
that's all managed by the driver core.
