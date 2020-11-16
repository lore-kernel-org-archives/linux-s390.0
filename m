Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728638AbgKPKZk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 05:25:40 -0500
Date: Mon, 16 Nov 2020 11:25:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 04/27] s390: fix kernel-doc markups
Message-ID: <20201116112530.7fdf2020.cohuck@redhat.com>
In-Reply-To: <4a9df42dfb68aed6b4a4882f6dccabf00ce932cd.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
        <4a9df42dfb68aed6b4a4882f6dccabf00ce932cd.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexander Egorenkov <egorenar@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

On Mon, 16 Nov 2020 11:18:00 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> fix one typo:
> 	ccw driver -> ccw_driver
> 
> and one function rename.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  arch/s390/include/asm/ccwdev.h | 2 +-
>  arch/s390/include/asm/cio.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
