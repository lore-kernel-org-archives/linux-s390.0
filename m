Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgHSKh5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 06:37:57 -0400
Subject: Re: [kvm-unit-tests PATCH 1/4] common.bash: run `cmd` only if a test
 case was found
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
 <20200818130424.20522-2-mhartmay@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b12dbee8-5965-f268-79d6-9d750704808a@redhat.com>
Date: Wed, 19 Aug 2020 12:37:45 +0200
MIME-Version: 1.0
In-Reply-To: <20200818130424.20522-2-mhartmay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>, kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On 18.08.20 15:04, Marc Hartmayer wrote:
> It's only useful to run `cmd` in `for_each_unittest` if a test case
> was found. This change allows us to remove the guards from the
> functions `run_task` and `mkstandalone`.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  run_tests.sh            | 3 ---
>  scripts/common.bash     | 8 ++++++--
>  scripts/mkstandalone.sh | 4 ----
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/run_tests.sh b/run_tests.sh
> index 01e36dcfa06e..24aba9cc3a98 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -126,9 +126,6 @@ RUNTIME_log_stdout () {
>  function run_task()
>  {
>  	local testname="$1"
> -	if [ -z "$testname" ]; then
> -		return
> -	fi
>  
>  	while (( $(jobs | wc -l) == $unittest_run_queues )); do
>  		# wait for any background test to finish
> diff --git a/scripts/common.bash b/scripts/common.bash
> index 9a6ebbd7f287..96655c9ffd1f 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -17,7 +17,9 @@ function for_each_unittest()
>  
>  	while read -r -u $fd line; do
>  		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
> -			"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +			if [ -n "${testname}" ]; then
> +				"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +			fi
>  			testname=${BASH_REMATCH[1]}
>  			smp=1
>  			kernel=""
> @@ -45,6 +47,8 @@ function for_each_unittest()
>  			timeout=${BASH_REMATCH[1]}
>  		fi
>  	done
> -	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +	if [ -n "${testname}" ]; then
> +		"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +	fi
>  	exec {fd}<&-
>  }
> diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
> index 9d506cc95072..cefdec30cb33 100755
> --- a/scripts/mkstandalone.sh
> +++ b/scripts/mkstandalone.sh
> @@ -83,10 +83,6 @@ function mkstandalone()
>  {
>  	local testname="$1"
>  
> -	if [ -z "$testname" ]; then
> -		return
> -	fi
> -
>  	if [ -n "$one_testname" ] && [ "$testname" != "$one_testname" ]; then
>  		return
>  	fi
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
