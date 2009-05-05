From: Greg KH <gregkh@suse.de>
Date: Tue, 05 May 2009 17:15:05 +0000
Subject: Re: [PATCH] s390: remove driver_data direct access of struct device
Message-Id: <20090505171505.GA16356@suse.de>
In-Reply-To: <alpine.LFD.2.00.0905051242570.3332@localhost.localdomain>
References: <alpine.LFD.2.00.0905051242570.3332@localhost.localdomain>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, May 05, 2009 at 12:47:33PM +0200, Sebastian Ott wrote:
> hi,
> 
> this patch introduces some build failures like:
> 
> drivers/s390/char/raw3270.c: In function 'raw3270_model_show':
> drivers/s390/char/raw3270.c:1132: warning: dereferencing 'void *' pointer
> drivers/s390/char/raw3270.c:1132: error: request for member 'model' in something not a structure or union
> 
> the following add-on patch fixes this
> 
> Regards,
> Sebastian
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

Argh, sorry about this, bad typo, compounded by cut and paste and the
inability for me to cross-compile s390 anymore :(

I'll merge this with my original patch, thanks so much for checking and
fixing it.

thanks,

greg k-h
