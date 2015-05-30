Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 30 May 2015 13:45:32 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH V2] s390/sclp: pass timeout as HZ independent value
Message-ID: <20150530114532.GB4218@osiris>
References: <1432911055-23219-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432911055-23219-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 29, 2015 at 04:50:55PM +0200, Nicholas Mc Guire wrote:
> schedule_timeout takes a timeout in jiffies but the code currently is
> passing in a constant SDIAS_SLEEP_TICKS, as this is otherwise unused
> it is replaced by 500ms as recommended by Michael Holzheu
> <holzheu@linux.vnet.ibm.com> and converted with msecs_to_jiffies();
> As SDIAS_SLEEP_TICKS was only used in this one location it is dropped.
> 
> Patch was compile tested with (s390) defconfig + 
> CONFIG_MARCH_Z10=y, (implies CONFIG_CRASH_DUMP=y)
> 
> Patch is against 4.1-rc5 (localversion-next is -next-20150529)
> 
> Link: http://lkml.org/lkml/2015/5/29/235
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> V2: timeout clarified by Heiko Carstens <heiko.carstens@de.ibm.com> and
>     set to 500ms (HZ/2). And thanks for the test-config hints.
> 
>  drivers/s390/char/sclp_sdias.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks!
