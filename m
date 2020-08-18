Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44345 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726727AbgHROcx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Aug 2020 10:32:53 -0400
Date: Tue, 18 Aug 2020 16:32:40 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 3/4] run_tests/mkstandalone: add arch_cmd
 hook
Message-ID: <20200818143240.lhdtsvftvvmukexk@kamzik.brq.redhat.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
 <20200818130424.20522-4-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818130424.20522-4-mhartmay@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Tue, Aug 18, 2020 at 03:04:23PM +0200, Marc Hartmayer wrote:
> This allows us, for example, to auto generate a new test case based on
> an existing test case.
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  scripts/common.bash | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/common.bash b/scripts/common.bash
> index c7acdf14a835..a6044b7c6c35 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -19,7 +19,7 @@ function for_each_unittest()
>  	while read -r -u $fd line; do
>  		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
>  			if [ -n "${testname}" ]; then
> -				"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +				$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
>  			fi
>  			testname=${BASH_REMATCH[1]}
>  			smp=1
> @@ -49,11 +49,16 @@ function for_each_unittest()
>  		fi
>  	done
>  	if [ -n "${testname}" ]; then
> -		"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +		$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
>  	fi
>  	exec {fd}<&-
>  }
>  
> +function arch_cmd()
> +{
> +	[ "${ARCH_CMD}" ] && echo "${ARCH_CMD}"
> +}
> +
>  # The current file has to be the only file sourcing the arch helper
>  # file
>  ARCH_FUNC=scripts/${ARCH}/func.bash
> -- 
> 2.25.4
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
