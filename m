Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 20 Sep 2018 12:12:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH net 2/5] net/smc: remove duplicate mutex_unlock
Message-ID: <20180920091243.xgansymg6a4dfixg@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918134638.90271-3-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kbuild@01.org, Ursula Braun <ubraun@linux.ibm.com>
Cc: kbuild-all@01.org, davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Ursula,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net/master]

url:    https://github.com/0day-ci/linux/commits/Ursula-Braun/net-smc-fixes-2018-09-18/20180919-080857

smatch warnings:
net/smc/af_smc.c:1289 smc_listen_work() warn: inconsistent returns 'mutex:&smc_create_lgr_pending'.
  Locked on:   line 1285
  Unlocked on: line 1209

# https://github.com/0day-ci/linux/commit/c69342ef9becfe90f3778db1c386abdd80b786d1
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout c69342ef9becfe90f3778db1c386abdd80b786d1
vim +1289 net/smc/af_smc.c

3b2dec260 Hans Wippel   2018-05-18  1231  	/* IPSec connections opt out of SMC-R optimizations */
3b2dec260 Hans Wippel   2018-05-18  1232  	if (using_ipsec(new_smc)) {
3b2dec260 Hans Wippel   2018-05-18  1233  		smc_listen_decline(new_smc, SMC_CLC_DECL_IPSEC, 0);
3b2dec260 Hans Wippel   2018-05-18  1234  		return;
3b2dec260 Hans Wippel   2018-05-18  1235  	}
3b2dec260 Hans Wippel   2018-05-18  1236  
3b2dec260 Hans Wippel   2018-05-18  1237  	mutex_lock(&smc_create_lgr_pending);
3b2dec260 Hans Wippel   2018-05-18  1238  	smc_close_init(new_smc);
3b2dec260 Hans Wippel   2018-05-18  1239  	smc_rx_init(new_smc);
3b2dec260 Hans Wippel   2018-05-18  1240  	smc_tx_init(new_smc);
3b2dec260 Hans Wippel   2018-05-18  1241  
413498440 Hans Wippel   2018-06-28  1242  	/* check if ISM is available */
413498440 Hans Wippel   2018-06-28  1243  	if ((pclc->hdr.path == SMC_TYPE_D || pclc->hdr.path == SMC_TYPE_B) &&
413498440 Hans Wippel   2018-06-28  1244  	    !smc_check_ism(new_smc, &ismdev) &&
413498440 Hans Wippel   2018-06-28  1245  	    !smc_listen_ism_init(new_smc, pclc, ismdev, &local_contact)) {
413498440 Hans Wippel   2018-06-28  1246  		ism_supported = true;
413498440 Hans Wippel   2018-06-28  1247  	}
413498440 Hans Wippel   2018-06-28  1248  
3b2dec260 Hans Wippel   2018-05-18  1249  	/* check if RDMA is available */
413498440 Hans Wippel   2018-06-28  1250  	if (!ism_supported &&
413498440 Hans Wippel   2018-06-28  1251  	    ((pclc->hdr.path != SMC_TYPE_R && pclc->hdr.path != SMC_TYPE_B) ||
7005ada68 Ursula Braun  2018-07-25  1252  	     smc_vlan_by_tcpsk(new_smc->clcsock, &vlan) ||
7005ada68 Ursula Braun  2018-07-25  1253  	     smc_check_rdma(new_smc, &ibdev, &ibport, vlan, NULL) ||
3b2dec260 Hans Wippel   2018-05-18  1254  	     smc_listen_rdma_check(new_smc, pclc) ||
3b2dec260 Hans Wippel   2018-05-18  1255  	     smc_listen_rdma_init(new_smc, pclc, ibdev, ibport,
3b2dec260 Hans Wippel   2018-05-18  1256  				  &local_contact) ||
413498440 Hans Wippel   2018-06-28  1257  	     smc_listen_rdma_reg(new_smc, local_contact))) {
3b2dec260 Hans Wippel   2018-05-18  1258  		/* SMC not supported, decline */
145686baa Ursula Braun  2017-10-25  1259  		mutex_unlock(&smc_create_lgr_pending);
603cc1498 Karsten Graul 2018-07-25  1260  		smc_listen_decline(new_smc, SMC_CLC_DECL_MODEUNSUPP,
603cc1498 Karsten Graul 2018-07-25  1261  				   local_contact);
3b2dec260 Hans Wippel   2018-05-18  1262  		return;
a046d57da Ursula Braun  2017-01-09  1263  	}
a046d57da Ursula Braun  2017-01-09  1264  
3b2dec260 Hans Wippel   2018-05-18  1265  	/* send SMC Accept CLC message */
3b2dec260 Hans Wippel   2018-05-18  1266  	rc = smc_clc_send_accept(new_smc, local_contact);
3b2dec260 Hans Wippel   2018-05-18  1267  	if (rc) {
145686baa Ursula Braun  2017-10-25  1268  		mutex_unlock(&smc_create_lgr_pending);
3b2dec260 Hans Wippel   2018-05-18  1269  		smc_listen_decline(new_smc, rc, local_contact);
3b2dec260 Hans Wippel   2018-05-18  1270  		return;
3b2dec260 Hans Wippel   2018-05-18  1271  	}
3b2dec260 Hans Wippel   2018-05-18  1272  
3b2dec260 Hans Wippel   2018-05-18  1273  	/* receive SMC Confirm CLC message */
3b2dec260 Hans Wippel   2018-05-18  1274  	reason_code = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
3b2dec260 Hans Wippel   2018-05-18  1275  				       SMC_CLC_CONFIRM);
3b2dec260 Hans Wippel   2018-05-18  1276  	if (reason_code) {
3b2dec260 Hans Wippel   2018-05-18  1277  		mutex_unlock(&smc_create_lgr_pending);
3b2dec260 Hans Wippel   2018-05-18  1278  		smc_listen_decline(new_smc, reason_code, local_contact);
3b2dec260 Hans Wippel   2018-05-18  1279  		return;
3b2dec260 Hans Wippel   2018-05-18  1280  	}
3b2dec260 Hans Wippel   2018-05-18  1281  
3b2dec260 Hans Wippel   2018-05-18  1282  	/* finish worker */
c69342ef9 Ursula Braun  2018-09-18  1283  	if (!ism_supported) {
c69342ef9 Ursula Braun  2018-09-18  1284  		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact))
c69342ef9 Ursula Braun  2018-09-18  1285  			return;
                                                                ^^^^^^
We need to mutex_unlock(&smc_create_lgr_pending); before the return.

c69342ef9 Ursula Braun  2018-09-18  1286  	}
3b2dec260 Hans Wippel   2018-05-18  1287  	smc_conn_save_peer_info(new_smc, &cclc);
3b2dec260 Hans Wippel   2018-05-18  1288  	mutex_unlock(&smc_create_lgr_pending);
3b2dec260 Hans Wippel   2018-05-18 @1289  	smc_listen_out_connected(new_smc);
a046d57da Ursula Braun  2017-01-09  1290  }
a046d57da Ursula Braun  2017-01-09  1291  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
