Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfGLL0Z (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 07:26:25 -0400
Date: Fri, 12 Jul 2019 13:26:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 2/5] vfio-ccw: Fix memory leak and don't call cp_free
 in cp_init
Message-ID: <20190712132622.750cf61f.cohuck@redhat.com>
In-Reply-To: <3173c4216f4555d9765eb6e4922534982bc820e4.1562854091.git.alifm@linux.ibm.com>
References: <cover.1562854091.git.alifm@linux.ibm.com>
        <3173c4216f4555d9765eb6e4922534982bc820e4.1562854091.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu, 11 Jul 2019 10:28:52 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> We don't set cp->initialized to true so calling cp_free
> will just return and not do anything.
> 
> Also fix a memory leak where we fail to free a ccwchain
> on an error.
> 
> Fixes: 812271b910 ("s390/cio: Squash cp_free() and cp_unpin_free()")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
