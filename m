Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 26 May 2010 21:10:08 -0700 (PDT)
Message-Id: <20100526.211008.116373263.davem@davemloft.net>
Subject: Re: [PATCH 9/17] net/iucv: Add missing spin_unlock
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.1005261756330.23743@ask.diku.dk>
References: <Pine.LNX.4.64.1005261756330.23743@ask.diku.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: julia@diku.dk
Cc: ursula.braun@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <julia@diku.dk>
Date: Wed, 26 May 2010 17:56:48 +0200 (CEST)

> Add a spin_unlock missing on the error path.  There seems like no reason
> why the lock should continue to be held if the kzalloc fail.

Applied, thanks.
