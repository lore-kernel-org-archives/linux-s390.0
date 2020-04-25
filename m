Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 25 Apr 2020 10:23:00 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/protvirt: fix compilation issue
Message-ID: <your-ad-here.call-01587802980-ext-8570@work.hours>
References: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, david@redhat.com, kbuild test robot <lkp@intel.com>, Philipp Rudo <prudo@linux.ibm.com>

On Thu, Apr 23, 2020 at 02:01:14PM +0200, Claudio Imbrenda wrote:
> The kernel fails to compile with CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> set but CONFIG_KVM unset.
> 
> This patch fixes the issue by making the needed variable always available.
> 
> Fixes: a0f60f8431999bf5 ("s390/protvirt: Add sysfs firmware interface for Ultravisor information")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Philipp Rudo <prudo@linux.ibm.com>
> Suggested-by: Philipp Rudo <prudo@linux.ibm.com>
> CC: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/boot/uv.c   | 2 --
>  arch/s390/kernel/uv.c | 3 ++-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
Applied, thanks
