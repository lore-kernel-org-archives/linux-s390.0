Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 16 Sep 2020 14:20:32 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH -next] s390/diag: convert to use DEFINE_SEQ_ATTRIBUTE
 macro
Message-ID: <20200916122032.GA7076@osiris>
References: <20200916025029.3992939-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916025029.3992939-1-liushixin2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:50:29AM +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  arch/s390/kernel/diag.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Applied, thanks.
