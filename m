Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635810;
	b=NGaBgcSSJOLHYzuk8EzUl0cL05yzhmV4FuYC6wUyNGFZ2Z/28s+HEO8AHm4zliebaZCB
	 P0sN7UP7dqUegSeVjBSUAKZ+zOeFA6lX6D69eiUaolf6BuaXycAF/F0NdJVRS9eMLnZS7
	 PQXOoB98E5pXOz/yKUpq6UcM9joxst74PZDjpQituxyBl2UdUTZynxlu4f8eASJB81m6l
	 R+zjBRko0qnpjOsOYI/uVnEm+NJlfEIVXEae+buMILv1Az5N8sCVlQ9bGjhzKa+sAaCS9
	 H+BrABVa4gmYlvD8ovnZEdMCtuL9xklDmTKZ+E9KIDBlpknN5/V9cgZCvkeQyUNRr3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=0SJ/IT6cl7PvbBfdwOVaYMI9Ri7oNYteO3BRN3/eb9Q=;
	b=plaGOCk0nHi1Ufaciw++PtVZq6rgyaxug9S1g8sExi2/ywJdex+YKB2pbecuPR2lUqG/
	 tI+++9aUiG+s+OWX7eOysTdWV70cB7dLAmI/GLBIMVSnyRyxyLiO0YMFjdbz3wLnRVoe1
	 ZQMhghsBI21AXRFnKGOul200dYObCuJoKo68XPX+/c0kPhBhTOrJq494I7LRQstzeVpHP
	 tQsrhU31DHDtuGUVRE32gvalCZhluAjr5ay2tBG2bHdxvwjPKkk+qMWLArLz0tiJ/XCX8
	 g49RCZKm1FCHS3N17k4Ygh+Tv/4RA1DvsoF3en2vzxp5WLxDKXMLZC2taWeVuq2nerw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=g2Q72u81;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B889606A31E
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 02:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B889606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=g2Q72u81
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3abb4c24125so1098881a91.3
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792635809; x=1793240609; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SJ/IT6cl7PvbBfdwOVaYMI9Ri7oNYteO3BRN3/eb9Q=;
        b=g2Q72u81CpNuihVK9M4KPq3rL3w9Ttm3yJo+AuQlZn4TTWFpoAseCpajS0YF2wCnjx
         XUx20E/l2f7uZ9k/vtIfA0up4tgnlUjRIfYhJywE2IPKQVWF64C3faCvZYwxJO+xKiNb
         R2fILNT039mg0p3K3ye9dK/AP31MVX9doIiXc06GwDJEbbZZOKhSRfMS2byVFaeSZ8K6
         ryJQ/MnKy6h+4PKvPlqELr1xGjAkvSdBI8jupfdZCeDz89huMs8xvqhwnfQNq0/iMqNz
         LwIh9pX7MV0/4mT7/ukSQzqCcfdhSIPEbjxtj0lDPgDLAxZ8/5gDgqDri+9c51Auy7bE
         1/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635809; x=1793240609;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SJ/IT6cl7PvbBfdwOVaYMI9Ri7oNYteO3BRN3/eb9Q=;
        b=Iks8K3Jblwa9Y9x9Fb9Q7ua/l2Y6JQWYmaBwkKCzQxPgDjxSlcompHkjP7yAlV0lyO
         7+mO55Hto25MoX+EHXSI4sDgjzGV/Sr/dAlWH+zbOFHhbtLVcPbNt8IzeKeROiNnbYs9
         m8IgwbL1/5PO9QuhPK++TdPXiSNhr5/8jWjqwpcPIekrQWaW2jwpavdxZ0Sqe+t7T7+Y
         tsYOfIeFCddgvfURYXCQNpA0ML82q7YWmzYcQh0eGVQz7wdlM7rtGroGpoMMNby3GW0E
         kCwA4l0I55RmKt2zEcKaduW++h9psmSdMzi3va5bl2dl1OcjlERbfa/yHgB5t/aQkFg2
         Kkgw==
X-Forwarded-Encrypted: i=1; AKwUvBx3qmzkGjB52Mk3iiY1fVzstmW1BNbFvSJHGSkML+jrObVnPj4fTCyq6ph9rARi1orb4QGGtkaWrgqi@vger.kernel.org
X-Gm-Message-State: AFq9FYLvRzzbMHS6y0idBpbfqDbMHg1gfhrr/MjCeqwofGbcKVklWBF4
	VUyKGlS/Zi+3gFwtwove+DbgqHFptr/+NZw+LpEFbRE80yIXzNzhXeYVksQ1EtEK86aEmnoBObY
	1mzEbXA==
X-Received: from pjbli16.prod.google.com ([2002:a17:90b:48d0:b0:3a4:b36f:8bb6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28cc:b0:3ac:86a0:5764
 with SMTP id 98e67ed59e1d1-3ad86f43109mr2940095a91.64.1792635809433; Wed, 21
 Oct 2026 19:23:29 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:23:28 -0700
In-Reply-To: <20261020175818.375700-2-borntraeger@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020175818.375700-1-borntraeger@linux.ibm.com> <20261020175818.375700-2-borntraeger@linux.ibm.com>
Message-ID: <atlzoKxKxaM9ymGm@google.com>
Subject: Re: [PATCH v2 1/2] KVM: Set up async page faults only for faults that
 need to wait
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 20, 2026, Christian Borntraeger wrote:
> hva_to_pfn() checks a FOLL_NOWAIT gup() for EINTR, EAGAIN and EHWPOISON.
> There might be others like -EFAULT for VM_FAULT_SIGBUS.  For those other
> errors, reporting KVM_PFN_ERR_NEEDS_IO would be wrong as it triggers an
> async_pf resulting in endless retries.
> 
> Return KVM_PFN_ERR_NEEDS_IO only if gup() returned 0 pages and report
> the error otherwise.
> 
> Fixes: 0857b9e95c1a ("KVM: Enable async page fault processing")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
