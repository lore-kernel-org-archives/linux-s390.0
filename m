Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbfFSISW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Jun 2019 04:18:22 -0400
Date: Wed, 19 Jun 2019 10:18:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 3/5] vfio-ccw: Copy CCW data outside length
 calculation
Message-ID: <20190619101818.77521a63.cohuck@redhat.com>
In-Reply-To: <20190618202352.39702-4-farman@linux.ibm.com>
References: <20190618202352.39702-1-farman@linux.ibm.com>
        <20190618202352.39702-4-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 18 Jun 2019 22:23:50 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> It doesn't make much sense to "hide" the copy to the channel_program
> struct inside a routine that calculates the length of the chain.
> 
> Let's move it to the calling routine, which will later copy from
> channel_program to the memory it allocated itself.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
