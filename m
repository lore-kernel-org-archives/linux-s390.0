Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbgDWJjx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 05:39:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03N9XZRR099122
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:39:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30k09wd9sb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 05:39:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Thu, 23 Apr 2020 10:39:01 +0100
Subject: Re: [PATCH rdma-next] RDMA: Allow ib_client's to fail when add() is
 called
References: <20200421172440.387069-1-leon@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 23 Apr 2020 11:39:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200421172440.387069-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8ee742d7-952b-b521-d05c-17de601f6e32@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Leon Romanovsky <leon@kernel.org>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Bart Van Assche <bvanassche@acm.org>, "David S. Miller" <davem@davemloft.net>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Jakub Kicinski <kuba@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>, rds-devel@oss.oracle.com, Santosh Shilimkar <santosh.shilimkar@oracle.com>, target-devel@vger.kernel.org



On 4/21/20 7:24 PM, Leon Romanovsky wrote:
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
> 

For the net/smc part:
Acked-by: Ursula Braun <ubraun@linux.ibm.com>
