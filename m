From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Date: Thu, 13 Jun 2013 14:10:31 +0000
Subject: Re: [PATCH] zfcp: Fix spinlock imbalance in zfcp_qdio_sbal_get
Message-Id: <1371132631.12134.34.camel@br9vgx5g.de.ibm.com>
In-Reply-To: <1371131228.12134.19.camel@br9vgx5g.de.ibm.com>
References: <1371131228.12134.19.camel@br9vgx5g.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2013-06-12 at 21:25 -0400, Mikulas Patocka wrote:
> Hi
> 
> It looks ok. There is a difference - before this patch, 
> zfcp_erp_adapter_reopen was called without req_q_lock. With this patch, it 
> is called with the lock held.
> 
> Can it cause any problems? (deadlock, sleep with spinlock or lock 
> inversion?) I didn't find a case where it could, but I am not familiar 
> with all the code in this driver.

Ah, I forgot:
I don't see any risk as to lock inversion (erp_lock first, req_q_lock
second won't work).

The erp_lock is only used by a list of functions in zfp_erp.c. The
reopen/shutdown functions might be called from almost anywhere. They
take erp_lock; they do not issue requests and therewith do not use
req_q_lock. The other code paths in zfcp_erp.c might issue requests;
they are users of req_q_lock. But they do so without the erp_lock held,
in order to allow waiting for completion or other blocking operations
(see zfcp_erp_strategy).

Martin
