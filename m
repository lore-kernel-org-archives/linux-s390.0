Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48357 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726823AbgHROb5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Aug 2020 10:31:57 -0400
Date: Tue, 18 Aug 2020 16:31:44 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 2/4] scripts: add support for architecture
 dependent functions
Message-ID: <20200818143144.vs6ikxp4tgifodyb@kamzik.brq.redhat.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
 <20200818130424.20522-3-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818130424.20522-3-mhartmay@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Tue, Aug 18, 2020 at 03:04:22PM +0200, Marc Hartmayer wrote:
> This is necessary to keep architecture dependent code separate from
> common code.
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  README.md           | 3 ++-
>  scripts/common.bash | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/README.md b/README.md
> index 48be206c6db1..24d4bdaaee0d 100644
> --- a/README.md
> +++ b/README.md
> @@ -134,7 +134,8 @@ all unit tests.
>  ## Directory structure
>  
>      .:                  configure script, top-level Makefile, and run_tests.sh
> -    ./scripts:          helper scripts for building and running tests
> +    ./scripts:          general architecture neutral helper scripts for building and running tests
> +    ./scripts/<ARCH>:   architecture dependent helper scripts for building and running tests
>      ./lib:              general architecture neutral services for the tests
>      ./lib/<ARCH>:       architecture dependent services for the tests
>      ./<ARCH>:           the sources of the tests and the created objects/images
> diff --git a/scripts/common.bash b/scripts/common.bash
> index 96655c9ffd1f..c7acdf14a835 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -1,3 +1,4 @@
> +source config.mak
>  
>  function for_each_unittest()
>  {
> @@ -52,3 +53,10 @@ function for_each_unittest()
>  	fi
>  	exec {fd}<&-
>  }
> +
> +# The current file has to be the only file sourcing the arch helper
> +# file
> +ARCH_FUNC=scripts/${ARCH}/func.bash
> +if [ -f "${ARCH_FUNC}" ]; then
> +	source "${ARCH_FUNC}"
> +fi
> -- 
> 2.25.4
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
