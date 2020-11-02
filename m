Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgKBWM7 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Nov 2020 17:12:59 -0500
Date: Mon, 2 Nov 2020 14:12:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 10/15] net/smc: Introduce SMCR get link command
Message-ID: <20201102141258.68ffad28@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201102193409.70901-11-kgraul@linux.ibm.com>
References: <20201102193409.70901-1-kgraul@linux.ibm.com>
        <20201102193409.70901-11-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

On Mon,  2 Nov 2020 20:34:04 +0100 Karsten Graul wrote:
> +	__u8 netdev[IFNAMSIZ];		/* ethernet device name */

In file included from <command-line>:32:
./usr/include/linux/smc_diag.h:135:14: error: =E2=80=98IFNAMSIZ=E2=80=99 un=
declared here (not in a function)
  135 |  __u8 netdev[IFNAMSIZ];  /* ethernet device name */
      |              ^~~~~~~~
make[3]: *** [usr/include/linux/smc_diag.hdrtest] Error 1
make[2]: *** [usr/include] Error 2
make[1]: *** [usr] Error 2
make[1]: *** Waiting for unfinished jobs....
make[1]: *** wait: No child processes.  Stop.
make: *** [__sub-make] Error 2
In file included from <command-line>:32:
./usr/include/linux/smc_diag.h:135:14: error: =E2=80=98IFNAMSIZ=E2=80=99 un=
declared here (not in a function)
  135 |  __u8 netdev[IFNAMSIZ];  /* ethernet device name */
      |              ^~~~~~~~
