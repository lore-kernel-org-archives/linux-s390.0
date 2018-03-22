Return-Path: <netdev-owner@vger.kernel.org>
Subject: Re: [PATCH net-next 1/1] net/ipv4: disable SMC TCP option with SYN
 Cookies
References: <20180320155340.18017-1-ubraun@linux.vnet.ibm.com>
 <20180320155340.18017-2-ubraun@linux.vnet.ibm.com>
 <435f82d0-407e-6675-194a-102d83f418f8@gmail.com>
 <27701c4c-3759-6226-3307-fa03a9cc49b8@gmail.com>
 <9b88f9f8-1d3b-7d7d-f612-b823069afa75@linux.vnet.ibm.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <541e6836-a3be-58ef-dbbf-0f114042b86a@gmail.com>
Date: Thu, 22 Mar 2018 07:30:48 -0700
MIME-Version: 1.0
In-Reply-To: <9b88f9f8-1d3b-7d7d-f612-b823069afa75@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <ubraun@linux.vnet.ibm.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 03/22/2018 06:23 AM, Ursula Braun wrote:

> We moved the clear to cookie_v4_check()/cookie_v6_check. However, this does not seem to
> be sufficient to prevent the SYNACK from containing the SMC experimental option.
> We found that an additional check in tcp_conn_request() helps:
> 
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6248,6 +6248,9 @@ int tcp_conn_request(struct request_sock
>  	if (want_cookie && !tmp_opt.saw_tstamp)
>  		tcp_clear_options(&tmp_opt);
>  
> +	if (IS_ENABLED(CONFIG_SMC) && want_cookie && tmp_opt.smc_ok)
> +		tmp_opt.smc_ok = 0;
> +
>  	tmp_opt.tstamp_ok = tmp_opt.saw_tstamp;
>  	tcp_openreq_init(req, &tmp_opt, skb, sk);
>  	inet_rsk(req)->no_srccheck = inet_sk(sk)->transparent;
> 
> Do you think this could be the right place for clearing the smc_ok bit?


Yes, but since tmp_opt is private to this thread/cpu, no false sharing to be afraid of

if (IS_ENABLED(CONFIG_SMC) && want_cookie)
    tmp_opt.smc_ok = 0;
