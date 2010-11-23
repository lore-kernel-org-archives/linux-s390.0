From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: Re: Fw: [Patch V2 -next] Adapt s390 qeth & lcs driver code to use
 RCU
Date: Tue, 23 Nov 2010 10:48:55 +0100
Message-ID: <1290505735.3782.3.camel@braunu-laptop>
References: <OFDFD4C08B.1C026299-ONC12577E4.003543D2-C12577E4.003556F2@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <OFDFD4C08B.1C026299-ONC12577E4.003543D2-C12577E4.003556F2@de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>, davem@davemloft.net
Cc: linux-s390@vger.kernel.org, linux-next@vger.kernel.org, eric.dumazet@gmail.com
List-ID: <linux-s390.vger.kernel.org>


ACK, thanks Sachin!

> From: 
> Sachin Sant <sachinp@in.ibm.com> 
> To: 
> netdev@vger.kernel.org,
> davem@davemloft.net 
> Cc: 
> Sachin Sant <sachinp@in.ibm.com>,
> linux-s390@vger.kernel.org,
> linux-next@vger.kernel.org, Ursula
> Braun1/Germany/IBM@IBMDE,
> eric.dumazet@gmail.com 
> Date: 
> 19.11.2010 10:40 
> Subject: 
> [Patch V2 -next] Adapt s390 qeth &
> lcs driver code to use RCU
> 
> 
> ______________________________________________________________________
> 
> 
> 
> Commit 1d7138de878d1d4210727c1200193e69596f93b3
> igmp: RCU conversion of in_dev->mc_list
> 
> converted rwlock to RCU.
> 
> Update the s390 network drivers(qeth & lcs) code to adapt to this
> change.
> 
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> ---
> 
> V2 : Changes based on suggestions given by Eric Dumazet
> 
> diff -Naurp a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
> --- a/drivers/s390/net/lcs.c                 2010-11-19
> 14:37:10.000000000 +0530
> +++ b/drivers/s390/net/lcs.c                 2010-11-19
> 15:03:52.000000000 +0530
> @@ -1188,7 +1188,7 @@ lcs_remove_mc_addresses(struct lcs_card
>                  spin_lock_irqsave(&card->ipm_lock, flags);
>                  list_for_each(l, &card->ipm_list) {
>                                   ipm = list_entry(l, struct
> lcs_ipm_list, list);
> -                                  for (im4 = in4_dev->mc_list; im4 !=
> NULL; im4 = im4->next) {
> +                                  for (im4 =
> rcu_dereference(in4_dev->mc_list); im4 != NULL; im4 =
> rcu_dereference(im4->next_rcu)) {
> 
>  lcs_get_mac_for_ipm(im4->multiaddr, buf, card->dev);
>                                                    if
> ( (ipm->ipm.ip_addr == im4->multiaddr) &&
>                                                         (memcmp(buf,
> &ipm->ipm.mac_addr,
> @@ -1233,7 +1233,7 @@ lcs_set_mc_addresses(struct lcs_card *ca
>                  unsigned long flags;
> 
>                  LCS_DBF_TEXT(4, trace, "setmclst");
> -                 for (im4 = in4_dev->mc_list; im4; im4 = im4->next) {
> +                 for (im4 = rcu_dereference(in4_dev->mc_list); im4;
> im4 = rcu_dereference(im4->next_rcu)) {
>                                   lcs_get_mac_for_ipm(im4->multiaddr,
> buf, card->dev);
>                                   ipm = lcs_check_addr_entry(card,
> im4, buf);
>                                   if (ipm != NULL)
> @@ -1269,10 +1269,10 @@ lcs_register_mc_addresses(void *data)
>                  in4_dev = in_dev_get(card->dev);
>                  if (in4_dev == NULL)
>                                   goto out;
> -                 read_lock(&in4_dev->mc_list_lock);
> +                 rcu_read_lock();
>                  lcs_remove_mc_addresses(card,in4_dev);
>                  lcs_set_mc_addresses(card, in4_dev);
> -                 read_unlock(&in4_dev->mc_list_lock);
> +                 rcu_read_unlock();
>                  in_dev_put(in4_dev);
> 
>                  netif_carrier_off(card->dev);
> diff -Naurp a/drivers/s390/net/qeth_l3_main.c
> b/drivers/s390/net/qeth_l3_main.c
> --- a/drivers/s390/net/qeth_l3_main.c                 2010-11-19
> 14:37:10.000000000 +0530
> +++ b/drivers/s390/net/qeth_l3_main.c                 2010-11-19
> 15:03:32.000000000 +0530
> @@ -1796,7 +1796,7 @@ static void qeth_l3_add_mc(struct qeth_c
>                  char buf[MAX_ADDR_LEN];
> 
>                  QETH_CARD_TEXT(card, 4, "addmc");
> -                 for (im4 = in4_dev->mc_list; im4; im4 = im4->next) {
> +                 for (im4 = rcu_dereference(in4_dev->mc_list); im4 !=
> NULL; im4 = rcu_dereference(im4->next_rcu)) {
> 
> qeth_l3_get_mac_for_ipm(im4->multiaddr, buf, in4_dev->dev);
>                                   ipm =
> qeth_l3_get_addr_buffer(QETH_PROT_IPV4);
>                                   if (!ipm)
> @@ -1828,9 +1828,9 @@ static void qeth_l3_add_vlan_mc(struct q
>                                   in_dev = in_dev_get(netdev);
>                                   if (!in_dev)
>                                                    continue;
> -                                  read_lock(&in_dev->mc_list_lock);
> +                                  rcu_read_lock();
>                                   qeth_l3_add_mc(card, in_dev);
> -                                  read_unlock(&in_dev->mc_list_lock);
> +                                  rcu_read_unlock();
>                                   in_dev_put(in_dev);
>                  }
> }
> @@ -1843,10 +1843,10 @@ static void qeth_l3_add_multicast_ipv4(s
>                  in4_dev = in_dev_get(card->dev);
>                  if (in4_dev == NULL)
>                                   return;
> -                 read_lock(&in4_dev->mc_list_lock);
> +                 rcu_read_lock();
>                  qeth_l3_add_mc(card, in4_dev);
>                  qeth_l3_add_vlan_mc(card);
> -                 read_unlock(&in4_dev->mc_list_lock);
> +                 rcu_read_unlock();
>                  in_dev_put(in4_dev);
> }
> 
> 
