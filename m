Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 10 Sep 2020 08:35:40 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [trivial PATCH] treewide: Convert switch/case fallthrough; to
 break;
Message-ID: <20200909223540.GA27590@gondor.apana.org.au>
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
 <20200909205558.GA3384631@dhcp-10-100-145-180.wdl.wdc.com>
 <b0c31cbb82aa64027569dff69803ca3ec2f65501.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c31cbb82aa64027569dff69803ca3ec2f65501.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Keith Busch <kbusch@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>, Kees Cook <kees.cook@canonical.com>, Nick Desaulniers <ndesaulniers@google.com>

On Wed, Sep 09, 2020 at 02:09:32PM -0700, Joe Perches wrote:
> On Wed, 2020-09-09 at 13:55 -0700, Keith Busch wrote:
> > On Wed, Sep 09, 2020 at 01:06:39PM -0700, Joe Perches wrote:
> > > diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
> > > index eea0f453cfb6..8aac5bc60f4c 100644
> > > --- a/crypto/tcrypt.c
> > > +++ b/crypto/tcrypt.c
> > > @@ -2464,7 +2464,7 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
> > >  		test_hash_speed("streebog512", sec,
> > >  				generic_hash_speed_template);
> > >  		if (mode > 300 && mode < 400) break;
> > > -		fallthrough;
> > > +		break;
> > >  	case 399:
> > >  		break;
> > 
> > Just imho, this change makes the preceding 'if' look even more
> > pointless. Maybe the fallthrough was a deliberate choice? Not that my
> > opinion matters here as I don't know this module, but it looked a bit
> > odd to me.
> 
> It does look odd to me too.
> 
> It's also just a test module though so the
> code isn't particularly crucial.
> 
> Herbert/David? thoughts?

Please read the function as a whole, that fallthrough (and every other
one in do_test) needs to stay.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
