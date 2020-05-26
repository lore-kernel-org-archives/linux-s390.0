Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728364AbgEZH73 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 03:59:29 -0400
Subject: Re: [PATCH 8/8] net/iucv: Use the new device_to_pm() helper to access
 struct dev_pm_ops
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-9-kw@linux.com>
From: Ursula Braun <ubraun@linux.ibm.com>
Message-ID: <55c3d2eb-feff-bf33-235d-b89c0abef7b1@linux.ibm.com>
Date: Tue, 26 May 2020 09:07:27 +0200
MIME-Version: 1.0
In-Reply-To: <20200525182608.1823735-9-kw@linux.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Felipe Balbi <balbi@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, John Stultz <john.stultz@linaro.org>, "David S. Miller" <davem@davemloft.net>, greybus-dev@lists.linaro.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org



On 5/25/20 8:26 PM, Krzysztof Wilczyński wrote:
> Use the new device_to_pm() helper to access Power Management callbacs
> (struct dev_pm_ops) for a particular device (struct device_driver).
> 
> No functional change intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

pm support is going to be removed (for s390 in general and) for
net/iucv/iucv.c with this net-next patch:

commit 4b32f86bf1673acb16441dd55d7b325609f54897
Author: Julian Wiedmann <jwi@linux.ibm.com>
Date:   Tue May 19 21:10:08 2020 +0200

    net/iucv: remove pm support
    
    commit 394216275c7d ("s390: remove broken hibernate / power management support")
    removed support for ARCH_HIBERNATION_POSSIBLE from s390.
    
    So drop the unused pm ops from the s390-only iucv bus driver.
    
    CC: Hendrik Brueckner <brueckner@linux.ibm.com>
    Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

> ---
>  net/iucv/iucv.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index 9a2d023842fe..1a3029ab7c1f 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c

...
