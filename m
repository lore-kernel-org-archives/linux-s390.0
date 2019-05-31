Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 31 May 2019 11:50:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1] s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
Message-ID: <20190531115055.7f5cf64e.cohuck@redhat.com>
In-Reply-To: <20190531093628.14766-1-david@redhat.com>
References: <20190531093628.14766-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri, 31 May 2019 11:36:28 +0200
David Hildenbrand <david@redhat.com> wrote:

> systemd-modules-load.service automatically tries to load the pkey module
> on systems that have MSA.
> 
> Pkey also requires the MSA3 facility and a bunch of subfunctions.
> Failing with -EOPNOTSUPP makes "systemd-modules-load.service" fail on
> any system that does not have all needed subfunctions. For example,
> when running under QEMU TCG (but also on systems where protected keys
> are disabled via the HMC).
> 
> Let's use -ENODEV, so systemd-modules-load.service properly ignores
> failing to load the pkey module because of missing HW functionality.
> 
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looking at what other modules return when needed features are missing,
this looks like the right thing to do.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
