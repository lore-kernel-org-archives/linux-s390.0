Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfFLKcN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:32:13 -0400
Date: Wed, 12 Jun 2019 12:32:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/4] s390/crypto: ghash: Use -ENODEV instead of
 -EOPNOTSUPP
Message-ID: <20190612123205.4b6220af.cohuck@redhat.com>
In-Reply-To: <20190612102248.18903-3-david@redhat.com>
References: <20190612102248.18903-1-david@redhat.com>
        <20190612102248.18903-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>

On Wed, 12 Jun 2019 12:22:46 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's use the error value that is typically used if HW support is not
> available when trying to load a module - this is also what systemd's
> systemd-modules-load.service expects.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/crypto/ghash_s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
