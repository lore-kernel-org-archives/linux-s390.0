Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DC3B47E1;
	Wed, 30 Sep 2026 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790747808; cv=none; b=JwE1PTLsW8IkHHFAqYhNA9Zr6xkZtJClFIqE7G/tKU6/GB2ifZz6Nk7Usqac27KCMpMS8GzYukRYVLN0mMy+0CMDXHMlMNIB8S87Fm889knL1gIXUyOvD/PpqzXqYfAZUx0ycVAcbFyAyMlOnJNiX9hw+Y/6KIWodoufc4x/wHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790747808; c=relaxed/simple;
	bh=LE+3PqxdWjcgpBH3ZooOrHBFJSgfu2PuqpzTkCDaT8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1bAStDlShUxmakLkMIJJZ44nHvadsYBJBktbbW/iFf87N2tvhaf16ZpGk443fhxmPt6bd7zgE42Gup/HzkkPkyoHxBC8Fy5WZ+bxlaxiFpA0zVxQz/9BuAmXmUcCy5WEVbF6+Yhi7yc50xXlzJ6qkheLPZCPeSk+NrzesxEkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MScvLOtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MScvLOtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C351F000FF;
	Wed, 30 Sep 2026 05:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790747804;
	bh=VkuVbbtrgAK4RWxfDzqWfi5BX9aniPuzy9VI1kmAGJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MScvLOtDMg1qFB6mQEZi0Av6vTaA7Pvq9D13oRFPzHNiWg9xtH+JNBjZVqNe/KarZ
	 ijvsyLgjKU2VeIIqe1aHhETEIZ6yjvWdDZjOTegYKuUiAsiuLVRgFJnwVQTIJ9Nj8d
	 vIY2iqoEZseMmrmwlw72EPdsvGUnAwTjczgLLv/c/kH8KV2mdrMX+FjdtE8H69/KtJ
	 domBu7z9ORK6HYdKSKC+G5+wUN8AYU2i1QxJWKNrg3u/qGcf4IlM30fr2AIdcZggln
	 NSPNboB4wklT6I+tS3MxvshAxBGb6x/zkjwaV3NeVUxH2qIabLA3qH45A3QSBoV5zq
	 tuYCgZCew0jew==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Steffen Eiden <seiden@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steffen Eiden <seiden@linux.ibm.com>
Subject: Re: [PATCH v3 2/5] KVM: Add file back-pointer to struct kvm
In-Reply-To: <20260924-vfio-v3-2-4a294307797b@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-2-4a294307797b@linux.ibm.com>
Date: Wed, 30 Sep 2026 11:26:32 +0530
Message-ID: <yq5afqyruvsf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steffen Eiden <seiden@linux.ibm.com> writes:

> Add kvm->file as a no-reference back-pointer to the VM file in struct
> kvm. The pointer is set at VM creation time and cleared under
> WRITE_ONCE() in kvm_vm_release() before the file is freed.
> Callers storing the file must take their own reference.
>

I have a series that does something similar and also updates VFIO:

https://lore.kernel.org/all/20260917140159.1163281-2-aneesh.kumar@kernel.org

Any suggestions on how we can combine the two efforts? This series has
received more feedback from maintainers.

>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  include/linux/kvm_host.h | 6 ++++++
>  virt/kvm/kvm_main.c      | 4 ++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e840ceda9f16..943b108f01cd 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -784,6 +784,12 @@ struct kvm {
>  	 * kvm_swap_active_memslots().
>  	 */
>  	struct mutex slots_arch_lock;
> +	/*
> +	 * Back-reference to the VM file for subsystems (e.g., VFIO). Holds no
> +	 * reference to avoid pinning the VM. Callers storing the file must
> +	 * take their own reference.
> +	 */
> +	struct file *file;
>

I had to add the file pointer as an __rcu field:

@@ -840,6 +842,7 @@ struct kvm {
	struct srcu_struct srcu;
	struct srcu_struct irq_srcu;
	pid_t userspace_pid;
+	struct file __rcu *_file;
	bool override_halt_poll_ns;
	unsigned int max_halt_poll_ns;
	u32 dirty_ring_size;

because my series uses get_file_active().

>  	struct mm_struct *mm; /* userspace tied to this vm */
>  	unsigned long nr_memslot_pages;
>  	/* The two memslot sets - active and inactive (per address space) */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0172ca94f82e..bab71d398236 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1352,6 +1352,8 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
>  
>  	kvm_irqfd_release(kvm);
>  
> +	WRITE_ONCE(kvm->file, NULL);
> +
>  	kvm_put_kvm(kvm);
>  	return 0;
>  }
> @@ -5532,6 +5534,8 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
>  		goto put_kvm;
>  	}
>  
> +	kvm->file = file;
> +
>  	/*
>  	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
>  	 * already set, with ->release() being kvm_vm_release().  In error
>

-aneesh
