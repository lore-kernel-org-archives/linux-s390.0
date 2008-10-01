Return-Path: <linux-kernel-owner+w=401wt.eu-S1753456AbYJALVc@vger.kernel.org>
Subject: Re: [patch 21/21] Add ioctl support for EMC Symmetrix Subsystem
	Control I/O
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20081001110301.GB6648@infradead.org>
References: <20081001083317.782967473@de.ibm.com>
	 <20081001084130.599948666@de.ibm.com> <20081001110301.GB6648@infradead.org>
Content-Type: text/plain
Date: Wed, 01 Oct 2008 13:17:00 +0200
Message-Id: <1222859820.32562.8.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Nigel Hislop <hislop_nigel@emc.com>, Hannes Reinecke <hare@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-10-01 at 07:03 -0400, Christoph Hellwig wrote:
> > +static int dasd_symm_io(struct dasd_device *device, void __user *argp)
> > +{
> > +	struct dasd_symmio_parms usrparm;
> > +	char *psf_data, *rssd_result;
> > +	struct dasd_ccw_req *cqr;
> > +	struct ccw1 *ccw;
> > +	int rc;
> > +
> > +	/* Copy parms from caller */
> > +	rc = copy_from_user(&usrparm, argp, sizeof(usrparm)) ? -EFAULT : 0;
> > +	if (rc)
> > +		goto out;
> 
> That style is quite odd,  what about the more normal
> 
> 	rc = -EFAULT;
> 	if (copy_from_user(&usrparm, argp, sizeof(usrparm)))
> 		goto out;
> 
> instead?

Ok, I will change that.

> > +	/* alloc I/O data area */
> > +	psf_data = kzalloc(usrparm.psf_data_len, GFP_KERNEL | GFP_DMA);
> > +	rssd_result = kzalloc(usrparm.rssd_result_len, GFP_KERNEL | GFP_DMA);
> > +	if (!psf_data || !rssd_result) {
> > +		rc = -ENOMEM;
> > +		goto out_free;
> > +	}
> 
> just check each on individually and do individual unwinding.  Makes the
> code a little more easily readable.

Well, matter of taste I would say. Two kzallocs, one check for the
results and just two kfrees if one of the kzallocs failed. I find this
version to be a little more compact and therefore easier to read. If you
insist I will change it ..

> > +	/* get syscall header from user space */
> > +	rc = copy_from_user(psf_data,
> > +			    (void __user *)(unsigned long) usrparm.psf_data,
> > +			    usrparm.psf_data_len) ? -EFAULT : 0;
> > +	if (rc)
> > +		goto out_free;
> 
> Same as the first copy_from_user

Ok.

> > +	rc = copy_to_user((void __user *)(unsigned long) usrparm.rssd_result,
> > +			   rssd_result, usrparm.rssd_result_len) ? -EFAULT : 0;
> 
> And here again.

Ok.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
