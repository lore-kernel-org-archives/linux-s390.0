From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 02:07:54 +0000
Subject: Re: [patch 2/4] afiucv: avoid left over IUCV connections from
Message-Id: <20090105.180754.45322040.davem@davemloft.net>
In-Reply-To: <20090105121932.187423000@linux.vnet.ibm.com>
References: <20090105121932.187423000@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>
Date: Mon, 05 Jan 2009 13:14:24 +0100

> For certain types of AFIUCV socket connect failures IUCV connections
> are left over. Add some cleanup-statements to avoid cluttered IUCV
> connections.
> 
> Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>

Applied.
