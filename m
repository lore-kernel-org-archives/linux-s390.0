Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfFNJmG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Jun 2019 05:42:06 -0400
Date: Fri, 14 Jun 2019 11:42:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 8/9] vfio-ccw: Rearrange IDAL allocation in direct
 CCW
Message-ID: <20190614114202.1ddb6264.cohuck@redhat.com>
In-Reply-To: <20190606202831.44135-9-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
        <20190606202831.44135-9-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Jun 2019 22:28:30 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> This is purely deck furniture, to help understand the merge of the
> direct and indirect handlers.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
