Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439910AbfFLPJN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 11:09:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CF4Q8n123231
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 11:09:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t32s6bbb1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 11:09:11 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 12 Jun 2019 16:09:09 +0100
Date: Wed, 12 Jun 2019 17:08:50 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v3 0/4] s390/crypto: Use -ENODEV instead of -EOPNOTSUPP
References: <20190612133306.10231-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612133306.10231-1-david@redhat.com>
Message-Id: <20190612150850.GA4038@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

On Wed, Jun 12, 2019 at 03:33:02PM +0200, David Hildenbrand wrote:
> s390x crypto is one of the rare modules that returns -EOPNOTSUPP instead of
> -ENODEV in case HW support is not available.
> 
> Convert to -ENODEV, so e.g., systemd's systemd-modules-load.service
> ignores this error properly.
> 
> v2 -> v3:
> - "s390/pkey: Use -ENODEV instead of -EOPNOTSUPP"
> -- Also convert pkey_clr2protkey() as requested by Harald
> - Add r-b's (thanks!)
> 
> v1 -> v2:
> - Include
> -- "s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP"
> -- "s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP"
> -- "s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP"
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> 
> David Hildenbrand (4):
>   s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
>   s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP
>   s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP
>   s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP

Should I pick these up so they can go upstream via the s390 tree?
