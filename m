Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731494AbgEZQsP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 12:48:15 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53626C03E96F
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2020 09:48:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f3so22792858ioj.1
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2020 09:48:15 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH 8/8] net/iucv: Use the new device_to_pm()
 helper to access struct dev_pm_ops
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-9-kw@linux.com> <20200526063521.GC2578492@kroah.com>
 <20200526150744.GC75990@rocinante>
From: Alex Elder <elder@linaro.org>
Message-ID: <acb9415a-d0d0-3ebc-b5ae-c26a7dc2114a@linaro.org>
Date: Tue, 26 May 2020 11:48:12 -0500
MIME-Version: 1.0
In-Reply-To: <20200526150744.GC75990@rocinante>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pci@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, linux-acpi@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Felipe Balbi <balbi@kernel.org>, Alex Elder <elder@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Karsten Graul <kgraul@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>

On 5/26/20 10:07 AM, Krzysztof Wilczyński wrote:
> Hello Greg,
> 
> [...]
>> It's "interesting" how using your new helper doesn't actually make the
>> code smaller.  Perhaps it isn't a good helper function?

Helper functions often improve code readability, which is
beneficial even if it doesn't reduce code size or efficiency.

But I won't argue for or against this particular change.
It's OK with me either way.

					-Alex

> The idea for the helper was inspired by the comment Dan made to Bjorn
> about Bjorn's change, as per:
> 
>    https://lore.kernel.org/driverdev-devel/20191016135002.GA24678@kadam/
> 
> It looked like a good idea to try to reduce the following:
> 
>    dev->driver && dev->driver->pm && dev->driver->pm->prepare
> 
> Into something more succinct.  Albeit, given the feedback from yourself
> and Rafael, I gather that this helper is not really a good addition.
> 
> Thank you everyone and sorry for the commotion!
> 
> Krzysztof
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 
