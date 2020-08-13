Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59474 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726691AbgHMHuA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 13 Aug 2020 03:50:00 -0400
Date: Thu, 13 Aug 2020 09:49:40 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [kvm-unit-tests RFC v2 2/4] scripts: add support for
 architecture dependent functions
Message-ID: <20200813074940.73xzr6nq4xktjhpu@kamzik.brq.redhat.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com>
 <20200812092705.17774-3-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812092705.17774-3-mhartmay@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Wed, Aug 12, 2020 at 11:27:03AM +0200, Marc Hartmayer wrote:
> This is necessary to keep architecture dependent code separate from
> common code.
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  README.md           | 3 ++-
>  scripts/common.bash | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
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
> index 96655c9ffd1f..f9c15fd304bd 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -52,3 +52,8 @@ function for_each_unittest()
>  	fi
>  	exec {fd}<&-
>  }
> +
> +ARCH_FUNC=scripts/${ARCH}/func.bash

The use of ${ARCH} adds a dependency on config.mak. It works now because
in the two places we source common.bash we source config.mak first, but
I'd prefer we make that dependency explicit. We could probably just
source it again from this file.

Thanks,
drew

> +if [ -f "${ARCH_FUNC}" ]; then
> +	source "${ARCH_FUNC}"
> +fi
> -- 
> 2.25.4
> 
