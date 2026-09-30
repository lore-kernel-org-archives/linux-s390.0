Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57631D375;
	Wed, 30 Sep 2026 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752756; cv=none; b=BjK9KyKRuZcWlqw5yID1iDSe6FSmtiYhCqisu1Ng6gIcExV6fT2kZZj0zAif5i9fcIOsRUr+hWh6dMwVDZfdQNdW+KJ5P9ci7g+KAzIAxukXATglXlkYt7ZhXrJGaYaGseaQpTgHxsh7N6DR8ZxaesjzZIb6vtPHVvA41vhnqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752756; c=relaxed/simple;
	bh=Nak8LEru8v/pcz0CN4nzoZou4RZ80teM2z7CuxUcw1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0q9iAZQAOXnmRArdBM66TCiWrXx+kPdLwhsgOPbgksx3Xk7Ovp0EEIo/kNqlF9+AvDqSwRD9MEMpqxJpCH9yPAEgQwHCV3rrKdOOT+TLQlfrLXOBwkX1+zyLv0D1h1T4cR+926v1pD3IMbZFVna0MnpqMFc1IAcc8+nPzfeg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeItx9m+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeItx9m+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E181F000FF;
	Wed, 30 Sep 2026 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752754;
	bh=Nak8LEru8v/pcz0CN4nzoZou4RZ80teM2z7CuxUcw1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WeItx9m+i4oA96v81j1W4/PI1RxmUiK8aU/EtyAmg2gEz0b7LlutJAWMkI2ZJ2kJS
	 e/YBcOuuk2NwNfNbcoQ5sOzljvAgCz0fcKmn1TvkgeLhO5BXYea20i1Xw37S7RuQ8z
	 bKI86lkKYJBP34KrGEoGrEbKYXnBXdKuZQmA2+HaqieW3wqB4mEK7n/kSZNffYYjpA
	 F8uqx+Uc5RmfB2OUFZZRj02XPrIaFSP4g6CbgjjEIF0W8tVJBT0SspdLues2U0GMPd
	 kvHsjLSSjzOXRmi+VsXcPMXjMFMCOoFrzBuFXpO7HnZ+D4hfsJIQrZcsK4rhkVnzSr
	 awgRFWqSus3HA==
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
In-Reply-To: <yq5afqyruvsf.fsf@kernel.org>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-2-4a294307797b@linux.ibm.com>
 <yq5afqyruvsf.fsf@kernel.org>
Date: Wed, 30 Sep 2026 12:49:02 +0530
Message-ID: <yq5acxtvuryx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Steffen Eiden <seiden@linux.ibm.com> writes:
>
>> Add kvm->file as a no-reference back-pointer to the VM file in struct
>> kvm. The pointer is set at VM creation time and cleared under
>> WRITE_ONCE() in kvm_vm_release() before the file is freed.
>> Callers storing the file must take their own reference.
>>
>
> I have a series that does something similar and also updates VFIO:
>
> https://lore.kernel.org/all/20260917140159.1163281-2-aneesh.kumar@kernel.org
>
> Any suggestions on how we can combine the two efforts? This series has
> received more feedback from maintainers.
>

I compared the full series and will rebase my work on v4 of this series.

-aneesh
