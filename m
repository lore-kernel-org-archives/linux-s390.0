Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4914FDA76;
	Fri, 18 Sep 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743495; cv=none; b=qQw38hS+HWuNI27vmB6Pimq2/A6xnOb7ChORmMSZdA4qOf3ebUSIWnZjeU1qID0H+uyvnCm4MdjE9MVaOeJWtDaCBHcRUuqX6gjyeS2VifvD71PrMOGKcp0HR5XBk6+MVjcp1Vi4/byr/d4gVrdA3tlw4s39Zh45GWO4nCPrnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743495; c=relaxed/simple;
	bh=RF1s6mLH/teaAVMBltKOXpAY10cWmutijpOAWgvqd5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U+zJwF+yUImArWWlUrjuGlhBgJ03/b0rT7FNQ5xqNPxCpNI3I3hm5RpkcV234Xn3v83ex8BEMlAmFUEOeaKowjkctSEamm1BeoFIT2/CD7gFXkz88c3pRMIVH2s8JBMMhQMW7Jna9u8WbCWE0B5LWVxDxTvcOxCXFl+j/gq549k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVZQdrwL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVZQdrwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE131F00898;
	Fri, 18 Sep 2026 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743494;
	bh=+aMLP3BCeP896xtPE7BbMOwBTSyhVeEGlc2T6/YOQOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DVZQdrwLwjIWqK1W3V17xY1NMSJptPahMpZw07NlGySJC95UMAmxYaEsyE6kQAbXV
	 KxpWd7Xpa35RU6DjxYenT5F3IHRQ734hY1Lfgzcib9j+CjZSOvR2/GB4x/bA53IlG9
	 xO7+YCyK5Meyun3Tgfb+7+Ac+LdlKsMPtkeLKygNM0OjAp3gLWrKcaQGMshkMA1Px2
	 QSAZYbXaH6WucAozGbifILf9RmdYjHSRs72UVXz1z1vPCVH10otvW/Y0Bw+zxcB/bI
	 N8c0k65Uta3JtoQmAliEYP+YVPUyzf97VRVUw1ZH9uukOzeURBEX0FT9mH1nC1q9kR
	 zirxD/oXq7Ixg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/29] KVM: Make device name configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260918133107.1042730-8-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-8-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:58:13 +0000
Message-Id: <20260918145813.CEE131F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] kvm: KVM_DEV_STRING macro evaluates to literal "KVM_DEV_NAME_vcp=
u"
- [Low] kvm: hardcoded "kvm" strings bypass the configurable device name
--

commit d598c93c97a669f28341c88d4d371abfd9c3b335
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: Make device name configurable

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously.

[ ... ]
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 2b56fb4e85557..5926478563e88 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -45,6 +45,9 @@
>  #include <asm/kvm_host.h>
>  #include <linux/kvm_dirty_ring.h>
> =20
> +#define __KVM_DEV_STRING(name, x) __stringify(name ## _ ## x)
> +#define KVM_DEV_STRING(x) __KVM_DEV_STRING(KVM_DEV_NAME, x)

[Severity: Medium]
Does KVM_DEV_STRING(vcpu) expand to the literal string "KVM_DEV_NAME_vcpu"
instead of the expected configured name?

Because the name parameter in __KVM_DEV_STRING is adjacent to the ##
token-pasting operator, the C preprocessor does not macro-expand it before
pasting. The tokens KVM_DEV_NAME, _, and vcpu are pasted into
KVM_DEV_NAME_vcpu, which __stringify converts to the literal string.

Does this need an extra level of macro indirection to evaluate the arguments
before pasting?

[ ... ]
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 891a67cb365ab..4f25e170b542c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5596,8 +5596,8 @@ static struct file_operations kvm_chardev_ops =3D {
>  };
> =20
>  static struct miscdevice kvm_dev =3D {
> -	KVM_MINOR,
> -	"kvm",
> +	KVM_DEV_MINOR,
> +	__stringify(KVM_DEV_NAME),

[Severity: Low]
Are there other hardcoded "kvm" strings that will bypass this configurable
device name when creating a VM or interacting with KVM infrastructure?

For instance, processes utilizing different KVM implementations will have
indistinguishable workqueues and anonymous inodes, reducing observability:

virt/kvm/eventfd.c:kvm_irqfd_init() {
    ...
    irqfd_cleanup_wq =3D alloc_workqueue("kvm-irqfd-cleanup", WQ_PERCPU, 0);
    ...
}

virt/kvm/kvm_main.c:kvm_create_vm() {
    ...
    file =3D anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
    ...
}

And also hardcoded log prefixes:

virt/kvm/kvm_main.c:kvm_shutdown() {
    ...
    pr_info("kvm: exiting hardware virtualization\n");
    ...
}

Do these strings also need to use the configured device name to ensure
concurrent KVM instances are cleanly segregated?

[Severity: Low]
This is a pre-existing issue, but does generic multiple KVM support conflict
with hardcoded core kernel singletons?

If architectures using CONFIG_KVM_GENERIC_HARDWARE_ENABLING attempt to load
multiple KVM modules simultaneously, the second module will fail to initial=
ize.
The core hotplug subsystem returns -EBUSY when a second implementation invo=
kes
it since the hotplug state is statically assigned:

virt/kvm/kvm_main.c:kvm_enable_virtualization() {
    ...
    r =3D cpuhp_setup_state(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
                          kvm_online_cpu, kvm_offline_cpu);
    ...
}

Also, concurrent registrations of guest info callbacks trigger a WARN_ON_ON=
CE
since the core kernel only maintains a single pointer:

virt/kvm/kvm_main.c:__kvm_register_perf_callbacks() {
    ...
    perf_register_guest_info_callbacks(&kvm_guest_cbs);
    ...
}

Can these singletons be adjusted to support concurrent implementations?

>  	&kvm_chardev_ops,
>  };
> =20
[ ... ]
> @@ -6521,7 +6521,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_alig=
n, struct module *module)
>  	if (!vcpu_align)
>  		vcpu_align =3D __alignof__(struct kvm_vcpu);
>  	kvm_vcpu_cache =3D
> -		kmem_cache_create_usercopy("kvm_vcpu", vcpu_size, vcpu_align,
> +		kmem_cache_create_usercopy(KVM_DEV_STRING(vcpu), vcpu_size, vcpu_align,

[Severity: Medium]
With the KVM_DEV_STRING() macro evaluating to the literal string
"KVM_DEV_NAME_vcpu", will all KVM modules unconditionally attempt to create=
 a
kmem_cache named literally "KVM_DEV_NAME_vcpu" during module initialization?

This causes duplicate slab names across multiple KVM implementations, leadi=
ng
to sysfs creation warnings (SLUB: Unable to add cache KVM_DEV_NAME_vcpu to
sysfs) and broken observability in /proc/slabinfo. Although SLUB permits
duplicate names and proceeds with cache creation, this seems to break the
intended uniqueness.

>  					   SLAB_ACCOUNT,
>  					   offsetof(struct kvm_vcpu, arch),
>  					   offsetofend(struct kvm_vcpu, stats_id)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D7
