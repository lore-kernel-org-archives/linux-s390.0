Return-Path: <linux-kbuild-owner@vger.kernel.org>
Subject: Re: [PATCH 0/2] ubsan for s390
References: <1473683840-8700-1-git-send-email-borntraeger@de.ibm.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <aea3cefc-7699-6fe5-ceb9-f8ea58f063fc@virtuozzo.com>
Date: Mon, 12 Sep 2016 19:38:57 +0300
MIME-Version: 1.0
In-Reply-To: <1473683840-8700-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michal Marek <mmarek@suse.com>, Yang Shi <yang.shi@linaro.org>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On 09/12/2016 03:37 PM, Christian Borntraeger wrote:
> This patch set enables ubsan for s390.
> 
> We have to fence some files and can then enable
> ARCH_HAS_UBSAN_SANITIZE_ALL. (patch 2)
> 
> We have to disable the null pointer sanitizer as
> we use the S390_lowcore macro to access several 
> memory location after address 0  (patch 1)
> 
> If patch 1 is ok, is the s390 tree the right place
> also for patch1?
> 

Fine by me
	Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

> Christian Borntraeger (2):
>   ubsan: allow to disable the null sanitizer
>   s390/ubsan: enable UBSAN for s390
> 
>  arch/s390/Kconfig                  |  2 ++
>  arch/s390/boot/compressed/Makefile |  1 +
>  arch/s390/kernel/Makefile          |  3 +++
>  arch/s390/kernel/vdso32/Makefile   |  3 ++-
>  arch/s390/kernel/vdso64/Makefile   |  3 ++-
>  lib/Kconfig.ubsan                  | 11 +++++++++++
>  scripts/Makefile.ubsan             |  5 ++++-
>  7 files changed, 25 insertions(+), 3 deletions(-)
> 
