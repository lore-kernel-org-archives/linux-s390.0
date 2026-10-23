Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767976;
	b=xUGrkpI5drfYSDxv57Xo/qVALLe0EuyeUu6NPNKK4lmBgLJuFlk+tkK7zx4T8Yh6MjrB
	 iOO5X2gRxq1xT8fxzSBsJrNSuw8xYcYN1CM+4eXd1yGHZ1I2m9ALLkw/okWZzOAFgBmVC
	 2MtHxpYcoWoTJcsoYt0IFqiH+xaqTwsPcmJc4Rmsq62ZSG2z1bkb5h4wl6mKdX8t8CqNP
	 TckfsufvsHQiYQe4DivwhSlVkJN3vXkxM21rfhxjeIy3D7kdQIH0Dk2/dUhkoAgI/k5nF
	 KZFgQrEJH5QpkjQL96cRCJUMoMin0P+dUKG27A0SYfQxexatYp5n4w0z6+8Pjzyq3Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=wz9tOFWt7BhQDze29fB23fRXoLeWs5QHCqP5Z4tBz+E=;
	b=qSDI6P2J9amlDzo5oNx6dddZcqWh0du0a3dLd0EJapHlBkEWzN/PV6y2GKaKkzn38ToQ
	 pwCcEhiE/q939S/bIda3zRg6uLCnrVYTWKge+JxZJBi7m2sbndLP7Jtj/wroBY45+tew8
	 tuxhGtqfaVW0Mdqa7uje9Yv9SBVpY0jHy++b7wLHYni80TrDiUT9loVozvzppKJGxhN4V
	 2KEMb/8QD1tYy4NJlv6SQc2W6CBFPj8241BW9RNQmOXEduDVQ8LY+zJjLar7/4pJHmY31
	 GWoH8CtAxQKhGEb/DH/2QseZ+g4hBD6zlR7cPjel/nvUxaJJo6rL79z4Y/mxuu1U/Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rY9Eunz7;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47530606A31E
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 15:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47530606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rY9Eunz7
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89e6ddd4554so715511b3a.3
        for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792767975; x=1793372775; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wz9tOFWt7BhQDze29fB23fRXoLeWs5QHCqP5Z4tBz+E=;
        b=rY9Eunz7aQZZgNv1E8e5qXPlPd8OfgnrSrMLIR5SR1JMMqv9sK0+qNbBJuaCPBDtCB
         lfXuWThYUbxke1ygOXvSq7T/Wmv7WWwOtN9G/cSda1Ff443UGstMeMZnw85CUeUSElu5
         16Kku1zpsf3kUSE1OFs08w/YEqypxtf6it/UHlR/pABBDD2rTXVv9HylxGjjb94IO0LS
         vuLGe+TqPzSKxKWfKKHGyEBlpIkiwinhqWpQbyr2l72NoZdicmycRtTb46K/Wn1OaPQ/
         D/mg47rapnmB7jRsc3/Bsu/i8F4PKgf/ZyNpb/b4HZ4xMSdLmbl+75lrHgxkTYJdQYcn
         WWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767975; x=1793372775;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wz9tOFWt7BhQDze29fB23fRXoLeWs5QHCqP5Z4tBz+E=;
        b=t9/86SOnNJFD8gamd2YZ2HzFDkoXC6XOmBe6cQ5thmxp82CO11FqQiJqnNgjR7FsPl
         RKW92SLWzyoviVVJogO+cx1vto29E6eLIS8fos4QtujRAQ29kTAvLpbTseTvEooR9rUr
         MXmm5JWZqiYVfyUdWe7ls15S94EnKkpSZH5lYdSxvw5wZukOR7B6+l/SkrWrKcu36z7s
         fvneNn2b7QptT2uYx9WQBgFH9HRYnMDe/P0KJFQmwaHBL56CM4seeNxIYAJDKohrZvYF
         CllnkQQLDgOEJAphxq7KzCc36HSVwLbGaf8LoMlkqgsUnQrgKFNvs74CnwkQ39rtJo9s
         LRAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSLabXn3UZH3NEUp9fh4Gae/SHswCHpLO5EcC5uuksTFFNOc6dNnkrVDfrAW0VbIjHfKs7tX7peMqm@vger.kernel.org
X-Gm-Message-State: AFq9FYKliFTVujXdrh4+a1orzuzyVjf9ExgjCHLmxRRxN568DFiPAFEp
	EfNysNXbsDlmvUTTsDoEHMAzy1uyj3ZjAT4aPv5qtDBwOCkC5roMuctBrFKNAyYqhQ5AlMsxm28
	xuX7QLQ==
X-Received: from pfww6-n2.prod.google.com ([2002:a05:6a00:8886:20b0:890:ac21:250c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e2a:b0:89f:e1e7:e7e8
 with SMTP id d2e1a72fcca58-8a2c5e33c76mr2368910b3a.18.1792767975274; Fri, 23
 Oct 2026 08:06:15 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:06:14 -0700
In-Reply-To: <20261023140506.336663-1-borntraeger@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <50a3ff35-ae53-4372-a53c-c07f1d153627@linux.ibm.com> <20261023140506.336663-1-borntraeger@linux.ibm.com>
Message-ID: <att35ilyLvAA8gM4@google.com>
Subject: Re: [PATCH v3 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 23, 2026, Christian Borntraeger wrote:
> Add a test in which the guest writes to a shmem-backed memslot beyond
> the end of the file.  KVM_RUN must fail with -EFAULT.
> 
> On x86 the guest enables interrupts, and on s390 the test sets up
> pfault, so that KVM could handle the fault with an asynchronous page
> fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
> retries the access forever, and the test fails after a timeout.
> 
> The test is not built for LoongArch, which handles a failed mapping as
> an MMIO access.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
> I went with Seans name proposal

Aww, bummer.  If you posted a faulty_mcfault_face_test, I would absolutely apply
that and force Paolo to tell me no :-)
