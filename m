Return-Path: <SRS0=TiMe=QP=vger.kernel.org=netdev-owner@kernel.org>
Date: Thu, 07 Feb 2019 18:06:33 -0800 (PST)
Message-Id: <20190207.180633.732104508255121374.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/7] net/smc: patches 2019-02-07
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190207145620.92811-1-ubraun@linux.ibm.com>
References: <20190207145620.92811-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu,  7 Feb 2019 15:56:13 +0100

> here are patches for SMC:
> * patches 1, 3, and 6 are cleanups without functional change
> * patch 2 postpones closing of internal clcsock
> * patches 4 and 5 improve link group creation locking
> * patch 7 restores AF_SMC as diag_family field

Series applied, thank you.
