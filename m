Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 1 Jun 2019 12:22:47 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/purgatory: update .gitignore
References: <20190531024651.5925-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531024651.5925-1-yamada.masahiro@socionext.com>
Message-Id: <20190601102247.GF3600@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 31, 2019 at 11:46:51AM +0900, Masahiro Yamada wrote:
> Since commit 4c0f032d4963 ("s390/purgatory: Omit use of bin2c"),
> kexec-purgatory.c is not generated.
> 
> purgatory and purgatory.lds are generated files, so should be ignored
> by git.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/purgatory/.gitignore | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitignore
> index e9e66f178a6d..04a03433c720 100644
> --- a/arch/s390/purgatory/.gitignore
> +++ b/arch/s390/purgatory/.gitignore
> @@ -1,2 +1,3 @@
> -kexec-purgatory.c
> +purgatory
> +purgatory.lds
>  purgatory.ro

Applied, thanks.
