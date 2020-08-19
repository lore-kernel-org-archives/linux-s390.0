Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727896AbgHSKje (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 06:39:34 -0400
Subject: Re: [kvm-unit-tests PATCH 3/4] run_tests/mkstandalone: add arch_cmd
 hook
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
 <20200818130424.20522-4-mhartmay@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <61b2aa71-6b2d-acbf-204d-e3d9909fe30b@redhat.com>
Date: Wed, 19 Aug 2020 12:39:27 +0200
MIME-Version: 1.0
In-Reply-To: <20200818130424.20522-4-mhartmay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>, kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On 18.08.20 15:04, Marc Hartmayer wrote:
> This allows us, for example, to auto generate a new test case based on
> an existing test case.

An example would have been nice :)

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
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
