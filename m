Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 1 Sep 2016 12:32:45 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/hypfs: Use kmalloc_array() in diag0c_store()
References: <5fd5f9ef-923f-4655-54f0-874114dc9428@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd5f9ef-923f-4655-54f0-874114dc9428@users.sourceforge.net>
Message-Id: <20160901103245.GA3624@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 01, 2016 at 11:38:15AM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 1 Sep 2016 11:30:58 +0200
> 
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "kmalloc_array".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/s390/hypfs/hypfs_diag0c.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/hypfs/hypfs_diag0c.c b/arch/s390/hypfs/hypfs_diag0c.c
> index 0f1927c..61418a8 100644
> --- a/arch/s390/hypfs/hypfs_diag0c.c
> +++ b/arch/s390/hypfs/hypfs_diag0c.c
> @@ -48,7 +48,9 @@ static void *diag0c_store(unsigned int *count)
>  
>  	get_online_cpus();
>  	cpu_count = num_online_cpus();
> -	cpu_vec = kmalloc(sizeof(*cpu_vec) * num_possible_cpus(), GFP_KERNEL);
> +	cpu_vec = kmalloc_array(num_possible_cpus(),
> +				sizeof(*cpu_vec),
> +				GFP_KERNEL);

How does this improve the situation? For any real life scenario this can't
overflow, but it does add an extra (pointless) runtime check, since
num_possible_cpus() is not a compile time constant.

So, why is this an "issue"?
