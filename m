Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507225;
	b=J6rZjjwqe5tI9QdF9ajV6YyFq1qdkH7dXOt8ljtqL897BVx09jANDCWFmOWSyVBR+sAT
	 jgKwuEVAdeTvrGgz5fkeoLoYv2zUyRVx4K1zd1KnOhIfHqyGW8NJIHCkoZ/QN9HY++MJO
	 mOSLsYka6JGVh5AAcbNpvBOtRaQ18iWNQe/kfTe1Dvys+Z7ShskoAXblME51cb2FwjYfp
	 0VwXKz877nQ5mQgAMwnkMAS+HlFhWFBZ9qDWu2lLpfXWeI0GUW+o2iebkkOX1EoFUIcXg
	 ovXBCAWlmf8BXWkeDJG6vtgiN07LOwyO8MclgXVDRXK2sigUpw3xejHUt/TUm0YCtDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5ag2TWCXWR9uzwdO4FL54tkw6F6WUl4C1dUeOhZ1BMU=;
	b=KRh3E2tbarD7GTUXOvnIsz/h7/x+/lPTJ7roQYzGkMq66lKmpIKqpYsEfu7B97mGofVr
	 PAu1QIWh6QVAlUtAmDnTNoNfUV+6XOLr0ATZ2+sDNSOjH3J1FG2VHlGISKD5ZszEgbRib
	 uf4ckQLkeVwv+kVMgAh958LeJGPzXw71wzT9XC5DXi2SQEWr9oH81pCdjjjJ02ysa0A3c
	 dm2qxwdg/TB9MgF8Ky+5eXCaavvCyItqIx9nDZJ/3f0XN+/WGNRrOwOgLTNUWOMWynu2F
	 Sq545nbJJNmq47zhlArvYLInKYdLR/H+M7Onlc5Nu13vU6DTq5ERunZ9LrNNq9UEM5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cxn7Ofr1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE4606A319;
	Tue, 20 Oct 2026 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cxn7Ofr1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CD01F000C8;
	Tue, 20 Oct 2026 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507225;
	bh=5ag2TWCXWR9uzwdO4FL54tkw6F6WUl4C1dUeOhZ1BMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cxn7Ofr1wvvUiUpg/R0YCV7YQ7xesgvqbIo4AzRbd11v2ij8B92lvDF9Hk0ikuocG
	 pLIQvpRzAWRvcWpOBeSgqjKqtEy5OCSA5+RwXtcRn+FFf7CxaZfm0NfXcpmWfKparq
	 rpT0MrjKnqspN75f+S3LlHHy/UmdyA5EQXMh0DHndukWRaXlWRQ/6DebnxVDk/DFhK
	 XQB4odxaxRYZfVAVeAcjq5GSbgmzvfW5vy/Gmi620JuBaFsB7ai2VJM69PoNlQFIuX
	 TmXZ6ZnkwjPvbCJX0mOmwRSX5ChBSyLD/8EkuxOZr9D72Hxbw3uarZmbctwgCVB1I5
	 yBqF1KeisXU8g==
Message-ID: <sashiko-outbox-179179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261020143308.228328-3-borntraeger@linux.ibm.com>
References: <20261020143308.228328-1-borntraeger@linux.ibm.com>
 <20261020143308.228328-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:40:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: selftests: missing gmem_flags argument to vm_mem_add() in m=
ain()
--

commit 3a1c0f90404979b6638dbd3c2769d7b78633b104
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: selftests: Test that KVM_RUN fails for unresolvable host faults

This commit adds a selftest in which a guest writes to a shmem-backed
memslot beyond the end of the file to verify that KVM_RUN fails with
-EFAULT rather than retrying an asynchronous page fault indefinitely.

> diff --git a/tools/testing/selftests/kvm/faultin_sigbus_test.c b/tools/te=
sting/selftests/kvm/faultin_sigbus_test.c
> new file mode 100644
> index 0000000000000..b9d673260ed5a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/faultin_sigbus_test.c
> @@ -0,0 +1,168 @@

[ ... ]

> +int main(void)
> +{
> +	struct sigaction sa =3D { .sa_handler =3D sig_alarm };	/* no SA_RESTART=
 */
> +	struct userspace_mem_region *region;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	gpa_t gpa;
> +	gva_t gva;
> +	u64 npages;
> +	int r;
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +	/* After slot 0 and the page that some architectures use for ucalls. */
> +	region =3D memslot2region(vm, 0);
> +	gpa =3D align_up(region->region.guest_phys_addr +
> +		       region->region.memory_size + vm->page_size, TEST_SIZE);
> +	npages =3D TEST_SIZE / vm->page_size;
> +
> +	vm_mem_add(vm, VM_MEM_SRC_SHMEM, gpa, TEST_SLOT, npages, 0, -1, 0);

[Severity: Medium]
Does this fail to build when compiling KVM selftests?

In tools/testing/selftests/kvm/include/kvm_util.h (and
tools/testing/selftests/kvm/lib/kvm_util.c), vm_mem_add() takes 9
arguments following commit ee455183c92be7:

void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
		gpa_t gpa, u32 slot, u64 npages, u32 flags,
		int gmem_fd, u64 gmem_offset, u64 gmem_flags);

Calling vm_mem_add() in main() with only 8 arguments omits the final
gmem_flags parameter and fails compilation with too few arguments to
function vm_mem_add. Should this pass the 9th argument (0), or use the
6-argument helper vm_userspace_mem_region_add(vm, VM_MEM_SRC_SHMEM, gpa,
TEST_SLOT, npages, 0) instead?

> +	region =3D memslot2region(vm, TEST_SLOT);
> +	/* Only the first host page is backed, everything behind it is SIGBUS. =
*/
> +	TEST_ASSERT(!ftruncate(region->fd, getpagesize()), "ftruncate() failed"=
);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020143308.2283=
28-1-borntraeger@linux.ibm.com?part=3D2
