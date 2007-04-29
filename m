From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/3] [AF_IUCV/IUCV]: Implementation of a skb backlog
 queue
Date: Sat, 28 Apr 2007 23:06:26 -0700 (PDT)
Message-ID: <20070428.230626.79066898.davem@davemloft.net>
References: <20070419091214.GD14586@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070419091214.GD14586@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: fpavlic@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Frank Pavlic <fpavlic@de.ibm.com>
Date: Thu, 19 Apr 2007 11:12:14 +0200

> From: Jennifer Hunt <jenhunt@us.ibm.com>
> 
> With the inital implementation we missed to implement a skb backlog
> queue . The result is that socket receive processing tossed packets.
> Since AF_IUCV connections are working synchronously it leads to 
> connection hangs. Problems with read, close and select also
> occured. 
> Using a skb backlog queue is fixing all of these problems .
> 
> Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

This won't apply cleanly because of all the sk_buff packet
buffer interface API changes in the current GIT tree.

Can you fix this up and also get a Signoff from Jennifer Hunt?

Thanks a lot!
