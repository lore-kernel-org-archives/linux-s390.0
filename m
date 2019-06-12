Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfFLLSy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 07:18:54 -0400
Date: Wed, 12 Jun 2019 13:18:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 4/9] s390/cio: Use generalized CCW handler in
 cp_init()
Message-ID: <20190612131850.4a7efc04.cohuck@redhat.com>
In-Reply-To: <20190606202831.44135-5-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
        <20190606202831.44135-5-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Jun 2019 22:28:26 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> It is now pretty apparent that ccwchain_handle_ccw()
> (nee ccwchain_handle_tic()) does everything that cp_init()
> wants to do.
> 
> Let's remove that duplicated code from cp_init() and let
> ccwchain_handle_ccw() handle it itself.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)

Nice cleanup :)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
