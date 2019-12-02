Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:54572 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLBNXs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 08:23:48 -0500
Date: Mon, 2 Dec 2019 16:23:16 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] net/smc: fix ethernet interface refcounting
Message-ID: <20191202132316.GA1787@kadam>
References: <20191202131233.2b4daujqmi27tecx@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202131233.2b4daujqmi27tecx@kili.mountain>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: linux-s390@vger.kernel.org

Oops...  I read the caller and it's fine.  My bad.

regards,
dan carpenter

On Mon, Dec 02, 2019 at 04:12:33PM +0300, Dan Carpenter wrote:
> Hello Ursula Braun,
> 
> The patch 98f3375505b8: "net/smc: fix ethernet interface refcounting"
> from Nov 6, 2019, leads to the following static checker warning:
> 
> 	net/smc/smc_pnet.c:379 smc_pnet_fill_entry()
> 	warn: 'pnetelem->ndev' held on error path.
> 
> net/smc/smc_pnet.c
>    329  static int smc_pnet_fill_entry(struct net *net,
>    330                                 struct smc_user_pnetentry *pnetelem,
>    331                                 struct nlattr *tb[])
>    332  {
>    333          char *string, *ibname;
>    334          int rc;
>    335  
>    336          memset(pnetelem, 0, sizeof(*pnetelem));
>    337          INIT_LIST_HEAD(&pnetelem->list);
>    338  
>    339          rc = -EINVAL;
>    340          if (!tb[SMC_PNETID_NAME])
>    341                  goto error;
>    342          string = (char *)nla_data(tb[SMC_PNETID_NAME]);
>    343          if (!smc_pnetid_valid(string, pnetelem->pnet_name))
>    344                  goto error;
>    345  
>    346          rc = -EINVAL;
>    347          if (tb[SMC_PNETID_ETHNAME]) {
>    348                  string = (char *)nla_data(tb[SMC_PNETID_ETHNAME]);
>    349                  pnetelem->ndev = dev_get_by_name(net, string);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> dev_hold().
> 
>    350                  if (!pnetelem->ndev)
>    351                          goto error;
>    352          }
>    353  
>    354          /* if this is not the initial namespace, stop here */
>    355          if (net != &init_net)
>    356                  return 0;
>    357  
>    358          rc = -EINVAL;
>    359          if (tb[SMC_PNETID_IBNAME]) {
>    360                  ibname = (char *)nla_data(tb[SMC_PNETID_IBNAME]);
>    361                  ibname = strim(ibname);
>    362                  pnetelem->smcibdev = smc_pnet_find_ib(ibname);
>    363                  pnetelem->smcd_dev = smc_pnet_find_smcd(ibname);
>    364                  if (!pnetelem->smcibdev && !pnetelem->smcd_dev)
>    365                          goto error;
>                                 ^^^^^^^^^^
> Smatch thinks these require dev_put()
> 
>    366                  if (pnetelem->smcibdev) {
>    367                          if (!tb[SMC_PNETID_IBPORT])
>    368                                  goto error;
>    369                          pnetelem->ib_port = nla_get_u8(tb[SMC_PNETID_IBPORT]);
>    370                          if (pnetelem->ib_port < 1 ||
>    371                              pnetelem->ib_port > SMC_MAX_PORTS)
>    372                                  goto error;
>                                         ^^^^^^^^^^
>    373                  }
>    374          }
>    375  
>    376          return 0;
>    377  
>    378  error:
> 
> So maybe this should be:
> 
> 	if (pnetelem->ndev && tb[SMC_PNETID_ETHNAME])
> 		dev_put(pnetelem->ndev);
> 
>    379          return rc;
>    380  }
> 
> regards,
> dan carpenter
