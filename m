Received: from mta1.migadu.com (out-214.mta1.migadu.com [95.215.58.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912893148DA
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230147; cv=none; b=hmCPb6g5F23WXdR+ntArFkFgVFCBOO3/c78VyB8ZL0K14Nj5RdDHaAGoRkuZ54l8pgVHW3rwE+d7DaScVIcuPq/XxSeO95RL2KtZ+sbghVae+faGCsx3rCeZlKJueA62lqKD4xqAybiJ9bTeEZOQcHgG7huj4p8zeMeSSH3xva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230147; c=relaxed/simple;
	bh=RyyiC0ofM8CGzkXnRUfQTw+HLZ/pLb7WijiCtVOlmu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhNlpImZVN+wrLi/2JDNTSmuRAQKYSGiAvigJDV8aFYkkCBxynCvHlRIPJTXFJB7IItwEZEhVyiHVIvdqUQ3zvqSz5kf8KSJkoPLXDjFs+1lwQSKw9wXfjG9GwVikjiWzfDabASYe4lKtHRVx3nf4kb9P3p1umBrfRd+ipY8A+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u3cMYv7L; arc=none smtp.client-ip=95.215.58.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u3cMYv7L"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RyyiC0ofM8CGzkXnRUfQTw+HLZ/pLb7WijiCtVOlmu0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790230142; v=1; x=1790834942;
 b=u3cMYv7Lpzjl5o9Lncdq5CjWxIoHlu+Hs4SsaCm1znSPJwE7NStNjeS8wX2t0znWjRrZjGGg
 RD81vrzjOMhW84rD33qbURk9rToLR5yrZed4gAVHDw4K3hKiN8SUBMq6mowdrHXuA2krHzzkTHP
 EvmB8/1kNyKcgz2jBY36ixaE=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 012aeb2a153468dc;
	Thu, 24 Sep 2026 06:09:02 +0000
X-Mizu-Trace-ID: 012aeb2a153468dc
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso3599e87.1
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 23:09:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx7sRfMCXayVVa3+w9+2m7Vnc4LWUgPqKsPQzC7fMPgpr3PJ048VkvJfq/sUlt0ai6gjt/kre7Ezdrx@vger.kernel.org
X-Gm-Message-State: AFuF++kffAiA5INZstPN+SA4TFc6ahdeDBCJn+fFMGDJKl3fMYIzu7Qt
	Vy5vov8iI+mCAQdyowbxIFVKADryTaExJaYR/gB9V1mFfZrA0vapBgInQyFdSCPh+VPouhhk5In
	zaIYB0l/Sn7O9qW9o/Ny6E27d2XBfXHD93vjNVeRm
X-Received: by 2002:a05:6512:1358:b0:5b2:a967:c0e1 with SMTP id
 2adb3069b0e04-5b8dd6d2b18mr130595e87.0.1790230141441; Wed, 23 Sep 2026
 23:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org> <20260923-kvm-arm-prefault-v4-12-d4b0b4dfa8c3@kernel.org>
In-Reply-To: <20260923-kvm-arm-prefault-v4-12-d4b0b4dfa8c3@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 24 Sep 2026 07:08:25 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxAah=pvuTqSYE0-jkXmgWJBrVD33nCThS4SNJN-kfNmw@mail.gmail.com>
X-Gm-Features: AclHuK_kb7tirLzxpH1tqzJpHCuAErXckpMiZSE-Wc4zTJclc5slHcBac4UN3_w
Message-ID: <CA+EHjTxAah=pvuTqSYE0-jkXmgWJBrVD33nCThS4SNJN-kfNmw@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] KVM: selftests: Enable pre_fault_memory_test for arm64
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jack Thomson <jackabt@amazon.com>, 
	Jack Thomson <jackabt.amazon@gmail.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Vincent Donnefort <vdonnefort@google.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Leo Soares Passos <Leo.Bras@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Sept 2026 at 16:18, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> From: Jack Thomson <jackabt@amazon.com>
>
> Enable the pre_fault_memory_test to run on arm64 by making it work with
> different guest page sizes and testing multiple guest configurations.
>
> Add an assert on the exit reason, comparing against UCALL_EXIT_REASON so
> the check is portable, as arm64 exits with KVM_EXIT_MMIO while x86 uses
> KVM_EXIT_IO.
>
> Signed-off-by: Jack Thomson <jackabt@amazon.com>
> [ljs: merge conflict resolution with commit c847704619da ("KVM: selftests:
>  Fix pre_fault_memory_test to run on s390"), commit message accuracy fixup]
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
