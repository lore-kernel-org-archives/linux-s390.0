Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 8 Apr 2019 15:16:32 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 04/12] s390: qeth: address type mismatch warning
Message-ID: <20190408221632.GB18333@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408212648.2407234-4-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 08, 2019 at 11:26:17PM +0200, Arnd Bergmann wrote:
> clang produces a harmless warning for each use for the qeth_adp_supported
> macro:
> 
> drivers/s390/net/qeth_l2_main.c:559:31: warning: implicit conversion from enumeration type 'enum qeth_ipa_setadp_cmd' to
>       different enumeration type 'enum qeth_ipa_funcs' [-Wenum-conversion]
>         if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
>             ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/s390/net/qeth_core.h:179:41: note: expanded from macro 'qeth_adp_supported'
>         qeth_is_ipa_supported(&c->options.adp, f)
>         ~~~~~~~~~~~~~~~~~~~~~                  ^
> 
> Add a version of this macro that uses the correct types, and
> remove the unused qeth_adp_enabled() macro that has the same
> problem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I wonder if it is better to just change the func parameter to type long.
I guess it's better to keep the type safety to make sure values aren't
unintentionally mixed but the body of the functions is the same so does
the type actually matter?

Regardless, this change does fix the warning so:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/s390/net/qeth_core.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
> index c851cf6e01c4..d603dfea97ab 100644
> --- a/drivers/s390/net/qeth_core.h
> +++ b/drivers/s390/net/qeth_core.h
> @@ -163,6 +163,12 @@ struct qeth_vnicc_info {
>  	bool rx_bcast_enabled;
>  };
>  
> +static inline int qeth_is_adp_supported(struct qeth_ipa_info *ipa,
> +		enum qeth_ipa_setadp_cmd func)
> +{
> +	return (ipa->supported_funcs & func);
> +}
> +
>  static inline int qeth_is_ipa_supported(struct qeth_ipa_info *ipa,
>  		enum qeth_ipa_funcs func)
>  {
> @@ -176,9 +182,7 @@ static inline int qeth_is_ipa_enabled(struct qeth_ipa_info *ipa,
>  }
>  
>  #define qeth_adp_supported(c, f) \
> -	qeth_is_ipa_supported(&c->options.adp, f)
> -#define qeth_adp_enabled(c, f) \
> -	qeth_is_ipa_enabled(&c->options.adp, f)
> +	qeth_is_adp_supported(&c->options.adp, f)
>  #define qeth_is_supported(c, f) \
>  	qeth_is_ipa_supported(&c->options.ipa4, f)
>  #define qeth_is_enabled(c, f) \
> -- 
> 2.20.0
> 
