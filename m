From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: Re: [PATCH] iucv: properly clone LSM attributes to newly created
 child sockets
Date: Mon, 13 Jun 2016 12:08:46 +0200
Message-ID: <1465812526.4401.4.camel@BR9GV9YG.de.ibm.com>
References: <OFBFC201CF.D9C45214-ONC1257FCD.0059BB30-C1257FCD.0059C94A@notes.na.collabserv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <OFBFC201CF.D9C45214-ONC1257FCD.0059BB30-C1257FCD.0059C94A@notes.na.collabserv.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Paul Moore <pmoore@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-ID: <linux-s390.vger.kernel.org>

> From: Paul Moore <paul@paul-moore.com>
> 
> Much like we had to do for AF_BLUETOOTH and AF_ALG, make sure we
> properly clone the parent socket's LSM attributes to newly created
> child sockets.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
> net/iucv/af_iucv.c |    5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index fc3598a..a0d1e36 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -22,6 +22,7 @@
> #include <linux/skbuff.h>
> #include <linux/init.h>
> #include <linux/poll.h>
> +#include <linux/security.h>
> #include <net/sock.h>
> #include <asm/ebcdic.h>
> #include <asm/cpcmd.h>
> @@ -530,8 +531,10 @@ static void iucv_sock_close(struct sock *sk)
> 
> static void iucv_sock_init(struct sock *sk, struct sock *parent)
> {
> -                 if (parent)
> +                 if (parent) {
>                                   sk->sk_type = parent->sk_type;
> +                                  security_sk_clone(parent, sk);
> +                 }
> }
> 
> static struct sock *iucv_sock_alloc(struct socket *sock, int proto,
> gfp_t prio, int kern)

applied locally - thx. Your patch will now be submitted for inclusion
into net-next.

Regards, Ursula Braun
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
