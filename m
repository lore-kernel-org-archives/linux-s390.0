Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729217AbgJ1WDx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:53 -0400
Subject: Re: [bug report] net/smc: CLC accept / confirm V2
References: <20201028112539.GA1155565@mwanda>
From: Ursula Braun <ubraun@linux.ibm.com>
Message-ID: <6d16cfab-b512-3f57-cb91-26c762b3db0b@linux.ibm.com>
Date: Wed, 28 Oct 2020 14:23:07 +0100
MIME-Version: 1.0
In-Reply-To: <20201028112539.GA1155565@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>



On 10/28/20 12:25 PM, Dan Carpenter wrote:
> Hello Ursula Braun,
> 
> The patch a7c9c5f4af7f: "net/smc: CLC accept / confirm V2" from Sep
> 26, 2020, leads to the following static checker warning:
> 
> 	net/smc/af_smc.c:1771 smc_listen_work()
> 	error: we previously assumed 'ini' could be null (see line 1715)
> 

Thanks for reporting this problem!
Karsten Graul provided already this fix on 10/23/20 (accepted by
Jakub Kicinski 10/27/20) for the net-tree:

   net/smc: fix null pointer dereference in smc_listen_decline()

   smc_listen_work() calls smc_listen_decline() on label out_decl,
   providing the ini pointer variable. But this pointer can still be null
   when the label out_decl is reached.
   Fix this by checking the ini variable in smc_listen_work() and call
   smc_listen_decline() with the result directly.

   Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
   Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

This fix is supposed to solve your reported problem.

Regards, Ursula Braun

> net/smc/af_smc.c
>   1665  static void smc_listen_work(struct work_struct *work)
>   1666  {
>   1667          struct smc_sock *new_smc = container_of(work, struct smc_sock,
>   1668                                                  smc_listen_work);
>   1669          u8 version = smc_ism_v2_capable ? SMC_V2 : SMC_V1;
>   1670          struct socket *newclcsock = new_smc->clcsock;
>   1671          struct smc_clc_msg_accept_confirm *cclc;
>   1672          struct smc_clc_msg_proposal_area *buf;
>   1673          struct smc_clc_msg_proposal *pclc;
>   1674          struct smc_init_info *ini = NULL;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>   1675          int rc = 0;
>   1676  
>   1677          if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
>   1678                  return smc_listen_out_err(new_smc);
>   1679  
>   1680          if (new_smc->use_fallback) {
>   1681                  smc_listen_out_connected(new_smc);
>   1682                  return;
>   1683          }
>   1684  
>   1685          /* check if peer is smc capable */
>   1686          if (!tcp_sk(newclcsock->sk)->syn_smc) {
>   1687                  smc_switch_to_fallback(new_smc);
>   1688                  new_smc->fallback_rsn = SMC_CLC_DECL_PEERNOSMC;
>   1689                  smc_listen_out_connected(new_smc);
>   1690                  return;
>   1691          }
>   1692  
>   1693          /* do inband token exchange -
>   1694           * wait for and receive SMC Proposal CLC message
>   1695           */
>   1696          buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>   1697          if (!buf) {
>   1698                  rc = SMC_CLC_DECL_MEM;
>   1699                  goto out_decl;
>                         ^^^^^^^^^^^^^^
> There are several paths where "ini" is NULL leading to an Oops in the
> error handling.
> 
>   1700          }
>   1701          pclc = (struct smc_clc_msg_proposal *)buf;
>   1702          rc = smc_clc_wait_msg(new_smc, pclc, sizeof(*buf),
>   1703                                SMC_CLC_PROPOSAL, CLC_WAIT_TIME);
>   1704          if (rc)
>   1705                  goto out_decl;
>                         ^^^^^^^^^^^^^
> 
>   1706          version = pclc->hdr.version == SMC_V1 ? SMC_V1 : version;
>   1707  
>   1708          /* IPSec connections opt out of SMC optimizations */
>   1709          if (using_ipsec(new_smc)) {
>   1710                  rc = SMC_CLC_DECL_IPSEC;
>   1711                  goto out_decl;
>                         ^^^^^^^^^^^^^
> 
>   1712          }
>   1713  
>   1714          ini = kzalloc(sizeof(*ini), GFP_KERNEL);
>   1715          if (!ini) {
>   1716                  rc = SMC_CLC_DECL_MEM;
>   1717                  goto out_decl;
>                         ^^^^^^^^^^^^^
> 
>   1718          }
>   1719  
>   1720          /* initial version checking */
>   1721          rc = smc_listen_v2_check(new_smc, pclc, ini);
>   1722          if (rc)
>   1723                  goto out_decl;
>   1724  
>   1725          mutex_lock(&smc_server_lgr_pending);
>   1726          smc_close_init(new_smc);
>   1727          smc_rx_init(new_smc);
>   1728          smc_tx_init(new_smc);
>   1729  
>   1730          /* determine ISM or RoCE device used for connection */
>   1731          rc = smc_listen_find_device(new_smc, pclc, ini);
>   1732          if (rc)
>   1733                  goto out_unlock;
>   1734  
>   1735          /* send SMC Accept CLC message */
>   1736          rc = smc_clc_send_accept(new_smc, ini->first_contact_local,
>   1737                                   ini->smcd_version == SMC_V2 ? SMC_V2 : SMC_V1);
>   1738          if (rc)
>   1739                  goto out_unlock;
>   1740  
>   1741          /* SMC-D does not need this lock any more */
>   1742          if (ini->is_smcd)
>   1743                  mutex_unlock(&smc_server_lgr_pending);
>   1744  
>   1745          /* receive SMC Confirm CLC message */
>   1746          memset(buf, 0, sizeof(*buf));
>   1747          cclc = (struct smc_clc_msg_accept_confirm *)buf;
>   1748          rc = smc_clc_wait_msg(new_smc, cclc, sizeof(*buf),
>   1749                                SMC_CLC_CONFIRM, CLC_WAIT_TIME);
>   1750          if (rc) {
>   1751                  if (!ini->is_smcd)
>   1752                          goto out_unlock;
>   1753                  goto out_decl;
>   1754          }
>   1755  
>   1756          /* finish worker */
>   1757          if (!ini->is_smcd) {
>   1758                  rc = smc_listen_rdma_finish(new_smc, cclc,
>   1759                                              ini->first_contact_local);
>   1760                  if (rc)
>   1761                          goto out_unlock;
>   1762                  mutex_unlock(&smc_server_lgr_pending);
>   1763          }
>   1764          smc_conn_save_peer_info(new_smc, cclc);
>   1765          smc_listen_out_connected(new_smc);
>   1766          goto out_free;
>   1767  
>   1768  out_unlock:
>   1769          mutex_unlock(&smc_server_lgr_pending);
>   1770  out_decl:
>   1771          smc_listen_decline(new_smc, rc, ini, version);
>                                                 ^^^
> If "ini" is NULL then this will Oops.
> 
>   1772  out_free:
>   1773          kfree(ini);
>   1774          kfree(buf);
>   1775  }
> 
> regards,
> dan carpenter
> 
