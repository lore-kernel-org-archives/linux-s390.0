From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [patch 2/2] zcrypt: add support for large random numbers
Date: Mon, 31 Mar 2008 22:21:11 +0800
Message-ID: <20080331142111.GB14688@gondor.apana.org.au>
References: <20080314092523.147382820@de.ibm.com> <20080314093046.914555041@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080314093046.914555041@de.ibm.com>
Sender: linux-crypto-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-crypto/>
List-Post: <mailto:linux-crypto@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Ralph Wuerthner <rwuerthn@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Mar 14, 2008 at 09:25:25AM +0000, Martin Schwidefsky wrote:
> From: Ralph Wuerthner <rwuerthn@de.ibm.com>
> 
> This patch allows user space applications to access large amounts of 
> truly random data. The random data source is the build-in hardware 
> random number generator on the CEX2C cards.
> 
> Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

The patch looks OK.

Are you guys going to carry this patch in the s390 tree?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
