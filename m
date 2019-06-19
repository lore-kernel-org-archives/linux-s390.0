Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfFSIXH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Jun 2019 04:23:07 -0400
Date: Wed, 19 Jun 2019 10:23:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 5/5] vfio-ccw: Remove copy_ccw_from_iova()
Message-ID: <20190619102304.63848eea.cohuck@redhat.com>
In-Reply-To: <20190618202352.39702-6-farman@linux.ibm.com>
References: <20190618202352.39702-1-farman@linux.ibm.com>
        <20190618202352.39702-6-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 18 Jun 2019 22:23:52 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Just to keep things tidy.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
