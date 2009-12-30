Return-Path: <linux-kernel-owner+w=401wt.eu-S1753156AbZL3RQq@vger.kernel.org>
Date: Wed, 30 Dec 2009 09:16:43 -0800 (PST)
Message-Id: <20091230.091643.246513654.davem@davemloft.net>
Subject: Re: [PATCH] drivers/s390/net/qeth_l2_main.c: use %pM to shown MAC
 address
From: David Miller <davem@davemloft.net>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200F4CF@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F4CF@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: hartleys@visionengravers.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, blaschka@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Date: Mon, 28 Dec 2009 18:39:26 -0500

> Use the %pM kernel extension to display the MAC address.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Applied.
