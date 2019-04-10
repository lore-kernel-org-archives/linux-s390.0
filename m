Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Apr 2019 17:59:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
In-Reply-To: <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-5-arnd@arndb.de>
        <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410175946.0e6d2b00@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Ingo Franzki <ifranzki@de.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Apr 2019 11:54:30 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 08.04.19 23:26, Arnd Bergmann wrote:
> > The 'func_code' variable gets printed in debug statements without
> > a prior initialization in multiple functions, as reported when building
> > with clang:
> >
> > drivers/s390/crypto/zcrypt_api.c:659:6: warning: variable 'func_code' is used uninitialized whenever 'if' condition is true
> >       [-Wsometimes-uninitialized]
> >         if (mex->outputdatalength < mex->inputdatalength) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/s390/crypto/zcrypt_api.c:725:29: note: uninitialized use occurs here
> >         trace_s390_zcrypt_rep(mex, func_code, rc,
> >                                    ^~~~~~~~~
> > drivers/s390/crypto/zcrypt_api.c:659:2: note: remove the 'if' if its condition is always false
> >         if (mex->outputdatalength < mex->inputdatalength) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/s390/crypto/zcrypt_api.c:654:24: note: initialize the variable 'func_code' to silence this warning
> >         unsigned int func_code;
> >                               ^
> >
> > Add initializations to all affected code paths to shut up the warning
> > and make the warning output consistent.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/s390/crypto/zcrypt_api.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> > index eb93c2d27d0a..23472063d9a8 100644
> > --- a/drivers/s390/crypto/zcrypt_api.c
> > +++ b/drivers/s390/crypto/zcrypt_api.c
> > @@ -657,6 +657,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
> >  	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
> >  
> >  	if (mex->outputdatalength < mex->inputdatalength) {
> > +		func_code = -1;
> >  		rc = -EINVAL;
> >  		goto out;
> >  	}
> > @@ -739,6 +740,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
> >  	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
> >  
> >  	if (crt->outputdatalength < crt->inputdatalength) {
> > +		func_code = -1;
> >  		rc = -EINVAL;
> >  		goto out;
> >  	}
> > @@ -946,6 +948,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
> >  
> >  		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
> >  		if (!targets) {
> > +			func_code = -1;
> >  			rc = -ENOMEM;
> >  			goto out;
> >  		}
> > @@ -953,6 +956,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
> >  		uptr = (struct ep11_target_dev __force __user *) xcrb->targets;
> >  		if (copy_from_user(targets, uptr,
> >  				   target_num * sizeof(*targets))) {
> > +			func_code = -1;
> >  			rc = -EFAULT;
> >  			goto out_free;
> >  		}  
> Thanks Arnd, but as Nathan already wrote, I'd prefer to have the
> variable initialized with 0 instead of -1.
> If you agree with this, I'll rewrite the patch and apply it to our
> internal git and it will appear at kernel org with the next s390 code merge then.

Do we agreement on func_coed=0 for this one ?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
