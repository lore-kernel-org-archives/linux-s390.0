Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgEFQFz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 12:05:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D8DC0610D5
        for <linux-s390@vger.kernel.org>; Wed,  6 May 2020 09:05:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so2489422qke.7
        for <linux-s390@vger.kernel.org>; Wed, 06 May 2020 09:05:54 -0700 (PDT)
Date: Wed, 6 May 2020 13:05:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-next] RDMA: Allow ib_client's to fail when add() is
 called
Message-ID: <20200506160552.GA9993@ziepe.ca>
References: <20200421172440.387069-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421172440.387069-1-leon@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>, Bart Van Assche <bvanassche@acm.org>, "David S. Miller" <davem@davemloft.net>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Jakub Kicinski <kuba@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>, rds-devel@oss.oracle.com, Santosh Shilimkar <santosh.shilimkar@oracle.com>, target-devel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>

On Tue, Apr 21, 2020 at 08:24:40PM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> When a client is added it isn't allowed to fail, but all the client's have
> various failure paths within their add routines.
> 
> This creates the very fringe condition where the client was added, failed
> during add and didn't set the client_data. The core code will then still
> call other client_data centric ops like remove(), rename(), get_nl_info(),
> and get_net_dev_by_params() with NULL client_data - which is confusing and
> unexpected.
> 
> If the add() callback fails, then do not call any more client ops for the
> device, even remove.
> 
> Remove all the now redundant checks for NULL client_data in ops callbacks.
> 
> Update all the add() callbacks to return error codes
> appropriately. EOPNOTSUPP is used for cases where the ULP does not support
> the ib_device - eg because it only works with IB.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> Acked-by: Ursula Braun <ubraun@linux.ibm.com>
> ---
>  drivers/infiniband/core/cm.c                  | 24 ++++++++++--------
>  drivers/infiniband/core/cma.c                 | 23 +++++++++--------
>  drivers/infiniband/core/device.c              | 16 ++++++++++--
>  drivers/infiniband/core/mad.c                 | 17 ++++++++++---
>  drivers/infiniband/core/multicast.c           | 12 ++++-----
>  drivers/infiniband/core/sa_query.c            | 22 ++++++++--------
>  drivers/infiniband/core/user_mad.c            | 22 ++++++++--------
>  drivers/infiniband/core/uverbs_main.c         | 24 +++++++++---------
>  drivers/infiniband/ulp/ipoib/ipoib_main.c     | 15 ++++-------
>  .../infiniband/ulp/opa_vnic/opa_vnic_vema.c   | 12 ++++-----
>  drivers/infiniband/ulp/srp/ib_srp.c           | 21 ++++++++--------
>  drivers/infiniband/ulp/srpt/ib_srpt.c         | 25 ++++++++-----------
>  include/rdma/ib_verbs.h                       |  2 +-
>  net/rds/ib.c                                  | 21 ++++++++++------
>  net/smc/smc_ib.c                              | 10 +++-----
>  15 files changed, 142 insertions(+), 124 deletions(-)

Applied to for-next

Jason
