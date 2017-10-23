Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 0/3] s390 refcount conversions
References: <1508485670-24070-1-git-send-email-elena.reshetova@intel.com>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Mon, 23 Oct 2017 14:11:13 +0200
MIME-Version: 1.0
In-Reply-To: <1508485670-24070-1-git-send-email-elena.reshetova@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bd915b0f-4c13-ae9c-00f9-9420102f4412@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Elena Reshetova <elena.reshetova@intel.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com, peterz@infradead.org, keescook@chromium.org
List-ID: <linux-s390.vger.kernel.org>

On 10/20/2017 09:47 AM, Elena Reshetova wrote:
> This series, for S390, replaces atomic_t reference
> counters with the new refcount_t type and API (see include/linux/refcount.h).
> By doing this we prevent intentional or accidental
> underflows or overflows that can led to use-after-free vulnerabilities.
> 
> The patches are fully independent and can be cherry-picked separately.
> Patches are based on top of linux-next as of yesterday.
> If there are no objections to the patches, please merge them via respective trees
> 
> Elena Reshetova (3):
>   [S390] vmur: convert urdev.ref_count from atomic_t to refcount_t
>   [S390] net: convert lcs_reply.refcnt from atomic_t to refcount_t
>   [S390] qeth: convert qeth_reply.refcnt from atomic_t to refcount_t
> 
>  drivers/s390/char/vmur.c          |  8 ++++----
>  drivers/s390/char/vmur.h          |  4 +++-
>  drivers/s390/net/lcs.c            | 10 +++++-----
>  drivers/s390/net/lcs.h            |  3 ++-
>  drivers/s390/net/qeth_core.h      |  3 ++-
>  drivers/s390/net/qeth_core_main.c | 10 +++++-----
>  6 files changed, 21 insertions(+), 17 deletions(-)
> 
Thanks Elena, I picked up the two network patches. Also removed the WARN_ONs while applying,
those who care may use CONFIG_REFCOUNT_FULL.
