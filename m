From: Thomas Huth <thuth@redhat.com>
Date: Fri, 11 Jan 2019 08:59:28 +0000
Subject: Re: [kvm-unit-tests PATCH v5 01/11] s390x: Add Sigp header file
Message-Id: <396bd20f-e451-59f8-3a6c-e13292b93616@redhat.com>
In-Reply-To: <20190110154151.24233-2-frankja@linux.ibm.com>
References: <20190110154151.24233-2-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2019-01-10 16:41, Janosch Frank wrote:
> The magic numbers for SIGP are not nice to read, so let's put them in
> a new header file. Also move sigp_stop() there, it will later be
> joined by more sigp functions and definitions.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  lib/s390x/asm/sigp.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/s390x/io.c       | 11 +---------
>  2 files changed, 61 insertions(+), 10 deletions(-)
>  create mode 100644 lib/s390x/asm/sigp.h

Reviewed-by: Thomas Huth <thuth@redhat.com>
