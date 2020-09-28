Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6527 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgI1T0U (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Sep 2020 15:26:20 -0400
Date: Mon, 28 Sep 2020 12:26:19 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 7/8] selftests/vm: run_vmtest.sh: update and clean up
 gup_test invocation
Message-ID: <20200928192619.GF458519@iweiny-DESK2.sc.intel.com>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-8-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928062159.923212-8-jhubbard@nvidia.com>
List-ID: <linux-s390.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org

On Sun, Sep 27, 2020 at 11:21:58PM -0700, John Hubbard wrote:
> Run benchmarks on the _fast variants of gup and pup, as originally
> intended.
> 
> Run the new gup_test sub-test: dump pages. In addition to exercising the
> dump_page() call, it also demonstrates the various options you can use
> to specify which pages to dump, and how.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/vm/run_vmtest.sh | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtest.sh b/tools/testing/selftests/vm/run_vmtest.sh
> index d1843d5f3c30..e3a8b14d9df6 100755
> --- a/tools/testing/selftests/vm/run_vmtest.sh
> +++ b/tools/testing/selftests/vm/run_vmtest.sh
> @@ -124,9 +124,9 @@ else
>  fi
>  
>  echo "--------------------------------------------"
> -echo "running 'gup_test -U' (normal/slow gup)"
> +echo "running 'gup_test -u' (fast gup benchmark)"
>  echo "--------------------------------------------"
> -./gup_test -U
> +./gup_test -u
>  if [ $? -ne 0 ]; then
>  	echo "[FAIL]"
>  	exitcode=1
> @@ -134,10 +134,22 @@ else
>  	echo "[PASS]"
>  fi
>  
> -echo "------------------------------------------"
> -echo "running gup_test -b (pin_user_pages)"
> -echo "------------------------------------------"
> -./gup_test -b
> +echo "---------------------------------------------------"
> +echo "running gup_test -a (pin_user_pages_fast benchmark)"
> +echo "---------------------------------------------------"
> +./gup_test -a
> +if [ $? -ne 0 ]; then
> +	echo "[FAIL]"
> +	exitcode=1
> +else
> +	echo "[PASS]"
> +fi
> +
> +echo "--------------------------------------------------------------"
> +echo "running gup_test -ct -F 0x1 0 19 0x1000"
> +echo "   Dumps pages 0, 19, and 4096, using pin_user_pages (-F 0x1)"
> +echo "--------------------------------------------------------------"
> +./gup_test -ct -F 0x1 0 19 0x1000

Ah here it is...  Maybe just remove that from the previous commit message.

Ira

>  if [ $? -ne 0 ]; then
>  	echo "[FAIL]"
>  	exitcode=1
> -- 
> 2.28.0
> 
> 
