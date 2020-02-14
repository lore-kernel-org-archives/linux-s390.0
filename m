Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgBNPcR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 10:32:17 -0500
Date: Fri, 14 Feb 2020 16:32:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] s390/cio: use kobj_to_dev() API
Message-ID: <20200214163209.5b5e9833.cohuck@redhat.com>
In-Reply-To: <1581688293-17283-1-git-send-email-qiwuchen55@gmail.com>
References: <1581688293-17283-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: qiwuchen55@gmail.com
Cc: sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>

On Fri, 14 Feb 2020 21:51:33 +0800
qiwuchen55@gmail.com wrote:

> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> Signed-off-by: chenqiwu <qiwuchen55@gmail.com>
> ---
> changes in v2:
>  - add signed off for my gmail adderss.
> --- 
>  drivers/s390/cio/chp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
