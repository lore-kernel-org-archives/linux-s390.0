Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31711 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgAGJr1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jan 2020 04:47:27 -0500
Date: Tue, 7 Jan 2020 10:47:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: Use the correct style for SPDX License
 Identifier
Message-ID: <20200107104717.5447e24c.cohuck@redhat.com>
In-Reply-To: <20191225122054.GA4598@nishad>
References: <20191225122054.GA4598@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 25 Dec 2019 17:50:58 +0530
Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> This patch corrects the SPDX License Identifier style in
> header file related to S/390 common i/o drivers.
> It assigns explicit block comment to the SPDX License
> Identifier.
> 
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
>

Fixes: 3cd90214b70f ("vfio: ccw: add tracepoints for interesting error paths")
 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/s390/cio/vfio_ccw_trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.
