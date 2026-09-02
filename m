Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F52F260C
	for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2026 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309628; cv=none; b=nr+vAd22miAQgUvLas4L9pgti2uJO4nq711Kc78EDTOl1V3iuVq6z55hWZBYb/gglfp7IhYeelSJqajNyWjAgtNcmss2VV7/xskGfR4oK0uryagQVPeBM/DQ4f8Z8LRixEeYRPU461jO3ejnYvUMjIYpshtlvQ6iM2Yd5/obmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309628; c=relaxed/simple;
	bh=vaDS6XNQUMUuPDi84wd9HFSG8Scz5CNLwlPkibF3DEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JPErjtqeQmjWaJwNpSpGYeUyGwe7JdWi7+Djob0KgQ5+GKUSeiOl/yReUyyXCOKllrk6K1aS1n9JFbwtXnNSdS1ru5Lboa2UbLpfMsTVTWQYJ4jmGqbKnp8VK8MWgwcs7DYWsvBUQVhuPL3+0+g1VoCYUwBT73fCWnoAmUezutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cA2nPkTc; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cA2nPkTc"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-853402198efso425111b3a.2
        for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309626; x=1788914426; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Yk5W8YMQMFUnjqW7SP37P8eIRPlwXT5+5U93q8LYb8=;
        b=cA2nPkTcxR26xe3iUdwPzYeikQPcHPUtQl5oHDdyfTtDTEAu9Gh/PaQAEGwIQeGRWO
         4FDu+mUADCLJgxiaplhKBMZ9FggdMfiMhO1GmphQbiZufLoshRKzp32WYRcz4GangQ/a
         K85e6J7iXyyFnOPgIs8SunkI6hxdII5bjACr2OhHB+uc8u28jvGSFyKlvg3T91CRMuMO
         sfirtXlNqb2bsuCuGgHjvLXZMm0GDCxOhJmRZtUR45UOy/A3SdeWHy6xzocXNVtwulkY
         po+h7puKPoGb8ZS6Ku13L55X2Y7+CC1WEUVYdwhdZuli7fEBu/zZkUh7+zov8axfb/MF
         Z9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309626; x=1788914426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Yk5W8YMQMFUnjqW7SP37P8eIRPlwXT5+5U93q8LYb8=;
        b=KcMgb0zbD128gJ7Dqhnk9xMWuXZvphvD6il0X77G71WTD16dwBqoqHHOtqP4nXAoCY
         SWdN9WaA2aIFe2QiuFcAxHLTHFnuxzID1dZkVbQNP4OtX6BgvSLJHW+4dbx/PtDCXhlK
         m0r4m217KoDtqyN5s5pTtiGfx1HtjYpPl1MKjrpaTDcymhCWlrhxWFGyG+1VNl4JrHCx
         l0pHfr8RxPez2+Pw0mzirpsq3GvhDmGCcT7bJV1E8QYGqBOz7UwuvCNa+0OqaSeAvWgv
         /DGJV/xOFWol5AqS7BwpEWzPpVWcAvrMIOrRjAa7Ckkx1Tf7Pw/B9Xh3tQhZ5VqMiBy5
         Zyhg==
X-Forwarded-Encrypted: i=1; AKwUvBzYX4GBKQ81mG9GEoIojVTUfzqAcnRlM0CeIG12sIq8AWud3VOXH2toizUlncutRo8W/roavuRo6a4n@vger.kernel.org
X-Gm-Message-State: AFuF++nnWIER3gitT8eueunrJ+Cysb1y4IQMbKWqCoOx909XirZ/sufW
	XeBu45wQRgEtVMZUibWK6nP23kRvggUYdZA8PqjUIwWtSMPH/FnFrSYyz7xKV5vzRxcheex3W0m
	TaFUpcA==
X-Received: from pfbi25-n2.prod.google.com ([2002:a05:6a00:a519:20b0:84f:4ff1:f767])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab08:b0:848:5cf5:5040
 with SMTP id d2e1a72fcca58-85ed23e044bmr2745937b3a.10.1788309626365; Tue, 01
 Sep 2026 17:40:26 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:40:25 -0700
In-Reply-To: <20260831144802.834315-3-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-3-seiden@linux.ibm.com>
Message-ID: <apdweRfqt4dTxcU9@google.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, Steffen Eiden wrote:
> Allow KVM implementations to choose alternative device names. This is
> especially useful for architectures providing multiple KVM
> implementations simultaneously. Architectures providing multiple KVM
> implementations must compile the KVM common code once per
> implementation and mange symbols.

What about tracepoints?  Or do those show up as "kvm" and "kvm-arm64"?
