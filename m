From: Thomas Huth <thuth@redhat.com>
Date: Wed, 06 Feb 2019 11:02:45 +0000
Subject: Re: [kvm-unit-tests PATCH v2] s390x: Only look at relevant skey bits
Message-Id: <6de43d2f-654b-244b-8f06-c278566a4f1e@redhat.com>
In-Reply-To: <20190206084656.110920-1-frankja@linux.ibm.com>
References: <20190206084656.110920-1-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2019-02-06 09:46, Janosch Frank wrote:
> Reference and change indication should not be consulted when checking
> for ACC and FP values of storage keys.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  lib/s390x/asm/mem.h |  5 +++++
>  s390x/pfmf.c        |  6 +++++-
>  s390x/skey.c        | 15 +++++++++++----
>  3 files changed, 21 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
