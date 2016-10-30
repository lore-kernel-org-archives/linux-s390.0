Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 30 Oct 2016 14:43:08 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 3/3] s390: char: make slp_ctl explicitly non-modular
In-Reply-To: <20161029203843.515-4-paul.gortmaker@windriver.com>
References: <20161029203843.515-1-paul.gortmaker@windriver.com>
        <20161029203843.515-4-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161030144308.03a804de@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 29 Oct 2016 16:38:43 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> The Makefile currently controlling compilation of this code is obj-y,
> meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple traces of modular usage, so that when reading
> the driver there is no doubt it is builtin-only.
> 
> Since module_misc_device translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

That idea behind the patch makes sense to me. But the built robot
reports a new warning which should be fixed. If that is done:

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
