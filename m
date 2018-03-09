Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Mar 2018 11:18:05 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 08/11] kexec_file: Simplify kexec_purgatory_setup_sechdrs
 2
Message-ID: <20180309031805.GB3246@dhcp-128-65.nay.redhat.com>
References: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
 <20180226151620.20970-9-prudo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226151620.20970-9-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

On 02/26/18 at 04:16pm, Philipp Rudo wrote:
> The main loop currently uses quite a lot of variables to update the section
> headers. Some of them are unnecessary. So clean them up a little.
> 

It looks better to use some patch subject eg below:
"Remove unnecessary variables in kexec_purgatory_setup_sechdrs"

> Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
> ---
>  kernel/kexec_file.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index bb31a3b627c2..746b91e46e34 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -724,12 +724,8 @@ static int kexec_purgatory_setup_kbuf(struct purgatory_info *pi,
>  static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  					 struct kexec_buf *kbuf)
>  {
> -	unsigned long curr_load_addr;
> -	unsigned long load_addr;
>  	unsigned long bss_addr;
>  	unsigned long offset;
> -	unsigned char *buf_addr;
> -	unsigned char *src;
>  	Elf_Shdr *sechdrs;
>  	int i;
>  
> @@ -762,20 +758,18 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  						sechdrs[i].sh_offset;
>  	}
>  
> -	/* Load SHF_ALLOC sections */
> -	buf_addr = kbuf->buffer;
> -	load_addr = curr_load_addr = kbuf->mem;
> -	bss_addr = load_addr + kbuf->bufsz;
> +	offset = 0;
> +	bss_addr = kbuf->mem + kbuf->bufsz;
>  	kbuf->image->start = pi->ehdr->e_entry;
>  
>  	for (i = 0; i < pi->ehdr->e_shnum; i++) {
>  		unsigned long align;
> +		void *src, *dst;
>  
>  		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
>  			continue;
>  
>  		align = sechdrs[i].sh_addralign;
> -
>  		if (sechdrs[i].sh_type == SHT_NOBITS) {
>  			bss_addr = ALIGN(bss_addr, align);
>  			sechdrs[i].sh_addr = bss_addr;
> @@ -783,31 +777,27 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  			continue;
>  		}
>  
> -		curr_load_addr = ALIGN(curr_load_addr, align);
> -		offset = curr_load_addr - load_addr;
> -		/* We already modifed ->sh_offset to keep src addr */
> -		src = (char *)sechdrs[i].sh_offset;
> -		memcpy(buf_addr + offset, src, sechdrs[i].sh_size);
> -
> +		offset = ALIGN(offset, align);
>  		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
>  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
>  					 + sechdrs[i].sh_size)) {
>  			kbuf->image->start -= sechdrs[i].sh_addr;
> -			kbuf->image->start += curr_load_addr
> +			kbuf->image->start += kbuf->mem + offset;
>  		}
>  
> -		/* Store load address and source address of section */
> -		sechdrs[i].sh_addr = curr_load_addr;
> +		src = (void *)sechdrs[i].sh_offset;
> +		dst = pi->purgatory_buf + offset;
> +		memcpy(dst, src, sechdrs[i].sh_size);
> +
> +		sechdrs[i].sh_addr = kbuf->mem + offset;
>  
>  		/*
>  		 * This section got copied to temporary buffer. Update
>  		 * ->sh_offset accordingly.
>  		 */
> -		sechdrs[i].sh_offset = (unsigned long)(buf_addr + offset);
> -
> -		/* Advance to the next address */
> -		curr_load_addr += sechdrs[i].sh_size;
> +		sechdrs[i].sh_offset = (unsigned long)dst;
> +		offset += sechdrs[i].sh_size;
>  	}
>  
>  	return 0;
> -- 
> 2.13.5
> 

Thanks
Dave
