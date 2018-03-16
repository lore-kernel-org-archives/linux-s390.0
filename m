Return-Path: <netdev-owner@vger.kernel.org>
Date: Fri, 16 Mar 2018 11:44:32 -0400 (EDT)
Message-Id: <20180316.114432.218859017379740021.davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/iucv: Free memory obtained by kzalloc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180313155006.88162-2-jwi@linux.vnet.ibm.com>
References: <20180313155006.88162-1-jwi@linux.vnet.ibm.com>
        <20180313155006.88162-2-jwi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 16:50:06 +0100

> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Free memory by calling put_device(), if afiucv_iucv_init is not
> successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
> Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>

Applied, thank you.
