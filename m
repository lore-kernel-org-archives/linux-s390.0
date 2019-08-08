Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbfHHHwx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 8 Aug 2019 03:52:53 -0400
Date: Thu, 8 Aug 2019 09:52:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] s390/mm: Use refcount_t for refcount
Message-ID: <20190808095249.4fc40eb1.cohuck@redhat.com>
In-Reply-To: <20190808071826.6649-1-hslester96@gmail.com>
References: <20190808071826.6649-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu,  8 Aug 2019 15:18:26 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Reference counters are preferred to use refcount_t instead of
> atomic_t.
> This is because the implementation of refcount_t can prevent
> overflows and detect possible use-after-free.
> So convert atomic_t ref counters to refcount_t.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  arch/s390/include/asm/gmap.h |  4 +++-
>  arch/s390/mm/gmap.c          | 10 +++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
