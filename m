From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] arch: s390: kernel: reset 'c->hotpluggable' when failure
 occurs
Date: Tue, 25 Jun 2013 08:48:32 +0200
Message-ID: <20130625064832.GA4999@osiris>
References: <51C8F685.6000209@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51C8F685.6000209@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 25, 2013 at 09:46:45AM +0800, Chen Gang wrote:
> When smp_add_present_cpu() fails, it has reset all things excluding
> 'c->hotpluggable', so need reset it as original state completely.
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/s390/kernel/smp.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 15a016c..c4c6f42 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -1016,6 +1016,7 @@ out_cpu:
>  	unregister_cpu(c);
>  #endif
>  out:
> +	c->hotpluggable = 0;
>  	return rc;

No, that doesn't make sense. All cpus on s390 are always hotplugable.
It really doesn't matter if the value of this field is 0 or 1 after
an error.
