Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 19 Jul 2018 16:41:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/hypfs: Replace PTR_RET with PTR_ERR_OR_ZERO
In-Reply-To: <20180719050830.GA26688@embeddedor.com>
References: <20180719050830.GA26688@embeddedor.com>
MIME-Version: 1.0
Message-Id: <20180719164107.3c2a2385@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 19 Jul 2018 00:08:30 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/s390/hypfs/hypfs_diag.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
> index a2945b2..3452e18 100644
> --- a/arch/s390/hypfs/hypfs_diag.c
> +++ b/arch/s390/hypfs/hypfs_diag.c
> @@ -497,7 +497,7 @@ static int hypfs_create_cpu_files(struct dentry *cpus_dir, void *cpu_info)
>  	}
>  	diag224_idx2name(cpu_info__ctidx(diag204_info_type, cpu_info), buffer);
>  	rc = hypfs_create_str(cpu_dir, "type", buffer);
> -	return PTR_RET(rc);
> +	return PTR_ERR_OR_ZERO(rc);
>  }
> 
>  static void *hypfs_create_lpar_files(struct dentry *systems_dir, void *part_hdr)
> @@ -544,7 +544,7 @@ static int hypfs_create_phys_cpu_files(struct dentry *cpus_dir, void *cpu_info)
>  		return PTR_ERR(rc);
>  	diag224_idx2name(phys_cpu__ctidx(diag204_info_type, cpu_info), buffer);
>  	rc = hypfs_create_str(cpu_dir, "type", buffer);
> -	return PTR_RET(rc);
> +	return PTR_ERR_OR_ZERO(rc);
>  }
> 
>  static void *hypfs_create_phys_files(struct dentry *parent_dir, void *phys_hdr)

Applied to the s390/linux tree for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
