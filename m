Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbgHJRDH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Aug 2020 13:03:07 -0400
Date: Mon, 10 Aug 2020 10:03:05 -0700
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 19/22] crypto: inside-secure - add check for xts input
 length equal to zero
Message-ID: <20200810170305.GA3352718@gmail.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
 <20200807162010.18979-20-andrei.botila@oss.nxp.com>
 <CY4PR0401MB36528610C3ABF802F8CBF35FC3440@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20200810134500.GA22914@gondor.apana.org.au>
 <fd3e5862-3357-7dfc-6c75-30086ab19f82@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd3e5862-3357-7dfc-6c75-30086ab19f82@nxp.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>, "David S. Miller" <davem@davemloft.net>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>, Andrei Botila <andrei.botila@nxp.com>, Antoine Tenart <antoine.tenart@bootlin.com>

On Mon, Aug 10, 2020 at 05:33:39PM +0300, Horia Geantă wrote:
> On 8/10/2020 4:45 PM, Herbert Xu wrote:
> > On Mon, Aug 10, 2020 at 10:20:20AM +0000, Van Leeuwen, Pascal wrote:
> >>
> >> With all due respect, but this makes no sense.
> > 
> > I agree.  This is a lot of churn for no gain.
> > 
> I would say the gain is that all skcipher algorithms would behave the same
> when input length equals zero - i.e. treat the request as a no-op.
> 
> We can't say "no input" has any meaning to the other skcipher algorithms,
> but the convention is to accept this case and just return 0.
> I don't see why XTS has to be handled differently.
> 

CTS also rejects empty inputs.

The rule it follows is just that all input lengths >= blocksize are allowed.
Input lengths < blocksize aren't allowed.

- Eric
