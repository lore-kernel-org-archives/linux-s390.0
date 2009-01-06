From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 02:08:30 +0000
Subject: Re: [patch 3/4] af_iucv: Free iucv path/socket in path_pending
Message-Id: <20090105.180830.181218184.davem@davemloft.net>
In-Reply-To: <20090105121933.090613000@linux.vnet.ibm.com>
References: <20090105121933.090613000@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>
Date: Mon, 05 Jan 2009 13:14:25 +0100

> Free iucv path after iucv_path_sever() calls in iucv_callback_connreq()
> (path_pending() iucv callback).
> If iucv_path_accept() fails, free path and free/kill newly created socket.
> 
> Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>

Applied.
