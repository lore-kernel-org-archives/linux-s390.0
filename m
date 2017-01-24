From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Tue, 24 Jan 2017 09:50:19 +0000
Subject: Re: [PATCH] s390/bpf: remove redundant check for non-null image
Message-Id: <20170124105019.1a5e2766@TP-holzheu>
In-Reply-To: <20170114105739.GB6789@osiris>
References: <20170114105739.GB6789@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am Sat, 14 Jan 2017 01:48:24 +0100
schrieb Daniel Borkmann <daniel@iogearbox.net>:

> After we already allocated the jit.prg_buf image via
> bpf_jit_binary_alloc() and filled it out with instructions,
> jit.prg_buf cannot be NULL anymore. Thus, remove the
> unnecessary check. Tested on s390x with test_bpf module.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/net/bpf_jit_comp.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 167b31b..b4272cd 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -1331,14 +1331,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	}
>  	if (bpf_jit_enable > 1) {
>  		bpf_jit_dump(fp->len, jit.size, pass, jit.prg_buf);
> -		if (jit.prg_buf)
> -			print_fn_code(jit.prg_buf, jit.size_prg);
> -	}
> -	if (jit.prg_buf) {
> -		set_memory_ro((unsigned long)header, header->pages);
> -		fp->bpf_func = (void *) jit.prg_buf;
> -		fp->jited = 1;
> +		print_fn_code(jit.prg_buf, jit.size_prg);
>  	}
> +
> +	set_memory_ro((unsigned long)header, header->pages);
> +	fp->bpf_func = (void *) jit.prg_buf;
> +	fp->jited = 1;
>  free_addrs:
>  	kfree(jit.addrs);
>  out:

Makes sense, thanks!

Michael
