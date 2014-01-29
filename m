From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] qeth: fix build of s390 allmodconfig
Date: Wed, 29 Jan 2014 00:43:43 -0800 (PST)
Message-ID: <20140129.004343.2290446170547264253.davem@davemloft.net>
References: <20140129082348.GA34455@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20140129082348.GA34455@tuxmaker.boeblingen.de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: blaschka@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Date: Wed, 29 Jan 2014 09:23:48 +0100

> From: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
> 
> commit 949efd1c "qeth: bridgeport support - basic control" broke
> s390 allmodconfig. This patch fixes this by eliminating one of the
> cross-module calls, and by making two other calls via function
> pointers in the qeth_discipline structure.
> 
> Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks.
