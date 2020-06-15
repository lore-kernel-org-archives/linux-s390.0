Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Jun 2020 21:40:38 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200615114038.GA20708@gondor.apana.org.au>
References: <20200611125144.GA2506@gondor.apana.org.au>
 <20200613122834.GA23739@xsang-OptiPlex-9020>
 <20200613130949.GA22005@gondor.apana.org.au>
 <20200613142901.65xieioomt6bbqa6@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613142901.65xieioomt6bbqa6@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: kernel test robot <lkp@intel.com>, linux-sparse@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org

On Sat, Jun 13, 2020 at 04:29:01PM +0200, Luc Van Oostenryck wrote:
>
> while there is no such problem with the previous commit.
> I think the problem is that:
> * ratelimit.h needs raw_spinlock_t
> * spinlock_types.h needs lockdep.h
> * lockdep.h needs ratelimit.h

Thanks for investigating.  I now realise that this was sent against
my first patch which did have this problem, which was fixed in my
second patch.  Sorry for the false alarm.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
