Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0D3C942E;
	Mon, 23 Mar 2026 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288403; cv=none; b=iCCBsh/V5cNEvDqCCSllEuDdQ0c8IiHwuo0Q85zc4BttPUjcCR4AcDr/tuFaRmP88vpAFR/337n5Z2m6z8V6yUHPyZWUIJKdLagimvHlbGsgQuiQGk+KADY+yLrQ+ZG0K9mlme4mb6fAWn/GWDAhENnJaBvQ6HpRtz460I57yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288403; c=relaxed/simple;
	bh=AE6bvPRBuu/wn9CJ9Bc0lzK1gYt9cBL0a+aIcWO4eCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLf5MR+VswoHtJvnWjGdKLUzPzbQ27pLCkaHUn4JZVYSzLdxEjZvfSpWEnITJ5yoIlnVEmzu5Yp00m+9J6iGTqdNYMpK8Q6EmKXsut66ErGqrdGQyVtNV+I1uiWC9+u6eBDWrn8335FgFvmGyVImwW1Qwu/qpii6O4g+FWUSLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV7mxTWB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV7mxTWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC77C2BCB0;
	Mon, 23 Mar 2026 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774288403;
	bh=AE6bvPRBuu/wn9CJ9Bc0lzK1gYt9cBL0a+aIcWO4eCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bV7mxTWBukFmR5V1TfAE3U4PHdCw+B18jcmZLFiYDg7lovpoVi6W/EcoLDOyawoWb
	 c0G+I1soK0HNQ46qHJ+Kjhzxtr3DmCXIVcBDdGHe7lZgMwdP8lE4dOiU+1frxh5Oxk
	 tg1wgR+cFyGJUFixQBX2maEdDM0hOlThkIbVZFptqw91KGyr/5gFVsKpksHc8l7FYm
	 Zch52RON9+hDZ0Z7iCImIZ9bbmdEUsIctlSMiYO8s9e9QpKd6up+CSD0A/rQcEGzcG
	 /9mMQ/b/RZUqQx95MmexN/E+miQtL0jHPA0oXOyJeIypJzez/ho+OREMjiHEL+dFS5
	 JqIYFBD77kcJQ==
Date: Mon, 23 Mar 2026 17:53:21 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 3/4] KVM: s390: avoid kvm_s390_handle_pv() error
 overwrite
Message-ID: <fb38ecc9-36f8-49a1-bf20-a2c03244e574@lucifer.local>
References: <20260322054309.898214-1-surenb@google.com>
 <20260322054309.898214-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322054309.898214-4-surenb@google.com>

On Sat, Mar 21, 2026 at 10:43:07PM -0700, Suren Baghdasaryan wrote:
> If kvm_s390_handle_pv() call fails its error code gets recorded but
> execution proceeds as if the call was successful. If the next call to
> copy_to_user() fails then the original error is overwritten.

Is that really a big deal though, as you're returning an error in either case?

> The follow-up patch adds fatal signal checks during VMA walk, which
> makes it possible for kvm_s390_handle_pv() to return EINTR error.
> Without this fix any error including EINTR can be overwritten and
> original error will be lost.
>
> Change error handling for kvm_s390_handle_pv() to alter normal flow
> once failure happens. This is consistent with how kvm_arch_vm_ioctl
> handles errors for other ioctl commands.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 3eb60aa932ec..ddad08c0926f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2947,6 +2947,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		}
>  		/* must be called without kvm->lock */
>  		r = kvm_s390_handle_pv(kvm, &args);
> +		if (r)
> +			break;
>  		if (copy_to_user(argp, &args, sizeof(args))) {

Yeah as per Sashiko we probably need to copy_to_user() still.

But in that case, do we even need a change at all? I'm not sure it really
matters which error code terminates things does it?

>  			r = -EFAULT;
>  			break;
> --
> 2.53.0.1018.g2bb0e51243-goog
>

Thanks, Lorenzo
