Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <d4de00a939be7b2b37ac1eb84c48777b73614dce.camel@sipsolutions.net>
Subject: Re: [PATCH 3/8] net: mac80211: convert tasklets to use new
 tasklet_setup() API
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 17 Aug 2020 10:56:06 +0200
In-Reply-To: <20200817085120.24894-3-allen.cryptic@gmail.com> (sfid-20200817_105156_998114_A405125C)
References: <20200817085120.24894-1-allen.cryptic@gmail.com>
         <20200817085120.24894-3-allen.cryptic@gmail.com>
         (sfid-20200817_105156_998114_A405125C)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Allen Pais <allen.cryptic@gmail.com>, gerrit@erg.abdn.ac.uk, davem@davemloft.net, kuba@kernel.org, edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, alex.aring@gmail.com, stefan@datenfreihafen.org, santosh.shilimkar@oracle.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: keescook@chromium.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>, Romain Perier <romain.perier@gmail.com>

On Mon, 2020-08-17 at 14:21 +0530, Allen Pais wrote:
> 
> -static void ieee80211_tasklet_handler(unsigned long data)
> +static void ieee80211_tasklet_handler(struct tasklet_struct *t)
>  {
> -	struct ieee80211_local *local = (struct ieee80211_local *) data;
> +	struct ieee80211_local *local = from_tasklet(local, t, tasklet);

Yay, thank you!

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>


Dave, if you want to take this patch, I have no objections - I have
nothing in my mac80211-next tree (yet).

johannes
