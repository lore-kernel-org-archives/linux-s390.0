Return-Path: <linux-kernel-owner+w=401wt.eu-S1755393AbYGOJKW@vger.kernel.org>
Date: Tue, 15 Jul 2008 02:10:04 -0700 (PDT)
Message-Id: <20080715.021004.33973618.davem@davemloft.net>
Subject: Re: [PATCH] iucv: fix memory leak in cpu hotplug error path.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080715081025.GB22068@localhost.localdomain>
References: <20080715081025.GB22068@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akinobu.mita@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ubraun@linux.vnet.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 15 Jul 2008 17:10:25 +0900

> Fix memory leak in error path in CPU_UP_PREPARE notifier.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Applied, thank you.
