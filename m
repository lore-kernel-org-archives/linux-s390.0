Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1362921205-10295-1-git-send-email-steliannirlu@gmail.com>
References: <1362921205-10295-1-git-send-email-steliannirlu@gmail.com>
Date: Sun, 10 Mar 2013 16:14:00 +0200
Message-ID: <CAOJsxLGZ=6r85D5OBrFehbpjVSTvK-vaMGQGD9W0ssymT4QyTw@mail.gmail.com>
Subject: Re: [PATCH] s390: replace kmalloc + memset with kzalloc
From: Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stelian Nirlu <steliannirlu@gmail.com>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 10, 2013 at 3:13 PM, Stelian Nirlu <steliannirlu@gmail.com> wrote:
> Signed-off-by: Stelian Nirlu <steliannirlu@gmail.com>
> ---
>  arch/s390/net/bpf_jit_comp.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 0972e91..e645528 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -747,10 +747,9 @@ void bpf_jit_compile(struct sk_filter *fp)
>
>         if (!bpf_jit_enable)
>                 return;
> -       addrs = kmalloc(fp->len * sizeof(*addrs), GFP_KERNEL);
> +       addrs = kzalloc(fp->len * sizeof(*addrs), GFP_KERNEL);

kcalloc() might be more appropriate here to protect against integer
overflow if "fp->len" is too large.
