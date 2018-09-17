Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH net-next] net/smc: cast sizeof to int for comparison
References: <20180915100036.20100-1-yuehaibing@huawei.com>
From: Ursula Braun <ubraun@linux.ibm.com>
Date: Mon, 17 Sep 2018 10:49:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180915100036.20100-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <554a145a-d59d-9033-1702-4987a9c4bc94@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 09/15/2018 12:00 PM, YueHaibing wrote:
> Comparing an int to a size, which is unsigned, causes the int to become
> unsigned, giving the wrong result. kernel_sendmsg can return a negative
> error code.
> 

Thanks for reporting this issue!

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/smc/smc_clc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 83aba9a..fd0f5ce 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -446,7 +446,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
>  	vec[i++].iov_len = sizeof(trl);
>  	/* due to the few bytes needed for clc-handshake this cannot block */
>  	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
> -	if (len < sizeof(pclc)) {
> +	if (len < (int)sizeof(pclc)) {
>  		if (len >= 0) {
>  			reason_code = -ENETUNREACH;
>  			smc->sk.sk_err = -reason_code;
> 

Your fix helps, but I would like to follow the hint of Andreas Schwab, and split
the return value check like this:

---
 net/smc/smc_clc.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -446,14 +446,12 @@ int smc_clc_send_proposal(struct smc_soc
 	vec[i++].iov_len = sizeof(trl);
 	/* due to the few bytes needed for clc-handshake this cannot block */
 	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
-	if (len < sizeof(pclc)) {
-		if (len >= 0) {
-			reason_code = -ENETUNREACH;
-			smc->sk.sk_err = -reason_code;
-		} else {
-			smc->sk.sk_err = smc->clcsock->sk->sk_err;
-			reason_code = -smc->sk.sk_err;
-		}
+	if (len < 0) {
+		smc->sk.sk_err = smc->clcsock->sk->sk_err;
+		reason_code = -smc->sk.sk_err;
+	} else if (len < (int)sizeof(pclc)) {
+		reason_code = -ENETUNREACH;
+		smc->sk.sk_err = -reason_code;
 	}
 
 	return reason_code;

Agreed?

Regards, Ursula
