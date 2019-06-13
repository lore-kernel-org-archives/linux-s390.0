Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731392AbfFMQDI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 12:03:08 -0400
Date: Thu, 13 Jun 2019 18:03:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 7/9] vfio-ccw: Remove pfn_array_table
Message-ID: <20190613180305.3aeeae1d.cohuck@redhat.com>
In-Reply-To: <20190606202831.44135-8-farman@linux.ibm.com>
References: <20190606202831.44135-1-farman@linux.ibm.com>
        <20190606202831.44135-8-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Jun 2019 22:28:29 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Now that both CCW codepaths build this nested array:
> 
>   ccwchain->pfn_array_table[1]->pfn_array[#idaws/#pages]
> 
> We can collapse this into simply:
> 
>   ccwchain->pfn_array[#idaws/#pages]
> 
> Let's do that, so that we don't have to continually navigate two
> nested arrays when the first array always has a count of one.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 118 +++++++++------------------------
>  1 file changed, 33 insertions(+), 85 deletions(-)

That's how I like my diffstats :) Nice cleanup!

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
