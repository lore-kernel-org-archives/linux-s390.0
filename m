Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 04 Aug 2018 13:10:31 -0700 (PDT)
Message-Id: <20180804.131031.531712040899086911.davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: no cursor update send in state
 SMC_INIT
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180803083833.51029-1-ubraun@linux.ibm.com>
References: <20180803083833.51029-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Fri,  3 Aug 2018 10:38:33 +0200

> If a writer blocked condition is received without data, the current
> consumer cursor is immediately sent. Servers could already receive this
> condition in state SMC_INIT without finished tx-setup. This patch
> avoids sending a consumer cursor update in this case.
> 
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied, thank you.
