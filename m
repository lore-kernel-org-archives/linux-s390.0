Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <b0c31cbb82aa64027569dff69803ca3ec2f65501.camel@perches.com>
Subject: Re: [trivial PATCH] treewide: Convert switch/case fallthrough; to
 break;
From: Joe Perches <joe@perches.com>
Date: Wed, 09 Sep 2020 14:09:32 -0700
In-Reply-To: <20200909205558.GA3384631@dhcp-10-100-145-180.wdl.wdc.com>
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
         <20200909205558.GA3384631@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Keith Busch <kbusch@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>, Kees Cook <kees.cook@canonical.com>, Nick Desaulniers <ndesaulniers@google.com>

On Wed, 2020-09-09 at 13:55 -0700, Keith Busch wrote:
> On Wed, Sep 09, 2020 at 01:06:39PM -0700, Joe Perches wrote:
> > diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
> > index eea0f453cfb6..8aac5bc60f4c 100644
> > --- a/crypto/tcrypt.c
> > +++ b/crypto/tcrypt.c
> > @@ -2464,7 +2464,7 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
> >  		test_hash_speed("streebog512", sec,
> >  				generic_hash_speed_template);
> >  		if (mode > 300 && mode < 400) break;
> > -		fallthrough;
> > +		break;
> >  	case 399:
> >  		break;
> 
> Just imho, this change makes the preceding 'if' look even more
> pointless. Maybe the fallthrough was a deliberate choice? Not that my
> opinion matters here as I don't know this module, but it looked a bit
> odd to me.

It does look odd to me too.

It's also just a test module though so the
code isn't particularly crucial.

Herbert/David? thoughts?
