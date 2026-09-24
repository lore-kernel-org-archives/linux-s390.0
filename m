Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAD12FF69
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230185; cv=none; b=oe77w82WGiWDWV1L6MBC7JtoYJzurksavDJD+9wyQHObJYciaivS/8re7t2VgxSiYUXgP8VZi17jfwVt68jIgfo5HoDqRREtp7Sk/U/38tmtSYKzdYQ0ht5G/xnNklSvm1eE4MM0ksFBusQ5O5taP8JJp4+UfiQkNaxKomJcxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230185; c=relaxed/simple;
	bh=0CUsutr5c/pwyjZUne1mfLzu7Ng+TMFz2fiafLg6SYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjwjnVOLz8UZPWDUwHmC8YKzoWgOro3PXs9CVtifIbyxveUdJQLe0X0c3wKf7lKKLxfI/bgrB8je1XTkg2PqDlVcs64mOPOvNf/IuOgn/YCax8/ynsRJ/2zVgHHb1KKaYZWPfQtfn5A37undskhdz9/LhGxkwquyg/XhbvnMDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UKCUwCsh; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UKCUwCsh"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0CUsutr5c/pwyjZUne1mfLzu7Ng+TMFz2fiafLg6SYM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790230181; v=1; x=1790834981;
 b=UKCUwCshvqwnydCXpABgaEn243UDLeQGF/DaHRDgvNuFcp0xvE9Nzy9cbCp7BYM3AojONF1l
 xkO1NLdje586zElMUCJqMg/+Q4pugso2+Qc1Sh34qZrBg2gYTl3xHT5XUnRj4HPbjNs+0SxlElg
 XGn1Sl7i8YTB5Ng8VN4g71XQ=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8afa20f483a481e;
	Thu, 24 Sep 2026 06:09:41 +0000
X-Mizu-Trace-ID: b8afa20f483a481e
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b778bdb5b8so3530e87.1
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 23:09:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwv1L8cNMEuvfGC87bb5Y+uhi6cRRyjUcuv6SPIlUpO0iwc5Q51n/+WdhD1w07vRLN0m8B83n+GueDK@vger.kernel.org
X-Gm-Message-State: AFuF++lYjI6XQFkQ36L7hSQKLtd1wncGywl5rzWlfKdK3LApsK03LuCL
	bzZWNlh2qaGAIQskVLIQUzfoqvCx23d5HRwHqqKKGzjHFrc0dNm59RP5o5MLHJSpwaj1N5Kn7/c
	FN8U2LZxvqxHw1LQaTYB3qSpc6su541YFKn2LPugH
X-Received: by 2002:a05:6512:3b28:b0:5b8:caec:cc77 with SMTP id
 2adb3069b0e04-5b8de5c4ceamr119554e87.7.1790230180648; Wed, 23 Sep 2026
 23:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
In-Reply-To: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 24 Sep 2026 07:09:04 +0100
X-Gmail-Original-Message-ID: <CA+EHjTw-OXzqXbs8phvXKpbR5UCx6munmFQni80eH6G4gD_k_w@mail.gmail.com>
X-Gm-Features: AclHuK_Ine4NnKUQcaZ0yB1SSKmzV1yVXJdk5G12ur315eMZsDY4KFVeV3Z9hpE
Message-ID: <CA+EHjTw-OXzqXbs8phvXKpbR5UCx6munmFQni80eH6G4gD_k_w@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] KVM: arm64: Add KVM_PRE_FAULT_MEMORY support
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

Hi Lorenzo,

On Wed, 23 Sep 2026 16:15:43 +0100, "Lorenzo Stoakes (ARM)"
<ljs@kernel.org> wrote:
> This series implements the KVM stage 2 page table pre-faulting feature for
> arm64.

Retested as follows (let's see if this one sticks ;) ):

QEMU/arm64 -cpu max:
- guests boot on VHE, nVHE and protected-mode hosts, protected guests included
- pre_fault_memory_test (all guest modes, anonymous, THP, hugetlb and
shmem backing) and nv_pre_fault_memory_test pass
- pre-faulting an uninitialised vCPU returns -ENOEXEC
- a failed guest_memfd pre-fault leaves kvm_run's exit_reason alone
- dirty_log_test, demand_paging_test, mmu_stress_test and
stage2_block_transitions also pass

Apple M4 (nVHE, 4K and 16K pages):
- pre_fault_memory_test passes on the five guest modes available
there, with the same backings
- in protected mode (4K pages), the cap isn't advertised, the ioctl
returns -EOPNOTSUPP before and after vCPU init, and guests boot

Tested-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
