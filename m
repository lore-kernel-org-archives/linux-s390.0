Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfJAOOL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Oct 2019 10:14:11 -0400
Date: Tue, 1 Oct 2019 16:14:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] zfcp: fix reaction on bit error theshold notification
 with adapter close
Message-ID: <20191001141408.GB3129841@kroah.com>
References: <yq1d0fhw2ex.fsf@oracle.com>
 <20191001104949.42810-1-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001104949.42810-1-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, stable@vger.kernel.org

On Tue, Oct 01, 2019 at 12:49:49PM +0200, Steffen Maier wrote:
> On excessive bit errors for the FCP channel ingress fibre path, the channel
> notifies us. Previously, we only emitted a kernel message and a trace record.
> Since performance can become suboptimal with I/O timeouts due to
> bit errors, we now stop using an FCP device by default on channel
> notification so multipath on top can timely failover to other paths.
> A new module parameter zfcp.ber_stop can be used to get zfcp old behavior.

Ugh, module parameters?  This isn't the 1990's anymore :(

Why not just make this a dynamic sysfs variable, that way you properly
can set this on whatever device you want, not just "all or nothing"?

thanks,

greg k-h
