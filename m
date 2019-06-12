Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389772AbfFLLSK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 07:18:10 -0400
Date: Wed, 12 Jun 2019 13:18:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 3/9] s390/cio: Generalize the TIC handler
Message-ID: <20190612131805.7b907956.cohuck@redhat.com>
In-Reply-To: <20190606202831.44135-4-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
        <20190606202831.44135-4-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Jun 2019 22:28:25 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Refactor ccwchain_handle_tic() into a routine that handles a channel
> program address (which itself is a CCW pointer), rather than a CCW pointer
> that is only a TIC CCW.  This will make it easier to reuse this code for
> other CCW commands.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
