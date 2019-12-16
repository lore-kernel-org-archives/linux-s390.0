Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37074 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727436AbfLPKyT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 16 Dec 2019 05:54:19 -0500
Date: Mon, 16 Dec 2019 11:54:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 9/9] s390x: css: ping pong
Message-ID: <20191216115409.3a89717a.cohuck@redhat.com>
In-Reply-To: <bb6c04a1-501c-16c4-107b-f10ac9d1e41d@linux.ibm.com>
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
        <1576079170-7244-10-git-send-email-pmorel@linux.ibm.com>
        <20191213105009.482bab48.cohuck@redhat.com>
        <bb6c04a1-501c-16c4-107b-f10ac9d1e41d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Fri, 13 Dec 2019 17:50:02 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2019-12-13 10:50, Cornelia Huck wrote:

> > [This also got me thinking about your start_subchannel function
> > again... do you also want to allow flags like e.g. SLI? It's not
> > unusual for commands to return different lengths of data depending on
> > what features are available; it might be worthwhile to allow short data
> > if you're not sure that e.g. a command returns either the short or the
> > long version of a structure.]  
> 
> I would prefer to keep simple it in this series if you agree.

Sure, that's fine.

> 
> AFAIU the current QEMU implementation use a fix length and if a short 
> read occurs it is an error.
> Since we test on PONG, there should be no error.

It all depends on how the QEMU device is supposed to work. For a
command reading/writing some data, I'd usually expect the following:

- If SLI is not set, require the length to be the exact value expected
  by the device; otherwise, generate an error.
- If SLI is set, require the length to be between the minimum length
  that makes sense and the full length of the buffer; otherwise,
  generate an error.

Of course, if minimum length == full length, SLI has no real effect :)

> 
> I agree that for a general test we should change this, but currently the 
> goal is just to verify that the remote device is PONG.
> 
> If we accept variable length, we need to check the length of what we 
> received, and this could need some infrastructure changes that I would 
> like to do later.

You mean at the device level? At the driver level (== here), you should
simply get an error or not, I guess.

> 
> When the series is accepted I will begin to do more complicated things like:
> - checking the exceptions for wrong parameters
>    This is the first I will add.

Agreed, that's probably the most useful one.

> - checking the response difference on flags (SLI, SKP)
> - using CC and CD flags for chaining
> - TIC, NOP, suspend/resume and PCI
> 
> These last one will be fun, we can also trying to play with prefetch 
> while at it. :)

I think any kind of ccw chain will already be fun :) It's probably not
so well tested anyway, as virtio is basically single-command.
