From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Next July 16: s390 sha1 crypro build failure.
Date: Thu, 16 Jul 2009 19:58:59 +0800
Message-ID: <20090716115859.GA964@gondor.apana.org.au>
References: <20090716172015.be5dc94b.sfr@canb.auug.org.au> <4A5EF9FE.2050302@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A5EF9FE.2050302@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 16, 2009 at 03:29:26PM +0530, Sachin Sant wrote:
> Today's next tree fails to build on s390 with following errors.
>
> arch/s390/crypto/sha1_s390.c:67: error: 'struct sha1_state' has no member named 'buf'
> arch/s390/crypto/sha1_s390.c:68: error: 'struct sha1_state' has no member named 'func'
>
> arch/s390/crypto/sha256_s390.c:64: error: 'struct sha256_state' has no member named 'func'
>
> Probably because of commit 406f104b4172de7452702c6810807c1b0132ba22.
>
> In sha1_/sha256_import() functions struct s390_sha_ctx *sctx should be
> used instead of struct sha1_state.
>
> The following patch fixed the issue for me.

Thanks for the fix! Patch applied to cryptodev.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
