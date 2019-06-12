Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfFLLRd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 07:17:33 -0400
Date: Wed, 12 Jun 2019 13:17:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/9] s390/cio: Refactor the routine that handles TIC
 CCWs
Message-ID: <20190612131729.1264bd15.cohuck@redhat.com>
In-Reply-To: <20190606202831.44135-3-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
        <20190606202831.44135-3-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Jun 2019 22:28:24 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Extract the "does the target of this TIC already exist?" check from
> ccwchain_handle_tic(), so that it's easier to refactor that function
> into one that cp_init() is able to use.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
