Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:51294 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgHLAh0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Aug 2020 20:37:26 -0400
Date: Wed, 12 Aug 2020 10:36:32 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 19/22] crypto: inside-secure - add check for xts input
 length equal to zero
Message-ID: <20200812003632.GB4166@gondor.apana.org.au>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
 <20200807162010.18979-20-andrei.botila@oss.nxp.com>
 <CY4PR0401MB36528610C3ABF802F8CBF35FC3440@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20200810134500.GA22914@gondor.apana.org.au>
 <fd3e5862-3357-7dfc-6c75-30086ab19f82@nxp.com>
 <20200810170305.GA3352718@gmail.com>
 <d4a471e6-34c9-c702-63d6-1f6a3cba0ebe@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4a471e6-34c9-c702-63d6-1f6a3cba0ebe@nxp.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc: Eric Biggers <ebiggers@kernel.org>, "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>, "David S. Miller" <davem@davemloft.net>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>, Andrei Botila <andrei.botila@nxp.com>, Antoine Tenart <antoine.tenart@bootlin.com>

On Tue, Aug 11, 2020 at 06:28:39PM +0300, Horia Geantă wrote:
>
> What about, for example, CBC?
> AFAICT cbc(aes) with input length = 0 is valid.

That's just because CBC accepts any input which is a multiple
of blocksize.

> Same for CTR (with the note that blocksize = 1) and several other algorithms
> mentioned in the cover letter.

CTR accepts any input size.

> What's the rule in these cases?

What input size is accepted depends on the algorithm.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
