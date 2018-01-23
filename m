Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 23 Jan 2018 18:37:35 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] s390/cmf: fix kerneldoc
In-Reply-To: <20180123150245.30312-4-cohuck@redhat.com>
References: <20180123150245.30312-1-cohuck@redhat.com> <20180123150245.30312-4-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1801231833550.1761@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, corbet@lwn.net, oberpar@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 23 Jan 2018, Cornelia Huck wrote:
> Make sure we use proper Return sections, and make the output
> for cmf_enable() less odd.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> +++ b/drivers/s390/cio/cmf.c
> @@ -1118,9 +1118,10 @@ int ccw_set_cmf(struct ccw_device *cdev, int enable)
>   * enable_cmf() - switch on the channel measurement for a specific device
>   *  @cdev:	The ccw device to be enabled
>   *
> - *  Returns %0 for success or a negative error value.
> - *  Note: If this is called on a device for which channel measurement is already
> - *	  enabled a reset of the measurement data is triggered.
> + *  Enable channel measurements for @cdev. If this is called on a device
> + *  for which channel measurement is already enabled a reset of the
> + *  measurement data is triggered.
> + *  Returns: %0 for success or a negative error value
                                                        ^
I took the liberty to do re-add the dot at the end..
Applied. Thanks!
