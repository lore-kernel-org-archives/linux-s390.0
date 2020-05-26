Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35727 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgEZPBU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 11:01:20 -0400
Date: Tue, 26 May 2020 17:01:14 +0200
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [greybus-dev] [PATCH 1/8] driver core: Add helper for accessing
 Power Management callbacs
Message-ID: <20200526150114.GB75990@rocinante>
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-2-kw@linux.com>
 <20200526063334.GB2578492@kroah.com>
 <41c42552-0f4f-df6a-d587-5c62333aa6a8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41c42552-0f4f-df6a-d587-5c62333aa6a8@linaro.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pci@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, linux-acpi@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Felipe Balbi <balbi@kernel.org>, Alex Elder <elder@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Karsten Graul <kgraul@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>

Hello Alex and Greg,

[...]
> This could just be:
> 
> 	if (drv)
> 		return drv->pm;
> 
> 	return NULL;
> 
> Or if you want to evoke passion in Greg:
> 
> 	return drv ? drv->pm : NULL;
> 
> 					-Alex
> 
> > I hate ? : lines with a passion, as they break normal pattern mattching
> > in my brain.  Please just spell this all out:
> > 	if (drv && drv->pm)
> > 		return drv->pm;
> > 	return NULL;
> > 
> > Much easier to read, and the compiler will do the exact same thing.
> > 
> > Only place ? : are ok to use in my opinion, are as function arguments.

I will steer away from the ternary operator next time.  Also, good to
learn about Greg's preference.

Thank you both!

Krzysztof
