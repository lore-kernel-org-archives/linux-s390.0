Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/hypfs: fix a typo in the name of a function
References: <20190721123321.12879-1-christophe.jaillet@wanadoo.fr>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 22 Jul 2019 09:44:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190721123321.12879-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fef3c70c-5c36-ea73-b52a-252656b46457@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, heiko.carstens@de.ibm.com, Vasily Gorbik <gor@linux.ibm.com>, gregkh@linuxfoundation.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

thanks, applied.

On 21.07.19 14:33, Christophe JAILLET wrote:
> Everything is about hypfs_..., except 'hpyfs_vm_create_guest()'
> s/hpy/hyp/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/s390/hypfs/hypfs_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
> index 42f2375c203e..e1fcc03159ef 100644
> --- a/arch/s390/hypfs/hypfs_vm.c
> +++ b/arch/s390/hypfs/hypfs_vm.c
> @@ -118,7 +118,7 @@ do { \
>  		return PTR_ERR(rc); \
>  } while(0)
>  
> -static int hpyfs_vm_create_guest(struct dentry *systems_dir,
> +static int hypfs_vm_create_guest(struct dentry *systems_dir,
>  				 struct diag2fc_data *data)
>  {
>  	char guest_name[NAME_LEN + 1] = {};
> @@ -219,7 +219,7 @@ int hypfs_vm_create_files(struct dentry *root)
>  	}
>  
>  	for (i = 0; i < count; i++) {
> -		rc = hpyfs_vm_create_guest(dir, &(data[i]));
> +		rc = hypfs_vm_create_guest(dir, &(data[i]));
>  		if (rc)
>  			goto failed;
>  	}
> 
