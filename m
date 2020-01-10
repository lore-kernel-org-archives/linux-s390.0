Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56710 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbgAJRGm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Jan 2020 12:06:42 -0500
Date: Fri, 10 Jan 2020 12:05:59 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 00/10] Impveovements for random.h/archrandom.h
Message-ID: <20200110170559.GA304349@mit.edu>
References: <20200110145422.49141-1-broonie@kernel.org>
 <20200110155153.GG19453@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110155153.GG19453@zn.tnic>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, linux-s390@vger.kernel.org, herbert@gondor.apana.org.au, x86@kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 10, 2020 at 04:51:53PM +0100, Borislav Petkov wrote:
> On Fri, Jan 10, 2020 at 02:54:12PM +0000, Mark Brown wrote:
> > This is a resend of a series from Richard Henderson last posted back in
> > November:
> > 
> >    https://lore.kernel.org/linux-arm-kernel/20191106141308.30535-1-rth@twiddle.net/
> > 
> > Back then Borislav said they looked good and asked if he should take
> > them through the tip tree but things seem to have got lost since then.
> 
> Or, alternatively, akpm could take them. In any case, if someone else
> ends up doing that, for the x86 bits:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Or I can take them through the random.git tree, since we have a lot of
changes this cycle going to Linus anyway.  Any objections?

	     	   	    	  	   - Ted
