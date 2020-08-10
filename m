Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:45758
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbgHJOdr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Aug 2020 10:33:47 -0400
Subject: Re: [PATCH 19/22] crypto: inside-secure - add check for xts input
 length equal to zero
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
 <20200807162010.18979-20-andrei.botila@oss.nxp.com>
 <CY4PR0401MB36528610C3ABF802F8CBF35FC3440@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20200810134500.GA22914@gondor.apana.org.au>
From: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <fd3e5862-3357-7dfc-6c75-30086ab19f82@nxp.com>
Date: Mon, 10 Aug 2020 17:33:39 +0300
In-Reply-To: <20200810134500.GA22914@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>
Cc: "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>, "David S. Miller" <davem@davemloft.net>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>, Andrei Botila <andrei.botila@nxp.com>, Antoine Tenart <antoine.tenart@bootlin.com>

On 8/10/2020 4:45 PM, Herbert Xu wrote:
> On Mon, Aug 10, 2020 at 10:20:20AM +0000, Van Leeuwen, Pascal wrote:
>>
>> With all due respect, but this makes no sense.
> 
> I agree.  This is a lot of churn for no gain.
> 
I would say the gain is that all skcipher algorithms would behave the same
when input length equals zero - i.e. treat the request as a no-op.

We can't say "no input" has any meaning to the other skcipher algorithms,
but the convention is to accept this case and just return 0.
I don't see why XTS has to be handled differently.

Thanks,
Horia
