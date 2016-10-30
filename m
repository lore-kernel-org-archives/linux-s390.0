Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 30 Oct 2016 12:04:14 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/3] s390: char: make slp_ctl explicitly non-modular
Message-ID: <20161030160414.GO5641@windriver.com>
References: <20161029203843.515-1-paul.gortmaker@windriver.com>
 <20161029203843.515-4-paul.gortmaker@windriver.com>
 <20161030144308.03a804de@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161030144308.03a804de@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

[Re: [PATCH 3/3] s390: char: make slp_ctl explicitly non-modular] On 30/10/2016 (Sun 14:43) Martin Schwidefsky wrote:

[...]

> That idea behind the patch makes sense to me. But the built robot
> reports a new warning which should be fixed. If that is done:
> 
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

The kbuild robot is a false positive ; it test-applied the patches on
master and not on Greg's char-misc ; which as per the 0/3 text is the
whole reason we are putting these patches in via Greg's branch.  So
there should be nothing to fix once they are in the right place.

Paul.
--

> 
> -- 
> blue skies,
>    Martin.
> 
> "Reality continues to ruin my life." - Calvin.
> 
