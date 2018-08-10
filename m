Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 10 Aug 2018 14:39:13 -0700 (PDT)
Message-Id: <20180810.143913.742123900688849323.davem@davemloft.net>
Subject: Re: [PATCH net-next 1/1] net/smc: send response to test link signal
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180810154511.71106-1-ubraun@linux.ibm.com>
References: <20180810154511.71106-1-ubraun@linux.ibm.com>
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
Date: Fri, 10 Aug 2018 17:45:11 +0200

> With SMC-D z/OS sends a test link signal every 10 seconds. Linux is
> supposed to answer, otherwise the SMC-D connection breaks.
> 
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied.
