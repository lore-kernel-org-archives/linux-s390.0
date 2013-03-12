Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Mar 2013 08:07:15 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] s390: use kcalloc instead of kmalloc and memset
Message-ID: <20130312070715.GB4148@osiris>
References: <1363018931-9628-1-git-send-email-steliannirlu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1363018931-9628-1-git-send-email-steliannirlu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stelian Nirlu <steliannirlu@gmail.com>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, penberg@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 11, 2013 at 06:22:10PM +0200, Stelian Nirlu wrote:
> Signed-off-by: Stelian Nirlu <steliannirlu@gmail.com>
> ---
>  arch/s390/net/bpf_jit_comp.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 0972e91..82f165f 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -747,10 +747,9 @@ void bpf_jit_compile(struct sk_filter *fp)
> 
>  	if (!bpf_jit_enable)
>  		return;
> -	addrs = kmalloc(fp->len * sizeof(*addrs), GFP_KERNEL);
> +	addrs = kcalloc(fp->len, sizeof(*addrs), GFP_KERNEL);
>  	if (addrs == NULL)
>  		return;
> -	memset(addrs, 0, fp->len * sizeof(*addrs));

Applied, thanks!
