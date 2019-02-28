Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
Date: Thu, 28 Feb 2019 12:50:07 -0800 (PST)
Message-Id: <20190228.125007.2284433882358224023.davem@davemloft.net>
Subject: Re: [PATCH net-next 1/1] net/smc: allow pnetid-less configuration
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190228141008.16458-1-ubraun@linux.ibm.com>
References: <20190228141008.16458-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 28 Feb 2019 15:10:08 +0100

> Without hardware pnetid support there must currently be a pnet
> table configured to determine the IB device port to be used for SMC
> RDMA traffic. This patch enables a setup without pnet table, if
> the used handshake interface belongs already to a RoCE port.
> 
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied, thanks.
