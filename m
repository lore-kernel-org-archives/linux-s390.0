Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E887F4F1
	for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737646618; cv=none; b=pcfcy1zMloCpcv4XsLBJRhlslHddLdJeZ0yePDzyaNxP8NKivCxiPYhb92zsDA+6GKjtlIoE7aIVe4m8NT9ZWoFjDIXZ/i69PTPs1K9hw4lvHAiFL3KfomlP1pHZA0oYSyUlWUkhP+J96CyrWtqKp3/N86XueQ0R3CiZbguEFCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737646618; c=relaxed/simple;
	bh=vVMicQnUKZpo1ViAzQ7vlBGv1KYxvfJdFGP+PXB41F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIixltISdNrxORb5bR0XNiGu6ejbi02i7IZdY98CzmVj7WZZyt9lLGwiPjmhdTVwLI9YdtJo1WiQYfxznuo/rsu7WLoRniIV1qRnYEHgu7CEusxc6BFZvsPuE2npvOu0jqCs12ulnD8915byw/J2GrmPAyw83tSLP1g6fE0bRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RajfLYfS; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RajfLYfS"
Date: Thu, 23 Jan 2025 16:36:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737646599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7daHCSAZnVQzRP+983s7ap8EHdLiIYE2KVKyVsz4xmM=;
	b=RajfLYfSBFBSWc6mFyySZKDs5szeMKvPp68QvuBuich9RvwWiU/TPw5u4GCyHN1qDh1J2w
	RuwGLEDTJihJADhrHv1AyFrSodpLrhKTaeVCo6MkAq4qIKInk09/reGjTOPg8prtIaY4NU
	7bwcJ4hGN3mVOcxgkKzuPoaeQN18ibg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org, 
	oliver.upton@linux.dev, suzuki.poulose@arm.com, yuzenghui@huawei.com, joey.gouly@arm.com, 
	andre.przywara@arm.com
Subject: Re: [kvm-unit-tests PATCH v2 13/18] run_tests: Do not probe for
 maximum number of VCPUs when using kvmtool
Message-ID: <20250123-1155fba5858c4ee31e647d8a@orel>
References: <20250120164316.31473-1-alexandru.elisei@arm.com>
 <20250120164316.31473-14-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120164316.31473-14-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 20, 2025 at 04:43:11PM +0000, Alexandru Elisei wrote:
> The --probe-maxsmp parameter updates MAX_SMP with the maximum number of
> VCPUs that the host supports. Qemu will exit with an error when creating a
> virtual machine if the number of VCPUs is exceeded.
> 
> kvmtool behaves differently: it will automatically limit the number of
> VCPUs to the what KVM supports, which is exactly what --probe-maxsmp wants
> to achieve. When doing --probe-maxsmp with kvmtool, print a message
> explaining why it's redundant and don't do anything else.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  run_tests.sh | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/run_tests.sh b/run_tests.sh
> index 61480d0c05ed..acaaadbb879b 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -89,7 +89,15 @@ while [ $# -gt 0 ]; do
>              list_tests="yes"
>              ;;
>          --probe-maxsmp)
> -            probe_maxsmp
> +            case "$TARGET" in
> +            qemu)
> +                probe_maxsmp
> +                ;;
> +            kvmtool)
> +                echo "kvmtool automatically limits the number of VCPUs to maximum supported"
> +                echo "The 'smp' test parameter won't be modified"
> +                ;;
> +            esac
>              ;;
>          --)
>              ;;
> -- 
> 2.47.1
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

but I hope we can do something with the associative array idea to
avoid all the TARGET case statements that are getting scattered
around. Here, we could rename probe_maxsmp to qemu_probe_maxmp and
then add kvmtool_probe_maxsmp which does this output and each
to their respective vmm[$vmm,probe_maxsmp] member.

Thanks,
drew
