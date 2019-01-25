Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 25 Jan 2019 09:47:58 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: hypfs: no need to check return value of
 debugfs_create functions
References: <20190122152151.16139-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <20190122152151.16139-1-gregkh@linuxfoundation.org>
Message-Id: <20190125084758.GB3561@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 22, 2019 at 04:21:00PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/s390/hypfs/hypfs.h        |  6 +++---
>  arch/s390/hypfs/hypfs_dbfs.c   |  8 ++------
>  arch/s390/hypfs/hypfs_diag.c   |  9 ++++-----
>  arch/s390/hypfs/hypfs_diag0c.c |  3 ++-
>  arch/s390/hypfs/hypfs_sprp.c   |  6 +++---
>  arch/s390/hypfs/hypfs_vm.c     |  3 ++-
>  arch/s390/hypfs/inode.c        | 11 +++--------
>  7 files changed, 19 insertions(+), 27 deletions(-)

Applied, thanks!
