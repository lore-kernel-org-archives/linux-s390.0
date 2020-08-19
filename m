Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36652 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgHSKfZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 06:35:25 -0400
Date: Wed, 19 Aug 2020 12:34:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 4/4] s390x: add Protected VM support
Message-ID: <20200819123443.2287abc3.cohuck@redhat.com>
In-Reply-To: <20200818130424.20522-5-mhartmay@linux.ibm.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
        <20200818130424.20522-5-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Tue, 18 Aug 2020 15:04:24 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> Add support for Protected Virtual Machine (PVM) tests. For starting a
> PVM guest we must be able to generate a PVM image by using the
> `genprotimg` tool from the s390-tools collection. This requires the
> ability to pass a machine-specific host-key document, so the option
> `--host-key-document` is added to the configure script.
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  configure               |  9 +++++++++
>  s390x/Makefile          | 17 +++++++++++++++--
>  s390x/selftest.parmfile |  1 +
>  s390x/unittests.cfg     |  1 +
>  scripts/s390x/func.bash | 35 +++++++++++++++++++++++++++++++++++
>  5 files changed, 61 insertions(+), 2 deletions(-)
>  create mode 100644 s390x/selftest.parmfile
>  create mode 100644 scripts/s390x/func.bash

(...)

> +function arch_cmd_s390x()
> +{
> +	local cmd=$1
> +	local testname=$2
> +	local groups=$3
> +	local smp=$4
> +	local kernel=$5
> +	local opts=$6
> +	local arch=$7
> +	local check=$8
> +	local accel=$9
> +	local timeout=${10}
> +
> +	# run the normal test case
> +	"$cmd" "${testname}" "$groups" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +
> +	# run PV test case
> +	kernel=${kernel%.elf}.pv.bin
> +	if [ ! -f "${kernel}" ]; then
> +		if [ -z "${HOST_KEY_DOCUMENT}" ]; then
> +			print_result 'SKIP' $testname '(no host-key document specified)'
> +			return 2
> +		fi
> +
> +		print_result 'SKIP' $testname '(PVM image was not created)'

When can that happen? Don't we already fail earlier if we specified a
host key document, but genprotimg does not work?

> +		return 2
> +	fi
> +	"$cmd" "${testname}_PV" "$groups pv" "$smp" "$kernel" "$opts" "$arch" "$check" "$accel" "$timeout"
> +}
