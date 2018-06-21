From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH net 1/1] net/smc: coordinate wait queues for nonblocking
 connect
Date: Fri, 22 Jun 2018 00:26:51 +0800
Message-ID: <201806220025.hvV6K991%fengguang.wu@intel.com>
References: <20180620080737.50323-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620080737.50323-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
Cc: kbuild-all@01.org, davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com, xiyou.wangcong@gmail.com, hch@lst.de
List-ID: <linux-s390.vger.kernel.org>

Hi Ursula,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net/master]

url:    https://github.com/0day-ci/linux/commits/Ursula-Braun/net-smc-coordinate-wait-queues-for-nonblocking-connect/20180620-180901
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/smc/af_smc.c:1301:49: sparse: incorrect type in assignment (different address spaces) @@    expected struct socket_wq [noderef] <asn:4>*sk_wq @@    got [noderef] <asn:4>*sk_wq @@
   net/smc/af_smc.c:1301:49:    expected struct socket_wq [noderef] <asn:4>*sk_wq
   net/smc/af_smc.c:1301:49:    got struct socket_wq *smcwq
   net/smc/smc_cdc.h:143:24: sparse: expression using sizeof(void)
   net/smc/smc_cdc.h:146:16: sparse: expression using sizeof(void)
   net/smc/smc_cdc.h:143:24: sparse: expression using sizeof(void)
   net/smc/smc_cdc.h:146:16: sparse: expression using sizeof(void)
>> net/smc/af_smc.c:1667:20: sparse: incorrect type in assignment (different address spaces) @@    expected struct socket_wq *smcwq @@    got struct socket_wq struct socket_wq *smcwq @@
   net/smc/af_smc.c:1667:20:    expected struct socket_wq *smcwq
   net/smc/af_smc.c:1667:20:    got struct socket_wq [noderef] <asn:4>*sk_wq
   net/smc/af_smc.c:1668:29: sparse: expression using sizeof(void)
   net/smc/af_smc.c:1669:29: sparse: expression using sizeof(void)

vim +1301 net/smc/af_smc.c

  1277	
  1278	static __poll_t smc_poll_mask(struct socket *sock, __poll_t events)
  1279	{
  1280		struct sock *sk = sock->sk;
  1281		__poll_t mask = 0;
  1282		struct smc_sock *smc;
  1283		int rc;
  1284	
  1285		if (!sk)
  1286			return EPOLLNVAL;
  1287	
  1288		smc = smc_sk(sock->sk);
  1289		sock_hold(sk);
  1290		if ((sk->sk_state == SMC_INIT) || smc->use_fallback) {
  1291			/* delegate to CLC child sock */
  1292			mask = smc->clcsock->ops->poll_mask(smc->clcsock, events);
  1293			sk->sk_err = smc->clcsock->sk->sk_err;
  1294			if (sk->sk_err) {
  1295				mask |= EPOLLERR;
  1296			} else {
  1297				/* if non-blocking connect finished ... */
  1298				if (sk->sk_state == SMC_INIT &&
  1299				    mask & EPOLLOUT &&
  1300				    smc->clcsock->sk->sk_state != TCP_CLOSE) {
> 1301					sock->sk->sk_wq = smc->smcwq;
  1302					lock_sock(sk);
  1303					rc = __smc_connect(smc);
  1304					release_sock(sk);
  1305					if (rc < 0)
  1306						mask |= EPOLLERR;
  1307					/* success cases including fallback */
  1308					mask |= EPOLLOUT | EPOLLWRNORM;
  1309				}
  1310			}
  1311		} else {
  1312			if (sk->sk_err)
  1313				mask |= EPOLLERR;
  1314			if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
  1315			    (sk->sk_state == SMC_CLOSED))
  1316				mask |= EPOLLHUP;
  1317			if (sk->sk_state == SMC_LISTEN) {
  1318				/* woken up by sk_data_ready in smc_listen_work() */
  1319				mask = smc_accept_poll(sk);
  1320			} else {
  1321				if (atomic_read(&smc->conn.sndbuf_space) ||
  1322				    sk->sk_shutdown & SEND_SHUTDOWN) {
  1323					mask |= EPOLLOUT | EPOLLWRNORM;
  1324				} else {
  1325					sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
  1326					set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
  1327				}
  1328				if (atomic_read(&smc->conn.bytes_to_rcv))
  1329					mask |= EPOLLIN | EPOLLRDNORM;
  1330				if (sk->sk_shutdown & RCV_SHUTDOWN)
  1331					mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
  1332				if (sk->sk_state == SMC_APPCLOSEWAIT1)
  1333					mask |= EPOLLIN;
  1334			}
  1335			if (smc->conn.urg_state == SMC_URG_VALID)
  1336				mask |= EPOLLPRI;
  1337	
  1338		}
  1339		sock_put(sk);
  1340	
  1341		return mask;
  1342	}
  1343	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
